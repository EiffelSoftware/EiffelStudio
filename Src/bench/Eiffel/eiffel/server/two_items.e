indexing

	description:
		"";
	date: "$Date$";
	revision: "$Revision$"

class TWO_ITEMS [T]

feature -- Access

	first, second: T

feature -- Element change

	swap is
			-- Swap `first' and `second'.
		local
			temp: T
		do
			temp := first
			first := second
			second := temp
		end

feature -- Settings

	set_first (v: T) is
			-- Make `v' the first item of Current.
		do
			first := v
		end

	set_second (v: T) is
			-- Make `v' the second item of Current.
		do
			second := v
		end

feature -- Removal

	wipe_out is
			-- Clear Current
		do
			first := Void
			second := Void
		end

end -- class TWO_ITEMS
