indexing
	description: "Convert path string formats to DOS 8.3 length filename conventions."
	date: "08/29/02"
	revision: "$Revision$"

class
	PATH_CONVERTER

feature -- Access

	Max_path_length: INTEGER is 1024
			-- Maximum path length (in characters)
			--| Windows limit.

	short_path (long_path: STRING): STRING is
			-- Short path name corresponding to `long_path'.
		require
			non_void_long_path: long_path /= Void
			valid_long_path: not long_path.is_empty
		local
			p: POINTER
			a1, a2: ANY
			buf: STRING
			ret: INTEGER
		do
			create buf.make (Max_path_length)
			a1 := long_path.to_c
			a2 := buf.to_c
			p := $a2
			ret := convert_path ($a1, p, Max_path_length)
			if ret > 0 and ret <= Max_path_length then
				create Result.make_from_c (p)
			else
				Result := long_path
			end
		ensure
			non_void_short_path: Result /= Void
			valid_short_path: not Result.is_empty
		end

feature {NONE} -- Externals

	convert_path (a1, a2: POINTER; sz: INTEGER): INTEGER is
			-- Convert a long path name to a short path name.
		external
			"C | <windows.h>"
		alias
			"GetShortPathName"
		end
		
end -- class PATH_CONVERTER
