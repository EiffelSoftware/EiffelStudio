indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class ENV_INTERP

inherit

	SHARED_EXEC_ENVIRONMENT

feature -- Access

	interpreted_string (s: STRING): STRING is
			-- Interpretation of string `s' where the environment variables
			-- are interpreted
		require
			good_argument: s /= Void
		do
			Result := processed_string (s, True)
		ensure
			good_result: Result /= Void
		end

	translated_string (s: STRING): STRING is
			-- Interpretation of string `s' where the environment variables
			-- are replaced by "$(VARIABLE)"
			--| Useful when writing makefiles.
		require
			good_argument: s /= Void
		do
			Result := processed_string (s, False)
		ensure
			good_result: Result /= Void
		end

feature {NONE} -- Implementation

	processed_string (s: STRING; interpreted: BOOLEAN): STRING is
			-- Interpretation of string `s' where the environment variables
			-- are either replaced by their values (`interpreted' = True)
			-- or replaced by "$(VARIABLE)" in order to be written in
			-- makefiles
		require
			good_argument: s /= Void
		local
			current_character, last_character: CHARACTER;
			s1,s2: STRING;
			i, j: INTEGER;
			stop : BOOLEAN;
		do
			from
				Result := s;
				i := 1;
			until
				i > Result.count
			loop
				current_character := Result.item (i);
				if 	current_character = '$'
					and then
					last_character /= '%%'
				then
						-- Found beginning of a environment variable
						-- It is either ${VAR} or $VAR
					if i > 1 then
						s1 := Result.substring (1, i - 1);
					else
						create s1.make (0);
					end;
					i := i + 1;
					current_character := Result.item (i);
					if current_character = '{' then
							-- Looking for a right brace
						from
							i := i + 1;
							j := i;
						until
							j > Result.count or else Result.item (j) = '}'
						loop
							j := j + 1;
						end;
					else
							-- Looking for a non-alphanumeric character
						from
							j := i;
							stop := False
						until
							j > Result.count or else stop
						loop
							current_character := Result.item (j);
							stop := 	(not (current_character.is_alpha or else
												current_character.is_digit))
										and
										(current_character /= '_');
							if not stop then
								j := j + 1;
							end;
						end;
							-- We've been one char too far
						j := j - 1;
					end;
					if j > Result.count then
						j := Result.count;
					end;
					if Result.item (j) = '}' then
						if j - 1 >= i then
							if interpreted then
								s2 := Execution_environment.get (Result.substring (i, j - 1));
							else
								create s2.make (15);
								s2.append ("$(");
								s2.append (Result.substring (i, j - 1));
								s2.extend (')')
							end
						else
							create s2.make (0);
						end;
					else
						if j >= i then
							if interpreted then
								s2 := Execution_environment.get (Result.substring (i, j));
							else
								create s2.make (15);
								s2.append ("$(");
								s2.append (Result.substring (i, j));
								s2.extend (')')
							end
						else
							create s2.make (0);
						end;
					end;
					if s2 = Void then
						create s2.make (0);
					end;
					s1.append (s2);
					i := s1.count + 1;
					if j < Result.count then
						s1.append
							(Result.substring (j + 1, Result.count));
					end;
					Result := s1;
				end;
				i := i + 1;
			end;
		ensure
			good_result: Result /= Void;
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end
