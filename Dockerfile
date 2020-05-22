FROM ubuntu:20.04
ARG terraria_version=1403
ARG terraria_config=world.conf
ARG terraria_dir=/home/terraria
USER root
RUN useradd -ms /bin/bash terraria
RUN apt-get update && apt-get -y install unzip
WORKDIR ${terraria_dir}
COPY ${terraria_config} ${terraria_dir}/config
ADD https://terraria.org/system/dedicated_servers/archives/000/000/037/original/terraria-server-${terraria_version}.zip ${terraria_dir}/server.zip
RUN chown -R terraria:terraria ${terraria_dir}
RUN unzip ${terraria_dir}/server.zip
WORKDIR "${terraria_dir}/${terraria_version}/Linux/"
RUN chmod +x $PWD/TerrariaServer*
ENV CONFIG=${terraria_dir}/config
EXPOSE 7777
CMD ["sh", "-c", "./TerrariaServer -config $CONFIG"]



