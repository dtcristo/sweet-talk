# Sweet Talk

A simple chatroom. Sweet Talk is built on [Sinatra](http://www.sinatrarb.com/) (the minimal web framework for Ruby) and uses the [Faye](http://faye.jcoglan.com/) publish-subscribe messaging system.

![Screenshot](https://raw.github.com/dtcristo/sweet_talk/master/assets/screenshot.png)

## Installation

Clone the repo:

    $ git clone https://github.com/dtcristo/sweet_talk.git
    $ cd sweet_talk

Copy the example environment configuration and fill it out:

    $ cp .env.example .env
    $ nano .env

Install dependencies:

    $ bundle install

Start `puma` web server with desired port and environment:

    $ puma -p 3000 -e production

You're all set for some sweet talk.

## Todo

* Multiple chat rooms (create your own)
* Per-user authentication
* Persist messages
