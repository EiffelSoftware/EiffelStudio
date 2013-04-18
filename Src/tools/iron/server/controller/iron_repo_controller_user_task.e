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
					if args.valid_index (3) then
						create_user (iron, args[2], args[3])
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
			io.put_string ("    list: existing users%N")
			io.put_string ("    create username password%N")
		end

	display_list (iron: IRON_REPO)
		do
			io.error.put_string ("Error: 'list' not yet implemented%N")
		end

	create_user (iron: IRON_REPO; n: IMMUTABLE_STRING_32; p: IMMUTABLE_STRING_32)
		local
			u: IRON_REPO_USER
		do
			create u.make (n)
			u.set_password (p)
			iron.database.update_user (u)
		end


end
