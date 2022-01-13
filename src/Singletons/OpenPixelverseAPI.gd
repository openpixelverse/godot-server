extends Node


########################################################
# Routes                                               #
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
			load_building_data("information_booth")
		]
	}


func load_building_data(building: String)->Dictionary:
	# Create sprite image in order to send it to the client.
	var sprite_base64 = """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"""
	
	return {
		"name": "Information Booth",
		"type": "static",
		"position": Vector2(700, 200),
		"scale_factor": 2,
		"collision_shape": {
			"type": "rectangle",
			"extents": {
				"x": 72,
				"y": 90,
			},
			"position": {
				"x": 0,
				"y": 16
			}
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
						"x": 132,
						"y": 148,
					},
					"position": {
						"x": 0,
						"y": 16
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
