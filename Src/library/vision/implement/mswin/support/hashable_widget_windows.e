indexing 
	description: "Hashing routines for a Widget";
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 

class
	HASHABLE_WIDGET_WINDOWS

inherit
	HASHABLE

feature -- Access

	hash_code: INTEGER 
			-- Hash code

feature {ACTIONS_MANAGER}

	set_hash_code is
			-- Set the hash code of the widget		
		do
			if hash_code = 0 then
				hash_code := hash_code_generator.value
				hash_code_generator.next
			end
		end

feature {NONE} -- Implemementation

	hash_code_generator: INTEGER_GENERATOR_WINDOWS is
			-- Generator for hash code values
		once
			!! Result.make (1, 32767 * 32766)
		end

end -- class HASHABLE_WIDGET_WINDOWS


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

