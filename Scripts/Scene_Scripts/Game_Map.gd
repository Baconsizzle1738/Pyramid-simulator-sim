extends Node2D

var frameOneLoad = false

const eventResource = preload("res://Game_Scenes/Popups/Events/Event_Base.tscn")

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
		
		#HQraidNotif("San Francisco")
		#showFBIstart()
		#print(PacificIndex)
		frameOneLoad = true
	
	#determine whether or not the payment buttons work
	updateDebtUse()
	
	if GameData.captured:
		get_tree().change_scene_to_file("res://Game_Scenes/Lose_Screen.tscn")
	
	if !GameData.choosing or !GameData.captured: #make !choosing later
		timePast += delta
		#print(delta)
		if timePast >= 1: # tick game every "second" representing a "day"
			#print("tick "+str(timePast))
			
			GameData.tick() # day go up
			
			#cashout each region
			if GameData.days >= GameData.START_CASHOUT and GameData.days%GameData.DEBT_PAYOUT_INTERVAL == 0:
				$PacificWindow/PacificPopup.cashout()
				
			
			#FBI raid each region
			if GameData.days%GameData.FBI_RAID_FREQ == 0:
				var random = RandomNumberGenerator.new()
				random = random.randi_range(PacificIDX, PacificIDX)
				self.get_child(random).get_child(0).raidCity()
			
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
			if GameData.days%GameData.DEBT_PAYOUT_INTERVAL == 0 and GameData.debt>0:
				print("DEBT SHOW")
				$Debt.visible = true
				$Debt/Amount.text = "$"+GameData.numSuffix(GameData.debt)
				GameData.debtDays = GameData.TIME_TO_PAY_DEBT
				$Debt/Bar.max_value = GameData.TIME_TO_PAY_DEBT
				$Debt/Bar.value = GameData.TIME_TO_PAY_DEBT
			
			#signal FBI start
			if (GameData.legit <= 50 or GameData.days >= GameData.START_FBI) and GameData.FBIprogress <= 0.001:
				GameData.FBIprogress = 0.015
				showFBIstart()
			
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

#show that FBI has started investigation
func showFBIstart() -> void:
	var FBIstartNotif = eventResource.instantiate()
	FBIstartNotif.setTitle("FBI begins investigation")
	FBIstartNotif.setImage("res://Assets/Temp/usa-map-capitals-only-color.png")
	FBIstartNotif.setArticle("Since the foundation of " + GameData.playerName + ", there have been a large amount of investors flocking to get their hands on a piece. However, some investors have recently raised concerns about whether or not " + GameData.playerName + " will be able to make good on the promised return on investment as there have been no signs of any widgets being produced.")
	FBIstartNotif.setButtonText("Are they on to us?")
	self.add_child(FBIstartNotif)
	#print("SHOW FBI START")
	#print("pos: "+str(FBIstartNotif.position))

func HQraidNotif(cityRaided:String) -> void:
	var raidNotif = eventResource.instantiate()
	raidNotif.setTitle(cityRaided + " HQ Raided")
	raidNotif.setImage("res://Assets/Temp/usa-map-capitals-only-color.png")
	raidNotif.setArticle("After waiting for days, the FBI has finally gotten a warrant to raid the HQ of " + GameData.playerName + " in " + cityRaided + ". The doors of the HQ were torn down at 5AM and some employees were apprehended. However, the FBI was not able to capture the ringleader as they did not seem to be at that location. The FBI has stated that they will continue to raid until the pyramid scheme is gone for good.")
	raidNotif.setButtonText("Uh oh.")
	self.add_child(raidNotif)

#update button pressability amd max value of spin box
func updateDebtUse() -> void:
	$Debt/PayAll.disabled = GameData.cash < GameData.debt
	if GameData.debt > GameData.cash:
		$Debt/SpinBox.max_value = GameData.cash
	else:
		$Debt/SpinBox.max_value = GameData.debt


func _on_pay_all_pressed():
	GameData.cash -= GameData.debt
	$Debt.visible = false


func _on_pay_amount_pressed():
	GameData.cash -= $Debt/SpinBox.value
	GameData.debt -= $Debt/SpinBox.value
	if GameData.debt == 0:
		$Debt.visible = false
	$Debt/Amount.text = "$"+GameData.numSuffix(GameData.debt)
