note
	description: "Strong signing for IL code generation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_STRONG_NAME

create
	make

feature

	make
			-- Create instance of MD_STRONG_NAME.
		do
		end

feature -- Access

	exists: BOOLEAN = False;
		-- On Unix platform, no strong signing ability.

	assembly_signature (a_file: UNI_STRING; a_public_private_key: MANAGED_POINTER): MANAGED_POINTER
			-- Signature of assembly `a_file' using `a_public_private_key'.
		require
			a_file_not_void: a_file /= Void
			a_public_private_key_not_void: a_public_private_key /= Void
		do
			check to_be_implemented: False end
		end

	assembly_signature_size (a_public_private_key: MANAGED_POINTER): INTEGER
			-- Size of signature using `a_public_private_key'.
		require
			a_public_private_key_not_void: a_public_private_key /= Void
		do
			check to_be_implemented: False end
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
