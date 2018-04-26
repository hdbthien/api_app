### Contents

- [Requirements](#requirements)
- [Setup](#setup)
- [API Docs](#api-docs)
- [Achievements](#achievements)

## Requirements
- Ruby 2.5.0
- Rails 5.1.6
- PostgreSQL 9.6
 -Rspec-rails 3.5


## Setup

### Setting up the development environment

#### Clone and pull source code:
    ```bash
    https://github.com/hdbthien/api_app.git
    cd api_app
    git pull origin master
    ```

#### Prepare database.yml
    ```bash
    cp config/database.example.yml config/database.yml
    ```

Config database.yml with your database configuration in your development enviroment

#### Create, migrate, seed database.yml
    ```bash
    bundle exec rake db:create
    bundle exec rake db:migrate
    bundle exec rake db:seed
    ```
#### Re-generate secret key if needed
    ```bash
    bundle exec rake secret
    ```
####  Start the development server:
    ```bash
    bundle exec rails s
    ```

Done

#### Unit testing code with Rspec


1.  Move project directory

1.  Initialize your test database:

    ```bash
    bundle exec rake test:prepare
    ```

    This needs to be rerun whenever you make changes to your database schema.

1.  To run unit tests, open another terminal and run:

    ```bash
    bundle exec rspec spec --format documentation
    ```

## Achievements

- Build DB structual
- Finish feature
- Tested with Rspec
- JWT authentication
