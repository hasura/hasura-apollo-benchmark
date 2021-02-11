const { Model } = require('objection')
const db = require('../knex')

Model.knex(db)

class MediaType extends Model {
  static tableName = 'mediatype'
  static idColumn = 'mediatypeid'
}

module.exports = MediaType
