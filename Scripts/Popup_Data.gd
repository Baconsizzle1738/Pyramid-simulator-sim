extends Control

@export var group: ButtonGroup

#var BaseInvestGrowth
var regionPopulation

var publicity = 5
const DEFAULT_PUBLICITY_GROWTH = 0.015
var publicGrowth = DEFAULT_PUBLICITY_GROWTH


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
