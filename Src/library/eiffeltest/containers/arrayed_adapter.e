indexing
	description:
		"Adapter from ARRAYED_LIST to BASIC"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class ARRAYED_ADAPTER [G] inherit

	ARRAYED_LIST [G]
		rename
			replace as list_replace, remove as list_remove
		export
			{NONE} all
		redefine
			extend
		end

create

	-- Not for instantiation

feature -- Element change

	extend (v: G) is
			-- Add `v' to end.
		do
			Precursor (v)
			if off then go_i_th (1) end
		ensure then
			not_off: not off
		end

	replace (v: G; i: INTEGER) is
			-- Replace `i'-th item with `v'.
		local
			old_idx: INTEGER
		do
			old_idx := index
			go_i_th (i)
			list_replace (v)
			go_i_th (old_idx)
		end

feature -- Removal

	remove (i: INTEGER) is
			-- Remove `i'-th.
		local
			old_idx: INTEGER
		do
			old_idx := index
			go_i_th (i)
			list_remove
			go_i_th (old_idx)
		end


end -- class ARRAYED_ADAPTER

--|----------------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000-2001 Interactive Software Engineering Inc (ISE).
--| EiffelTest may be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------------
