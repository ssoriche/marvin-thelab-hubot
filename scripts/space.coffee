# Description:
#  NASA - Astronomy Picture of the Day
#
# Dependencies:
# "cheerio": "0.19.0"
#
# Commands:
#  .apod - returns the NASA APOD
#
# Author:
#  @katagatame_
cheerio = require("cheerio")

module.exports = (robot) ->
  robot.hear /.apod/i, (msg) ->
    url = "http://apod.nasa.gov/apod/astropix.html"
    msg.http(url).get() (err, resp, body) ->
      $ = cheerio.load(body)
      msg.send "http://apod.nasa.gov/apod/" + $('img').attr('src')