query_folders=(albums_tracks_genre_all albums_tracks_genre_some artists_collaboration tracks_media_all tracks_media_some artist_by_id)
histogram=hist[0,2ms,4ms,6ms,8ms,10ms,15ms,20ms,40ms,80ms,125ms,200ms]
verbose='false'

while getopts 'v' flag; do
  case "${flag}" in
    v) verbose='true' ;;
  esac
done

set_vegeta_binary_for_os() {
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    vegeta_bin=./vegeta
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    vegeta_bin=vegeta_darwin
  fi
}

function print_report() {
  cat ./queries/$1/results/$2.bin | $vegeta_bin report -type=$3
}

# Set binary
set_vegeta_binary_for_os

# Print report
for query_folder_name in  ${query_folders[@]}; do
  echo "============================================="
  echo "[Platform: Apollo & Prisma]"
  echo "[Query: $query_folder_name]"

  print_report $query_folder_name knex_results text
  echo "============================================="
  print_report $query_folder_name knex_results $histogram
  if [ "$verbose" = true ]; then
    echo "============================================="
   print_report $query_folder_name knex_results hdrplot
  fi
  echo "============================================="
  echo "[Platform: Hasura]"
  echo "[Query: $query_folder_name]"

  print_report $query_folder_name hasura_results text
  echo "============================================="

  print_report $query_folder_name hasura_results $histogram
  if [ "$verbose" = true ]; then
    echo "============================================="
    print_report $query_folder_name hasura_results hdrplot
  fi
done 

