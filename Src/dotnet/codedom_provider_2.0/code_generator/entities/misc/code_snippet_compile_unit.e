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

	CODE_SHARED_CLASS_SEPARATOR
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_source: SYSTEM_DLL_CODE_SNIPPET_COMPILE_UNIT) is
			-- Initialize `namespaces'.
		require
			non_void_source: a_source /= Void
		do
			create {ARRAYED_LIST [CODE_NAMESPACE]} namespaces.make (0)
			value := a_source.value
			if a_source.line_pragma /= Void then
				create line_pragma.make (a_source.line_pragma)
			end
		ensure
			value_set: value = a_source.value
		end

feature -- Access

	value: STRING
			-- Literal code block of the snippet

	line_pragma: CODE_LINE_PRAGMA
			-- Line pragma

	code: STRING is
			-- Eiffel code of snippet compile unit
		do
			create Result.make (value.count)
			if line_pragma /= Void then
				Result.append (line_pragma.code)
			end
			Result.append (value)
			Result.append (Class_separator)
		end

invariant
	non_void_value: value /= Void

end -- class CODE_SNIPPET_COMPILE_UNIT

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
