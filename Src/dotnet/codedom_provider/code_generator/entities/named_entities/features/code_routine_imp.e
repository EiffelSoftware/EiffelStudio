indexing 
	description: "Eiffel representation of a routine for non-VS CodeDOM provider"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ROUTINE_IMP

inherit
	CODE_ROUTINE

create
	make

feature {NONE} -- Specific implementation

	constructor_call: STRING is
			-- Add constructor
		do
			create Result.make_empty
			if not name.is_equal (".ctor") then
				Result.append (indent_string)
				Result.append ("make%N")
			end
		end

end -- class CODE_ROUTINE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
