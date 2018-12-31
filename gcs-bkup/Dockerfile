FROM google/cloud-sdk:slim
LABEL maintainer="suzukenz"

ENV HOME /root
ENV SAVE_DIR /7d2d/Save
ENV LOGS_DIR /7d2d/7DaysToDieServer_Data
ENV GCS_SAVE_URL gs://seven-days-2d/save
ENV GCS_LOGS_URL gs://seven-days-2d/logs

RUN apt-get update && apt-get install -y \
  busybox-static \
  && apt-get clean

WORKDIR ${HOME}

COPY backup.sh backup.sh
COPY create-and-restore-save.sh create-and-restore-save.sh
COPY run.sh run.sh
COPY crontab /var/spool/cron/crontabs/root

ENTRYPOINT ["./run.sh"]
