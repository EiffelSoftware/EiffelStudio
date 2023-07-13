note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FILE

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			internal_stream := {SYSTEM_CONSOLE}.open_standard_output
		end

	internal_stream: SYSTEM_STREAM

feature -- Element change

	put_string (s: STRING)
			-- Write `s' at end of default output.
		require
			string_not_void: s /= Void
		do
			-- FAKE output
			if attached internal_stream as l_stream then
				l_stream.write_byte (109) -- m
				l_stream.write_byte (105) -- i
				l_stream.write_byte (110) -- n
				l_stream.write_byte (105) -- i
				l_stream.write_byte ( 95) -- _
				l_stream.write_byte ( 98) -- b
				l_stream.write_byte ( 97) -- a
				l_stream.write_byte (115) -- s
				l_stream.write_byte (101) -- e
				l_stream.write_byte ( 10) -- %N
			end
		end			

end
