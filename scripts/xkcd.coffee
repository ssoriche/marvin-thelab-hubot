# Description:
#   Grab XKCD comic image urls
#
# Commands:
#   .xkcd [latest]- The latest XKCD comic
#   !xkcd [latest]- The latest XKCD comic
#
#   .xkcd <num> - XKCD comic <num>
#   !xkcd <num> - XKCD comic <num>
#
#   .xkcd r - XKCD comic <num>
#   !xkcd r - XKCD comic <num>
#
# Author:
#   twe4ked
#   Hemanth (fixed the max issue)
#
# Modified by:
#   @katagatame_ <nathan@kaizotrap.com>

module.exports = (robot) ->
  robot.hear /^[\.!]xkcd(\s+latest)?$/i, (msg) ->
    msg.http("http://xkcd.com/info.0.json")
      .get() (err, res, body) ->
        if res.statusCode == 404
          msg.send 'Comic not found.'
        else
          object = JSON.parse(body)
          msg.send object.title, object.img, object.alt

  robot.hear /^[\.!]xkcd\s+(\d+)/i, (msg) ->
    num = "#{msg.match[1]}"

    msg.http("http://xkcd.com/#{num}/info.0.json")
      .get() (err, res, body) ->
        if res.statusCode == 404
          msg.send 'Comic #{num} not found.'
        else
          object = JSON.parse(body)
          msg.send object.title, object.img, object.alt

  robot.hear /^[\.!]xkcd(\s+r)?$/i, (msg) ->
    msg.http("http://xkcd.com/info.0.json")
          .get() (err,res,body) ->
            if res.statusCode == 404
               max = 0
            else
               max = JSON.parse(body).num 
               num = Math.floor((Math.random()*max)+1)
               msg.http("http://xkcd.com/#{num}/info.0.json")
               .get() (err, res, body) ->
                 object = JSON.parse(body)
                 msg.send object.title, object.img, object.alt
