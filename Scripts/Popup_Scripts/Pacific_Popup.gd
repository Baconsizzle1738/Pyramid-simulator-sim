extends "res://Scripts/Popup_Data.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	regionPopulation = 53400000
	$Data/RegionPopulation.text = "Region population: "+GameData.numSuffix(regionPopulation)
	#BaseInvestGrowth = 0.0000003 * regionPopulation
	for i in group.get_buttons():
		i.connect("pressed", button_pressed) #connect all buttons to the buttons_pressed() func
	group.get_buttons()[0].button_pressed = true # so that there are no null instances
	button_pressed()

func button_pressed():
	#print(group.get_pressed_button().get_name())
	$Data/SelectedCity.text = "Selected: "+group.get_pressed_button().get_name()
	$Data/Population.text = "Population: "+GameData.numSuffix(group.get_pressed_button().population)
	$Data/HQCost.text = "HQ cost: $"+str(group.get_pressed_button().HQBaseCost)
	
	$Build_HQ.disabled = (GameData.cash <= group.get_pressed_button().HQBaseCost) or (group.get_pressed_button().HQTimer > 0) or (group.get_pressed_button().HQs == 1)

# Called to update region data
func tick():
	#add to buffers
	var AllIncreaseFactor = publicity * GameData.LegitIncreaseFactor # for non tier dependent factors
	buffer3 += regionPopulation * Tier3GrowthFactor * ExternalFactor3 * AllIncreaseFactor
	buffer2 += regionPopulation * Tier2GrowthFactor * ExternalFactor2 * AllIncreaseFactor
	buffer1 += regionPopulation * Tier1GrowthFactor * ExternalFactor1 * AllIncreaseFactor
	var grow3 = int(buffer3) # no half ppl
	var grow2 = int(buffer2)
	var grow1 = int(buffer1)
	print(group.get_pressed_button())
	publicity += publicGrowth #growth of publicity
	print("publicity "+str(publicity))
	
	#subtract from buffer
	buffer3 -= grow3
	buffer2 -= grow2
	buffer1 -= grow1
	print("buffer2 "+str(buffer2))
	
	Tier3 += grow3
	Tier2 += grow2
	Tier1 += grow1
	print("Tier2 "+str(Tier2))
	
	var TotalCashGenerated = grow3*GameData.Tier3Worth + grow2*GameData.Tier2Worth + grow1*GameData.Tier1Worth
	GameData.cash += TotalCashGenerated
	
	for button in group.get_buttons(): #countdown for the HQ build time
		#print(get_node("CityHQ/"+button.name).visible)
		#button.get_child(0).visible = true
		button.HQTimer -= 1
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
	
	$Data/Tier3Invest.text = "Tier 3: "+GameData.numSuffix(int(Tier3))
	$Data/Tier2Invest.text = "Tier 2: "+GameData.numSuffix(int(Tier2))
	$Data/Tier1Invest.text = "Tier 1: "+GameData.numSuffix(int(Tier1))
	$Data/Publicity.text = "Publicity: "+str(round(publicity))


func _on_build_hq_pressed():
	GameData.cash -= group.get_pressed_button().HQBaseCost
	group.get_pressed_button().HQTimer = GameData.HQBuildTime
	group.get_pressed_button().get_child(0).visible = true
	group.get_pressed_button().get_child(0).max_value = GameData.HQBuildTime
	group.get_pressed_button().get_child(0).value = GameData.HQBuildTime
	$Build_HQ.disabled = true


func _on_run_ads_pressed():
	# run da ads
	pass # Replace with function body.
