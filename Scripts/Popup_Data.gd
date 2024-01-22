extends Control

@export var group: ButtonGroup

#var BaseInvestGrowth
var regionPopulation

var numHQ = 0

var publicity = 5
const DEFAULT_PUBLICITY_GROWTH = 0.008
var publicGrowth = DEFAULT_PUBLICITY_GROWTH
const AD_COST_FACTOR = 0.01 # multiply this value by the region population
var AdCost
const AD_INCREASE_FACTOR = 0.05 #add this to publicGrowth
const AD_COOLDOWN = 50 # player can only run ads once per this many days
var daysSinceAd = 0 #set to AD_COOLDOWN and count down once ad is run

#Base daily investor growth factor
var Tier3GrowthFactor = 0.0000000005
var Tier2GrowthFactor = 0.000000001
var Tier1GrowthFactor = 0.00000001

#external growth factors
var ExternalFactor3 = 1
var ExternalFactor2 = 1
var ExternalFactor1 = 1

# Buffer if growth has a decimal
var buffer3 = 0.0
var buffer2 = 0.0
var buffer1 = 0.0

# Actual number of investors
var Tier3 = 0
var Tier2 = 0
var Tier1 = 0
