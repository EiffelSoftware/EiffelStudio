note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	RESERVATION_CONTROLLER

inherit
	DEMOAPPLICATION_CONTROLLER

create
	default_create

feature -- Status Change	

	get_res_id_from_args: STRING
			-- Retrieve reservartion ID from request arguments
		do
			Result := ""
			if attached {STRING} current_request.argument_table["id"] as id then
				if attached {RESERVATION} global_state.db.reservation_by_id (id.to_integer_32) as res then
					Result := res.id.out
				end
			end
		ensure
			Result_attached: Result /= Void
		end

	save (a_bean: ANY)
		do
			if attached {RESERVATION} a_bean as l_reservation then
				global_state.db.reservations.extend (l_reservation)
			end
		end

	delete (a_bean: detachable ANY)
		do
			if attached {RESERVATION} a_bean as l_reservation then
				global_state.db.reservations.start
				global_state.db.reservations.prune (l_reservation)
			end
		end

	get_res_name_from_args: STRING
			-- Retrieve reservartion name from request arguments
		do
			Result := ""
			if attached {STRING} current_request.argument_table["id"] as id then
				if attached {RESERVATION} global_state.db.reservation_by_id (id.to_integer_32) as res then
					Result := res.name
				end
			end
		ensure
			Result_attached: Result /= Void
		end

	get_res_date_from_args: DATE
			-- Retrieve reservartion date from request arguments
		do
			create Result.make_now
			if attached {STRING} current_request.argument_table["id"] as id then
				if attached {RESERVATION} global_state.db.reservation_by_id (id.to_integer_32) as res then
					Result := res.date
				end
			end
		ensure
			Result_attached: Result /= Void
		end

	get_res_persons_from_args: STRING
			-- Retrieve reservartion persons from request arguments
		do
			Result := ""
			if attached {STRING} current_request.argument_table ["id"] as id then
				if attached {RESERVATION} global_state.db.reservation_by_id (id.to_integer_32) as res then
					Result := res.persons.out
				end
			end
		ensure
			Result_attached: Result /= Void
		end

	get_res_description_from_args: STRING
			-- Retrieve reservartion description from request arguments
		do
			Result := ""
			if attached {STRING} current_request.argument_table ["id"] as id then
				if attached {RESERVATION} global_state.db.reservation_by_id (id.to_integer_32) as res then
					Result := res.description
				end
			end
		ensure
			Result_attached: Result /= Void
		end

	logged_in_name: STRING
			-- Retrieve the name of the person logged in
		do
			Result := ""
			if attached {USER} session.item ("auth") as user then
				Result := user.name
			end
		ensure
			Result_attached: attached Result
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
