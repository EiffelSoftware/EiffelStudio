indexing
	description: "Eiffel representation of a CodeDom snippet compile unit"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SNIPPET_COMPILE_UNIT

inherit
	CODE_COMPILE_UNIT
		rename
			make as parent_make
		redefine
			code
		end

create
	make

feature {NONE} -- Initialization

	make (a_value: like value) is
			-- Initialize `namespaces'.
		require
			non_void_value: a_value /= Void
		do
			create {ARRAYED_LIST [CODE_NAMESPACE]} namespaces.make (0)
			value := a_value
		ensure
			value_set: value = a_value
		end

feature -- Access

	value: STRING
			-- Literal code block of the snippet

	code: STRING is
			-- Eiffel code of snippet compile unit
		do
			Result := value.twin
		end

invariant
	non_void_value: value /= Void

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