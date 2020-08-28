/datum/outfit/syndicate/plasmaman
	name = "Syndicate Operative Plasmaman - Basic"
	head = /obj/item/clothing/head/helmet/space/plasmaman/robotics/syndicate
	uniform = /obj/item/clothing/under/plasmaman/security/syndicate
	r_hand= /obj/item/tank/internals/plasmaman/belt/full
	mask = /obj/item/clothing/mask/gas/syndicate
	gloves = /obj/item/clothing/gloves/combat

/datum/outfit/syndicate/leader/plasmaman
	name = "Syndicate Leader Plasmaman - Basic"
	head = /obj/item/clothing/head/helmet/space/plasmaman/robotics/syndicate
	uniform = /obj/item/clothing/under/plasmaman/security/syndicate
	r_pocket= /obj/item/tank/internals/plasmaman/belt/full // They spawn with both hands busy, so they have to manually set internals
	mask = /obj/item/clothing/mask/gas/syndicate
	id = /obj/item/card/id/syndicate/nuke_leader
	gloves = /obj/item/clothing/gloves/krav_maga/combatglovesplus
	command_radio = TRUE
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/kitchen/knife/combat/survival)

/obj/item/clothing/head/helmet/space/plasmaman/robotics/syndicate
	name = "syndicate plasma envirosuit helmet"
	desc = "A plasmaman envirosuit helmet designed for syndicate operatives."

/obj/item/clothing/under/plasmaman/security/syndicate
	name = "syndicate plasma envirosuit"
	desc = "A non-descript and slightly suspicious looking plasmaman enviormental suit."
	worn_icon = 'icons/fulpicons/phoenix_nest/syndicate_suits.dmi'
	icon = 'icons/fulpicons/phoenix_nest/syndicate_suits_icons.dmi'
	icon_state = "syndicate_envirosuit"
	has_sensor = NO_SENSORS
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 0, "fire" = 95, "acid" = 95)

