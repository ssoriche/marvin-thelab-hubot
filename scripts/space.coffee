# Description:
#  Look at outer space
#
# Dependencies:
# "cheerio": "0.19.0"
#
# Configuration:
#   None
#
# Commands:
#  hubot space - Get a random picture of space.
#
# Notes:
#  None
#
# Author:
#  @katagatame_
cheerio = require("cheerio")

module.exports = (robot) ->
  robot.hear /.spod/i, (msg) ->
    url = "http://apod.nasa.gov/apod/astropix.html"
    msg.http(url).get() (err, resp, body) ->
      $ = cheerio.load(body)
      msg.send "http://apod.nasa.gov/apod/" + $('img').attr('src')