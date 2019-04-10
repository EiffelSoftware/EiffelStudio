note
	description : "Root class that runs all examples one by one."
	date        : "$Date$"
	revision    : "$Revision$"

class
	EXAMPLES

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			example_loader: detachable separate ANY
		do
			if is_included ("prodcons") then
				example_loader := create {PRODUCER_CONSUMER}.make
			end
			if is_included ("echo") then
				example_loader := create {ECHO_APPLICATION}.make
			end
			if is_included ("pool") then
				example_loader := create {IO_WORKER_POOL}.make
			end
			if is_included ("gauss") then
				example_loader := create {GAUSS_APPLICATION}.make
			end
			if is_included ("database") then
				example_loader := create {DATABASE_LOGGER_APPLICATION}.make
			end
			if is_included ("download") then
				example_loader := create {DOWNLOAD_APPLICATION}.make
			end
			if is_included ("sed") then
				example_loader := create {SED_CONTAINER_EXAMPLE}.make
			end
			if example_loader = Void then
				io.error.put_string ("[
						Usage: prog {example_name}
							- example_name: 'all' or 'prodcons', 'echo', 'pool', 'gauss', 'database', 'download', 'sed'
						note: to execute all examples, pass "all" as argument, or no argument at all.
					]")
			end
		end

	is_included (a_id: READABLE_STRING_GENERAL): BOOLEAN
			-- Is example `a_id` included ?
		do
			if argument_count > 0 and then attached argument (1) as arg then
				Result := 			arg.is_case_insensitive_equal ("all")
							or else a_id.is_case_insensitive_equal (arg)

			else
				Result := True
			end
		end

end
