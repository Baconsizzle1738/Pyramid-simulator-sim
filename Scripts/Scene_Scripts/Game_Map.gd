extends Node2D

var frameOneLoad = false


#var choosing = true
var showing_popup = false

#var legit = 75
#var cash = 1000000.0
#var FBIsus = 0

var timePast = 0

@onready var PacificIDX
@onready var NorthernRockiesIDX
@onready var SouthwestIDX
@onready var NorthernPlainsIDX
@onready var SouthernPlainsIDX
@onready var GulfCoastIDX
@onready var MidwestIDX
@onready var AppalachiaIDX
@onready var SouthAtlanticIDX
@onready var NorthAtlanticIDX
@onready var NewEnglandIDX


func reset():
	#choosing = true
	showing_popup = false
	#legit = 75
	#cash = 1000000.0
	#FBIsus = 0
	timePast = 0
	GameData.init()

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(str(delta))
	if !frameOneLoad:
		PacificIDX = $PacificWindow.get_index()
		NorthernRockiesIDX = $NorthernRockiesWindow.get_index()
		SouthwestIDX = $SouthwestWindow.get_index()
		NorthernPlainsIDX = $NorthernPlainsWindow.get_index()
		SouthernPlainsIDX = $SouthernPlainsWindow.get_index()
		GulfCoastIDX = $GulfCoastWindow.get_index()
		MidwestIDX = $MidwestWindow.get_index()
		AppalachiaIDX = $AppalachiaWindow.get_index()
		SouthAtlanticIDX = $SouthAtlanticWindow.get_index()
		NorthAtlanticIDX = $NorthAtlanticWindow.get_index()
		NewEnglandIDX = $NewEnglandWindow.get_index()
		
		#print(PacificIndex)
		frameOneLoad = true
	
	if !GameData.choosing: #make !choosing later
		timePast += delta
		#print(delta)
		if timePast >= 1: # tick game every "second" representing a "day"
			print("tick "+str(timePast))
			
			GameData.tick() # day go up
			#tick each region
			$PacificWindow/PacificPopup.tick()
			
			#debt timer
			GameData.debtDays -= 1
			print(GameData.debtDays)
			$Debt/Bar.value = GameData.debtDays
			if GameData.debtDays <= -1:
				GameData.debtDays = -1
			if GameData.debtDays == 0:
				$Debt.visible = false
				GameData.legit -= (GameData.LEGIT_DECREASE_FACTOR * GameData.debt)
				GameData.debt = 0
			
			print(GameData.legit)
			
			#update HUD data
			$Legit.text = "Legitimacy: "+str(round(GameData.legit))
			$FBIsus.text = "The FBI is "+GameData.FBIstatus[int(ceil(GameData.FBIsus))]
			$Cash.text = "Cash: $"+str(round(GameData.cash))
			$Days.text = "Day "+str(GameData.days)
			
			print(GameData.debt)
			if GameData.days%30 == 0 and GameData.debt>0:
				print("DEBT SHOW")
				$Debt.visible = true
				$Debt/Amount.text = "$"+GameData.numSuffix(GameData.debt)
				GameData.debtDays = GameData.TIME_TO_PAY_DEBT
				$Debt/Bar.max_value = GameData.TIME_TO_PAY_DEBT
				$Debt/Bar.value = GameData.TIME_TO_PAY_DEBT
			
			
			#reset time
			timePast = 0
	#other stuff
	
	# choose location banner visibility
	$ChooseLocationBanner.visible = GameData.choosing


#window closing stuff
func _on_pacific_window_close_requested():
	$PacificWindow.visible = false
	$PacificRegionSelectable.exists = false

func _on_northern_rockies_window_close_requested():
	$NorthernRockiesWindow.visible = false
	$NorthernRockiesSelectable.exists = false

func _on_southwest_window_close_requested():
	$SouthwestWindow.visible = false
	$SouthwestSelectable.exists = false

func _on_northern_plains_window_close_requested():
	$NorthernPlainsWindow.visible = false
	$NorthernPlainsSelectable.exists = false

func _on_southern_plains_window_close_requested():
	$SouthernPlainsWindow.visible = false
	$SouthernPlainsSelectable.exists = false

func _on_gulf_coast_window_close_requested():
	$GulfCoastWindow.visible = false
	$GulfCoastSelectable.exists = false

func _on_midwest_window_close_requested():
	$MidwestWindow.visible = false
	$MidwestSelectable.exists = false

func _on_appalachia_window_close_requested():
	$AppalachiaWindow.visible = false
	$AppalachiaSelectable.exists = false

func _on_south_atlantic_window_close_requested():
	$SouthAtlanticWindow.visible = false
	$SouthAtlanticSelectable.exists = false

func _on_north_atlantic_window_close_requested():
	$NorthAtlanticWindow.visible = false
	$NorthAtlanticSelectable.exists = false

func _on_new_england_window_close_requested():
	$NewEnglandWindow.visible = false
	$NewEnglandSelectable.exists = false
