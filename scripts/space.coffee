# Description:
#  NASA - Astronomy Picture of the Day
#
# Dependency:
#  "cheerio": "0.19.0"
#
# Command:
#  .apod - returns the NASA APOD and description
#
# Author:
#  @katagatame_

cheerio = require("cheerio")

module.exports = (robot) ->
  robot.hear /^.apod/i, (msg) ->
    url = "http://apod.nasa.gov/apod/astropix.html"
    msg.http(url).get() (err, resp, body) ->
      $ = cheerio.load(body)
      desc = $('center + center + p').text().trim().replace(/(\r\n|\n|\r)/gm,"").replace(/(\s)+/g," ").replace(/(Explanation:)/,"**Explanation:**")
      msg.send "http://apod.nasa.gov/apod/" + $('img').attr('src')
      msg.send desc