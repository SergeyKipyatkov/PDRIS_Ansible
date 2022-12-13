FROM node:16

RUN apt-get update
RUN apt-get -y install git nodejs
RUN git clone https://github.com/SergeyKipyatkov/SampleApplicationForAnsibleHW

WORKDIR /ForTestContainer
RUN npm install

EXPOSE 8080
ENTRYPOINT npm start
