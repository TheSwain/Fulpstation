/datum/martial_art/fulpwrestling
	name = "Wrestling"
	id = MARTIALART_FULPWRESTLING
	var/datum/action/fulpslam/slam = new/datum/action/fulpslam()
	var/datum/action/fulpthrow_wrassle/throw_wrassle = new/datum/action/fulpthrow_wrassle()
	var/datum/action/fulpkick/kick = new/datum/action/fulpkick()
	var/datum/action/fulpstrike/strike = new/datum/action/fulpstrike()
	var/datum/action/fulpdrop/drop = new/datum/action/fulpdrop()

/datum/martial_art/fulpwrestling/proc/check_streak(mob/living/carbon/human/A, mob/living/carbon/human/D)
	switch(streak)
		if("fulpdrop") // Crashes into someone, dealing damage but with a cooldown
			streak = ""
			fulpdrop(A,D)
			return 1
		if("fulpstrike") // Slightly stronger than just punching
			streak = ""
			fulpstrike(A,D)
			return 1
		if("fulpkick") // Kicks someone away, doesn't deal damage but used to get away
			streak = ""
			fulpkick(A,D)
			return 1
		if("fulpthrow") // Spins and throws someone, just for the fancy
			streak = ""
			fulpthrow_wrassle(A,D)
			return 1
		if("fulpslam") // Slams someone onto the floor as long as you have them grabbed
			streak = ""
			fulpslam(A,D)
			return 1
	return 0

/datum/action/fulpslam
	name = "Slam (Cinch) - Slam a grappled opponent into the floor."
	button_icon_state = "wrassle_slam"
	icon_icon = 'icons/mob/actions/actions_wrestling.dmi'

/datum/action/fulpslam/Trigger()
	if(owner.incapacitated())
		to_chat(owner, "<span class='warning'>You can't WRESTLE while you're OUT FOR THE COUNT.</span>")
		return
	owner.visible_message("<span class='danger'>[owner] prepares to BODY SLAM!</span>", "<b><i>Your next attack will be a BODY SLAM.</i></b>")
	var/mob/living/carbon/human/H = owner
	H.mind.martial_art.streak = "fulpslam"

/datum/action/fulpthrow_wrassle
	name = "Throw (Cinch) - Spin a cinched opponent around and throw them."
	button_icon_state = "wrassle_throw"
	icon_icon = 'icons/mob/actions/actions_wrestling.dmi'

/datum/action/fulpthrow_wrassle/Trigger()
	if(owner.incapacitated())
		to_chat(owner, "<span class='warning'>You can't WRESTLE while you're OUT FOR THE COUNT.</span>")
		return
	owner.visible_message("<span class='danger'>[owner] prepares to THROW!</span>", "<b><i>Your next attack will be a THROW.</i></b>")
	var/mob/living/carbon/human/H = owner
	H.mind.martial_art.streak = "fulpthrow"

/datum/action/fulpkick
	name = "Kick - A powerful kick, sends people flying away from you."
	button_icon_state = "wrassle_kick"
	icon_icon = 'icons/mob/actions/actions_wrestling.dmi'

/datum/action/fulpkick/Trigger()
	if(owner.incapacitated())
		to_chat(owner, "<span class='warning'>You can't WRESTLE while you're OUT FOR THE COUNT.</span>")
		return
	owner.visible_message("<span class='danger'>[owner] prepares to KICK!</span>", "<b><i>Your next attack will be a KICK.</i></b>")
	var/mob/living/carbon/human/H = owner
	H.mind.martial_art.streak = "fulpkick"

/datum/action/fulpstrike
	name = "Strike - Hit your opponent with a quick attack."
	button_icon_state = "wrassle_strike"
	icon_icon = 'icons/mob/actions/actions_wrestling.dmi'

/datum/action/fulpstrike/Trigger()
	if(owner.incapacitated())
		to_chat(owner, "<span class='warning'>You can't WRESTLE while you're OUT FOR THE COUNT.</span>")
		return
	owner.visible_message("<span class='danger'>[owner] prepares to STRIKE!</span>", "<b><i>Your next attack will be a STRIKE.</i></b>")
	var/mob/living/carbon/human/H = owner
	H.mind.martial_art.streak = "fulpstrike"

/datum/action/fulpdrop
	name = "Drop - Smash down onto an opponent with force."
	button_icon_state = "wrassle_drop"
	icon_icon = 'icons/mob/actions/actions_wrestling.dmi'

