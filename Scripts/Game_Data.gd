extends Node #GLOBAL DATA FOR THE GAME

var playerName #name of player

#global stats for the player
var legit = 75.0
var cash = 1000000.0
var FBIsus = 0.0 #ceil the number to get the FBIstatus(FBIstatis[ceil(FBIsus)])
var FBIstatus = ["UNINTERESTED", "INTRIGUED", "SUSPICIOUS", "ALARMED", "APPREHENDING"]

#run at game start
func init():
	legit = 75
	cash = 1000000.0
	FBIsus = 0.0
	#FBIstatus = "uninterested"


#process game tick 
func tick(delta):
	pass
