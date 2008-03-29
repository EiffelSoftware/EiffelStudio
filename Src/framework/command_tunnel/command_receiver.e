indexing
	description: "Register of action to process external command other process."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_RECEIVER

create
	make_key

feature {NONE} -- Initialization

	make_key (a_key: !STRING) is
			-- Initialization
		do
			key := a_key
			create_implementation
		end

feature -- Access

	external_command_action: PROCEDURE [ANY, TUPLE [STRING]]
			-- Procedure action to be called when command is received.

	key: !STRING
			-- The key to identify current

feature -- Element change

	set_external_command_action (a_action: like external_command_action) is
			-- Set `external_command_action' with `a_action'
		do
			external_command_action := a_action
		ensure
			external_command_action_set: external_command_action = a_action
		end

	destroy is
			-- Destroy the receiver
		do
			if implementation /= Void then
				implementation.destroy
				implementation := Void
			end
		end

feature {NONE} -- Implementation

	implementation: ?COMMAND_RECEIVER_I

feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation
		do
			create {COMMAND_RECEIVER_IMP}implementation.make (Current)
		ensure
			implementation_not_void: implementation /= Void
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
