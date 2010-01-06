note
	description: "Project root class"

class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			s1: SEQ_STRING
			sys_s: SYSTEM_STRING
			sr: STREAM_READER
		do
			sr := {SYSTEM_FILE}.open_text ("$CLUSTER\dotnet_excep_trace")
			sys_s := sr.read_to_end

			create s1.make (0)
			s1.append (create {STRING}.make_from_cil (sys_s))
		end

end