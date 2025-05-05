# Event Sourcing Tracking System

An Applicant Tracking System (ATS) built with Rails API using Event Sourcing pattern to track the status of jobs and applications.

## Getting Started

### Building and Starting the Application

The application uses Docker for easy setup and deployment. Use the following make commands:

1. **Build containter**:

   ```bash
   make compose-build
   ```

2. **Install dependencies**:

   ```bash
   make compose-install
   ```

3. **Start Rails app**:

   ```bash
   make compose
   ```

   This will start the Rails API server on <http://localhost:3000>

### Database Setup

```bash
docker compose run --rm web rails db:setup
```

This will create, migrate and seed database

## App Structure

### Folders

- `app/blueprints` - JSON serializers
- `app/controllers` - API controllers
- `app/models` - Domain models (Job, Application, and their events)
- `app/services` - Service objects
- `db/migrate` - Database migrations
- `spec/factories` - Domain model factories
- `spec/requests` - Request tests

### Endpoints

The application provides the following RESTful API endpoints:

- **GET /api/v1/jobs?** - List all jobs with their status and application statistics
  - params:
    - `q[search_by]` - title and description search string
    - `page[number]` - page number (pagination)
    - `page[size]` - page size (pagination)
    - `includes[]` - included attributes
  - Return attributes: `title`, `description`, `status`, `created_at`, `updated_at`
  - Included attributes: `hired_candidates_count`, `ongoing_candidates_count`, `rejected_candidates_count`

- **GET /api/v1/applications** - List all applications for activated jobs
  - params:
    - `q[search_by]` - candidate name search string
    - `page[number]` - page number (pagination)
    - `page[size]` - page size (pagination)
    - `includes[]` - included attributes
  - Return attributes: `candidate_name`, `job_title`, `status`, `created_at`, `updated_at`
  - Included attributes: `notes_count`, `last_interview_at`

#### [Postman collection](ats_postman_collection.json) - import to test endpoints via Postman

### Event Sourcing Statuses

The system uses Event Sourcing to track the status of jobs and applications:

- A job's status is calculated based on its events:
  - `deactivated` - no events or last event is `Job::Event::Deactivated`
  - `activated` - last event is `Job::Event::Activated`

- An application's status is calculated based on its events (`Application::Event::Note` events don't change the status):
  - `applied` - no events
  - `interview` - last event is `Application::Event::Interview`
  - `hired` - Last event is `Application::Event::Hired`
  - `rejected` - Last event is `Application::Event::Rejected`

## Running Tests

The application uses RSpec for testing. To run the tests:

```bash
compose-rspec
```
