indexing
	description: "Store a version number as major,minor,build and revision number"
	date: "$Date$"
	revision: "$Revision$"

class
	VERSION

create
	default_create,
	make_from_string
	
feature {NONE} -- Initialization

	make_from_string (vers: STRING) is
			-- Create a new version object with its string representation `vers'.
		require
			version_valid: is_version_valid (vers)
		do
			set_version (vers)
		end

feature -- Access

	major, minor, build, revision: INTEGER
			-- Representation of a version.

feature -- Settings

	set_version (vers: STRING) is
			-- Update current with `vers' string representation of a version.
		require
			version_valid: is_version_valid (vers)
		local
			l_pos, l_new_pos: INTEGER
		do
			l_pos := 1
			l_new_pos := vers.index_of ('.', l_pos)
			major := vers.substring (l_pos, l_new_pos - 1).to_integer

			l_pos := l_new_pos + 1
			l_new_pos := vers.index_of ('.', l_pos)
			minor := vers.substring (l_pos, l_new_pos - 1).to_integer

			l_pos := l_new_pos + 1
			l_new_pos := vers.index_of ('.', l_pos)
			build := vers.substring (l_pos, l_new_pos - 1).to_integer

			l_pos := l_new_pos + 1
			revision := vers.substring (l_pos, vers.count).to_integer
		end
		
feature -- Checking

	is_version_valid (vers: STRING): BOOLEAN is
			-- Is `vers' a valid version number?
			-- I.e. a sequence of four integers separated by colon.
		local
			state: INTEGER
			i, nb, nb_colons: INTEGER
		do
			if vers /= Void then
					-- State:
					-- 1 means that we should read a sequence of digits
					-- 2 means that we should read a colon or a digit
	
				from
					state := 1	
					i := 1
					Result := True
					nb := vers.count
				until
					i > nb or not Result
				loop
					inspect state
					when 1 then
						Result := vers.item (i).is_digit
						state := 2
					when 2 then
						if vers.item (i) = '.' then
							state := 1
							nb_colons := nb_colons + 1
						else
							Result := vers.item (i).is_digit
						end
					end
					i := i + 1
				end
				if Result then
						-- It is a valid version number if there was 3 colons
						-- and that we were waiting for a colon or a digit for
						-- the last input.
					Result := nb_colons = 3 and then state = 2
				end
			end
		end

invariant
	positive_composants: major >= 0 and minor >= 0 and build >= 0 and revision >= 0

end -- class VERSION
