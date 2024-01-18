extends "res://Scripts/Popup_Data.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	regionPopulation = 53400000
	$Data/RegionPopulation.text = "Region population: "+GameData.numSuffix(regionPopulation)
	#BaseInvestGrowth = 0.0000003 * regionPopulation
	for i in group.get_buttons():
		i.connect("pressed", button_pressed) #connect all buttons to the buttons_pressed() func

func button_pressed():
	print(group.get_pressed_button().get_name())
	$Data/SelectedCity.text = "Selected: "+group.get_pressed_button().get_name()
	$Data/Population.text = "Population: "+GameData.numSuffix(group.get_pressed_button().population)
	$Data/HQCost.text = "HQ cost: $"+str(group.get_pressed_button().HQBaseCost)

# Called to update region data
func tick():
	#add to buffers
	buffer3 += regionPopulation * Tier3GrowthFactor * publicity * ExternalFactor3
	buffer2 += regionPopulation * Tier2GrowthFactor * publicity * ExternalFactor2
	buffer1 += regionPopulation * Tier1GrowthFactor * publicity * ExternalFactor1
	var grow3 = int(buffer3) # no half ppl
	var grow2 = int(buffer2)
	var grow1 = int(buffer1)
	
	publicity += publicGrowth #growth of publicity
	
	#subtract from buffer
	buffer3 -= grow3
	buffer2 -= grow2
	buffer1 -= grow1
	print(buffer2)
	
	Tier3 += grow3
	Tier2 += grow2
	Tier1 += grow1
	print(Tier2)
	
	var TotalCashGenerated = grow3*GameData.Tier3Worth + grow2*GameData.Tier2Worth + grow1*GameData.Tier1Worth
	GameData.cash += TotalCashGenerated
	
	$Data/Tier3Invest.text = "Tier 3: "+GameData.numSuffix(int(Tier3))
	$Data/Tier2Invest.text = "Tier 2: "+GameData.numSuffix(int(Tier2))
	$Data/Tier1Invest.text = "Tier 1: "+GameData.numSuffix(int(Tier1))
	
