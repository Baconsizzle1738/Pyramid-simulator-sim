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
	
	

# basic functions

#convert large numbers ex 1142000 -> 1.14M
func numSuffix(num) -> String:
	if num >= 1000000000: #billion
		num /= 10000000.0
		num = round(num)
		num /= 100.0
		return str(num)+" B"
	if num >= 1000000: #million
		num /= 10000.0
		num = round(num)
		num /= 100.0
		return str(num)+" M"
	if num >= 10000: #thousansk, only over 10 k
		num /= 1000.0
		num = round(num)
		return str(num)+" k"
	return str(num)
	
