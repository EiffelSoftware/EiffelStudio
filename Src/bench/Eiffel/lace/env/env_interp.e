class ENV_INTERP

feature

	interpret (s: STRING): STRING is
			-- Interpretation of string `s' where the environment varaibles
			-- are interpreted
		require
			good_argument: s /= Void;
		local
			current_character, last_character: CHARACTER;
			s1,s2: STRING;
			i, j: INTEGER;
			stop : BOOLEAN;
			ptr: ANY;
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
						!!s1.make (0);
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
						until
							j > Result.count or else stop
						loop
							current_character := Result.item (j);
							stop := 	(not c_isalnum (current_character))
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
							s2 := Result.substring (i, j - 1);
							ptr := s2.to_c;
							s2 := c_getenv ($ptr);
						else
							!!s2.make (0);
						end;
					else
						if j >= i then
							s2 := Result.substring (i, j);
							ptr := s2.to_c;
							s2 := c_getenv ($ptr);
						else
							!!s2.make (0);
						end;
					end;
					if s2 = Void then
						!!s2.make (0);
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

feature {NONE} -- Externals

	c_getenv (s: ANY): STRING is
			-- get enviroment variable
		external
			"C"
		end;

	c_isalnum (c: CHARACTER): BOOLEAN is
		external
			"C"
		end;

end
