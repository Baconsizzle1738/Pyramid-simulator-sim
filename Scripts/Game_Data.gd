extends Node #GLOBAL DATA FOR THE GAME

var playerName #name of player

#global stats for the player
var legit = 75.0
var cash = 1000000.0
var FBIsus = 0.0 #ceil the number to get the FBIstatus(FBIstatis[ceil(FBIsus)])
var FBIstatus = ["UNINTERESTED", "INTRIGUED", "SUSPICIOUS", "ALARMED", "APPREHENDING"]
var Tier3Worth = 1000
var Tier2Worth = 250
var Tier1Worth = 15

#run at game start, reset values to default
func init():
	legit = 75
	cash = 1000000.0
	FBIsus = 0.0
	Tier3Worth = 1000
	Tier2Worth = 250
	Tier1Worth = 15	
	#FBIstatus = "uninterested"


#process game tick 
func tick(delta):
	pass
