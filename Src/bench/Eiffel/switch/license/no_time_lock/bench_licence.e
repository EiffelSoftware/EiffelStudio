indexing

	description: "License manager for EiffelBench under Windows."
	date: "$Date$"
	revision: "$Revision $"

class BENCH_LICENSE

inherit
	LICENSE

	TIME_LOCK
		rename
			make as tlock_make
		end

	ENV_INTERP

creation
	make

feature -- Initialization

	make is
			-- Initialization.
		do
		end

feature -- Validity

	alive: BOOLEAN is True
			-- The license is always alive

feature -- Registration

	get_license is 
			-- Get the license for EiffelBench.
		local
			init_dir: DIRECTORY_NAME
			d_path: DIRECTORY_NAME
		do
			!! init_dir.make_from_string (interpreted_string ("$EIFFEL4\bench\spec\$PLATFORM\bin"))
			!! d_path.make_from_string (init_dir)
			tlock_make (init_dir) 
		end

	release is 
			-- Release the license.
		do 
			licensed := False
		end

feature {NONE} -- Not applicable

	daemon_alive: BOOLEAN is True
	expiration_date: INTEGER is 0
	is_unlimited: BOOLEAN is True
	license_count: INTEGER is 0
	license_host: STRING is "WINDOWS"
	time_left: INTEGER is 0
	usage_info: STRING is ""
	valid_expiration_date: BOOLEAN is True

end -- class BENCH_LICENSE
