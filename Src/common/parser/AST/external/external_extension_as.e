indexing
	description: "Encapsulation of an external extension."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class EXTERNAL_EXTENSION_AS

feature -- Properties

	argument_types: ARRAY [INTEGER]
			-- Types of the arguments (extracted from the C signature)

	return_type: INTEGER
			-- Return type (extracted from the C signature)

	header_files: ARRAY [INTEGER]
			-- Header files to include

feature -- Conveniences

	is_macro: BOOLEAN is
			-- Is this a macro extension?
		do
		end

	is_struct: BOOLEAN is
			-- Is this a struct extension?
		do
		end

	is_dll: BOOLEAN is
			-- Is this a dll extension?
		do
		end

	has_signature: BOOLEAN is
			-- Does the extension define a c_signature?
		do
			Result := return_type > 0 or else argument_types /= Void
		end

feature {NONE} -- Implementation

	c_signature: STRING
			-- Signature

	include_files: STRING
			-- Include files

	special_part: STRING;
			-- Special part

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EXTERNAL_EXTENSION_AS
