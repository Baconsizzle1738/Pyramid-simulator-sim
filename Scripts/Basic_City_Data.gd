extends Node

const HQ_COST_MULT = 0.3

var population
var HQs = 0
var HQBaseCost
var HQTimer = 0

var HQLegitIncrease = 0.000002 #legitamacy increase based on population for HQ
var HQPublicIncrease = 0.000001 # publicity increase based on population for HQ

var hasPlayer = false

var FBIcontrol = false
