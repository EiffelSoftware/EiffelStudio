indexing 
	description: "Eiffel representation of a routine for non-VS CodeDOM provider"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_ROUTINE

inherit
	ECDP_ROUTINE_INTERFACE

create
	make

feature {NONE} -- Specific implementation

	add_constructor: STRING is
			-- Add constructor
		do
			create Result.make_empty
			if not name.is_equal ("ctor") then
				Result.append (indent_string)
				Result.append ("ctor")
				Result.append (Dictionary.New_line)
			end
		end

end -- class ECDP_ROUTINE

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
