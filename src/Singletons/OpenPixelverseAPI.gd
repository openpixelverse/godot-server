extends Node


########################################################
# Requests / Routes                                    #
########################################################


func load_world_data(world: String)->Dictionary:
	# TODO: Make real API requests!
	
	var base64_sprite = """iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAA35JREFUaIHt
WV1P2zAUPXHTpJCgUXUqy8O0SUho2v//NUhMQmyDMUFX0bSJ5yR7aJ06jp3ETqBj2pGQCsnxuddf
957izE4/F3jFcAHg4uKTFfnnwzUWDxtr/mZNcfP1Sy99FwDm8zM8LhdWg/Tir2k/PgACAPf3P6zI
HIfkkz7C4VHUh44cq1788Cjql8DfAAIA8frxoEFsdmfBBuUKLBd3gwRji6eF3XYqE3gzfWctPp+f
GXOWizsQhOXvJ9Ow4e0tMlYvWQQAJv5pI9HzfHier31uc4uIE+b5rvY9HnTGCoxcp/acAEAURZWX
ASDPi/JHBXHJ+QqY8Fm63/cqfTl4nX6lDogZjkYEhDggxAGlKShNKwPMzmbl5za+Cq7vNfLloOXZ
5/raa7Qo+rVIffkj11FuGRnKBBynndgEzk+SFZLE/HYR9dsScfOium+fltvlDE7ewnXVh0sUkPmb
+BfIyEGSxACAsTcBENb4fIVyxUq1rZ6oX0bIUlotaFkOlukLzPdvl5Xf+aH0vWAbeHBceybjw8f3
uL65anynTd+R/QAZOcizw1kEU/1efoD38+fnF1Z8ALi6uuylX24h8VrrjF0PE0WRVT8v1hJb/UG6
0dvb2yGGscK/0U7bII73y88KNkgwNtB3UYYQEwqC9s5yKFglIAYLAK7jwj+eDBKQCU6mod0WCoKw
Msu8mzwECFC/wpp6/+eA1RW6AwH2ZTxjRRm8ST/PYesHRH0RKr48uZUtZNvP8zpgy1fpA6jx5eCf
Fiv9GRiP7ZcV6O8Hum7jxkPc5oV16OMnRD1ZX3aFAEDkfl43qDhQkx9I1wnGYw+M6YtbE19OQtan
NFX7ASdH6X+dfPu3DNsBR3BQCGul2h6c7x9P8DtJMSYustycb6r/3w+8Kj/A7+uU0W0l3vkB2zbi
xf1AyihSVi9g6ToxFx8IRgmYdJmMscabaChoE2i6/3ki/AtZ2Q+8ROC8I1Ym0LV4tX0lrvteaUgY
t9OqbeQ69UCfM3jRjwyi8tJmhk/iE11tE5CvMFXPYQLT2R/MD5jAxA/IFlTm6/S7+AntGWjrKMVZ
43VA5Qc2mxjT6ayRr9Pv4if+Wj/Qla9NgNJ0ED8QBKHVmeq6rRv9gOpfS3KAKn5RFL38AEccr5Tn
R+SXK8D7cf65CU39PP88Jm55COXxuvBTRpHT/TMd/w8BYCLQt+RTXgAAAABJRU5ErkJggg=="""
	
	var world_width = 48 * 80
	var world_height = 48 * 60
	
	return {
		"type": "2D",
		"limits": {
			"top": 0,
			"bottom": world_height,
			"left": 0,
			"right": world_width,
		},
		"environment": {
			"mode": "canvas",
			"layers": 1,
			"glow": {
				"intensity": 0.8,
				"strength": 1.6,
				"blend_mode": "additive",
				"levels": [1,5,6],
				"hdr_threshold": 2.0
#				"bicubic_upscale": true,
#				"high_quality": true,
			}
		},
		"background": {
			"grid": 48,
			"rect": {
				"x": 0,
				"y": 0,
				"w": world_width,
				"h": world_height,
			},
			"texture": {
				"type": "png",
				"data": base64_sprite,
			},
			"centered": false,
			"region": true,
			"scale": 4,
		},
		"objects": [
			load_object_data("information_booth")
		],
		"subjects": {
			"enemies": {
				"spawn_areas": [
					{
						"name": "Spawn Point 1",
						"position": Vector2(200, 200),
						"timer": {
							"interval": 3,
						},
						"enemy": {
							"type": "Rat_Brown",
							"amount": 1
						}
					},
					{
						"name": "Spawn Point 2",
						"position": Vector2(400, 400),
						"timer": {
							"interval": 3,
						},
						"enemy": {
							"type": "Rat_Brown",
							"amount": 3
						}
					},
					{
						"name": "Spawn Point 3",
						"position": Vector2(600, 600),
						"timer": {
							"interval": 3,
						},
						"enemy": {
							"type": "Rat_Brown",
							"amount": 3
						}
					},
					{
						"name": "Spawn Point 4",
						"position": Vector2(800, 800),
						"timer": {
							"interval": 3,
						},
						"enemy": {
							"type": "Rat_Brown",
							"amount": 3
						}
					},
				],
			},
			# "npcs": []
		}
	}