/datum/action/fulpdrop/Trigger()
	if(owner.incapacitated())
		to_chat(owner, "<span class='warning'>You can't WRESTLE while you're OUT FOR THE COUNT.</span>")
		return
	owner.visible_message("<span class='danger'>[owner] prepares to LEG DROP!</span>", "<b><i>Your next attack will be a LEG DROP.</i></b>")
	var/mob/living/carbon/human/H = owner
	H.mind.martial_art.streak = "fulpdrop"

/datum/martial_art/fulpwrestling/teach(mob/living/carbon/human/H,make_temporary=0)
	if(..())
		to_chat(H, "<span class='userdanger'>SNAP INTO A THIN TIM!</span>")
		to_chat(H, "<span class='danger'>Place your cursor over a move at the top of the screen to see what it does.</span>")
		drop.Grant(H)
		kick.Grant(H)
		slam.Grant(H)
		throw_wrassle.Grant(H)
		strike.Grant(H)

/datum/martial_art/fulpwrestling/on_remove(mob/living/carbon/human/H)
	to_chat(H, "<span class='userdanger'>You no longer feel that the tower of power is too sweet to be sour...</span>")
	drop.Remove(H)
	kick.Remove(H)
	slam.Remove(H)
	throw_wrassle.Remove(H)
	strike.Remove(H)

/datum/martial_art/fulpwrestling/harm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(check_streak(A,D))
		return 1
	log_combat(A, D, "punched with wrestling")
	..()

