indexing
	description: "[
		STA/MTA application entry point, required for .NET on Windows 2000.
	]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"
	
frozen class
	EC_MAIN

inherit
	SYSTEM_OBJECT

	EC_SHARED_PROJECT
		export
			{NONE} all
		end

create
	make,
	make_sta

feature {NONE} -- Initialization

	make is
			-- Launch application in default thread apartment.
		local
			l_app: EC_APPLICATION
		do
			add_arguments
			create l_app.make_and_launch
		end

	make_sta is
			-- Launch application in a STA.
		local
			l_thread: SYSTEM_THREAD
			l_thread_start: THREAD_START
		do
			create l_thread_start.make (Current, $make)
			create l_thread.make (l_thread_start)
			l_thread.set_apartment_state (feature {APARTMENT_STATE}.sta)
			l_thread.start
			l_thread.join
		end
		
feature {NONE} -- Implementation

	add_arguments is
			-- Add first argument as assembly file name and all others as reference paths
		local
			l_args: like arguments
			l_count: INTEGER
			i: INTEGER
		do
			l_args := arguments
			l_count := l_args.argument_count
			if l_count >= 1 then
				project.set_assembly (arguments.argument (1))
				from
					i := 2
				until
					i > l_count
				loop
					project.add_reference_path (l_args.argument (i))
					i := i + 1
				end
				project.set_is_dirty (False)
			end
		end
		
	arguments: ARGUMENTS is
			-- Application arguments
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end
		
end -- class EC_MAIN
