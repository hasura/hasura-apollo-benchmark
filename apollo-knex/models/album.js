const { Model } = require('objection')
const path = require('path')
const db = require('../knex')

Model.knex(db)

class Album extends Model {
  static tableName = 'album'
  static idColumn = 'albumid'

  static relationMappings = {
    artist: {
      relation: Model.BelongsToOneRelation,
      modelClass: path.join(__dirname, 'artist'),
      join: {
        from: 'album.artistid',
        to: 'artist.artistid',
      },
    },
    tracks: {
      relation: Model.HasManyRelation,
      modelClass: path.join(__dirname, 'track'),
      join: {
        from: 'album.albumid',
        to: 'track.albumid',
      },
    },
  }
}

module.exports = Album
