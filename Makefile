PROJECT = shuwa_statsd
PROJECT_DESCRIPTION = Statsd for EMQ X

NO_AUTOPATCH = prometheus.erl

DEPS = prometheus
dep_prometheus = git-emqx https://github.com/turtleDeng/prometheus.erl v3.1.1

CUR_BRANCH := $(shell git branch | grep -e "^*" | cut -d' ' -f 2)
BRANCH := $(if $(filter $(CUR_BRANCH), master develop), $(CUR_BRANCH), develop)


ERLC_OPTS += +'{parse_transform, lager_transform}'

COVER = true

$(shell [ -f erlang.mk ] || curl -s -o erlang.mk https://raw.githubusercontent.com/emqx/erlmk/master/erlang.mk)
include erlang.mk

app.config::
	./deps/cuttlefish/cuttlefish -l info -e etc/ -c etc/shuwa_statsd.conf -i priv/shuwa_statsd.schema -d data
