indexing

	description:
		"";
	date: "$Date$";
	revision: "$Revision$"

class TWO_ITEMS [T]

feature

	first, second: T

	set_first (v: T) is
		do
			first := v
		end

	set_second (v: T) is
		do
			second := v
		end

end -- class TWO_ITEMS
