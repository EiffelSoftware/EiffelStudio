note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FILE

feature -- Element change

	put_string (s: STRING)
			-- Write `s' at end of default output.
		require
			string_not_void: s /= Void
		local
			ext_s: ANY
		do
			if s.count /= 0 then
				ext_s := s.area
				file_ps (console_def (1), $ext_s, s.count)
			end
		end

feature {NONE} -- Externals

	file_ps (file: POINTER; a_string: POINTER; length: INTEGER_32)
			-- Print `a_string' to `file'.
			-- (from FILE)
			-- (export status {NONE})
		external
			"C signature (FILE *, char *, EIF_INTEGER) use %"eif_file.h%""
		alias
			"eif_file_ps"
		end

	console_def (number: INTEGER): POINTER
			-- Convert `number' to the corresponding
			-- file descriptor.
		external
			"C use %"eif_console.h%""
		end		

end
