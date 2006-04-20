indexing
	description: "Entry in completion list"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VARIABLE_DESCRIPTOR

inherit
	COMPLETION_ENTRY

create
	make

feature {NONE} -- Initialization

	make (n, s: STRING) is
			-- Set `name' with `n'.
			-- Set `signature' with `s'.
		require
			non_void_name: n /= Void
			non_void_signature: s /= Void
		do
			name := n.as_lower
			signature := s
		ensure
			signature_set: signature = s
			name_set: name.is_equal (n.as_lower)
		end

feature -- Access

	is_feature (return_value: BOOLEAN_REF) is
			-- Is entry a feature? (could be a variable)
			-- Not a feature
		do
			return_value.set_item (False)
		end

	signature: STRING
			-- Signature

	name: STRING;
			-- Name

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
end -- class VARIABLE_DESCRIPTOR
