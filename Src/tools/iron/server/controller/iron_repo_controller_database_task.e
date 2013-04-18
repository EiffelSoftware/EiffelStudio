note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	IRON_REPO_CONTROLLER_DATABASE_TASK

inherit
	IRON_REPO_CONTROLLER_TASK
		rename
			set_arguments as make
		end

create
	make

feature -- Access

	name: STRING = "db"

feature -- Execution

	is_available (iron: IRON_REPO): BOOLEAN
		do
			Result := True
		end

	execute (iron: IRON_REPO)
		local
		do
			if attached arguments as args and then not args.is_empty then
				if args[1].is_case_insensitive_equal ("init") then
					if not iron.database.is_available then
						iron.database.initialize
					end
				elseif args[1].is_case_insensitive_equal ("dump") then
					if args.valid_index (2) then
						dump (iron.database, args[2])
					else
						io.error.put_string ("Error: 'dump' is missing argument%N")
					end
				elseif args[1].is_case_insensitive_equal ("load") then
					if args.valid_index (2) then
						load (iron.database, args[2])
					else
						io.error.put_string ("Error: 'load' is missing argument%N")
					end
				else
					io.error.put_string ("Error: '" + args[1]  + "' is not supported%N")
					display_help (iron)
				end
			else
					-- Display info
				print (iron.database.generating_type)
				display_help (iron)
			end
		end

	display_help (iron: IRON_REPO)
		do
			io.put_string ("Help for 'database' command:%N")
			io.put_string ("    init: Initialize%N")
			io.put_string ("    dump <output_folder>: dump db into folder%N")
			io.put_string ("    load <output_folder>: load db from folder%N")
		end

	dump (db: IRON_REPO_DATABASE; fn: IMMUTABLE_STRING_32)
		do
			io.error.put_string ("Error: 'dump' not yet implemented%N")
		end

	load (db: IRON_REPO_DATABASE; fn: IMMUTABLE_STRING_32)
		do
			io.error.put_string ("Error: 'load' not yet implemented%N")
		end

end
