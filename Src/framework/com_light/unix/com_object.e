note
	description: "Light COM object"
	date: "$Date$"
	revision: "$Revision$"

class
	COM_OBJECT

create
	make_by_pointer,
	make_with_program_id,
	make_active_object_with_program_id


feature {NONE} -- Initialization

	make_by_pointer (an_item: POINTER)
			-- Initialize Current with `an_item'.
		do
		end

	make_with_program_id (a_name: READABLE_STRING_GENERAL)
			-- Initialization
			-- Example of program ID: "Word.Application"
		do
		end

	make_active_object_with_program_id (a_name: READABLE_STRING_GENERAL)
			-- Initialize with running object of `a_name'
			-- Example of program ID: "Word.Application"
		do
		end

feature -- Method	

	call_method (a_name: STRING; a_args: detachable TUPLE)
			-- Call OLE method
		require
			a_args_valid: valid_arguments (a_args)
		do
		end

	call_property_get (a_name: STRING; a_args: detachable TUPLE)
			-- Call OLE property get
		require
			a_args_valid: valid_arguments (a_args)
		do
		end

	call_property_put (a_name: STRING; a_args: detachable TUPLE)
			-- Call OLE property put
		require
			a_args_valid: valid_arguments (a_args)
		do
		end

	call_property_put_ref (a_name: STRING; a_args: detachable TUPLE)
			-- Call OLE property put ref
		require
			a_args_valid: valid_arguments (a_args)
		do
		end

feature -- Access

	last_object: detachable COM_OBJECT
			-- Last object from call result
		do
		end

	last_string: detachable STRING_32
			-- Last string from call result
		do
		end

feature -- Status report

	exists: BOOLEAN
			-- Is Current properly associated to a COM object?
		do
		end

	is_successful: BOOLEAN
			-- Was last call to a COM routine of `Current' successful?
		do
		end

	valid_arguments (a_args: detachable TUPLE): BOOLEAN
			-- Is `a_args' valid as arguments of OLE method call?
		do
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
