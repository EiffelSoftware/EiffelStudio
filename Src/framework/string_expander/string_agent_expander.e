note
	description: "[
		A string expander utilizing delegate function to retrieve a value associated with a variable name,
		
		See {STRING_EXPANDER} for details on variable styles and expansion.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_AGENT_EXPANDER

inherit
	STRING_EXPANDER
		rename
			expand_string as expand_string_internal,
			expand_string_32 as expand_string_32_internal
		export {NONE}
			expand_string_internal,
			expand_string_32_internal
		end

feature {NONE} -- Access

	value_delegate: detachable FUNCTION [TUPLE [name: READABLE_STRING_8], detachable STRING]
			-- Function used to retrieve a variable value associated with a name.

	value_delegate_32: detachable FUNCTION [TUPLE [name: READABLE_STRING_32], detachable STRING_32]
			-- Function used to retrieve a variable 32-bit value associated with a name.

feature -- Query

	expand_string (a_string: READABLE_STRING_8; a_delegate: FUNCTION [TUPLE [name: READABLE_STRING_8], detachable STRING]; a_keep: BOOLEAN): STRING
			-- Expands a 8-bit string and replaces any variable values.
			--
			-- `a_string'  : The string to expand.
			-- `a_delegate': A function used to retrieve a variable's value.
			-- `a_keep'    : True to retain any unmatched variables in the result; False otherwise.
			-- `Result'    : An expanded string with the match variable expanded.
		require
			a_string_attached: a_string /= Void
			a_delegate_attached: a_delegate /= Void
		do
			value_delegate := a_delegate
			Result := expand_string_internal (a_string, a_keep)
			value_delegate := Void
		ensure
			value_delegate_detached: value_delegate = Void
		end

	expand_string_32 (a_string: READABLE_STRING_32; a_delegate: FUNCTION [TUPLE [name: READABLE_STRING_32], detachable STRING_32]; a_use_env: BOOLEAN; a_keep: BOOLEAN): STRING_32
			-- Expands a 32-bit string and replaces any variable values.
			--
			-- `a_string'  : The string to expand.
			-- `a_delegate': A function used to retrieve a variable's value.
			-- `a_keep'    : True to retain any unmatched variables in the result; False otherwise.
			-- `Result'    : An expanded string with the match variable expanded
		require
			a_string_attached: a_string /= Void
			a_delegate_attached: a_delegate /= Void
		do
			value_delegate_32 := a_delegate
			Result := expand_string_32_internal (a_string, a_keep)
			value_delegate := Void
		ensure
			value_delegate_detached: value_delegate = Void
		end

feature {NONE} -- Query

	variable (a_id: READABLE_STRING_8): detachable STRING
			-- <Precursor>
		do
			if attached value_delegate as l_delegate then
				Result := l_delegate.item ([a_id])
			end
		end

	variable_32 (a_id: READABLE_STRING_32): detachable STRING_32
			-- <Precursor>
		do
			if attached value_delegate_32 as l_delegate then
				Result := l_delegate.item ([a_id])
			end
		end

;note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
