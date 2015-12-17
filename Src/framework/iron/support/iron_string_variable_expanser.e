note
	description: "Summary description for {IRON_STRING_VARIABLE_EXPANSER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	IRON_STRING_VARIABLE_EXPANSER

feature	-- Conversion

	expanded_string_32 (s: READABLE_STRING_32; a_variable_provider: FUNCTION [READABLE_STRING_GENERAL, detachable READABLE_STRING_32]): STRING_32
			-- String `s' with variables from `a_variable_provider' expanded.
		do
			create Result.make_from_string (s)
			expand_string_32 (Result, a_variable_provider)
		end

	expand_string_32 (s: STRING_32; a_variable_provider: FUNCTION [READABLE_STRING_GENERAL, detachable READABLE_STRING_32])
			-- Expand variables from `a_variable_provider' in `s'.
		local
			i,j,k,n: INTEGER
			l_var: detachable READABLE_STRING_32
		do
			from
				i := 1
				j := i
				n := s.count
			until
				i = 0 or i > s.count
			loop
				i := s.index_of ('$', j)
				if i > 0 then
					j := i
					i := i + 1
					if s[i] = '{' then
						i := i + 1
						k := s.index_of ('}', i)
						l_var := s.substring (i, k - 1)
					elseif s[i] = '(' then
						i := i + 1
						k := s.index_of (')', i)
						l_var := s.substring (i, k - 1)
					elseif s[i].is_alpha or s[i] = '_' then -- variable can start with alphabetic or underscore
						from
							k := i + 1
						until
							k > s.count or not (s[k].is_alpha_numeric or s[k] = '_')
						loop
							k := k + 1
						end
							-- Last s[k] is not alpha numeric and not '_'
							-- or if off
						k := k - 1
						l_var := s.substring (i, k)
					else
						k := 0
						l_var := Void
					end
					if k > 0 then
						if l_var /= Void and then attached a_variable_provider.item ([l_var]) as l_value then
							s.replace_substring (l_value, j, k)
							i := j + l_value.count
						else
							i := k + 1
						end
					end
				end
				j := i
			end
		end

end
