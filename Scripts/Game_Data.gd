extends Node #GLOBAL DATA FOR THE GAME


const DEFAULT_TIER3_WORTH = 2500
const DEFAULT_TIER2_WORTH = 300
const DEFAULT_TIER1_WORTH = 20

const DEFAULT_CASHOUT_RATE = 0.05
const TIME_TO_PAY_DEBT = 15 # time player has to pay debt
const ROI = 1.2 # ROI that the investors demand on cashout
const LEGIT_DECREASE_FACTOR = 0.00004 #how much legit decreases for every unpaid dollar
const DEBT_PAYOUT_INTERVAL = 35 #cashout happens every this many days
const START_CASHOUT = 365 # investors start cashing out after this many days

const START_FBI = 548 # FBI will start investigating after this many days
const FBI_RAID_FREQ = 20

const TIME_TO_TRAVEL = 4 #time it takes to travel in days

var playerName #name of player

var days:int = 200 # days passed

var choosing = true # change to true later
var captured = false # if player is captured by the FBI

var HQBuildTime = 30

#global stats for the player
var legit = 75.0
var cash = 1000000.0
var FBIsus = 0.0 #ceil the number to get the FBIstatus(FBIstatis[ceil(FBIsus)])
var FBIstatus = ["UNINTERESTED", "INTRIGUED", "SUSPICIOUS", "ALARMED", "APPREHENDING"]
var FBIprogress = 0.0 # Daily gain in FBI suspicion
var Tier3Worth = DEFAULT_TIER3_WORTH
var Tier2Worth = DEFAULT_TIER2_WORTH
var Tier1Worth = DEFAULT_TIER1_WORTH
var LegitIncreaseFactor = 1.0 + (legit-50)/100.0

var cashoutRate = DEFAULT_CASHOUT_RATE
var debt = 0
var debtDays = 0 # debt timer countdown

var currLocation
var travelling = false
var destination
var travelTimer = 0 #set to time to travel and count down


#run at game start, reset values to default
func init():
	legit = 75
	cash = 1000000.0
	FBIsus = 0.0
	FBIprogress = 0.0
	Tier3Worth = DEFAULT_TIER3_WORTH
	Tier2Worth = DEFAULT_TIER2_WORTH
	Tier1Worth = DEFAULT_TIER1_WORTH
	cashoutRate = DEFAULT_CASHOUT_RATE
	days = 200
	choosing = true
	captured = false
	LegitIncreaseFactor = 1.0 + (legit-50)/100.0
	HQBuildTime = 30
	travelling = false
	#FBIstatus = "uninterested"


#process game tick 
func tick():
	days += 1
	LegitIncreaseFactor = 1.0 + (legit-50)/100.0 # needed to update increase of investors based off legitamacy
	cashoutRate = legitCashoutRate(legit)
	travelTimer -= 1
	if travelTimer < -1:
		travelTimer = -1
	if travelTimer == 0:
		travelling = false
		currLocation = destination
	
	# done in Game_map file
	#debtDays -= 1
	#if debtDays <= -1:
		#debtDays = -1
	#if debtDays == 0:
		#pass
	print("FBIprogress: "+str(FBIprogress))
	FBIsus += FBIprogress
	if FBIsus > 3.9999:
		FBIsus = 3.9999
	

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
	

func legitCashoutRate(num) -> float:
	return 1 / (1 + 1.5**(0.2*(num-40.5)))
	
