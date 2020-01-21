
/*
		WELCOME TO THE FULPSTATION CODE Z-LEVEL!


	Any time we want to outright overwrite a variable that is already given a value in a previously defined atom or datum, we
	can overwrite it here!

		WHY DO THIS?

	So we don't have to overwrite the variables defined in TG code.
*/





 	//antag disallowing//

/datum/game_mode/revolution
	restricted_jobs = list("Security Officer", "Warden", "Detective", "AI", "Cyborg","Captain", "Head of Personnel", "Head of Security", "Chief Engineer", "Research Director", "Chief Medical Officer", "Deputy")

/datum/game_mode/clockwork_cult
	restricted_jobs = list("Chaplain", "Captain", "Deputy")

/datum/game_mode/cult
	restricted_jobs = list("Chaplain","AI", "Cyborg", "Security Officer", "Warden", "Detective", "Head of Security", "Captain", "Head of Personnel", "Deputy")

/datum/game_mode/traitor
	restricted_jobs = list("Cyborg", "Deputy")




/obj/item/clothing/accessory
	mob_overlay_icon = 'icons/mob/clothing/accessories.dmi'

/obj/item/clothing/suit/space/hardsuit
	var/toggle_helmet_sound = 'sound/mecha/mechmove03.ogg'

//*************************************************************************
//** FULPSTATION IMPROVED RECORD SECURITY PR -Surrealistik Oct 2019 BEGINS
//**-----------------------------------------------------------------------
//** -Adds security levels to the security record computer.
//** -Adds arrest logging for security bots.
//*************************************************************************

/mob/living/simple_animal/bot/secbot
	var/list/arrest_cooldown = list() //If you're in the list, we don't log the arrest

//*************************************************************************
//** FULPSTATION IMPROVED RECORD SECURITY PR -Surrealistik Oct 2019 ENDS
//**-----------------------------------------------------------------------
//** -Adds security levels to the security record computer.
//** -Adds arrest logging for security bots.
//*************************************************************************


//******************************************************
//SEC BODY CAMS by Surrealistik Oct 2019 BEGINS
//******************************************************
/obj/item/clothing/under/rank/security
	var/obj/machinery/camera/builtInCamera = null
	var/registrant
	var/camera_on = TRUE
	var/sound_time_stamp
	req_one_access = list(ACCESS_SECURITY, ACCESS_FORENSICS_LOCKERS)

/obj/machinery/computer/security
	req_one_access = list(ACCESS_SECURITY, ACCESS_FORENSICS_LOCKERS)

//******************************************************
//SEC BODY CAMS by Surrealistik Oct 2019 ENDS
//******************************************************


//*************************************************************
//** Mech Weapon Firing Pins PR by Surrealistik Oct 2019 BEGINS
//*************************************************************

/obj/item/mecha_parts/mecha_equipment/weapon
	var/obj/item/firing_pin/pin //standard firing pin for most guns
	var/initial_firing_pin //If it is unlocked by default, this is the firing pin type the weapon uses


/obj/item/mecha_parts/mecha_equipment/weapon/energy/plasma //Plasma cutter; more of a tool than a weapon
	initial_firing_pin = /obj/item/firing_pin //standard firing pin for most guns


/obj/item/mecha_parts/mecha_equipment/weapon/honker
	initial_firing_pin = /obj/item/firing_pin //standard firing pin for most guns


/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/banana_mortar
	initial_firing_pin = /obj/item/firing_pin //standard firing pin for most guns


/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/mousetrap_mortar
	initial_firing_pin = /obj/item/firing_pin //standard firing pin for most guns


/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/punching_glove
	initial_firing_pin = /obj/item/firing_pin //standard firing pin for most guns

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/banana_mortar/bombanana
	initial_firing_pin = null

/obj/item/storage/box/syndicate/bundle_mech/PopulateContents()
	new /obj/item/firing_pin/mech(src)
	new /obj/item/mecha_parts/concealed_weapon_bay(src)

//*************************************************************
//** Mech Weapon Firing Pins PR by Surrealistik Oct 2019 ENDS
//*************************************************************


//***********************************************************************
//** FULP PROPER RADIO CHANNELS FOR BORGS by Surrealistik Nov 2019 BEGINS
//**---------------------------------------------------------------------
//** Borgs now have access to appropriate secure radio channels
//***********************************************************************


/obj/item/robot_module/medical/do_transform_delay()
	..()
	borg_set_radio(/obj/item/encryptionkey/headset_med, FREQ_MEDICAL)


/obj/item/robot_module/engineering/do_transform_delay()
	..()
	borg_set_radio(/obj/item/encryptionkey/headset_eng, FREQ_ENGINEERING)


/obj/item/robot_module/security/do_transform_delay()
	..()
	borg_set_radio(/obj/item/encryptionkey/headset_sec, FREQ_SECURITY)

/obj/item/robot_module/peacekeeper/do_transform_delay()
	..()
	borg_set_radio(/obj/item/encryptionkey/headset_sec, FREQ_SECURITY)


/obj/item/robot_module/miner/do_transform_delay()
	..()
	borg_set_radio(/obj/item/encryptionkey/headset_mining, FREQ_SUPPLY)


/obj/item/robot_module/clown/do_transform_delay()
	..()
	borg_set_radio(/obj/item/encryptionkey/headset_service, FREQ_SERVICE)

/obj/item/robot_module/standard/do_transform_delay()
	..()
	borg_set_radio(/obj/item/encryptionkey/headset_service, FREQ_SERVICE)

