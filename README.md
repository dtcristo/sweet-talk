# Sweet Talk

A simple chatroom.

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
