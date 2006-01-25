indexing
	description: "String used to separate class definitions in `.es' files"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SHARED_CLASS_SEPARATOR

feature -- Access

	Class_separator: STRING is "%N--__end_class__--%N"
			-- Token used to separate class definition in single file

end -- class CODE_SHARED_CLASS_SEPARATOR

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