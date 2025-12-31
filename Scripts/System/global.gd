extends Node

var score: float = 0;
var quota: float = 1500;
var player: Player
var map: Map
var state: String = "game"
var spawner: Node2D
var phantom_health: int = 10
var time: float = 30
