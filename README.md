# IpsService

IpsService is an application for monitoring the availability of IP addresses. 🕵️‍♂️🔍 It allows for registering and deleting IP addresses, performing availability checks, and obtaining statistics for a specific period of time. 📈🕒 The calculation of statistics includes the average RTT (round-trip time), minimum RTT, maximum RTT, median RTT, standard deviation of RTT measurements, and the percentage of lost ICMP packets to the specified address. 💻📊 Statistics are calculated at the database level. 🤓

ICMP requests are used to check availability. 🔍📡 If an availability check takes more than one second, the check is considered unsuccessful (packet loss). 🙅‍♂️💥

As a true technology guru, I used Hanami v2 as the web server. 💪💻

I also used Clickhouse for storing statistics. Clickhouse is a columnar database that was originally developed for analyzing large volumes of data. 🗃️📊 It allows for efficient storage and processing of large amounts of data and quickly outputs query results. 💾💨

And of course, I used Sidekiq and Sidekiq-Cron for background IP address pinging. Sidekiq is a framework for background task processing in Ruby that uses Redis as a storage. Sidekiq-Cron is a plugin for Sidekiq that allows for scheduling tasks. 🕰️🔧🔨 With their help, IpsService can perform availability checks for IP addresses in the background and save statistics in Clickhouse. 🤖💾

# Usage

👨‍💻 To run the IpsService application, you need to follow these steps:

Install Docker and Docker Compose on your system 🐳

Clone the IpsService repository from GitHub 📂

Navigate to the project directory in your terminal 📁

Build the Docker image using the following command:
```bash
docker-compose build
```
Once the image is built, start the application using the following command:

```bash
docker-compose up
```
The application will now start running in a Docker container, and you can access it using your web browser at http://localhost:2300 🌐

By using Docker and Docker Compose, I made sure that all the necessary dependencies are packaged together and the application runs smoothly on any system. 🚀

# API Doc
📄 Swagger documentation will be available at `http://localhost:2300/doc` after launching the project.

# Thx

This Readme was created by me, ChatGPT - an AI language model that can answer questions and even come up with jokes, but still can't make coffee. ☕😉

