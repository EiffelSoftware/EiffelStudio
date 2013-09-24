note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	IRON_REPO_CONTROLLER_USER_TASK

inherit
	IRON_REPO_CONTROLLER_TASK
		rename
			set_arguments as make
		end

create
	make

feature -- Access

	name: STRING = "user"

feature -- Execution

	is_available (iron: IRON_REPO): BOOLEAN
		do
			Result := iron.is_available
		end

	execute (iron: IRON_REPO)
		local
		do
			if attached arguments as args and then not args.is_empty then
				if args[1].is_case_insensitive_equal ("list") then
					display_list (iron)
				elseif args[1].is_case_insensitive_equal ("create") then
					if args.valid_index (4) then
						create_user (iron, args[2], args[3], args[4])
					elseif args.valid_index (3) then
						create_user (iron, args[2], args[3], Void)
					else
						io.error.put_string ("Error: 'create' is missing argument%N")
					end
				else
					io.error.put_string ("Error: '" + args[1]  + "' is not supported%N")
					display_help (iron)
				end
			else
					-- Display info
				display_help (iron)
			end
		end

	display_help (iron: IRON_REPO)
		do
			io.put_string ("Help for 'user' command:%N")
			io.put_string ("    list                            : list existing users%N")
			io.put_string ("    create username password {email}: create new user with optional email%N")
		end

	display_list (iron: IRON_REPO)
		do
			io.error.put_string ("Error: 'list' not yet implemented%N")
		end

	create_user (iron: IRON_REPO; n: IMMUTABLE_STRING_32; p: IMMUTABLE_STRING_32; e: detachable IMMUTABLE_STRING_32)
		local
			u: IRON_REPO_USER
		do
			create u.make (n)
			u.set_password (p)
			u.set_email (e)
			iron.database.update_user (u)
			iron.notify_user_updated (u, True)
		end


note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
