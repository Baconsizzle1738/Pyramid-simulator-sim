extends "res://Scripts/Popup_Data.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	regionPopulation = 53400000
	$Data/RegionPopulation.text = "Region population: "+GameData.numSuffix(regionPopulation)
	#BaseInvestGrowth = 0.0000003 * regionPopulation
	for i in group.get_buttons():
		i.connect("pressed", button_pressed) #connect all buttons to the buttons_pressed() func
	group.get_buttons()[0].button_pressed = true # so that there are no null instances
	button_pressed() #press the button such that there is no null
	
	AdCost = regionPopulation * AD_COST_FACTOR
	$Data/AdCost.text = "$"+str(round(AdCost))
	$Run_Ads.disabled = (AdCost > GameData.cash) or GameData.choosing

func button_pressed():
	#print(group.get_pressed_button().get_name())
	$Data/SelectedCity.text = "Selected: "+group.get_pressed_button().get_name()
	$Data/Population.text = "Population: "+GameData.numSuffix(group.get_pressed_button().population)
	$Data/HQCost.text = "HQ cost: $"+str(group.get_pressed_button().HQBaseCost)
	
	$Build_HQ.disabled = !GameData.choosing and (GameData.cash <= group.get_pressed_button().HQBaseCost) or (group.get_pressed_button().HQTimer > 0) or (group.get_pressed_button().HQs == 1)
	$Travel.disabled = GameData.travelling or group.get_pressed_button().hasPlayer or group.get_pressed_button().HQs < 1 or GameData.choosing
	

func _process(delta):
	update_button_cash_disabled() # so that buttons disable faster when needed
	pass

# Called to update region data
func tick():
	#increase in cash
	#add to buffers
	var AllIncreaseFactor = publicity * GameData.LegitIncreaseFactor # for non tier dependent factors
	buffer3 += regionPopulation * Tier3GrowthFactor * ExternalFactor3 * AllIncreaseFactor
	buffer2 += regionPopulation * Tier2GrowthFactor * ExternalFactor2 * AllIncreaseFactor
	buffer1 += regionPopulation * Tier1GrowthFactor * ExternalFactor1 * AllIncreaseFactor
	var grow3 = int(buffer3) # no half ppl
	var grow2 = int(buffer2)
	var grow1 = int(buffer1)
	#print(group.get_pressed_button())
	publicity += publicGrowth #growth of publicity
	print("publicity "+str(publicity))
	#subtract from buffer
	buffer3 -= grow3
	buffer2 -= grow2
	buffer1 -= grow1
	#print("buffer2 "+str(buffer2))
	Tier3 += grow3
	Tier2 += grow2
	Tier1 += grow1
	#print("Tier2 "+str(Tier2))
	var TotalCashGenerated = grow3*GameData.Tier3Worth + grow2*GameData.Tier2Worth + grow1*GameData.Tier1Worth
	GameData.cash += TotalCashGenerated
	
	
	#amount of investors cashing out after around half a year
	if GameData.days >= GameData.START_CASHOUT and GameData.days%GameData.DEBT_PAYOUT_INTERVAL == 0:
		# number of ppl cashing out
		var t3out = round(GameData.cashoutRate * Tier3)
		var t2out = round(GameData.cashoutRate * Tier2)
		var t1out = round(GameData.cashoutRate * Tier1)
		Tier3 -= t3out
		Tier2 -= t2out
		Tier1 -= t1out
		# find money value of debt
		t3out *= GameData.ROI * GameData.Tier3Worth
		t2out *= GameData.ROI * GameData.Tier2Worth
		t1out *= GameData.ROI * GameData.Tier1Worth
		
		GameData.debt += (t3out + t2out + t1out)
		print("PACIFIC DEBT PAYOUT")
	
	#TODO: FBI raids
	#var rand = RandomNumberGenerator.new()
	#var raidCity = rand.randi_range(0, 5)
	
	
	#Ad timer logic
	daysSinceAd -= 1
	$Run_Ads/Bar.value -= 1
	if daysSinceAd <= 0:
		daysSinceAd = 0
	if daysSinceAd == 1:
		$Run_Ads.disabled = GameData.cash < AdCost
		$Run_Ads/Bar.visible = false
		
	
	
	for button in group.get_buttons(): 
		#print(get_node("CityHQ/"+button.name).visible)
		#button.get_child(0).visible = true
		button.HQTimer -= 1 #countdown for the HQ build time
		button.get_child(0).value -= 1
		#print(button.get_child(0).value)
		if button.HQTimer < 0:
			button.HQTimer = 0
		if button.HQTimer == 1:
			button.HQs = 1
			publicity += button.population * button.HQPublicIncrease
			GameData.legit += button.population * button.HQLegitIncrease
			get_node("CityHQ/"+button.name).visible = true #HQ name and button name MUST BE THE SAME
			button.get_child(0).visible = false
			numHQ += 1
		
		#check if the player is in the city
		if GameData.currLocation == button.get_name():
			button.get_child(1).visible = true
			button.hasPlayer = true
		else:
			button.get_child(1).visible = false
			button.hasPlayer = false
	
	#determine if travel bar is visible
	$Travel/Bar.value = GameData.travelTimer
	if GameData.travelTimer <= 0:
		$Travel/Bar.visible = false
	
	$Data/Tier3Invest.text = "Tier 3: "+GameData.numSuffix(int(Tier3))
	$Data/Tier2Invest.text = "Tier 2: "+GameData.numSuffix(int(Tier2))
	$Data/Tier1Invest.text = "Tier 1: "+GameData.numSuffix(int(Tier1))
	$Data/Publicity.text = "Publicity: "+str(round(publicity))
	
	update_button_cash_disabled()


