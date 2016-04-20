# Description:
#  NASA - Astronomy Picture of the Day
#
# Dependencies:
# "cheerio": "0.19.0"
#
# Commands:
#  Marvin apod - returns the NASA APOD and description
#
# Author:
#  @katagatame_
cheerio = require("cheerio")

module.exports = (robot) ->
  robot.respond /apod/i, (msg) ->
    url = "http://apod.nasa.gov/apod/astropix.html"
    msg.http(url).get() (err, resp, body) ->
      $ = cheerio.load(body)
      desc = $('center + center + p').text()
      desc = desc.replace(/(\r\n|\n|\r)/gm,"").trim()
      desc = "```" + desc + "```"
      msg.reply "http://apod.nasa.gov/apod/" + $('img').attr('src')
      msg.reply desc