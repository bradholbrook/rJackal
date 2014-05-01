rJackal [![Build Status](https://travis-ci.org/holbrookbw1/rJackal.svg?branch=master)](https://travis-ci.org/holbrookbw1/rJackal)
=======

A website to see, write, and rate apartment reviews from our users and from around the web.

## Getting Started Guide

Make sure you have the RVM, Ruby 1.9.3, the latest Rails, PostgreSQL 9.3.2, and the AWS EB CLI isntalled. The following list will point you in the right direction.

* [Install Ruby and Rails with RVM](https://www.digitalocean.com/community/articles/how-to-install-ruby-on-rails-on-ubuntu-12-04-lts-precise-pangolin-with-rvm)
* [Install Postgres 9.3.2](https://gist.github.com/pyk/8243010)
* [AWS EB CLI Download](http://aws.amazon.com/code/6752709412171743)
* [Add 'eb' to Path](http://compositecode.com/coding-community/documentation-for/amazon-web-services/elastic-beanstalk-setting-up-eb-command-line-tools/)

Clone the repository. If you dont know how to find the path, here is the git command:

```git clone https://www.github.com/holbrookbw1/rJackal```

Run the bundler to install gems with `bundle install`.

Setup the databse with `rake db:drop db:create db:migrate`

Run `rails s` to start a local server.

Push the project to Elastic Beanstalk, if you're signed up for AWS.

* [Pushing to EB With the CLI](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-reference-get-started.html)

## Possible Problems

Some problems I ran into and how to fix them.

If you try a `git aws.push` and get an error like "No module 'boto'" or "No module boto.beanstalk", make sure you install boto with pip.

```
sudo apt-get install python-pip
pip install boto
```