/obj/item/robot_module/janitor/do_transform_delay()
	..()
	borg_set_radio(/obj/item/encryptionkey/headset_service, FREQ_SERVICE)

/obj/item/robot_module/butler/do_transform_delay()
	..()
	borg_set_radio(/obj/item/encryptionkey/headset_service, FREQ_SERVICE)


//***********************************************************************
//** FULP PROPER RADIO CHANNELS FOR BORGS by Surrealistik Nov 2019 ENDS
//**---------------------------------------------------------------------
//** Borgs now have access to appropriate secure radio channels
//***********************************************************************

//***************************************************************************
//** FULPSTATION HOLOBEDS by Surrealistik Nov 2019 BEGINS
//---------------------------------------------------------------------------
//** Adds no-collision holobeds to the medborg. Support for handheld versions
//***************************************************************************

/obj/item/robot_module/medical
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/borghypo,
		/obj/item/borg/apparatus/beaker,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/syringe,
		/obj/item/surgical_drapes,
		/obj/item/retractor,
		/obj/item/hemostat,
		/obj/item/cautery,
		/obj/item/surgicaldrill,
		/obj/item/scalpel,
		/obj/item/circular_saw,
		/obj/item/extinguisher/mini,
		/obj/item/holobed_projector/robot,
		/obj/item/borg/cyborghug/medical,
		/obj/item/stack/medical/gauze/cyborg,
		/obj/item/organ_storage,
		/obj/item/borg/lollipop)

//***************************************************************************
//** FULPSTATION HOLOBEDS by Surrealistik Nov 2019 ENDS
//---------------------------------------------------------------------------
//** Adds no-collision holobeds to the medborg. Support for handheld versions
//***************************************************************************


//************************************************************
//** Improved Sec Starter Gear by Surrealistik Oct 2019 BEGINS
//************************************************************

/datum/outfit/job/security
	backpack_contents = list() //Start with stun baton in belt.
	r_pocket = /obj/item/pda/security
	belt = /obj/item/storage/belt/security/fulp_starter_full
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	box = /obj/item/storage/box/security/improved
	pda_slot = SLOT_R_STORE

/datum/outfit/job/warden
	backpack_contents = list() //Start with stun baton in belt.
	r_pocket = /obj/item/pda/security
	belt = /obj/item/storage/belt/security/fulp_starter_full
	box = /obj/item/storage/box/security/improved
	pda_slot = SLOT_R_STORE

/datum/outfit/job/hos
	backpack_contents = list() //Start with stun baton in belt.
	r_pocket = /obj/item/pda/security
	belt = /obj/item/storage/belt/security/fulp_starter_full
	box = /obj/item/storage/box/security/improved
	pda_slot = SLOT_R_STORE


/datum/techweb_node/sec_basic
	design_ids = list("seclite", "pepperspray", "bola_energy", "zipties", "evidencebag", "sec_radio", "sec_belt", "protolathe_handcuffs", "security_helmet", "security_armor", "security_uniform", "security_boots", "stun_baton")

/obj/machinery/vending/security
	products = list(/obj/item/restraints/handcuffs = 8,
					/obj/item/restraints/handcuffs/cable/zipties = 10,
					/obj/item/grenade/flashbang = 15, //Increase of flashbangs to compensate for loss of flashbangs from Sec Officer belt (Estimating ~5) and Sec lockers (~6).
					/obj/item/assembly/flash/handheld = 5,
					/obj/item/reagent_containers/food/snacks/donut = 12,
					/obj/item/storage/box/evidence = 6,
					/obj/item/flashlight/seclite = 4,
					/obj/item/radio/headset/headset_sec/alt = 6, //Compensate for loss of gear from sec-lockers (~6).
					/obj/item/clothing/glasses/hud/security/sunglasses = 6, //Compensate for loss of gear from sec-lockers (~6).
					/obj/item/restraints/legcuffs/bola/energy = 7)

/obj/machinery/vending/wardrobe/sec_wardrobe
	products = list(/obj/item/clothing/suit/hooded/wintercoat/security = 3,
					/obj/item/storage/backpack/security = 3,
					/obj/item/storage/backpack/satchel/sec = 3,
					/obj/item/storage/backpack/duffelbag/sec = 3,
					/obj/item/clothing/under/rank/security/officer = 3,
					/obj/item/clothing/suit/armor/vest/alt = 6, //Compensate for loss of gear from sec-lockers (~6).
					/obj/item/clothing/head/helmet = 6, //Compensate for loss of gear from sec-lockers (~6).
					/obj/item/clothing/shoes/jackboots = 3,
					/obj/item/clothing/head/beret/sec = 3,
					/obj/item/clothing/head/soft/sec = 3,
					/obj/item/clothing/mask/bandana/red = 3,
					/obj/item/clothing/under/rank/security/officer/skirt = 3,
					/obj/item/clothing/under/rank/security/officer/grey = 3,
					/obj/item/clothing/under/pants/khaki = 3,
					/obj/item/clothing/under/rank/security/officer/blueshirt = 3,
					/obj/item/clothing/shoes/jackboots/digitigrade = 2)

/obj/machinery/vending/wardrobe/sec_wardrobe
	req_access = list(ACCESS_SECURITY) //We can now vend armor and helmets, so we need to protect the contents.

/obj/structure/closet/secure_closet/security/PopulateContents()
	..()
	for(var/atom/movable/AM in src) //Empty to reduce locker bloat due to better on-spawn gear and expanded protolathe options; let the grand purge begin.
		qdel(AM)

//************************************************************
//** Improved Sec Starter Gear by Surrealistik Oct 2019 ENDS
//************************************************************