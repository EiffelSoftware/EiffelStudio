note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"
class
	INSERT_CONTROLLER

inherit
	DEMOAPPLICATION_CONTROLLER

create
	default_create

feature -- Status Change

--	insert: STRING
--			-- Inserts a new reservation into the db
--		do
--				Result := "Default Error"

--				if attached {STRING} current_request.argument_table ["name"] as name and
--				   attached {STRING} current_request.argument_table ["date"] as date and
--				   attached {STRING} current_request.argument_table ["persons"] as persons and
--				   attached {STRING} current_request.argument_table ["description"] as description then

--					if global_state.db.insert_reservation (name, date, persons.to_integer_32, description) then
--						Result := "New reservation successfully inserted."
--					else
--						Result := "Error inserting reservation"
--					end
--				else
--					Result := "Error, not enough arguments"
--				end
--		ensure
--			Result_attached: Result /= Void
--		end

	save (a_reservation: RESERVATION): STRING
		do
			Result := "login.xeb"
		end

	print_something (a_arg: STRING): STRING
		do
			print ("IT WORKS " + a_arg)
			Result := "bluh.html"
		end
note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
