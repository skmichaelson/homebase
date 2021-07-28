# Scheduling App
Provides online schedule for all employees for the current week

## Running tests
```bash
bundle install
bundle exec rspec spec/
```

## Running the app
```bash
bundle install
rails db:migrate
rails s
```

## Running the app with seeded data
```bash
bundle install
rails db:migrate && rails db:seed
rails s
```

## Decisions
- I used Rails instead of Sinatra. While Sinatra is lighter weight, Rails is easier to boilerplate
- I didn't build an endpoint to create the shifts because it wasn't explicitly needed to meet the Acceptance Criteria

## Future Improvements
- Make "role" and enum (Role.SERVER, Role.HOST, etc)
- The shift start and end time are strings, but they could be represented as times
- Validations
    - Presence of name on an employee
    - Employee unique identifier (since two employee might have the same name)
    - Shifts have valid inputs
