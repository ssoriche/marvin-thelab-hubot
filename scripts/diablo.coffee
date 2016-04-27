#   General purpose script to support Diablo 3
#
# Commands:
#   .D3 link <battleTag#1234> - Links specified battleTag to user.
#   !D3 link <battleTag#1234> - Links specified battleTag to user.
#
#   .D3 chars - Displays current character list for user.
#   !D3 chars - Displays current character list for user.
#
# Author:
#   @katagatame_ <nathan@kaizotrap.com>

# Global variable declaration
urlBase = "https://us.api.battle.net/d3/profile/"
locale = "locale=en_US"
apiKey = "qwwv99zw2e8jpueh8e3cbd4p77krdhpu"

module.exports = (robot) ->
  # .d3 link
  robot.hear /^[\.!]D3 link (.*)/i, (msg) ->
    # Variable declaration
    nick = "#{msg.message.user.name}"
    err_msg = "Invalid use of link command. Use: .d3 link battleTag#1234"
    validate = /#/.test(msg.match[1])

    if validate == true
      battleTag = msg.match[1].replace /#/, "%23"
      
      # Add battleTag
      robot.brain.set 'msg.message.user.name.toLowerCase()', battleTag
      
      # Confirmation message
      msg.send msg.match[1] + " linked to " + nick
    else
      msg.send err_msg    

  # .d3 chars
  robot.hear /^[\.!]D3 chars/i, (msg) ->
    # Check for nick
    battleTag = robot.brain.get('msg.message.user.name.toLowerCase()')

    uppercase = (str) ->
      a1 = str.split(" ")
      a2 = []
      x = 0
      while x < a1.length
        a2.push a1[x].charAt(0).toUpperCase() + a1[x].slice(1)
        x++
      a2.join ' '

    robot.http(urlBase + battleTag + "/?" + locale + "&apikey=" + apiKey)
    .header('Accept', 'application/json')
    .get() (err, res, body) ->
      chars = JSON.parse body
      charList = ""
      if chars.code == "NOTFOUND"
        msg.send "```No characters found.```"
      else
        for char in chars.heroes
          charClass = char.class.replace /-/, " "
          charList += char.level + " - " + char.name + " - " + uppercase(charClass) + "\n"

        msg.send "```" + charList + "```"
