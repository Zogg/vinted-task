#!/usr/bin/env bats

@test "Mail is sent to bob@localhost and put into Redis" {
  run /usr/local/bin/redis-cli flushdb && date | mail -s "Testing MTA Redis" bob@localhost && date | mail -s "Testing MTA Redis" bob@localhost && sleep 1 && /usr/local/bin/redis-cli lrange bob@localhost 0 -1 | grep "Testing MTA"
  [ "$status" -eq 0 ]
}
