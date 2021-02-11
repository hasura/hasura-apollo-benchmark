# Hasura vs Apollo Server & Knex Benchmark

**Instructions:**

- Start Hasura + Postgres + Apollo Server

  - `docker-compose up -d`

- Seed Database

  - `./seed-chinook-db.sh`
    - `chmod +x seed-chinook-db.sh`

- Build the `graphql-bench` Image

  - `cd graphql-bench`
  - `docker build --tag graphql-bench:1.0 .`

- Run the Benchmark:

  - `cd ../bench-params`
  - `./vegeta-benchmark.sh`
    - `chmod +x` if required

- Look at results, generate reports:
  - `./print-benchmark-results.sh` (pass -v to see HDR Plots, default is Text + Histogram)
    - `chmod +x` if required
  - `./generate-html-charts.sh`
    - `chmod +x` if required
  - Check `bench-params/charts` for a directory of HTML files containing comparison reports

Note: Test results by default are stored as gob-encoded binary data files under `bench-params/queries/[query name]/results`, you can pipe these through `vegeta encode` to convert to JSON or CSV if interested in detailed results.

```
cat bench-params/queries/albums_tracks_genre_some/results/hasura_results.bin | vegeta encode -to json
```

By default it pipes to `stdout`, you can redirect to a file with:

```
cat bench-params/queries/albums_tracks_genre_some/results/hasura_results.bin | vegeta encode -to json > hasura_results.json
```

The `body` is JWT Encoded but the contents can be read by pasting into jwt.io without a key

### Sample Benchmark Report

