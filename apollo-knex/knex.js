const Knex = require('knex')

const pg = Knex({
  client: 'pg',
  connection:
    'postgres://postgres:postgrespassword@postgres:5432/postgres?schema=public',
  searchPath: ['knex', 'public'],
})

module.exports = pg
