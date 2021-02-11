const { Model } = require('objection')
const path = require('path')
const db = require('../knex')

Model.knex(db)

class Artist extends Model {
  static tableName = 'artist'
  static idColumn = 'artistid'

  static relationMappings = {
    albums: {
      relation: Model.HasManyRelation,
      modelClass: path.join(__dirname, 'album'),
      join: {
        from: 'artist.artistid',
        to: 'album.artistid',
      },
    },
  }
}

module.exports = Artist
