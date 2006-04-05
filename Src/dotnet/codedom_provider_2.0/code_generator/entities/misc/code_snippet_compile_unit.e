indexing
	description: "Eiffel representation of a CodeDom snippet compile unit"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
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
