cat bench.yaml | docker run -i --rm --network host \
  -v $(pwd)/queries.hasura.graphql:/graphql-bench/ws/queries.hasura.graphql \
  -v  $(pwd)/albums_tracks_genre_all.graphql:/graphql-bench/ws/albums_tracks_genre_all.graphql \
  -v $(pwd)/albums_tracks_genre_some.graphql:/graphql-bench/ws/albums_tracks_genre_some.graphql \
  -v $(pwd)/artist_by_id.graphql:/graphql-bench/ws/artist_by_id.graphql \
 graphql-bench:1.0