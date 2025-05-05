# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Applications', type: :request do
  describe 'GET /api/v1/applications' do
    let(:job) { create(:job, :activated) }
    let(:deactivated_job) { create(:job) }

    let(:hired_app) { create(:application, :hired, :with_notes, job:) }
    let(:rejected_app) { create(:application, :with_notes, :rejected, job:) }
    let(:interview_app) { create(:application, :interview, :with_notes, job:, notes_count: 4) }
    let(:applied_app) { create(:application, :with_notes, :applied, job:, notes_count: 2) }
    let(:deactivated_app) { create(:application, job: deactivated_job) }

    context 'when requesting all applications' do
      it 'returns a successful response with applications for activated jobs only' do
        _applications = [hired_app, rejected_app, interview_app, applied_app, deactivated_app]
        get api_v1_applications_url

        expect(response).to have_http_status(:ok)
        expect(json_body[:data].size).to eq(4)
        expect(json_body[:data].find { |app| app[:candidate_name] == hired_app.candidate_name }).to include({
          'status' => 'hired',
          'job_title' => job.title
        })
        expect(json_body[:data].find { |app| app[:candidate_name] == rejected_app.candidate_name }).to include({
          'status' => 'rejected',
          'job_title' => job.title
        })
        expect(json_body[:data].find { |app| app[:candidate_name] == interview_app.candidate_name }).to include({
          'status' => 'interview',
          'job_title' => job.title
        })
        expect(json_body[:data].find { |app| app[:candidate_name] == applied_app.candidate_name }).to include({
          'status' => 'applied',
          'job_title' => job.title
        })
      end
    end

    context 'when searching for applications' do
      it 'returns applications matching the search criteria' do
        _applications = [hired_app, rejected_app, interview_app, applied_app, deactivated_app]
        get api_v1_applications_url, params: { q: { search_by: rejected_app.candidate_name.split.first.downcase } }

        expect(response).to have_http_status(:ok)

        expect(json_body[:data].size).to eq(1)
        expect(json_body[:data].first[:candidate_name]).to eq(rejected_app.candidate_name)
      end
    end

    context 'when including additional attributes' do
      it 'returns applications with the requested included attributes' do
        _applications = [hired_app, rejected_app, interview_app, applied_app, deactivated_app]
        get api_v1_applications_url, params: { includes: %w[notes_count last_interview_at] }

        expect(response).to have_http_status(:ok)

        expect(json_body[:data].size).to eq(4)
        expect(json_body[:data].find { |app| app[:candidate_name] == hired_app.candidate_name }).to include({
          'status' => 'hired',
          'notes_count' => 1,
          'last_interview_at' => hired_app.events.interview.last.created_at
        })
        expect(json_body[:data].find { |app| app[:candidate_name] == rejected_app.candidate_name }).to include({
          'status' => 'rejected',
          'notes_count' => 1,
          'last_interview_at' => nil
        })
        expect(json_body[:data].find { |app| app[:candidate_name] == interview_app.candidate_name }).to include({
          'status' => 'interview',
          'notes_count' => 4,
          'last_interview_at' => interview_app.events.interview.last.created_at
        })
        expect(json_body[:data].find { |app| app[:candidate_name] == applied_app.candidate_name }).to include({
          'status' => 'applied',
          'notes_count' => 2,
          'last_interview_at' => nil
        })
      end
    end

    context 'when paginating results' do
      it 'returns the requested page of results' do
        _applications = [hired_app, rejected_app, interview_app, applied_app, deactivated_app]
        get api_v1_applications_url, params: { page: { number: 2, size: 2 } }

        expect(response).to have_http_status(:ok)

        expect(json_body[:data].size).to eq(2)
        expect(json_body[:meta][:page]).to include(
          'total_count' => 4,
          'total_pages' => 2,
          'number' => 2,
          'size' => 2
        )
      end
    end
  end
end
