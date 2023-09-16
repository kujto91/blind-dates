# frozen_string_literal: true
namespace :dev do
  desc 'setup default development env'

  task setup: [
    '.env',
    'config/database.yml'
  ]

  file '.env' do
    cp '.env.sample', '.env'
  end

  file 'config/database.yml' do
    cp 'config/database.yml.sample', 'config/database.yml'
  end
end
