note
	description: "Pseudo random number in a range."
	author: "David Stevens"
	date: "$Date$"
	revision: "$Revision$"
	archive: "$Archive: /Beta/Kernel/Containers/ranged_random.e $"

class
	RANGED_RANDOM

inherit
	RANDOM

create
	make, make_default

feature {NONE} -- Initialization

	make_default
		local
			t: TIME
		do
			create t.make_now
			set_seed (t.seconds \\ 1000)
		end

feature -- Access

	next_item_in_range (a_min: INTEGER; a_max: INTEGER): INTEGER
		local
			l_double: DOUBLE
		do
			forth
			l_double := a_min + (a_max - a_min) * double_item
			Result := l_double.rounded
		end

end -- class RANGED_RANDOM
