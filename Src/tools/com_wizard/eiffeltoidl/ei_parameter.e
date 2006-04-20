indexing
	description: "Parameter"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EI_PARAMETER

creation
	make

feature {NONE} -- Initialization

	make (new_name, new_type: STRING) is
			-- Create and initialize object with parameters.
		require
			non_void_name: new_name /= Void
			non_void_type: new_type /= Void
			valid_name: not new_name.is_empty
			valid_type: not new_type.is_empty
		do
			set_name (new_name)
			set_type (new_type)
		end

feature -- Access

	name: STRING
			-- Name

	type: STRING
			-- Type

feature -- Element change

	set_name (new_name: STRING) is
			-- Set 'name' to 'new_name'
		require
			non_void_name: new_name /= Void
			valid_name: not new_name.is_empty
		do
			name := new_name.twin
		ensure
			name_set: name.is_equal (new_name)
		end

	set_type (new_type: STRING) is
			-- Set 'type' to 'new_type'
		require
			non_void_type: new_type /= Void
			valid_type: not new_type.is_empty
		do
			type:= new_type.twin
		ensure
			type_set: type.is_equal (new_type)
		end

feature -- Output

	code: STRING is
			-- Code output
		do
		end

invariant
	non_void_name: name /= Void
	non_void_type: type /= Void
	valid_name: not name.is_empty
	valid_type: not type.is_empty

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
end -- class EI_ATTRIBUTE

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

