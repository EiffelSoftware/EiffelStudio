indexing
	description: "Calls commands outside the eiffel environment.%
		%If a connection has been made then execute the command%
		%as a background process. Otherwize, do a system call"
	date: "$Date$"
	revision: "$Revision$"

class
	CASE_COMMAND_EXECUTOR

inherit
	BENCH_COMMAND_EXECUTOR


feature -- EiffelBench specific calls

	case_command_name: STRING is
		local
			eiffel4, platform: STRING
			ecase_location: FILE_NAME
			a: ANY
		do
			eiffel4 := Execution_environment.get ("EIFFEL4")
			platform := Execution_environment.get ("PLATFORM")
			create ecase_location.make_from_string (eiffel4)
			ecase_location.extend_from_array (<<"case","spec",platform,"bin">>)
			ecase_location.set_file_name ("ecase")
			create Result.make (128)
			a := ecase_location.to_c
			Result.from_c ($a)
		end

end -- class CASE_COMMAND_EXECUTOR
