indexing
	description:
		"A simple example of using class ACTION_SEQUENCE %
		% Tests pause, block and resume (not completely) %
		% Tests nested calls to ACTION_SEQUENCE.call %
		% Has example of a simple wrapper to allow easy binding."
	status:
		"See notice at end of class"
	keywords:
		"event, action"
	date:
		"$Date$"
	revision:
		"$Revision$"

class EVENT_EXAMPLE

creation
	make

feature -- Initialization

	make is
		do
			create birthday_actions.make ("birthday", <<"age","name">>)
			birthday_actions.extend (~send_card (?, ?, "Sam"))
			birthday_actions.extend (~buy_gift (?, ?, "cigars", "Sam"))
			birthday_actions.extend (~buy_gift (?, ?, "wine", "Sam"))
			birthday_actions.extend (~birthday_wrapper (?, ?, ~ print ("doing nothing...%N")))

			create nirvana_actions.make ("nirvana", <<>>)
			nirvana_actions.extend (~bliss_out)

			birthday_actions.call ([35, "Bertrand"])
			birthday_actions.call ([36, "Bertrand"])
			birthday_actions.call ([37, "Bertrand"])

			birthday_actions.extend (~buy_gift (?, ?, "learning perl", "Sam"))

			birthday_actions.pause

			birthday_actions.call ([38, "Bertrand"])
			birthday_actions.call ([39, "Bertrand"])

			birthday_actions.block

			birthday_actions.call ([40, "Bertrand"])
			birthday_actions.call ([41, "Bertrand"])

			birthday_actions.resume

			create loopy_actions.make ("loopy stuff", <<"counter">>)
			loopy_actions.extend (~loopy_wrapper (?, ~print("loopy action1!!%N")))
			loopy_actions.extend (~loopy_wrapper (?, ~print("loopy action2!!%N")))
			loopy_actions.extend (~loopy_action) 
			loopy_actions.extend (~loopy_wrapper (?, ~print("loopy action4!!%N")))
			loopy_actions.extend (~loopy_wrapper (?, ~print("loopy action5!!%N")))
			loopy_actions.call ([1])
		end

feature -- Event handlers

	birthday_data: TUPLE [INTEGER, STRING]
		 -- (age, name)
	birthday_actions: ACTION_SEQUENCE [like birthday_data]

	birthday_wrapper (age: INTEGER; name: STRING; p: PROCEDURE [ANY, TUPLE]) is
		do
			p.call ([age, name])
		end 

	nirvana_actions:  ACTION_SEQUENCE [TUPLE []]

feature -- Nesting test

	loopy_actions:  ACTION_SEQUENCE [TUPLE [INTEGER]]

	loopy_wrapper (i: INTEGER; p: PROCEDURE [ANY, TUPLE]) is
		do
			p.call ([i])
		end 

	loopy_action (i: INTEGER) is
		do
			if i < 10 then
				loopy_actions.call ([i+1])
			end
		end


feature -- Brown-nosing

	send_card (age: INTEGER; name, from_who: STRING) is
			-- Send `name' a `age'th birthday card from `from_who'. 
		do
			print ("Dear "+name+", happy "+age.out+"th birthday.%NRegards "+from_who+".%N")
			increase_karma
		end

	buy_gift (age: INTEGER; name, gift, from_who: STRING) is
			-- Buy `gift' for `name' for thier `age'th birthday from `from_who'. 
		do
			print ("Ordering "+gift+" for "+name+", billing "+from_who+".%N")
			if name.is_equal ("Bertrand") and gift.is_equal ("learning perl") then
				decrease_karma
			else
				increase_karma
			end
		end

feature -- Virtue

	increase_karma is
		do
			karma := karma + 1
			print ("karma is "+karma.out+"%N")
			if karma > 7 then
				nirvana_actions.call ([])
			end
		end

	decrease_karma is
		do
			print ("Oops...%N")
			karma := karma - 100
			print ("karma is "+karma.out+"%N")
		end

feature -- Reward

	bliss_out is
		do
			print ("Peace, love and mung beans baby!%N")
		end

feature {NONE} -- Implementation

	karma: REAL

end
