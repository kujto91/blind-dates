# Blind Dates

## Quick Development Setup

### Dependencies
* ruby 2.7.6
* docker / docker-compose
* tailwind css

### Configuration
in root directory:

```
cd blind-dates

bundle install
```

### Copy default configs
```
rails dev:setup
```
will create `.env` and `config/database.yml` from `.sample` files.

### Run Database Service
```
docker-compose up -d
```
will start `postgresql` database as a docker container.

### Setup Database
```
  rails db:setup
```
will setup `development` and `test` databases.

### Run tha Blind Dates App
in root directory:

```
cd blind-dates

foreman start -f Procfile.dev
```

After startup completed, you should be able to sign in as admin through http://localhost:3000 with:

username: test@test.de
password: password!
