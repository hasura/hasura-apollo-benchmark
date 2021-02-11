const { Model } = require('objection')
const db = require('../knex')

Model.knex(db)

class Genre extends Model {
  static tableName = 'genre'
  static idColumn = 'genreid'
}

module.exports = Genre
