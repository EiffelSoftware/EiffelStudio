indexing
	description: "Convert path string formats to DOS 8.3 length filename conventions."
	date: "08/29/02"
	revision: "$Revision$"

class
	PATH_CONVERTER

feature -- Access

	eiffel_dir: STRING			
			-- EIFFEL installation environment variable

feature -- Query

	short_path: STRING is
			--Short path name corresponding to eiffel_dir.
			require
				eiffel_dir_initialized: eiffel_dir /= Void
			local
				p: POINTER
				a1, a2: ANY
				buf, l_short_path: STRING
				ret: INTEGER
			once
				create buf.make (1024)
				a1 := eiffel_dir.to_c
				a2 := buf.to_c
				p := $a2
				ret := convert_path ($a1, p, 1024)
				if ret > 0 and ret <= 1024 then
					create l_short_path.make_from_c (p)
				else
					l_short_path := eiffel_dir
				end
				Result := l_short_path
			end

feature {NONE} -- Implementation

	env: EXECUTION_ENVIRONMENT is
			-- Environment variables.
		once
			create Result
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
