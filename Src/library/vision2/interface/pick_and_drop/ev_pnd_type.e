indexing
	description: "Abstract class representing the type of the transported data."
	status: "See notice at end of class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PND_TYPE

inherit
	HASHABLE

creation
	make, make_with_id--, make_with_cursor

feature {NONE} -- Initialization

	make is
			-- Create a pick and drop type.
		do
			counter.set_item (counter.item + 1)
			identifier := counter.item
		end

-- 	make_with_cursor (curs: EV_SCREEN_CURSOR) is
-- 			-- Create a pick and drop type with a cursor.
-- 		do
--			counter.set_item (counter.item + 1)
--			identifier := counter.item
-- 			set_cursor (curs)
-- 		end

	make_with_id (id: INTEGER) is
			-- Create a pick and drop with an identifier.
		do
			identifier := id
		end

feature -- Attribute

	identifier: INTEGER
			-- Idendifier of the current type

--	cursor: EV_SCREEN_CURSOR
			-- Cursor associated with
			-- current data during transport
	
feature -- Access

--	set_cursor (curs: EV_SCREEN_CURSOR) is
--			-- Set the `cursor' of the current type.
--		require
--			valid_cursor: curs /= Void
--		do
--			cursor := curs
--		end

feature {EV_PND_TARGET_I} -- Implementation

	hash_code: INTEGER is
		do
			Result := identifier
		end

feature {NONE} -- Implementation

	counter: INTEGER_REF is
		once
			!! Result
		end

end -- class EV_PND_TYPE

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

