const { gql } = require('apollo-server')
const Album = require('./models/album')
const Artist = require('./models/artist')
const Track = require('./models/track')

const typeDefs = gql`
  scalar bigint
  scalar numeric
  scalar timestamptz

  type artist {
    artistid: bigint!
    name: String
    albums: [album!]!
  }

  # columns and relationships of "track"
  type track {
    # An object relationship
    album: album
    albumid: bigint
    bytes: bigint
    composer: String

    # An object relationship
    genre: genre
    genreid: bigint

    # An object relationship
    mediatype: mediatype
    mediatypeid: bigint
    milliseconds: bigint
    name: String

    trackid: bigint!
    unitprice: numeric
  }

  # columns and relationships of "genre"
  type genre {
    genreid: bigint!
    name: String
  }

  type mediatype {
    mediatypeid: bigint!
    name: String
  }

  # columns and relationships of "album"
  type album {
    albumid: bigint!

    # An object relationship
    artist: artist
    artistid: bigint
    title: String
    tracks: [track!]!
  }

  type Query {
    track: [track]
    album: [album]
    artist_by_id: artist
    albums_tracks_genre_some: [album]
    tracks_media_some: [track]
    artists_collaboration: [artist]
  }
`

const resolvers = {
  Query: {
    album: () => Album.query(),
    track: () => Track.query(),
    artist_by_id: () => {
      return Artist.query().findById(3)
    },
    albums_tracks_genre_some: async () => {
      return Album.query().where('artistid', 127)
    },
    tracks_media_some: () => {
      return Track.query().where('composer', 'Kurt Cobain')
    },
    artists_collaboration: async () => {
      return Artist.query()
        .withGraphJoined('albums.[tracks]')
        .where('albums:tracks.composer', 'Ludwig van Beethoven')
    },
  },
  album: {
    artist: async (parent, args, ctx) => {
      const album = await Album.query()
        .findById(parent.albumid)
        .withGraphFetched('artist')
      return album.artist
    },
    tracks: async (parent, args, ctx) => {
      const album = await Album.query()
        .findById(parent.albumid)
        .withGraphFetched('tracks')
      return album.tracks
    },
  },
  track: {
    album: async (parent, args, ctx) => {
      const track = await Track.query()
        .findById(parent.albumid)
        .withGraphFetched('album')
      return track.album
    },
    genre: async (parent, args, ctx) => {
      const track = await Track.query()
        .findById(parent.albumid)
        .withGraphFetched('genre')
      return track.genre
    },
    mediatype: async (parent, args, ctx) => {
      const track = await Track.query()
        .findById(parent.albumid)
        .withGraphFetched('mediatype')
      return track.mediatype
    },
  },
}

module.exports = {
  typeDefs,
  resolvers,
}
