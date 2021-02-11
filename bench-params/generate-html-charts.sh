query_folders=(albums_tracks_genre_all albums_tracks_genre_some artists_collaboration tracks_media_all tracks_media_some artist_by_id)

set_vegeta_binary_for_os() {
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    vegeta_bin=vegeta
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    vegeta_bin=vegeta_darwin
  fi
}

function make_hasura_chart() {
  vegeta plot ./queries/$1/results/hasura_results.bin > ./charts/hasura_$1.html
}

function make_prisma_chart() {
  vegeta plot ./queries/$1/results/prisma_results.bin > ./charts/prisma_$1.html
}

set_vegeta_binary_for_os
for query_folder in ${query_folders[@]}; do
    $vegeta_bin plot \
    ./queries/$query_folder/results/prisma_results.bin \
    ./queries/$query_folder/results/hasura_results.bin \
    > ./charts/$query_folder.html
done