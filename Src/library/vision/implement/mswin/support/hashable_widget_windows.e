indexing 
	description: "Hashing routines for a Widget"
	legal: "See notice at end of class.";
	status: "See notice at end of class."; 
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
			create Result.make (1, 32767 * 32766)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class HASHABLE_WIDGET_WINDOWS

