# Description
#   General purpose script for the division
#
# Commands:
#   .weapon div <weapon> - returns infomation about the specified weapon
#   .weapons div <weapon> - returns infomation about the specified weapon
#   !weapon div <weapon> - returns infomation about the specified weapon
#   !weapons div <weapon> - returns infomation about the specified weapon
#
# Author:
#   @katagatame_ <nathan@kaizotrap.com>

module.exports = (robot) ->
   robot.hear /^[\.!]weapons? div (.*)/i, (msg) ->
     weaponName = msg.match[1]
     robot.http("https://thedivision.kaizotrap.com/weapons.min.json")
       .header('Accept', 'application/json')
       .get() (err, res, body) ->
         weapons = JSON.parse body
         weaponFound = ""
         for weapon in weapons
           if weapon.name.match ///#{weaponName}///i
             weaponFound = weapon

         if weaponFound == ""
           msg.send "Weapon not found."
         else
           msg.send "```" + weaponFound.name + "\n" + weaponFound.type + "\nRPM .............. " + weaponFound.rateOfFire + "\nAccuracy ......... " + weaponFound.accuracy + "\nStability ........ " + weaponFound.stability + "\nOptimal Range .... " + weaponFound.optimalRange + "\nReload Speed ..... " + weaponFound.reloadTime + "```"
