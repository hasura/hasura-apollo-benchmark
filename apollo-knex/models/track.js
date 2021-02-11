const { Model } = require('objection')
const path = require('path')

const db = require('../knex')
Model.knex(db)

class Track extends Model {
  static tableName = 'track'
  static idColumn = 'trackid'

  static relationMappings = {
    genre: {
      relation: Model.HasOneRelation,
      modelClass: path.join(__dirname, 'genre'),
      join: {
        from: 'track.genreid',
        to: 'genre.genreid',
      },
    },
    mediatype: {
      relation: Model.HasOneRelation,
      modelClass: path.join(__dirname, 'mediatype'),
      join: {
        from: 'track.mediatypeid',
        to: 'mediatype.mediatypeid',
      },
    },
    album: {
      relation: Model.BelongsToOneRelation,
      modelClass: path.join(__dirname, 'album'),
      join: {
        from: 'track.albumid',
        to: 'album.albumid',
      },
    },
  }
}

module.exports = Track
