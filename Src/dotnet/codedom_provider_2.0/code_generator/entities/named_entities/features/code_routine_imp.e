indexing 
	description: "Eiffel representation of a routine for non-VS CodeDOM provider"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ROUTINE_IMP

inherit
	CODE_ROUTINE

	CODE_SHARED_NAME_FORMATTER

create
	make

feature {NONE} -- Specific implementation

	constructor_call: STRING is
			-- Add constructor
		do
			create Result.make_empty
			if not name.is_equal (".ctor") then
				Result.append (indent_string)
				Result.append (Ctor_eiffel_name.twin)
				Result.append (Line_return)
			end
		end

feature {NONE} -- Implementation

	Ctor_eiffel_name: STRING is
				-- Eiffel name for `.ctor'
			once
				Result := Name_formatter.valid_variable_name (".ctor")
			end

end -- class CODE_ROUTINE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
