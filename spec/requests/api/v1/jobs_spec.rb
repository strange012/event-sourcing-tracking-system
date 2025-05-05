# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Jobs', type: :request do
  describe 'GET /api/v1/jobs' do
    let(:senior_be_job) { create(:job, :activated, :with_hired_application, :with_interview_application, title: 'Senior Backend Developer') }
    let(:lead_be_job) { create(:job, :activated, :with_rejected_application, title: 'Lead Backend Developer') }
    let(:fe_job) { create(:job, :with_applied_application, title: 'Frontend Developer') }

    context 'when requesting all jobs' do
      it 'returns a successful response with all jobs' do
        titles = [senior_be_job, lead_be_job, fe_job].map(&:title)
        get api_v1_jobs_url

        expect(response).to have_http_status(:ok)
        expect(json_body[:data].size).to eq(3)

        expect(json_body[:data].find { |job| job[:title] == titles.first }).to include({
          'status' => 'activated'
        })

        expect(json_body[:data].find { |job| job[:title] == titles.second }).to include({
          'status' => 'activated'
        })

        expect(json_body[:data].find { |job| job[:title] == titles.third }).to include({
          'status' => 'deactivated'
        })
      end
    end

    context 'when searching for jobs' do
      it 'returns jobs matching the search criteria' do
        titles = [senior_be_job, lead_be_job, fe_job].map(&:title)
        get api_v1_jobs_url, params: { q: { search_by: 'senior' } }

        expect(response).to have_http_status(:ok)

        expect(json_body[:data].size).to eq(1)
        expect(json_body[:data].first[:title]).to eq(titles.first)
      end
    end

    context 'when including additional attributes' do
      it 'returns jobs with the requested included attributes' do
        titles = [senior_be_job, lead_be_job, fe_job].map(&:title)
        get api_v1_jobs_url, params: { includes: %w[hired_candidates_count rejected_candidates_count ongoing_candidates_count] }

        expect(response).to have_http_status(:ok)

        expect(json_body[:data].size).to eq(3)
        expect(json_body[:data].find { |job| job[:title] == titles.first }).to include({
          'status' => 'activated',
          'hired_candidates_count' => 1,
          'rejected_candidates_count' => 0,
          'ongoing_candidates_count' => 1
        })

        expect(json_body[:data].find { |job| job[:title] == titles.second }).to include({
          'status' => 'activated',
          'hired_candidates_count' => 0,
          'rejected_candidates_count' => 1,
          'ongoing_candidates_count' => 0
        })

        expect(json_body[:data].find { |job| job[:title] == titles.third }).to include({
          'status' => 'deactivated',
          'hired_candidates_count' => 0,
          'rejected_candidates_count' => 0,
          'ongoing_candidates_count' => 1
        })
      end
    end

    context 'when paginating results' do
      it 'returns the requested page of results' do
        _jobs = [senior_be_job, lead_be_job, fe_job]
        get api_v1_jobs_url, params: { page: { number: 1, size: 2 } }

        expect(response).to have_http_status(:success)

        expect(json_body[:data].size).to eq(2)
        expect(json_body[:meta][:page]).to include(
          'total_count' => 3,
          'total_pages' => 2,
          'number' => 1,
          'size' => 2
        )
      end
    end
  end
end
