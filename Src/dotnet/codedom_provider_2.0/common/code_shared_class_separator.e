indexing
	description: "String used to separate class definitions in `.es' files"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SHARED_CLASS_SEPARATOR

inherit
	CODE_SHARED_GENERATION_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	Class_separator: STRING is
			-- Token used to separate class definition in single file
		once
			Result := Line_return + "--__end_class__--" + Line_return
		end

end -- class CODE_SHARED_CLASS_SEPARATOR

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