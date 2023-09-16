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

### Build Services
```
docker-compose up --build
```
will start `postgresql` database and `blind_dates` as docker containers

### Setup Database
```
rails db:setup
```
will setup `development` and `test` databases.

### Run Blind Dates App
```
docker-compose up -d
```
After startup completed, you should be able to sign in as admin through http://localhost:3000 with:

username: test@test.de
password: password!
