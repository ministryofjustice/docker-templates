#!/bin/bash

cat <<EOT

  input {
    file {
      path => "/app/log/app.log"
      type => "tbd"
      add_field => [ "project",   "$PROJECT" ]
      add_field => [ "appserver", "tbd" ]
      add_field => [ "version",   "$APPVERSION" ]
      add_field => [ "env",       "$ENV" ]
    }
  }
  output {
    redis { host => "$LOGSTASH_SERVER" data_type => "list" key => "logstash" }
  }

EOT