func _on_build_hq_pressed():
	if !GameData.choosing:
		GameData.cash -= group.get_pressed_button().HQBaseCost
		group.get_pressed_button().HQTimer = GameData.HQBuildTime
		group.get_pressed_button().get_child(0).visible = true
		group.get_pressed_button().get_child(0).max_value = GameData.HQBuildTime
		group.get_pressed_button().get_child(0).value = GameData.HQBuildTime
		$Build_HQ.disabled = true
		
	else: # player chooses one free node to start at
		get_node("CityHQ/"+group.get_pressed_button().get_name()).visible = true #HQ name and button name MUST BE THE SAME
		#GameData.cash -= group.get_pressed_button().HQBaseCost
		#group.get_pressed_button().HQTimer = GameData.HQBuildTime
		#group.get_pressed_button().get_child(0).visible = true
		#group.get_pressed_button().get_child(0).max_value = GameData.HQBuildTime
		#group.get_pressed_button().get_child(0).value = GameData.HQBuildTime
		group.get_pressed_button().HQs = 1
		GameData.choosing = false
		GameData.currLocation = group.get_pressed_button().get_name()
		group.get_pressed_button().hasPlayer = true
		$Build_HQ.disabled = true
	
	update_button_cash_disabled()

func _on_travel_pressed():
	GameData.travelling = true
	GameData.destination = group.get_pressed_button().get_name()
	GameData.travelTimer = GameData.TIME_TO_TRAVEL
	GameData.currLocation = "IN_TRANSIT"
	GameData.destination = group.get_pressed_button().get_name()
	$Travel/Bar.visible = true
	$Travel/Bar.max_value = GameData.TIME_TO_TRAVEL
	$Travel/Bar.value = GameData.TIME_TO_TRAVEL
	$Travel.disabled = true


func _on_run_ads_pressed():
	GameData.cash -= AdCost
	daysSinceAd = AD_COOLDOWN
	$Run_Ads.disabled = true
	$Run_Ads/Bar.visible = true
	$Run_Ads/Bar.max_value = AD_COOLDOWN
	$Run_Ads/Bar.value = AD_COOLDOWN
	publicGrowth += AD_INCREASE_FACTOR
	update_button_cash_disabled()
	

func update_button_cash_disabled():
	$Build_HQ.disabled = !GameData.choosing and (GameData.cash <= group.get_pressed_button().HQBaseCost) or (group.get_pressed_button().HQTimer > 0) or (group.get_pressed_button().HQs == 1) or (group.get_pressed_button().FBIcontrol)
	$Run_Ads.disabled = (AdCost > GameData.cash) or (daysSinceAd > 0) or GameData.choosing
	$Travel.disabled = GameData.travelling or group.get_pressed_button().hasPlayer or group.get_pressed_button().HQs < 1
	

func raidCity() -> void: #run this froim map tick
	#TODO: FBI raids
	var rand = RandomNumberGenerator.new()
	var cityidx = rand.randi_range(0, 5) #max index of city
	if ceil(GameData.FBIsus) == 4:
		if numHQ == 0:
			pass #TODO set investor growth to 0 and everyone cashes out
		if $Cities.get_child(cityidx).hasPlayer:
			$Cities.get_child(cityidx).FBIcontrol = true
			$Cities.get_child(cityidx).HQs = 0
			#TODO END THE GAMAE
		elif $Cities.get_child(cityidx).HQs > 0: 
			$Cities.get_child(cityidx).FBIcontrol = true
			$Cities.get_child(cityidx).HQs = 0
			#TODO: notify player of HQ bonk
		else:
			$Cities.get_child(cityidx).FBIcontrol = true
			$Cities.get_child(cityidx).HQs = 0
			
	elif ceil(GameData.FBIsus) == 3: # Can only prevent more HQ building
		if !$Cities.get_child(cityidx).HQs == 0:
			$Cities.get_child(cityidx).FBIcontrol = true