func load_object_data(object: String)->Dictionary:
	# Create sprite image in order to send it to the client.
	var sprite_base64 = """iVBORw0KGgoAAAANSUhEUgAAAEgAAABaCAYAAAAb8xDXAAABhGlDQ1BJQ0MgcHJvZmlsZQAAKJF9
kTtIw0Acxr+mSkUrDs0g0iFDdbIgvnDUKhShQqgVWnUwj76gSUOS4uIouBYcfCxWHVycdXVwFQTB
B4ibm5Oii5T4v6TQIsaD4358d9/H3XcA16gomtU1Bmi6baaTCSGbWxVCr+hDFBHwmJIUy5gTxRR8
x9c9Amy9i7Ms/3N/jn41bylAQCCeVQzTJt4gnt60Dcb7xLxSklTic+JRky5I/Mh02eM3xkWXOZbJ
m5n0PDFPLBQ7WO5gpWRqxJPEMVXTKZ/Leqwy3mKsVWpK657sheG8vrLMdJpRJLGIJYgQIKOGMiqw
EadVJ8VCmvYTPv4h1y+SSyZXGQo5FlCFBsn1g/3B726twsS4lxROAN0vjvMxDIR2gWbdcb6PHad5
AgSfgSu97a82gJlP0uttLXYEDGwDF9dtTd4DLneAwSdDMiVXCtLkCgXg/Yy+KQdEboHeNa+31j5O
H4AMdZW6AQ4OgZEiZa/7vLuns7d/z7T6+wG0EXLBd4tM6wAAAAZiS0dEADIAMQA7tgA2GgAAAAlw
SFlzAAAuIwAALiMBeKU/dgAAAAd0SU1FB+ULHBMmKA9Jz1AAAAAZdEVYdENvbW1lbnQAQ3JlYXRl
ZCB3aXRoIEdJTVBXgQ4XAAAGO0lEQVR42u2dW0wcVRzGvyW7CxWX3QW0pEPZblwaiaFoYikJ4aLY
BBNpmsYQI/LAk/rkkyaG9KkhTfTJJ/XJpEgfiA/GS0JiLFhDIrSJwZoUWgiXuK1tgN0d6LIXBB/q
Gc/OzvXM7sxuZ74XZuecM5fffv//OXPObHCBUVUezyEApLJZF0s7Vuk9n1G5CnHRetTZ22+o/ezM
lGlwUtmsy0XgdJ8d1tV4eXEGked7hb9q2liZBdd0siAXHt24g6bnOgtyrPXVP6T3Ly8AANwscIze
nBEVCjJRKHxKElIo0ob15YXHgFhE3EO7SSuclv4JpnPenhoyDFgOkpyr3EYOTEPSqpb+CdyeGmI6
n5G2rK5yw0S19E8gOjeKmuAJtvCcGzUXkpEQYxUfWzOWg0y+XtMBKblLnG9KQaYD0hperGFYFED7
mfjjD96AZSHGa3SMJSEWj0URCHLYz8SZIdG9mZYu33YhRkPROi4qB7kBIBDkmEOMjIXE4yE5R5Vl
DjKaf6TcQrtoeXEGXo9HMQeJc8vmw7slkYMqipWcWUbZRhXfjiK+HS2fbp6GlNrbkw0d7sxY3r62
gUlE50Z1wZHaJgrUcqUHiA6/jZVZ2RDjdAwJOAoCuWk11wRqOaGOXlAlMZJm7dKlbloKFiuckh5J
a5X4pllDqSQA3Z4aKsh0B4FcaBiWAqoJngAfWxMgsQI2E47pDqIhscrn8z6ZT/PkGzfrmy/oQNGR
A8gB5ACyEtBeclN1xLq8OCM8DJr9EGqFVu7O5/ZiBBKfkIb1VHWdMAXh8zfgwf3FJxLM7i5vLMR8
/gb7hZica2glH23ZDo6TpLUCWvrzhqqL7Oae6NoSAAteoConpbJZV87rbFUez2H32WHM/3bdvlB2
1nNe85N8WI00N2Nz8yH2D2ptAWU3sQocZgCXV/vT/P5BLU6fu2wLQDe++xi78SXJMllABI7c3I1Z
7+kUWy39Ezh97jKmr1zQBwiA4stO5GUmPUszJdlbzY1KLjtpAkQvu5BpUto1HORXSulpVfFcNNkW
16HbLXw/mHO8toFJ1fZKx1OKBqUpPM0zinrDSWqCXios5crbBibzIGm5LjFElmvXDIgOL2JDcUip
LePQ5SQs6f3iMKXr1z/bLOtKufakDp0ejKQCzSFGbEi/VKAUYuJyss3/5yw+tgZOIWQ5ifPT7pBr
L3YQp8FBnNFnMfqbaxuYhJ42epZ4SFjq6SFJfaN15CQ5kt7euo/jHZdUbcmdGSv7Xozcx/SVC4DL
q20kTTe0wziIyUGbmw/x0htf2mIkPT3+lvCooctBv//wruT+eCyBcDiEWDxe0Ast5nGVFAj6kUnv
Ipn8h30cVO5iBe/WQ5+PrQjbC9R2IWXmcV97fQR3lhYU22mecuWLdOGlrgoHDgrjILvK8iQ90tcj
bH/18y8OIDGYUKMfABBLpDHS11NykCqsghNq9KPGVyXA4XdSCDX6MdLXg4GOdvsCGuhoF8DwO6mc
slgiDT6ZQX31kZKBZImD+J0UYok0Qo1+rP+VQNBfiRpfVQ6w+uoj6G5tsyegUKNfgCRW68lnwCcz
9k7SNJhL772TU/bpxDdOLyYFhujDoTcBABe/+NqeOehUc0SAoAaw68UX7JmDlu49fpPk/KXP8srI
PlLHdoDGxq/i2s1bqvWu3byFsfGr9n4W+/biB5r22S5J08549eXWPOeI69gOUG/XIFZ3jqOhugk/
zotLO/H3ow30dg1i5tdJ+4VYb9cgjtWFVesdqwujt2vQXg4aHX4b7597BQDw0cSyYt1PhiIAIvj8
hNvScLMsSd/bWmUqM1uK62KA+pJJOau9o1uYtCfLPuJ1MWfKtZTHQQ4gB1B5S8v74KrdfCDoz9tX
yDX0Su///cSDB3GEwyEkkwmkM4c5ZekM+48BjFyv5Q4iN64EwAgcU0KM/iaLCUkPNKOu1XpPbpYb
sMJhVh3T6cUcQCY8rFZ6XZaFWTHOTfJPNr1N7fWwOUh8gcVO2GYAl1KVN+uEWMVhLOezp1L993AV
VnbvVvVi2fS2KLwAT+XRwjjIyi7fiJLJhCQoJgfV+J4uSTex5pzawIEuKIqArv80/kTB0SJP5VGk
MxmkdtbzyvKOYPefiIv/scm/lnIZ3MsnOh4AAAAASUVORK5CYII="""
	
	return {
		"name": "Information Booth",
		"type": "static",
		"position": Vector2(700, 200),
		"scale_factor": 4,
		"collision_shape": {
			"type": "rectangle",
			# https://docs.godotengine.org/en/stable/classes/class_rectangleshape2d.html#class-rectangleshape2d-property-extents
			"extents": {
				"x": 66 / 2,
				"y": 72 / 2,
			},
			"position": {
				"x": 0,
				"y": 8 / 2
			},
		},
		"sprite": {
			"type": "png",
			"data": sprite_base64,
			"hframes": 1,
			"vframes": 1,
			"frame": 0,
		},
		"events": {
			"open_blog": {
				"type": "open_url",
				"options": {
					"url": "https://thomasventurini.com",
				}
			},
			"open_twitter": {
				"type": "open_url",
				"options": {
					"url": "https://twitter.com/tjventurini",
				}
			},
			"open_youtube": {
				"type": "open_url",
				"options": {
					"url": "https://www.youtube.com/channel/UChUOhfzTGv3vE6B9tJ6g9Eg",
				}
			},
			"open_dialog": {
				"type": "open_dialog",
				"options": {
					"dialog": "default"
				}
			}
		},
		"areas": [
			{
				"name": "SelectableArea",
				"shape": {
					"type": "rectangle",
					"extents": {
						"x": 66 / 2,
						"y": 72 / 2,
					},
					"position": {
						"x": 0,
						"y": 8 / 2
					},
				},
#				"clickable": true,
				"action": "open_dialog",
			}
		],
		"dialogs": {
			"default": [
				{
					"id": 1,
					"type": "question",
					"value": "Heya! How can I help you?",
					"choices": [2,3,4]
				},
				{
					"id": 2,
					"type": "choice",
					"value": "Who are you?",
					"next": 5,
				},
				{
					"id": 3,
					"type": "choice",
					"value": "What is this place?",
					"next": 16,
				},
				{
					"id": 4,
					"type": "choice",
					"value": "Leave ...",
					"next": 15,
				},
				{
					"id": 5,
					"type": "answer",
					"value": "I'm Thomas, the creator of this little world. One of many to come!",
					"next": 6,
				},
				{
					"id": 6,
					"type": "question",
					"value": "Do you want to know more about me?",
					"choices": [7,8]
				},
				{
					"id": 7,
					"type": "choice",
					"value": "Yes",
					"next": 9,
				},
				{
					"id": 8,
					"type": "choice",
					"value": "No",
					"next": 15
				},
				{
					"id": 9,
					"type": "answer",
					"value": "Cool! Well, I'm a [b]webdeveloper[/b] located in Vienna Austria. You can check out my [b]blog[/b], [b]Twitter[/b] or [b]YouTube[/b] if you want.",
					"next": 10,
				},
				{
					"id": 10,
					"type": "question",
					"value": "Do you want to check out one of these resources?",
					"choices": [11,12,13,4]
				},
				{
					"id": 11,
					"type": "choice",
					"value": "Blog",
					"action": "open_blog",
				},
				{
					"id": 12,
					"type": "choice",
					"value": "Twitter",
					"action": "open_twitter",
				},
				{
					"id": 13,
					"type": "choice",
					"value": "YouTube",
					"action": "open_youtube",
				},
				{
					"id": 15,
					"type": "answer",
					"value": "Ok. Come back anytime!",
					"action": "close",
				},
				{
					"id": 16,
					"type": "answer",
					"value": "Well, this is the work-in-progress state of an [b]open source[/b] [b]Metaverse[/b] project that I'm currently developing.",
					"next": 17,
				},
				{
					"id": 17,
					"type": "answer",
					"value": "The project is not yet released, but I'm working on that. If you want to know more about the project, check out my blog at [b]thomasventurini.com[/b] , follow me on Twitter [b]@tjventurini[/b] or check out my [b]YouTube channel[/b].",
					"next": 10,
				},
			]
		},
	}


