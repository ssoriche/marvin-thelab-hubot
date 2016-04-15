# Description
#   hubot scripts for the division
#
# Commands:
#   hubot ping - Reply with pong
#
# Author:
#   Nathan Ray <nathan@kaizotrap.com>

module.exports = (robot) ->
   robot.hear /.weapon div (.*)/i, (msg) ->
     weaponName = msg.match[1]
     robot.http("https://thedivision.kaizotrap.com/weapons.min.json")
       .header('Accept', 'application/json')
       .get() (err, res, body) ->
         weapons = JSON.parse body
         weaponFound = ""
         for weapon in weapons
           if weapon.name == weaponName
             weaponFound = weapon

         if weaponFound == ""
           msg.send "Weapon not found."
         else
           msg.send "```\n" + weaponFound.name + "\n" + weaponFound.type + "\nAccuracy:      " + weaponFound.accuracy + "\nStability:     " + weaponFound.stability + "\nOptimal Range: " + weaponFound.optimalRange + "\nReload Speed:  " + weaponFound.reloadTime + "```"