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
			create birthday_actions
			create sweet_sixteen_actions.make (birthday_actions)
			birthday_actions.extend (~send_card (?, ?, "Sam"))
			birthday_actions.extend (~buy_gift (?, ?, "cigars", "Sam"))
			birthday_actions.extend (~buy_gift (?, ?, "wine", "Sam"))
			birthday_actions.extend (birthday_actions~wrapper (?, ?, ~ print ("doing nothing...%N")))

			create nirvana_actions.make ("nirvana", <<>>)
			nirvana_actions.extend (~bliss_out)

			sweet_sixteen_actions.extend (~buy_car (?, "Sam"))

			birthday_actions.call ([16, "Alice"])

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

	birthday_actions: BIRTHDAY_ACTION_SEQUENCE

	sweet_sixteen_actions: SWEET_SIXTEEN_ACTION_SEQUENCE

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

	buy_car (lucky, broke: STRING) is
			-- Buy car for `lucky' from `broke'. 
		do
			print ("T-bird for "+lucky+" from "+broke+", vrrrrmmmm!%N")
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


--|----------------------------------------------------------------
--| EiffelEvent: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

