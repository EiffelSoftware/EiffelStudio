indexing
	description: "Eiffel representation of a CodeDom snippet compile unit"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SNIPPET_COMPILE_UNIT

inherit
	CODE_COMPILE_UNIT
		redefine
			ready,
			code
		end

create
	make
	
feature -- Access

	value: STRING
			-- Literal code block of the snippet

	code: STRING is
			-- Eiffel code of snippet compile unit
		do
			Result := value.twin
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is snippet compile unit ready to be generated?
		do
			Result := Precursor {CODE_COMPILE_UNIT} and value /= Void
		end

feature -- Status Setting

	set_value (a_value: like value) is
			-- Set `value' with `a_value'.
		require
			non_void_value: a_value /= Void
		do
			value := a_value
		ensure
			value_set: value = a_value
		end
	
end -- class CODE_SNIPPET_COMPILE_UNIT

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