func load_enemy_data(subject: String)->Dictionary:
	
	var base64_sprite = """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
TkSuQmCC"""
	
	return {
		"name": "Rat",
		"start_state": "idle",
		"scale_factor": {
			"type": "random",
			"options": {
				"min": 2,
				"max": 4,
			},
		},
		"states": [
			"idle",
			"wander",
#			"chase",
#			"dead"
		],
		"stats": {
			"speed": 1,
			"friction": 1,
			"acceleration": 1,
		},
		"sprite": {
			"type": "png",
			"data": base64_sprite,
			"hframes": 40,
			"vframes": 1,
			"frame": 22,
		},
		"collision_shape": {
			"type": "circle",
			"radius": 4,
			"position": {
				"x": 0,
				"y": 0
			}
		},
		"player_detection_zone": {
			"radius": 48,
		},
		"animations": {
			"idle_up": {
				"length": 0.1,
				"keys": [
					{
						"position": 0.1,
						"frame": 2
					}
				]
			},
			"idle_up_right": {
				"length": 0.1,
				"keys": [
					{
						"position": 0.0,
						"frame": 8-1
					}
				]
			},
			"idle_right": {
				"length": 0.1,
				"keys": [
					{
						"position": 0.0,
						"frame": 13-1
					}
				]
			},
			"idle_right_down": {
				"length": 0.1,
				"keys": [
					{
						"position": 0.0,
						"frame": 18-1
					}
				]
			},
			"idle_down": {
				"length": 0.1,
				"keys": [
					{
						"position": 0.0,
						"frame": 23-1
					}
				]
			},
			"idle_down_left": {
				"length": 0.1,
				"keys": [
					{
						"position": 0.0,
						"frame": 28-1
					}
				]
			},
			"idle_left": {
				"length": 0.1,
				"keys": [
					{
						"position": 0.0,
						"frame": 33-1
					}
				]
			},
			"idle_left_up": {
				"length": 0.1,
				"keys": [
					{
						"position": 0.0,
						"frame": 38-1
					}
				]
			},
			"move_up": {
				"length": 0.5,
				"keys": [
					{
						"position": 0.0,
						"frame": 0
					},
					{
						"position": 0.1,
						"frame": 1
					},
					{
						"position": 0.2,
						"frame": 2
					},
					{
						"position": 0.3,
						"frame": 3
					},
					{
						"position": 0.4,
						"frame": 4
					}
				]
			},
			"move_up_right": {
				"length": 0.5,
				"keys": [
					{
						"position": 0.0,
						"frame": 5
					},
					{
						"position": 0.1,
						"frame": 6
					},
					{
						"position": 0.2,
						"frame": 7
					},
					{
						"position": 0.3,
						"frame": 8
					},
					{
						"position": 0.4,
						"frame": 9
					}
				]
			},
			"move_right": {
				"length": 0.5,
				"keys": [
					{
						"position": 0.0,
						"frame": 10
					},
					{
						"position": 0.1,
						"frame": 11
					},
					{
						"position": 0.2,
						"frame": 12
					},
					{
						"position": 0.3,
						"frame": 13
					},
					{
						"position": 0.4,
						"frame": 14
					}
				]
			},
			"move_right_down": {
				"length": 0.5,
				"keys": [
					{
						"position": 0.0,
						"frame": 15
					},
					{
						"position": 0.1,
						"frame": 16
					},
					{
						"position": 0.2,
						"frame": 17
					},
					{
						"position": 0.3,
						"frame": 18
					},
					{
						"position": 0.4,
						"frame": 19
					}
				]
			},
			"move_down": {
				"length": 0.5,
				"keys": [
					{
						"position": 0.0,
						"frame": 20
					},
					{
						"position": 0.1,
						"frame": 21
					},
					{
						"position": 0.2,
						"frame": 22
					},
					{
						"position": 0.3,
						"frame": 23
					},
					{
						"position": 0.4,
						"frame": 24
					}
				]
			},
			"move_down_left": {
				"length": 0.5,
				"keys": [
					{
						"position": 0.0,
						"frame": 25
					},
					{
						"position": 0.1,
						"frame": 26
					},
					{
						"position": 0.2,
						"frame": 27
					},
					{
						"position": 0.3,
						"frame": 28
					},
					{
						"position": 0.4,
						"frame": 29
					}
				]
			},
			"move_left": {
				"length": 0.5,
				"keys": [
					{
						"position": 0.0,
						"frame": 30
					},
					{
						"position": 0.1,
						"frame": 31
					},
					{
						"position": 0.2,
						"frame": 32
					},
					{
						"position": 0.3,
						"frame": 33
					},
					{
						"position": 0.4,
						"frame": 34
					}
				]
			},
			"move_left_up": {
				"length": 0.5,
				"keys": [
					{
						"position": 0.0,
						"frame": 35
					},
					{
						"position": 0.1,
						"frame": 36
					},
					{
						"position": 0.2,
						"frame": 37
					},
					{
						"position": 0.3,
						"frame": 38
					},
					{
						"position": 0.4,
						"frame": 39
					}
				]
			},
		},
		"animation_tree": {
			"nodes": [
				{
					"name": "Idle",
					"start": true,
					"blend_points": [
						{
							"animation": "idle_left",
							"x": -1,
							"y": 0
						},
						{
							"animation": "idle_left_up",
							"x": -1,
							"y": -1
						},
						{
							"animation": "idle_up",
							"x": 0,
							"y": -1
						},
						{
							"animation": "idle_up_right",
							"x": 1,
							"y": -1
						},
						{
							"animation": "idle_right",
							"x": 1,
							"y": 0
						},
						{
							"animation": "idle_right_down",
							"x": 1,
							"y": 1
						},
						{
							"animation": "idle_down",
							"x": 0,
							"y": 1
						},
						{
							"animation": "idle_down_left",
							"x": -1,
							"y": 1
						},
					]
				},
				{
					"name": "Move",
					"blend_points": [
						{
							"animation": "move_left",
							"x": -1,
							"y": 0
						},
						{
							"animation": "move_left_up",
							"x": -1,
							"y": -1
						},
						{
							"animation": "move_up",
							"x": 0,
							"y": -1
						},
						{
							"animation": "move_up_right",
							"x": 1,
							"y": -1
						},
						{
							"animation": "move_right",
							"x": 1,
							"y": 0
						},
						{
							"animation": "move_right_down",
							"x": 1,
							"y": 1
						},
						{
							"animation": "move_down",
							"x": 0,
							"y": 1
						},
						{
							"animation": "move_down_left",
							"x": -1,
							"y": 1
						},
					]
				}
			],
			"transitions": [
				{
					"from": "Idle",
					"to": "Move"
				},
				{
					"from": "Move",
					"to": "Idle"
				}
			]
		}
	}
