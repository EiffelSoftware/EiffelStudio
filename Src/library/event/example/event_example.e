indexing
	description:
		"A simple example of using class ACTION_SEQUENCE"
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
		end

feature -- Event handlers

	birthday_data: TUPLE [INTEGER, STRING]
		 -- (age, name)
	birthday_actions: ACTION_SEQUENCE [like birthday_data]

	nirvana_actions:  ACTION_SEQUENCE [TUPLE []]

feature -- Brown-nosing

	send_card (age: INTEGER; name, from_who: STRING) is
			-- Send `name' a `age'th birthday card from `from_who'. 
		do
			print ("Dear "+name+", happy "+age.out+"th birthday.%NRegards "+from_who+".%N")
			increase_carma
		end

	buy_gift (age: INTEGER; name, gift, from_who: STRING) is
			-- Buy `gift' for `name' for thier `age'th birthday from `from_who'. 
		do
			print ("Ordering "+gift+" for "+name+", billing "+from_who+".%N")
			if name.is_equal ("Bertrand") and gift.is_equal ("learning perl") then
				decrease_carma
			else
				increase_carma
			end
		end

feature -- Virtue

	increase_carma is
		do
			carma := carma + 1
			if carma >= 7 then
				nirvana_actions.call ([])
			end
		end

	decrease_carma is
		do
			print ("Oops...%N")
			carma := carma - 100
		end

feature -- Reward

	bliss_out is
		do
			print ("Peace, love and mung beans baby!%N")
		end

feature {NONE} -- Implementation

	carma: REAL

end