/datum/martial_art/fulpwrestling/proc/fulpthrow_wrassle(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(!D)
		return
	if(!A.pulling || A.pulling != D)
		to_chat(A, "<span class='warning'>You need to have [D] in a cinch!</span>")
		return
	D.forceMove(A.loc)
	D.setDir(get_dir(D, A))

	D.Stun(80)
	D.visible_message("<span class='danger'>[A] starts spinning around with [D]!</span>", \
					"<span class='userdanger'>You're spun around by [A]!</span>", "<span class='hear'>You hear aggressive shuffling!</span>", null, A)
	to_chat(A, "<span class='danger'>You start spinning around with [D]!</span>")
	A.emote("scream")

	for (var/i = 0, i < 20, i++)
		var/delay = 5
		switch (i)
			if (17 to INFINITY)
				delay = 0.25
			if (14 to 16)
				delay = 0.5
			if (9 to 13)
				delay = 1
			if (5 to 8)
				delay = 2
			if (0 to 4)
				delay = 3

		if (A && D)

			if (get_dist(A, D) > 1)
				to_chat(A, "<span class='warning'>[D] is too far away!</span>")
				return 0

			if (!isturf(A.loc) || !isturf(D.loc))
				to_chat(A, "<span class='warning'>You can't throw [D] from here!</span>")
				return 0

			A.setDir(turn(A.dir, 90))
			var/turf/T = get_step(A, A.dir)
			var/turf/S = D.loc
			if ((S && isturf(S) && S.Exit(D)) && (T && isturf(T) && T.Enter(A)))
				D.forceMove(T)
				D.setDir(get_dir(D, A))
		else
			return 0

		sleep(delay)

	if (A && D)
		// These are necessary because of the sleep call.

		if (get_dist(A, D) > 1)
			to_chat(A, "<span class='warning'>[D] is too far away!</span>")
			return 0

		if (!isturf(A.loc) || !isturf(D.loc))
			to_chat(A, "<span class='warning'>You can't throw [D] from here!</span>")
			return 0

		D.forceMove(A.loc) // Maybe this will help with the wallthrowing bug.

		D.visible_message("<span class='danger'>[A] throws [D]!</span>", \
						"<span class='userdanger'>You're thrown by [A]!</span>", "<span class='hear'>You hear aggressive shuffling and a loud thud!</span>", null, A)
		to_chat(A, "<span class='danger'>You throw [D]!</span>")
		playsound(A.loc, "swing_hit", 50, TRUE)
		var/turf/T = get_edge_target_turf(A, A.dir)
		if (T && isturf(T))
			if (!D.stat)
				D.emote("scream")
			D.throw_at(T, 10, 4, A, TRUE, TRUE, callback = CALLBACK(D, /mob/living/carbon/human.proc/Paralyze, 15))
	log_combat(A, D, "has thrown with wrestling")
	return 0

/datum/martial_art/fulpwrestling/proc/FlipAnimation(mob/living/carbon/human/D)
	set waitfor = FALSE
	if (D)
		animate(D, transform = matrix(180, MATRIX_ROTATE), time = 1, loop = 0)
	D.Stun(rand(10,15))
	if (D)
		animate(D, transform = null, time = 1, loop = 0)

/datum/martial_art/fulpwrestling/proc/fulpslam(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(!D)
		return
	if(!A.pulling || A.pulling != D)
		to_chat(A, "<span class='warning'>You need to have [D] in a cinch!</span>")
		return
	D.forceMove(A.loc)
	A.setDir(get_dir(A, D))
	D.setDir(get_dir(D, A))

	D.visible_message("<span class='danger'>[A] lifts [D] up!</span>", \
					"<span class='userdanger'>You're lifted up by [A]!</span>", "<span class='hear'>You hear aggressive shuffling!</span>", null, A)
	to_chat(A, "<span class='danger'>You lift [D] up!</span>")

	FlipAnimation()

	for (var/i = 0, i < 3, i++)
		if (A && D)
			A.pixel_y += 3
			D.pixel_y += 3
			A.setDir(turn(A.dir, 90))
			D.setDir(turn(D.dir, 90))

			switch (A.dir)
				if (NORTH)
					D.pixel_x = A.pixel_x
				if (SOUTH)
					D.pixel_x = A.pixel_x
				if (EAST)
					D.pixel_x = A.pixel_x - 8
				if (WEST)
					D.pixel_x = A.pixel_x + 8

			if (get_dist(A, D) > 1)
				to_chat(A, "<span class='warning'>[D] is too far away!</span>")
				A.pixel_x = 0
				A.pixel_y = 0
				D.pixel_x = 0
				D.pixel_y = 0
				return 0

			if (!isturf(A.loc) || !isturf(D.loc))
				to_chat(A, "<span class='warning'>You can't slam [D] here!</span>")
				A.pixel_x = 0
				A.pixel_y = 0
				D.pixel_x = 0
				D.pixel_y = 0
				return 0
		else
			if (A)
				A.pixel_x = 0
				A.pixel_y = 0
			if (D)
				D.pixel_x = 0
				D.pixel_y = 0
			return 0

		sleep(1)

	if (A && D)
		A.pixel_x = 0
		A.pixel_y = 0
		D.pixel_x = 0
		D.pixel_y = 0

		if (get_dist(A, D) > 1)
			to_chat(A, "<span class='warning'>[D] is too far away!</span>")
			return 0

		if (!isturf(A.loc) || !isturf(D.loc))
			to_chat(A, "<span class='warning'>You can't slam [D] here!</span>")
			return 0

		D.forceMove(A.loc)

		var/fluff = "body-slam"
		switch(pick(2,3))
			if (2)
				fluff = "turbo [fluff]"
			if (3)
				fluff = "atomic [fluff]"

		D.visible_message("<span class='danger'>[A] [fluff] [D]!</span>", \
						"<span class='userdanger'>You're [fluff]ed by [A]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
		to_chat(A, "<span class='danger'>You [fluff] [D]!</span>")
		playsound(A.loc, "swing_hit", 50, TRUE)
		if (!D.stat)
			D.emote("scream")
			D.Paralyze(40)

			switch(rand(1,3))
				if (2)
					D.adjustBruteLoss(rand(15,25))
				if (3)
					D.ex_act(EXPLODE_LIGHT)
				else
					D.adjustBruteLoss(rand(15,25))
		else
			D.ex_act(EXPLODE_LIGHT)

	else
		if (A)
			A.pixel_x = 0
			A.pixel_y = 0
		if (D)
			D.pixel_x = 0
			D.pixel_y = 0


	log_combat(A, D, "body-slammed")
	return 0

/datum/martial_art/fulpwrestling/proc/CheckStrikeTurf(mob/living/carbon/human/A, turf/T)
	if (A && (T && isturf(T) && get_dist(A, T) <= 1))
		A.forceMove(T)

/datum/martial_art/fulpwrestling/proc/fulpstrike(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(!D)
		return
	var/turf/T = get_turf(A)
	if (T && isturf(T) && D && isturf(D.loc))
		for (var/i = 0, i < 4, i++)
			A.setDir(turn(A.dir, 90))

		A.forceMove(D.loc)
		addtimer(CALLBACK(src, .proc/CheckStrikeTurf, A, T), 4)

		D.visible_message("<span class='danger'>[A] headbutts [D]!</span>", \
						"<span class='userdanger'>You're headbutted by [A]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
		to_chat(A, "<span class='danger'>You headbutt [D]!</span>")
		D.adjustBruteLoss(rand(10,15))
		playsound(A.loc, "swing_hit", 50, TRUE)
		D.Paralyze(10)
	log_combat(A, D, "headbutted")

/datum/martial_art/fulpwrestling/proc/fulpkick(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(!D)
		return
	A.emote("scream")
	A.emote("flip")
	A.setDir(turn(A.dir, 90))

	D.visible_message("<span class='danger'>[A] roundhouse-kicks [D]!</span>", \
					"<span class='userdanger'>You're roundhouse-kicked by [A]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
	to_chat(A, "<span class='danger'>You roundhouse-kick [D]!</span>")
	playsound(A.loc, "swing_hit", 50, TRUE)

	var/turf/T = get_edge_target_turf(A, get_dir(A, get_step_away(D, A)))
	if (T && isturf(T))
		D.Paralyze(20)
		D.throw_at(T, 3, 2)
	log_combat(A, D, "roundhouse-kicked")

/datum/martial_art/fulpwrestling/proc/fulpdrop(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(!D)
		return
	var/obj/surface = null
	var/turf/ST = null
	var/falling = 0

	for (var/obj/O in oview(1, A))
		if (O.density == 1)
			if (O == A)
				continue
			if (O == D)
				continue
			if (O.opacity)
				continue
			else
				surface = O
				ST = get_turf(O)
				break

	if (surface && (ST && isturf(ST)))
		A.forceMove(ST)
		A.visible_message("<span class='danger'>[A] climbs onto [surface]!</span>", \
						"<span class='danger'>You climb onto [surface]!</span>")
		A.pixel_y = 10
		falling = 1
		sleep(10)

	if (A && D)
		// These are necessary because of the sleep call.

		if ((falling == 0 && get_dist(A, D) > 1) || (falling == 1 && get_dist(A, D) > 2)) // We climbed onto stuff.
			A.pixel_y = 0
			if (falling == 1)
				A.visible_message("<span class='danger'>...and dives head-first into the ground, ouch!</span>", \
								"<span class='userdanger'>...and dive head-first into the ground, ouch!</span>")
				A.adjustBruteLoss(rand(10,15))
				A.Paralyze(80)
			to_chat(A, "<span class='warning'>[D] is too far away!</span>")
			return 0

		if (!isturf(A.loc) || !isturf(D.loc))
			A.pixel_y = 0
			to_chat(A, "<span class='warning'>You can't drop onto [D] from here!</span>")
			return 0

		if(A)
			animate(A, transform = matrix(90, MATRIX_ROTATE), time = 1, loop = 0)
		sleep(10)
		if(A)
			animate(A, transform = null, time = 1, loop = 0)

		A.forceMove(D.loc)

		D.visible_message("<span class='danger'>[A] leg-drops [D]!</span>", \
						"<span class='userdanger'>You're leg-dropped by [A]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", null, A)
		to_chat(A, "<span class='danger'>You leg-drop [D]!</span>")
		playsound(A.loc, "swing_hit", 50, TRUE)
		A.emote("scream")

		if (falling == 1)
			if (prob(33) || D.stat)
				D.ex_act(EXPLODE_LIGHT)
			else
				D.adjustBruteLoss(rand(20,30))
		else
			D.adjustBruteLoss(rand(20,30))

		D.Paralyze(15)

		A.pixel_y = 0

	else
		if (A)
			A.pixel_y = 0
	log_combat(A, D, "leg-dropped")
	return

/datum/martial_art/fulpwrestling/disarm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(check_streak(A,D))
		return 1
	log_combat(A, D, "wrestling-disarmed")
	..()

/datum/martial_art/fulpwrestling/grab_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(check_streak(A,D))
		return 1
	if(A.pulling == D)
		return 1
	A.start_pulling(D)
	D.visible_message("<span class='danger'>[A] gets [D] in a cinch!</span>", \
					"<span class='userdanger'>You're put into a cinch by [A]!</span>", "<span class='hear'>You hear aggressive shuffling!</span>", COMBAT_MESSAGE_RANGE, A)
	to_chat(A, "<span class='danger'>You get [D] in a cinch!</span>")
	D.Stun(rand(10,20))
	log_combat(A, D, "cinched")
	return 1

/obj/item/storage/belt/champion
	var/datum/martial_art/fulpwrestling/style = new

/obj/item/storage/belt/champion/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	if(slot == ITEM_SLOT_BELT)
		var/mob/living/carbon/human/U = user
		if(U.job in list("Quartermaster"))
			var/mob/living/carbon/human/H = user
			style.teach(H,1)
		else
			return
	return

/obj/item/storage/belt/champion/dropped(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.get_item_by_slot(ITEM_SLOT_BELT) == src)
		style.remove(H)
	return
