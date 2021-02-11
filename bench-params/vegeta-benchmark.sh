query_folders=(albums_tracks_genre_some artists_collaboration tracks_media_all tracks_media_some artist_by_id albums_tracks_genre_all)

test_duration="5s"
req_per_second="30/s"

set_vegeta_binary_for_os() {
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    vegeta_bin=./vegeta
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    vegeta_bin=vegeta_darwin
  fi
}

benchmark_query_prisma() {
  $vegeta_bin attack -targets=./queries/$1/prisma.http \
  -format=http -header='Content-Type: application/json' \
  -duration=5s -rate=$3 -name=$1.$3/prisma \
  | tee ./queries/$1/results/prisma_results.bin 
}

benchmark_query_hasura() {
  $vegeta_bin attack -targets=./queries/$1/hasura.http \
  -format=http -header='Content-Type: application/json' \
  -duration=$2 -rate=$3 -name=$1.$3/hasura \
  | tee ./queries/$1/results/hasura_results.bin 
}

benchmark_query_knex() {
  $vegeta_bin attack -targets=./queries/$1/knex.http \
  -format=http -header='Content-Type: application/json' \
  -duration=$2 -rate=$3 -name=$1.$3/knex \
  | tee ./queries/$1/results/knex_results.bin 
}


set_vegeta_binary_for_os

for query_folder_name in ${query_folders[@]}; do
  benchmark_query_knex $query_folder_name $test_duration $req_per_second
  benchmark_query_hasura $query_folder_name $test_duration $req_per_second
done 