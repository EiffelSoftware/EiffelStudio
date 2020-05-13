note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	IRON_NODE_CONTROLLER_USER_TASK

inherit
	IRON_NODE_CONTROLLER_TASK
		rename
			set_arguments as make_with_arguments
		end

create
	make_with_arguments

feature -- Access

	name: STRING = "user"

feature -- Execution

	is_available (iron: IRON_NODE): BOOLEAN
		do
			Result := iron.is_available
		end

	execute (iron: IRON_NODE)
		local
		do
			if attached arguments as args and then args.valid_index (1) then
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
				elseif args[1].is_case_insensitive_equal ("update") then
					if args.valid_index (3) then
						update_user (iron, args[2], args.subarray (3, args.upper))
					end
				else
					io.error.put_string_32 ({STRING_32} "Error: '" + args[1]  + "' is not supported%N")
					display_help (iron)
				end
			else
					-- Display info
				display_help (iron)
			end
		end

	display_help (iron: IRON_NODE)
		do
			io.put_string ("Help for 'user' command:%N")
			io.put_string ("    list                            : list existing users%N")
			io.put_string ("    create username password {email}: create new user with optional email%N")
			io.put_string ("    update username %N")
			io.put_string ("        --add-role {role_name} --remove-role {role_name}: add or remove role for user%N")
			io.put_string ("        --password %"new-password%" --email %"new-email%": change password, or email address%N")
		end

	display_list (iron: IRON_NODE)
		do
			io.error.put_string ("Error: 'list' not yet implemented%N")
		end

	create_user (iron: IRON_NODE; n: IMMUTABLE_STRING_32; p: IMMUTABLE_STRING_32; e: detachable IMMUTABLE_STRING_32)
		require
			n_is_not_empty: not n.is_empty
		local
			u: IRON_NODE_USER
		do
			create u.make (n)
			u.set_password (p)
			u.set_email (e)
			iron.database.update_user (u)
			iron.on_user_updated (u, True)
		end

	update_user (iron: IRON_NODE; a_username: IMMUTABLE_STRING_32; args: ARRAY [IMMUTABLE_STRING_32])
		require
			valid_username: not a_username.is_whitespace
		local
			i: INTEGER
			r: IRON_NODE_USER_ROLE
		do
			if attached {IRON_NODE_USER} iron.database.user (a_username) as u then
				from
					i := args.lower
				until
					i > args.upper
				loop
					if args[i].same_string_general ("--add-role") then
						i := i + 1
						if args.valid_index (i) then
							create r.make (args[i].as_lower)
							u.add_role (r)
						end
					elseif args[i].same_string_general ("--remove-role") then
						i := i + 1
						if args.valid_index (i) then
							create r.make (args[i].as_lower)
							u.remove_role (r)
						end
					elseif args[i].same_string_general ("--password") then
						i := i + 1
						if args.valid_index (i) then
							u.set_password (args[i])
						end
					elseif args[i].same_string_general ("--email") then
						i := i + 1
						if args.valid_index (i) then
							u.set_email (args[i])
						end
					end
					i := i + 1
				end
				iron.database.update_user (u)
				iron.on_user_updated (u, True)
				localized_print ("User %"")
				localized_print (u.name)
				localized_print ("%" updated.")
			else
				localized_print_error ("Error: user %"")
				localized_print_error (a_username)
				localized_print_error ("%" not found!")
			end
		end


note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
