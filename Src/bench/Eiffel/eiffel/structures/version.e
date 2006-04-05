indexing
	description: "Store a version number as major,minor,build and revision number"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			if l_new_pos > 0 then
				build := vers.substring (l_pos, l_new_pos - 1).to_integer
	
				l_pos := l_new_pos + 1
				revision := vers.substring (l_pos, vers.count).to_integer
			else
				build := vers.substring (l_pos, vers.count).to_integer
				revision := 0
			end
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
						-- It is a valid version number if there was 2 or 3 colons
						-- and that we were waiting for a colon or a digit for
						-- the last input.
					Result := (nb_colons = 2 or nb_colons = 3) and then state = 2
				end
			end
		end

invariant
	positive_composants: major >= 0 and minor >= 0 and build >= 0 and revision >= 0

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class VERSION
