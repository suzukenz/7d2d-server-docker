#!/usr/bin/expect
# If telnet port or password is changed on serverconfig.xml,
# you must modify this script.
set HOST localhost
set PORT 8081

spawn telnet $HOST $PORT

expect {
  -glob "Press 'exit' to end session." {
    send "saveworld\r"
  }
}

expect {
  -glob "World saved" {
    send "shutdown\r"
  }
}

expect {
  -glob "Connection closed" {
    exit 0
  }
}
