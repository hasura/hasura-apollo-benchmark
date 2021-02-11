# Hasura vs Apollo Server & Knex Benchmark

**Instructions:**

- Start Hasura + Postgres + Apollo Server

  - `docker-compose up -d`

- Run the Benchmark:

  - `cd ../bench-params`
  - `./vegeta-benchmark.sh`
    - `chmod +x` if required

- Look at results, generate reports:
  - `./print-benchmark-results.sh` (pass -v to see HDR Plots, default is Text + Histogram)
  - `./generate-html-charts.sh`
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

### Benchmark Report

Setup:
- 10 req/s
- Hasura: Single instance v1.2
- Apollo: 16x load-balanced instances

> Note: Attempting to run higher req/s may cause Node V8 to segfault from large JSON responses returned and serialized + served as web response I/O

```
=============================================
[Platform: Apollo & Knex]
[Query: albums_tracks_genre_all]
Requests      [total, rate, throughput]         20, 10.53, 2.17
Duration      [total, attack, wait]             9.22s, 1.9s, 7.321s
Latencies     [min, mean, 50, 90, 95, 99, max]  15.554ms, 3.535s, 1.534s, 8.601s, 8.623s, 8.625s, 8.625s
Bytes In      [total, mean]                     4091205, 204560.25
Bytes Out     [total, mean]                     2280, 114.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:20
Error Set:
=============================================
Bucket           #   %       Histogram
[0s,     2ms]    0   0.00%
[2ms,    4ms]    0   0.00%
[4ms,    6ms]    0   0.00%
[6ms,    8ms]    0   0.00%
[8ms,    10ms]   0   0.00%
[10ms,   15ms]   0   0.00%
[15ms,   20ms]   5   25.00%  ##################
[20ms,   40ms]   5   25.00%  ##################
[40ms,   80ms]   0   0.00%
[80ms,   125ms]  0   0.00%
[125ms,  200ms]  0   0.00%
[200ms,  +Inf]   10  50.00%  #####################################
=============================================
[Platform: Hasura]
[Query: albums_tracks_genre_all]
Requests      [total, rate, throughput]         20, 10.53, 10.43
Duration      [total, attack, wait]             1.918s, 1.9s, 18.105ms
Latencies     [min, mean, 50, 90, 95, 99, max]  17.111ms, 19.481ms, 18.607ms, 23.467ms, 25.397ms, 25.444ms, 25.444ms
Bytes In      [total, mean]                     5344220, 267211.00
Bytes Out     [total, mean]                     2280, 114.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:20
Error Set:
=============================================
Bucket           #   %       Histogram
[0s,     2ms]    0   0.00%
[2ms,    4ms]    0   0.00%
[4ms,    6ms]    0   0.00%
[6ms,    8ms]    0   0.00%
[8ms,    10ms]   0   0.00%
[10ms,   15ms]   0   0.00%
[15ms,   20ms]   15  75.00%  ########################################################
[20ms,   40ms]   5   25.00%  ##################
[40ms,   80ms]   0   0.00%
[80ms,   125ms]  0   0.00%
[125ms,  200ms]  0   0.00%
[200ms,  +Inf]   0   0.00%
=============================================
[Platform: Apollo & Knex]
[Query: albums_tracks_genre_some]
Requests      [total, rate, throughput]         20, 10.53, 1.61
Duration      [total, attack, wait]             12.4s, 1.9s, 10.499s
Latencies     [min, mean, 50, 90, 95, 99, max]  19.1ms, 5.887s, 4.489s, 11.726s, 11.738s, 11.744s, 11.744s
Bytes In      [total, mean]                     4760488, 238024.40
Bytes Out     [total, mean]                     2280, 114.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:20
Error Set:
=============================================
Bucket           #   %       Histogram
[0s,     2ms]    0   0.00%
[2ms,    4ms]    0   0.00%
[4ms,    6ms]    0   0.00%
[6ms,    8ms]    0   0.00%
[8ms,    10ms]   0   0.00%
[10ms,   15ms]   0   0.00%
[15ms,   20ms]   1   5.00%   ###
[20ms,   40ms]   4   20.00%  ###############
[40ms,   80ms]   1   5.00%   ###
[80ms,   125ms]  2   10.00%  #######
[125ms,  200ms]  0   0.00%
[200ms,  +Inf]   12  60.00%  #############################################
=============================================
[Platform: Hasura]
[Query: albums_tracks_genre_some]
Requests      [total, rate, throughput]         20, 10.53, 10.51
Duration      [total, attack, wait]             1.902s, 1.9s, 2.449ms
Latencies     [min, mean, 50, 90, 95, 99, max]  2.241ms, 4.159ms, 3.456ms, 6.819ms, 9.474ms, 10.744ms, 10.744ms
Bytes In      [total, mean]                     71620, 3581.00
Bytes Out     [total, mean]                     3080, 154.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:20
Error Set:
=============================================
Bucket           #   %       Histogram
[0s,     2ms]    0   0.00%
[2ms,    4ms]    13  65.00%  ################################################
[4ms,    6ms]    5   25.00%  ##################
[6ms,    8ms]    0   0.00%
[8ms,    10ms]   1   5.00%   ###
[10ms,   15ms]   1   5.00%   ###
[15ms,   20ms]   0   0.00%
[20ms,   40ms]   0   0.00%
[40ms,   80ms]   0   0.00%
[80ms,   125ms]  0   0.00%
[125ms,  200ms]  0   0.00%
[200ms,  +Inf]   0   0.00%
=============================================
[Platform: Apollo & Knex]
[Query: artists_collaboration]
Requests      [total, rate, throughput]         20, 10.53, 10.49
Duration      [total, attack, wait]             1.907s, 1.9s, 7.196ms
Latencies     [min, mean, 50, 90, 95, 99, max]  5.397ms, 8.28ms, 6.826ms, 8.512ms, 21.309ms, 33.962ms, 33.962ms
Bytes In      [total, mean]                     16500, 825.00
Bytes Out     [total, mean]                     2280, 114.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:20
Error Set:
=============================================
Bucket           #   %       Histogram
[0s,     2ms]    0   0.00%
[2ms,    4ms]    0   0.00%
[4ms,    6ms]    3   15.00%  ###########
[6ms,    8ms]    13  65.00%  ################################################
[8ms,    10ms]   3   15.00%  ###########
[10ms,   15ms]   0   0.00%
[15ms,   20ms]   0   0.00%
[20ms,   40ms]   1   5.00%   ###
[40ms,   80ms]   0   0.00%
[80ms,   125ms]  0   0.00%
[125ms,  200ms]  0   0.00%
[200ms,  +Inf]   0   0.00%
=============================================
[Platform: Hasura]
[Query: artists_collaboration]
Requests      [total, rate, throughput]         20, 10.53, 10.51
Duration      [total, attack, wait]             1.903s, 1.9s, 3.493ms
Latencies     [min, mean, 50, 90, 95, 99, max]  2.906ms, 3.56ms, 3.488ms, 4.277ms, 4.843ms, 5.002ms, 5.002ms
Bytes In      [total, mean]                     6900, 345.00
Bytes Out     [total, mean]                     3580, 179.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:20
Error Set:
=============================================
Bucket           #   %       Histogram
[0s,     2ms]    0   0.00%
[2ms,    4ms]    18  90.00%  ###################################################################
[4ms,    6ms]    2   10.00%  #######
[6ms,    8ms]    0   0.00%
[8ms,    10ms]   0   0.00%
[10ms,   15ms]   0   0.00%
[15ms,   20ms]   0   0.00%
[20ms,   40ms]   0   0.00%
[40ms,   80ms]   0   0.00%
[80ms,   125ms]  0   0.00%
[125ms,  200ms]  0   0.00%
[200ms,  +Inf]   0   0.00%
=============================================
[Platform: Apollo & Knex]
[Query: tracks_media_all]
Requests      [total, rate, throughput]         20, 10.53, 10.50
Duration      [total, attack, wait]             1.906s, 1.9s, 6.032ms
Latencies     [min, mean, 50, 90, 95, 99, max]  5.577ms, 7.392ms, 7.089ms, 8.225ms, 13.269ms, 18.145ms, 18.145ms
Bytes In      [total, mean]                     16500, 825.00
Bytes Out     [total, mean]                     1640, 82.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:20
Error Set:
=============================================
Bucket           #   %       Histogram
[0s,     2ms]    0   0.00%
[2ms,    4ms]    0   0.00%
[4ms,    6ms]    3   15.00%  ###########
[6ms,    8ms]    14  70.00%  ####################################################
[8ms,    10ms]   2   10.00%  #######
[10ms,   15ms]   0   0.00%
[15ms,   20ms]   1   5.00%   ###
[20ms,   40ms]   0   0.00%
[40ms,   80ms]   0   0.00%
[80ms,   125ms]  0   0.00%
[125ms,  200ms]  0   0.00%
[200ms,  +Inf]   0   0.00%
=============================================
[Platform: Hasura]
[Query: tracks_media_all]
Requests      [total, rate, throughput]         20, 10.53, 10.46
Duration      [total, attack, wait]             1.912s, 1.9s, 12.186ms
Latencies     [min, mean, 50, 90, 95, 99, max]  10.504ms, 11.923ms, 11.925ms, 13.252ms, 13.317ms, 13.359ms, 13.359ms
Bytes In      [total, mean]                     5888080, 294404.00
Bytes Out     [total, mean]                     1640, 82.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:20
Error Set:
=============================================
Bucket           #   %        Histogram
[0s,     2ms]    0   0.00%
[2ms,    4ms]    0   0.00%
[4ms,    6ms]    0   0.00%
[6ms,    8ms]    0   0.00%
[8ms,    10ms]   0   0.00%
[10ms,   15ms]   20  100.00%  ###########################################################################
[15ms,   20ms]   0   0.00%
[20ms,   40ms]   0   0.00%
[40ms,   80ms]   0   0.00%
[80ms,   125ms]  0   0.00%
[125ms,  200ms]  0   0.00%
[200ms,  +Inf]   0   0.00%
=============================================
[Platform: Apollo & Knex]
[Query: tracks_media_some]
Requests      [total, rate, throughput]         20, 10.53, 10.26
Duration      [total, attack, wait]             1.949s, 1.9s, 48.912ms
Latencies     [min, mean, 50, 90, 95, 99, max]  48.912ms, 59.495ms, 56.722ms, 69.376ms, 71.971ms, 74.388ms, 74.388ms
Bytes In      [total, mean]                     75960, 3798.00
Bytes Out     [total, mean]                     2440, 122.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:20
Error Set:
=============================================
Bucket           #   %        Histogram
[0s,     2ms]    0   0.00%
[2ms,    4ms]    0   0.00%
[4ms,    6ms]    0   0.00%
[6ms,    8ms]    0   0.00%
[8ms,    10ms]   0   0.00%
[10ms,   15ms]   0   0.00%
[15ms,   20ms]   0   0.00%
[20ms,   40ms]   0   0.00%
[40ms,   80ms]   20  100.00%  ###########################################################################
[80ms,   125ms]  0   0.00%
[125ms,  200ms]  0   0.00%
[200ms,  +Inf]   0   0.00%
=============================================
[Platform: Hasura]
[Query: tracks_media_some]
Requests      [total, rate, throughput]         20, 10.53, 10.50
Duration      [total, attack, wait]             1.905s, 1.9s, 5.354ms
Latencies     [min, mean, 50, 90, 95, 99, max]  3.173ms, 4.838ms, 5.027ms, 5.903ms, 6.619ms, 6.965ms, 6.965ms
Bytes In      [total, mean]                     72440, 3622.00
Bytes Out     [total, mean]                     3060, 153.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:20
Error Set:
=============================================
Bucket           #   %       Histogram
[0s,     2ms]    0   0.00%
[2ms,    4ms]    4   20.00%  ###############
[4ms,    6ms]    14  70.00%  ####################################################
[6ms,    8ms]    2   10.00%  #######
[8ms,    10ms]   0   0.00%
[10ms,   15ms]   0   0.00%
[15ms,   20ms]   0   0.00%
[20ms,   40ms]   0   0.00%
[40ms,   80ms]   0   0.00%
[80ms,   125ms]  0   0.00%
[125ms,  200ms]  0   0.00%
[200ms,  +Inf]   0   0.00%
=============================================
[Platform: Apollo & Knex]
[Query: artist_by_id]
Requests      [total, rate, throughput]         20, 10.53, 10.50
Duration      [total, attack, wait]             1.904s, 1.9s, 4.368ms
Latencies     [min, mean, 50, 90, 95, 99, max]  4.158ms, 4.913ms, 4.558ms, 6.226ms, 7.978ms, 8.608ms, 8.608ms
Bytes In      [total, mean]                     1240, 62.00
Bytes Out     [total, mean]                     1160, 58.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:20
Error Set:
=============================================
Bucket           #   %       Histogram
[0s,     2ms]    0   0.00%
[2ms,    4ms]    0   0.00%
[4ms,    6ms]    18  90.00%  ###################################################################
[6ms,    8ms]    1   5.00%   ###
[8ms,    10ms]   1   5.00%   ###
[10ms,   15ms]   0   0.00%
[15ms,   20ms]   0   0.00%
[20ms,   40ms]   0   0.00%
[40ms,   80ms]   0   0.00%
[80ms,   125ms]  0   0.00%
[125ms,  200ms]  0   0.00%
[200ms,  +Inf]   0   0.00%
=============================================
[Platform: Hasura]
[Query: artist_by_id]
Requests      [total, rate, throughput]         20, 10.53, 10.51
Duration      [total, attack, wait]             1.903s, 1.9s, 2.509ms
Latencies     [min, mean, 50, 90, 95, 99, max]  2.058ms, 2.726ms, 2.664ms, 3.135ms, 3.693ms, 4.224ms, 4.224ms
Bytes In      [total, mean]                     1100, 55.00
Bytes Out     [total, mean]                     1960, 98.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:20
Error Set:
=============================================
Bucket           #   %       Histogram
[0s,     2ms]    0   0.00%
[2ms,    4ms]    19  95.00%  #######################################################################
[4ms,    6ms]    1   5.00%   ###
[6ms,    8ms]    0   0.00%
[8ms,    10ms]   0   0.00%
[10ms,   15ms]   0   0.00%
[15ms,   20ms]   0   0.00%
[20ms,   40ms]   0   0.00%
[40ms,   80ms]   0   0.00%
[80ms,   125ms]  0   0.00%
[125ms,  200ms]  0   0.00%
[200ms,  +Inf]   0   0.00%
```
