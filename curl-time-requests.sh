# 1
albums_tracks_genres_all='query albums_tracks_genre_all {
  album {
    albumid
    title
    tracks {
      trackid
      name
      genre {
        name
      }
    }
  }
}'
albums_tracks_genres_all="$(echo $albums_tracks_genres_all)"
# 2
albums_tracks_genre_some='query albums_tracks_genre_some {
  album(where: { artistid: { _eq: 127 } }) {
    albumid
    title
    tracks {
      trackid
      name
      genre {
        name
      }
    }
  }
}'
albums_tracks_genres_all="$(echo $albums_tracks_genres_all)"
prisma_albums_tracks_genre_some='query prisma_albums_tracks_genre_some {
  albums_tracks_genre_some {
    albumid
    title
    tracks {
      trackid
      name
      genre {
        name
      }
    }
  }
}'
prisma_albums_tracks_genre_some="$(echo $prisma_albums_tracks_genre_some)"
#3
tracks_media_all='query tracks_media_all {
  track {
    trackid
    name
    mediatype {
      name
    }
  }
}'
tracks_media_all="$(echo $tracks_media_all)"

# Define each array and then add it to the main one
queries_1=("$(echo $albums_tracks_genres_all)", "$(echo $albums_tracks_genres_all)")
queries_2=("$(echo $albums_tracks_genre_some)", "$(echo $prisma_albums_tracks_genre_some)")
queries_3=("$(echo $tracks_media_all)", "$(echo $tracks_media_all)")
MAIN_ARRAY=(
  queries_1[@]
  queries_2[@]
  queries_3[@]
)
# Loop and print it.  Using offset and length to extract values
COUNT=${#MAIN_ARRAY[@]}
for ((i=0; i<$COUNT; i++))
do
  echo "======================="
  hasura_query=${!MAIN_ARRAY[i]:0:1}
  prisma_query=${!MAIN_ARRAY[i]:1:1}
  echo "Sending Queries:"
  printf "[Hasura Query] \n${hasura_query}\n"
  printf "[Apollo Query] \n${prisma_query}\n"
  # Hasura
  hasura_req_time=$(curl -i --silent --output /dev/null -H 'Content-Type: application/json' \
    -X POST -d "{ \"query\": \"${hasura_query}\"}" \
    -w Connect:%{time_connect}\\nStartTransfer:%{time_starttransfer}\\nTotal:%{time_total}\\n \
    http://localhost:8080/v1/graphql | tail -n 3)

  echo "[Hasura Request Time]"
  echo $hasura_req_time

  # Apollo + Prisma
  apollo_prisma_req_time=$(curl -i --silent --output /dev/null -H 'Content-Type: application/json' \
    -X POST -d "{ \"query\": \"${prisma_query}\"}" \
    -w Connect:%{time_connect}\\nStartTransfer:%{time_starttransfer}\\nTotal:%{time_total}\\n \
    http://localhost:8081/v1/graphql | tail -n 3)

  echo "[Apollo Prisma Time]"
  echo $apollo_prisma_req_time
  echo "======================="
  printf "\n"
done
echo 'Connect:0.000296 StartTransfer:0.000000 Total:0.014066' | cut cut --delimiter=' ' --fields=4

# Hasura
# hasura_req_time=$(curl -i --silent --output /dev/null -H 'Content-Type: application/json' \
#    -X POST -d "{ \"query\": \"$albums_tracks_genres_all\"}" \
#    -w Connect:%{time_connect}\\nStartTransfer:%{time_starttransfer}\\nTotal:%{time_total}\\n \
#    http://localhost:8080/v1/graphql | tail -n 3)

# echo "Hasura Request Time:"
# echo $hasura_req_time

# # Apollo + Prisma
# apollo_prisma_req_time=$(curl -i --silent --output /dev/null -H 'Content-Type: application/json' \
#    -X POST -d "{ \"query\": \"$albums_tracks_genres_all\"}" \
#    -w Connect:%{time_connect}\\nStartTransfer:%{time_starttransfer}\\nTotal:%{time_total}\\n \
#    http://localhost:8081/v1/graphql | tail -n 3)

# echo "Apollo Prisma Time:"
# echo $apollo_prisma_req_time


