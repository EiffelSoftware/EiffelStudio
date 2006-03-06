indexing
	description: "Variable reference with resolved Eiffel name and Eiffel type name"
	date: "$Date$"
	revision: "$Revision$"
	note: "Instances of this class are used for code snippets, any other variable reference%
			%should use instances of CODE_VARIABLE_REFERENCE"

class
	CODE_SNIPPET_VARIABLE

inherit
	CODE_ENTITY

create
	make
	
feature {NONE} -- Initialization

	make (a_eiffel_name, a_eiffel_type_name: STRING) is
			-- Set `eiffel_name' with `a_eiffel_name' and `eiffel_type_name' with `a_eiffel_type_name'.
		require
			non_void_eiffel_name: a_eiffel_name /= Void
			non_void_eiffel_type_name: a_eiffel_type_name /= Void
		do
			eiffel_name := a_eiffel_name
			eiffel_type_name := a_eiffel_type_name
		ensure
			eiffel_name_set: eiffel_name = a_eiffel_name
			eiffel_type_name_set: eiffel_type_name = a_eiffel_type_name
		end

feature -- Access

	eiffel_name: STRING
			-- Eiffel variable name

	eiffel_type_name: STRING
			-- Eiffel variable type name

	code: STRING is
			-- Local declaration
		do
			create Result.make (200)
			Result.append (Indent_string)
			Result.append (eiffel_name)
			Result.append (": ")
			Result.append (eiffel_type_name)
		end
	
invariant
	non_void_eiffel_name: eiffel_name /= Void
	non_void_eiffel_type_name: eiffel_type_name /= Void

end -- class CODE_SNIPPET_VARIABLE

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