```
=============================================
[Platform: Apollo & Knex]
[Query: albums_tracks_genre_all]
Requests      [total, rate, throughput]         500, 100.20, 0.14
Duration      [total, attack, wait]             34.99s, 4.99s, 30s
Latencies     [min, mean, 50, 90, 95, 99, max]  7.169s, 29.782s, 30s, 30s, 30s, 30.002s, 30.003s
Bytes In      [total, mean]                     1318550, 2637.10
Bytes Out     [total, mean]                     570, 1.14
Success       [ratio]                           1.00%
Status Codes  [code:count]                      0:495  200:5
Error Set:
net/http: request canceled (Client.Timeout exceeded while reading body)
Post http://localhost:8081/graphql: net/http: request canceled (Client.Timeout exceeded while awaiting headers)
=============================================
Bucket           #    %        Histogram
[0s,     2ms]    0    0.00%
[2ms,    4ms]    0    0.00%
[4ms,    6ms]    0    0.00%
[6ms,    8ms]    0    0.00%
[8ms,    10ms]   0    0.00%
[10ms,   15ms]   0    0.00%
[15ms,   20ms]   0    0.00%
[20ms,   40ms]   0    0.00%
[40ms,   80ms]   0    0.00%
[80ms,   125ms]  0    0.00%
[125ms,  200ms]  0    0.00%
[200ms,  +Inf]   500  100.00%  ###########################################################################
=============================================
[Platform: Hasura]
[Query: albums_tracks_genre_all]
Requests      [total, rate, throughput]         500, 100.20, 99.99
Duration      [total, attack, wait]             5.001s, 4.99s, 10.758ms
Latencies     [min, mean, 50, 90, 95, 99, max]  9.704ms, 11.046ms, 10.689ms, 12.37ms, 14.185ms, 15.354ms, 21.15ms
Bytes In      [total, mean]                     133605500, 267211.00
Bytes Out     [total, mean]                     57000, 114.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:500
Error Set:
=============================================
Bucket           #    %       Histogram
[0s,     2ms]    0    0.00%
[2ms,    4ms]    0    0.00%
[4ms,    6ms]    0    0.00%
[6ms,    8ms]    0    0.00%
[8ms,    10ms]   60   12.00%  #########
[10ms,   15ms]   433  86.60%  ################################################################
[15ms,   20ms]   6    1.20%
[20ms,   40ms]   1    0.20%
[40ms,   80ms]   0    0.00%
[80ms,   125ms]  0    0.00%
[125ms,  200ms]  0    0.00%
[200ms,  +Inf]   0    0.00%
=============================================
[Platform: Apollo & Knex]
[Query: albums_tracks_genre_some]
Requests      [total, rate, throughput]         150, 30.20, 30.11
Duration      [total, attack, wait]             4.982s, 4.967s, 15.223ms
Latencies     [min, mean, 50, 90, 95, 99, max]  12.256ms, 22.425ms, 15.323ms, 33.579ms, 48.945ms, 159.844ms, 189.38ms
Bytes In      [total, mean]                     533100, 3554.00
Bytes Out     [total, mean]                     16500, 110.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:150
Error Set:
=============================================
Bucket           #   %       Histogram
[0s,     2ms]    0   0.00%
[2ms,    4ms]    0   0.00%
[4ms,    6ms]    0   0.00%
[6ms,    8ms]    0   0.00%
[8ms,    10ms]   0   0.00%
[10ms,   15ms]   70  46.67%  ###################################
[15ms,   20ms]   44  29.33%  ######################
[20ms,   40ms]   26  17.33%  #############
[40ms,   80ms]   5   3.33%   ##
[80ms,   125ms]  3   2.00%   #
[125ms,  200ms]  2   1.33%   #
[200ms,  +Inf]   0   0.00%
=============================================
[Platform: Hasura]
[Query: albums_tracks_genre_some]
Requests      [total, rate, throughput]         500, 100.20, 100.16
Duration      [total, attack, wait]             4.992s, 4.99s, 2.118ms
Latencies     [min, mean, 50, 90, 95, 99, max]  824.376µs, 1.87ms, 1.802ms, 2.775ms, 3.933ms, 5.754ms, 10.412ms
Bytes In      [total, mean]                     1790500, 3581.00
Bytes Out     [total, mean]                     77000, 154.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:500
Error Set:
=============================================
Bucket           #    %       Histogram
[0s,     2ms]    362  72.40%  ######################################################
[2ms,    4ms]    113  22.60%  ################
[4ms,    6ms]    24   4.80%   ###
[6ms,    8ms]    0    0.00%
[8ms,    10ms]   0    0.00%
[10ms,   15ms]   1    0.20%
[15ms,   20ms]   0    0.00%
[20ms,   40ms]   0    0.00%
[40ms,   80ms]   0    0.00%
[80ms,   125ms]  0    0.00%
[125ms,  200ms]  0    0.00%
[200ms,  +Inf]   0    0.00%
=============================================
[Platform: Apollo & Knex]
[Query: artists_collaboration]
Requests      [total, rate, throughput]         150, 30.20, 30.17
Duration      [total, attack, wait]             4.971s, 4.967s, 4.621ms
Latencies     [min, mean, 50, 90, 95, 99, max]  3.217ms, 6.085ms, 4.763ms, 10.561ms, 11.09ms, 16.415ms, 32.305ms
Bytes In      [total, mean]                     53550, 357.00
Bytes Out     [total, mean]                     13350, 89.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:150
Error Set:
=============================================
Bucket           #   %       Histogram
[0s,     2ms]    0   0.00%
[2ms,    4ms]    35  23.33%  #################
[4ms,    6ms]    67  44.67%  #################################
[6ms,    8ms]    15  10.00%  #######
[8ms,    10ms]   15  10.00%  #######
[10ms,   15ms]   15  10.00%  #######
[15ms,   20ms]   2   1.33%   #
[20ms,   40ms]   1   0.67%
[40ms,   80ms]   0   0.00%
[80ms,   125ms]  0   0.00%
[125ms,  200ms]  0   0.00%
[200ms,  +Inf]   0   0.00%
=============================================
[Platform: Hasura]
[Query: artists_collaboration]
Requests      [total, rate, throughput]         500, 100.20, 100.17
Duration      [total, attack, wait]             4.991s, 4.99s, 1.302ms
Latencies     [min, mean, 50, 90, 95, 99, max]  996.824µs, 1.498ms, 1.301ms, 2.188ms, 2.651ms, 3.88ms, 4.469ms
Bytes In      [total, mean]                     172500, 345.00
Bytes Out     [total, mean]                     89500, 179.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:500
Error Set:
=============================================
Bucket           #    %       Histogram
[0s,     2ms]    445  89.00%  ##################################################################
[2ms,    4ms]    50   10.00%  #######
[4ms,    6ms]    5    1.00%
[6ms,    8ms]    0    0.00%
[8ms,    10ms]   0    0.00%
[10ms,   15ms]   0    0.00%
[15ms,   20ms]   0    0.00%
[20ms,   40ms]   0    0.00%
[40ms,   80ms]   0    0.00%
[80ms,   125ms]  0    0.00%
[125ms,  200ms]  0    0.00%
[200ms,  +Inf]   0    0.00%
=============================================
[Platform: Apollo & Knex]
[Query: tracks_media_all]
Requests      [total, rate, throughput]         500, 100.20, 0.11
Duration      [total, attack, wait]             34.99s, 4.99s, 30s
Latencies     [min, mean, 50, 90, 95, 99, max]  1.913s, 29.776s, 30s, 30s, 30s, 30s, 30.005s
Bytes In      [total, mean]                     1163612, 2327.22
Bytes Out     [total, mean]                     328, 0.66
Success       [ratio]                           0.80%
Status Codes  [code:count]                      0:496  200:4
Error Set:
Post http://localhost:8081/graphql: net/http: request canceled (Client.Timeout exceeded while awaiting headers)
=============================================
Bucket           #    %        Histogram
[0s,     2ms]    0    0.00%
[2ms,    4ms]    0    0.00%
[4ms,    6ms]    0    0.00%
[6ms,    8ms]    0    0.00%
[8ms,    10ms]   0    0.00%
[10ms,   15ms]   0    0.00%
[15ms,   20ms]   0    0.00%
[20ms,   40ms]   0    0.00%
[40ms,   80ms]   0    0.00%
[80ms,   125ms]  0    0.00%
[125ms,  200ms]  0    0.00%
[200ms,  +Inf]   500  100.00%  ###########################################################################
=============================================
[Platform: Hasura]
[Query: tracks_media_all]
Requests      [total, rate, throughput]         500, 100.20, 100.01
Duration      [total, attack, wait]             5s, 4.99s, 9.594ms
Latencies     [min, mean, 50, 90, 95, 99, max]  8.139ms, 12.931ms, 11.458ms, 18.532ms, 20.969ms, 28.793ms, 42.598ms
Bytes In      [total, mean]                     147202000, 294404.00
Bytes Out     [total, mean]                     41000, 82.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:500
Error Set:
=============================================
Bucket           #    %       Histogram
[0s,     2ms]    0    0.00%
[2ms,    4ms]    0    0.00%
[4ms,    6ms]    0    0.00%
[6ms,    8ms]    0    0.00%
[8ms,    10ms]   138  27.60%  ####################
[10ms,   15ms]   241  48.20%  ####################################
[15ms,   20ms]   88   17.60%  #############
[20ms,   40ms]   32   6.40%   ####
[40ms,   80ms]   1    0.20%
[80ms,   125ms]  0    0.00%
[125ms,  200ms]  0    0.00%
[200ms,  +Inf]   0    0.00%
=============================================
[Platform: Apollo & Knex]
[Query: tracks_media_some]
Requests      [total, rate, throughput]         500, 100.20, 94.85
Duration      [total, attack, wait]             5.272s, 4.99s, 281.92ms
Latencies     [min, mean, 50, 90, 95, 99, max]  39.978ms, 450.96ms, 459.866ms, 678.401ms, 720.788ms, 787.893ms, 837.117ms
Bytes In      [total, mean]                     1805000, 3610.00
Bytes Out     [total, mean]                     61000, 122.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:500
Error Set:
=============================================
Bucket           #    %       Histogram
[0s,     2ms]    0    0.00%
[2ms,    4ms]    0    0.00%
[4ms,    6ms]    0    0.00%
[6ms,    8ms]    0    0.00%
[8ms,    10ms]   0    0.00%
[10ms,   15ms]   0    0.00%
[15ms,   20ms]   0    0.00%
[20ms,   40ms]   1    0.20%
[40ms,   80ms]   13   2.60%   #
[80ms,   125ms]  8    1.60%   #
[125ms,  200ms]  30   6.00%   ####
[200ms,  +Inf]   448  89.60%  ###################################################################
=============================================
[Platform: Hasura]
[Query: tracks_media_some]
Requests      [total, rate, throughput]         500, 100.20, 100.16
Duration      [total, attack, wait]             4.992s, 4.99s, 2.283ms
Latencies     [min, mean, 50, 90, 95, 99, max]  1.205ms, 2.289ms, 1.961ms, 3.66ms, 4.521ms, 6.955ms, 11.491ms
Bytes In      [total, mean]                     1811000, 3622.00
Bytes Out     [total, mean]                     76500, 153.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:500
Error Set:
=============================================
Bucket           #    %       Histogram
[0s,     2ms]    257  51.40%  ######################################
[2ms,    4ms]    200  40.00%  ##############################
[4ms,    6ms]    30   6.00%   ####
[6ms,    8ms]    12   2.40%   #
[8ms,    10ms]   0    0.00%
[10ms,   15ms]   1    0.20%
[15ms,   20ms]   0    0.00%
[20ms,   40ms]   0    0.00%
[40ms,   80ms]   0    0.00%
[80ms,   125ms]  0    0.00%
[125ms,  200ms]  0    0.00%
[200ms,  +Inf]   0    0.00%
=============================================
[Platform: Apollo & Knex]
[Query: artist_by_id]
Requests      [total, rate, throughput]         500, 100.20, 100.15
Duration      [total, attack, wait]             4.993s, 4.99s, 2.74ms
Latencies     [min, mean, 50, 90, 95, 99, max]  2.159ms, 3.385ms, 2.973ms, 4.723ms, 6.609ms, 7.512ms, 16.863ms
Bytes In      [total, mean]                     30000, 60.00
Bytes Out     [total, mean]                     29000, 58.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:500
Error Set:
=============================================
Bucket           #    %       Histogram
[0s,     2ms]    0    0.00%
[2ms,    4ms]    427  85.40%  ################################################################
[4ms,    6ms]    38   7.60%   #####
[6ms,    8ms]    31   6.20%   ####
[8ms,    10ms]   1    0.20%
[10ms,   15ms]   1    0.20%
[15ms,   20ms]   2    0.40%
[20ms,   40ms]   0    0.00%
[40ms,   80ms]   0    0.00%
[80ms,   125ms]  0    0.00%
[125ms,  200ms]  0    0.00%
[200ms,  +Inf]   0    0.00%
=============================================
[Platform: Hasura]
[Query: artist_by_id]
Requests      [total, rate, throughput]         500, 100.20, 100.19
Duration      [total, attack, wait]             4.991s, 4.99s, 795.979µs
Latencies     [min, mean, 50, 90, 95, 99, max]  627.829µs, 1.213ms, 1.028ms, 2.04ms, 2.17ms, 2.563ms, 4.007ms
Bytes In      [total, mean]                     27500, 55.00
Bytes Out     [total, mean]                     49000, 98.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:500
Error Set:
=============================================
Bucket           #    %       Histogram
[0s,     2ms]    441  88.20%  ##################################################################
[2ms,    4ms]    58   11.60%  ########
[4ms,    6ms]    1    0.20%
[6ms,    8ms]    0    0.00%
[8ms,    10ms]   0    0.00%
[10ms,   15ms]   0    0.00%
[15ms,   20ms]   0    0.00%
[20ms,   40ms]   0    0.00%
[40ms,   80ms]   0    0.00%
[80ms,   125ms]  0    0.00%
[125ms,  200ms]  0    0.00%
[200ms,  +Inf]   0    0.00%
```
