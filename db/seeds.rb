# frozen_string_literal: true

include FactoryBot::Syntax::Methods

def create_jobs(count)
  count.times.map { create(:job) }
end

def create_applications(job, count)
  count.times.map { create(:application, job:) }
end

def create_job_events(job, count)
  count.times do |idx|
    job_event_factory = idx.even? ? :job_event_deactivated : :job_event_activated
    create(job_event_factory, job:)
  end
end

def create_application_events(application, count)
  count.times do |idx|
    application_event_factory = if idx != count - 1
                                  idx.even? ? :application_event_note : :application_event_interview
                                else
                                  idx.even? ? :application_event_rejected : :application_event_hired
                                end
    create(application_event_factory, application:)
  end
end

jobs = create_jobs(3)
puts "\t ##### JOBS CREATED! ##### "
jobs.zip([0, 1, 2]).map { |job, event_count| [job, create_job_events(job, event_count)] }
puts "\t ##### JOB EVENTS CREATED! ##### "

applications = jobs.zip([0, 1, 3]).map { |job, application_count| create_applications(job, application_count) }.flatten
puts "\t ##### APPLICATIONS CREATED! ##### "
applications.zip([0, 1, 2, 3]).map do |application, event_count|
  [application, create_application_events(application, event_count)]
end
puts "\t ##### APPLICATION EVENTS CREATED! ##### "
