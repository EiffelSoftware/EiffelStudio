indexing
	description: "Object returned by validity checking functions"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_VALIDITY_STATUS

inherit
	WIZARD_VALIDITY_STATUS_IDS

create
	make_success,
	make_error

feature {NONE} -- Initialization

	make_success (a_id: like id) is
			-- Set `id' with `a_id'.
		require
			valid_id: is_valid_status_id (a_id)
		do
			id := a_id
		ensure
			id_set: id = a_id
		end
	
	make_error (a_id: like id) is
			-- Set `id' with `a_id'.
			-- Set `is_error' to `True'.
		require
			valid_id: is_valid_status_id (a_id)
		do
			id := a_id
			is_error := True
		ensure
			id_set: id = a_id
			is_error: is_error
		end

feature -- Access

	id: INTEGER
			-- Status ID
			-- Used to check for global validity

	is_error: BOOLEAN
			-- Does status correspond to error?
	
	error_message: STRING is
			-- Error message if `is_error'
		do
			Result := errors.item (id)
		ensure
			non_void_message: Result /= Void
		end

invariant
	valid_id: is_valid_status_id (id)
		
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
end

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