note
	description: "String comparer used in for comparing elements in a case-specified manner."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMER_STRING_COMPARER

inherit
	ICOMPARER

	IHASH_CODE_PROVIDER

create
	make

feature {NONE} -- Initialization

	make (a_ignore_case: BOOLEAN)
			-- Initialize a comparer that will or will not ignore case based on `a_ignore_case'
		do
			is_case_insensitive := a_ignore_case
		ensure
			is_case_insensitive_set: is_case_insensitive = a_ignore_case
		end

feature -- Query

	compare (a_x: SYSTEM_OBJECT; a_y: SYSTEM_OBJECT): INTEGER
			-- Compares the specified objects.
		local
			l_x, l_y: SYSTEM_STRING
		do
			if a_x /= a_y then
				l_x ?= a_x
				l_y ?= a_y
				if l_x /= Void and l_y /= Void then
					Result := {SYSTEM_STRING}.compare (l_x, l_y, is_case_insensitive)
				elseif l_x = Void then
					Result := -1
				else
					Result := 1
				end
			end
		end

	get_hash_code_object (a_obj: SYSTEM_OBJECT): INTEGER_32
			-- Returns a hash code for the specified object.
		local
			l_s: SYSTEM_STRING
		do
			if is_case_insensitive then
				l_s ?= a_obj
			end
			if l_s /= Void then
				Result := l_s.to_lower.get_hash_code
			else
				Result := a_obj.get_hash_code
			end
		end

feature -- Status report

	is_case_insensitive: BOOLEAN
			-- Indicates if case should be ignored when compaing items

;note
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

end -- class {CONSUMER_STRING_COMPARER}
