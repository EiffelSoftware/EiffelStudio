note
	description: "[
		JSON Path evaluation

		See: - https://tools.ietf.org/id/draft-goessner-dispatch-jsonpath-00.html
			 - https://goessner.net/articles/JsonPath/
			 - for future: eventually https://github.com/JSONPath-Plus/JSONPath

			$	the root object/element
			@	the current object/element
				note: only first item by name  @.name

			. or []	child operator
			..	nested descendants. JSONPath borrows this syntax from E4X.
			*	wildcard. All objects/elements regardless their names.

			[]	subscript operator. XPath uses it to iterate over element collections and for predicates. In Javascript and JSON it is the native array operator.
			[,]	Union operator in XPath results in a combination of node sets. JSONPath allows alternate names or array indices as a set.
			[start:end:step]	array slice operator borrowed from ES4.

			?()	applies a filter (script) expression.
				support for has item by name: ?(@.name)
				and basic >, >=, <, <=, =, /=  operators on string and number.: ?(@.value<10)

			()	script expression, using the underlying script engine.
				NOT YET SUPPORTED:
	]"
	author: "Jocelyn FIAT <jfiat@eiffel.com>"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=JSON Path", "protocol=URI", "src=https://goessner.net/articles/JsonPath/"

expanded class
	JSON_PATH

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			zero_based_index := True
		end

feature -- Settings

	zero_based_index: BOOLEAN
			-- Index in JSON path start at 0 ?
			-- note: If False: 1-based, as in Eiffel
			-- WARNING: this is not the standard JSON PATH spec!

feature -- Settings change

	set_zero_based_index (b: BOOLEAN)
		do
			zero_based_index := b
		end

feature -- Execution

	matches (a_json_value: JSON_VALUE; a_json_path_expression: READABLE_STRING_GENERAL): JSON_ARRAY
		do
			Result := imp_matches (a_json_value, False, a_json_path_expression)
		end

feature {NONE} -- Implementation

	imp_matches (a_json_value: JSON_VALUE; a_is_collection: BOOLEAN; a_json_path_expression: READABLE_STRING_GENERAL): JSON_ARRAY
		local
			j_array_item: JSON_VALUE
			arr: JSON_ARRAY
			p, l_tail, k: STRING_32
			keys: like strings_as_keys
			jk: JSON_STRING
			i,j: INTEGER
			err: BOOLEAN
		do
				-- Example:  $[0].routine.body[3][0]
			if a_json_path_expression.is_whitespace then
				if attached {JSON_ARRAY} a_json_value as jarr and a_is_collection then
					Result := jarr
				else
					create Result.make (1)
					Result.extend (a_json_value)
				end
			else
				p := a_json_path_expression
				p.adjust
				check p.count > 0 end
				if p[1] = '$' then
					-- Always from starting point
					p.remove_head (1)
				end
				if p.is_empty then
					create Result.make (1)
					Result.extend (a_json_value)
				else
					create Result.make_empty
					inspect p[1]
					when '.' then
						if p.count > 2 and then p[2] = '.' then
							i := next_delimiter (p, 3)
							if i > 0 then
									-- "$..name" + ...
								k := p.substring (3, i - 1)
								l_tail := p.substring (i, p.count)
								if l_tail.is_whitespace then
									Result := nested_descendants (a_json_value, k)
								else
									Result := imp_matches (nested_descendants (a_json_value, k), True, l_tail)
								end
							elseif p.count = 2 then
									-- "$.."
								create arr.make (1)
								arr.extend (a_json_value)
								Result := arr
							else
								err := True
							end
						else
								-- .name
							i := next_delimiter (p, 2)
							if i > 0 then
								k := p.substring (2, i - 1)
								l_tail := p.substring (i, p.count)
								if attached {JSON_OBJECT} a_json_value as j_object then
									if k.same_string_general ("*") then
										create arr.make (j_object.count)
										across
											j_object as ic
										loop
											arr.extend (ic.item)
										end
										Result := imp_matches (arr, True, l_tail)
									elseif attached j_object.item (k) as v then
										Result := imp_matches (v, False, l_tail)
									end
								elseif attached {JSON_ARRAY} a_json_value as j_array then
									if k.same_string_general ("*") then
										Result := imp_matches (j_array, True, l_tail)
									else
										create arr.make (j_array.count)
										jk := k
										across
											j_array as ic
										loop
											if
												attached {JSON_OBJECT} ic.item as jo and then
												attached jo.item (k) as jv
											then
												arr.extend (jv)
											end
										end
										Result := imp_matches (arr, True, l_tail)
									end
								else
									err := True
								end
							else
								err := True
							end
						end
					when '[' then
						i := next_closing_bracket (p, 2)
						k := p.substring (2, i - 1)
						k.adjust
						l_tail := p.substring (i + 1, p.count)

						if i <= 0 then
							err := True
						end
						if k.is_empty then
							err := True
						elseif attached {JSON_OBJECT} a_json_value as j_object then
								-- [name1,name2] ...
							create arr.make_empty
							across
								strings_as_keys (k) as ic
							loop
								if attached j_object.item (ic.item) as jv then
									arr.extend (jv)
								end
							end
							Result := imp_matches (arr, True, l_tail)
						elseif attached {JSON_ARRAY} a_json_value as j_array then
								-- Array item
							if
								a_is_collection and then
								attached {JSON_ARRAY} a_json_value as j_arr and then
								j_arr.count = 1
							then
								j_array_item := j_arr.i_th (1)
							else
								j_array_item := a_json_value
							end
							if attached {JSON_ARRAY} j_array_item as j_arr then
								if k.count >= 3 and then k[1] = '?' and then k[2] = '(' and k [k.count] = ')' then
									Result := imp_matches (range_conditional_expression (j_arr, k.substring (3, k.count - 1)), True, l_tail)
								elseif k.count >= 2 and then k[1] = '(' and k [k.count] = ')' then
									if attached range_expression (j_arr, k.substring (2, k.count - 1)) as jv then
										Result := imp_matches (jv, False, l_tail)
									end
								elseif k[1].is_alpha then
									keys := strings_as_keys (k)
									create arr.make_empty
									across
										j_arr as ic
									loop
										if attached {JSON_OBJECT} ic.item as j_object then
											across
												keys as k_ic
											loop
												if attached j_object.item (k_ic.item) as jv then
													arr.extend (jv)
												end
											end
										end
									end
									Result := imp_matches (arr, True, l_tail)
								elseif attached range_lower_upper (j_arr, k) as l_range then
									create arr.make ((l_range.end_index - l_range.start_index + 1).max (0) // l_range.step + 1)
									from
										j := l_range.start_index
									until
										j > l_range.end_index
									loop
										if j_arr.valid_index (j) then
											arr.extend (j_arr.i_th (j))
										end
										j := j + l_range.step
									end
									Result := imp_matches (arr, True, l_tail)
								elseif attached range_indexes (j_arr, k) as l_range_indexes then
									create arr.make (l_range_indexes.count)
									across
										l_range_indexes as ic
									loop
										j := ic.item
										if j_arr.valid_index (j) then
											arr.extend (j_arr.i_th (j))
										end
									end
									Result := imp_matches (arr, True, l_tail)
								elseif k.same_string_general ("*") then
									Result := imp_matches (j_arr, True, l_tail)
								elseif k.is_integer then
									j := k.to_integer
									if zero_based_index then
										j := j + 1
									end
									if
										j_arr.valid_index (j) and then
										attached j_arr.i_th (j) as v
									then
											-- i_th
										Result := imp_matches (v, False, l_tail)
									end
								else
									-- ...
								end
							end
						else
							err := True
						end
					else
						err := True
					end
				end
			end
		end

feature {NONE} -- Implementation

	nested_descendants (a_json_value: JSON_VALUE; a_name: READABLE_STRING_GENERAL): JSON_ARRAY
		local
			js: JSON_STRING
		do
			create Result.make_empty
			js := a_name
			add_nested_descendants_to (a_json_value, js, Result)
		end

	add_nested_descendants_to (a_json_value: JSON_VALUE; a_name: JSON_STRING; a_results: JSON_ARRAY)
		do
			if attached {JSON_OBJECT} a_json_value as j_object then
				if attached j_object.item (a_name) as j then
					a_results.extend (j)
				end
				across
					j_object as ic
				loop
					add_nested_descendants_to (ic.item, a_name, a_results)
				end
			elseif attached {JSON_ARRAY} a_json_value as j_array then
				across
					j_array as ic
				loop
					add_nested_descendants_to (ic.item, a_name, a_results)
				end
			end
		end

	next_delimiter (p: READABLE_STRING_GENERAL; a_start_index: INTEGER): INTEGER
		local
			i: INTEGER
		do
			from
				i := a_start_index
			until
				i > p.count or Result > 0
			loop
				inspect p [i]
				when 'a' .. 'z' then
				when 'A' .. 'Z' then
				when '0' .. '9' then
				when '_' then
				else
					Result := i
				end
				i := i + 1
			end
			if Result <= 0 then
				Result := p.count + 1
			end
		end

	next_closing_bracket (p: READABLE_STRING_GENERAL; a_start_index: INTEGER): INTEGER
		local
			i:  INTEGER
			in_parenthesis: BOOLEAN
		do
			from
				i := a_start_index
			until
				i > p.count or Result > 0
			loop
				if in_parenthesis then
					in_parenthesis := p [i] /= ')'
				elseif p [i] = '(' then
					in_parenthesis := True
				elseif p [i] = ']' then
					Result := i
				end
				i := i + 1
			end
		end

	range_expression (a_json_array: JSON_ARRAY; exp: READABLE_STRING_GENERAL): detachable JSON_VALUE
		local
			i: INTEGER
			k, l_tail: STRING_32
			idx: INTEGER
		do
			if
				exp.count > 2 and then
				exp [1] = '@' and then
				exp [2] = '.'
			then
				i := next_delimiter (exp, 3)
				if i > 0 then
					k := exp.substring (3, i - 1)
					l_tail := exp.substring (i, exp.count)
					if k.same_string ("length") then
						idx := a_json_array.count + l_tail.to_integer
						if zero_based_index then
							idx := idx + 1
						end
						if a_json_array.valid_index (idx) then
							Result := a_json_array.i_th (idx)
						end
					end
				end
			end
		end

	range_conditional_expression (a_json_array: JSON_ARRAY; exp: READABLE_STRING_GENERAL): JSON_ARRAY
		local
			i: INTEGER
			k: STRING_32
			jk: JSON_STRING
			cond: like expression_condition
		do
			if
				exp.count > 2 and then
				exp [1] = '@' and then
				exp [2] = '.'
			then
				i := next_delimiter (exp, 3)
				if i > 0 then
					k := exp.substring (3, i - 1)
					cond := expression_condition (exp.substring (i, exp.count))
					create Result.make (a_json_array.count)
					jk := k
					across
						a_json_array as ic
					loop
						if
							attached {JSON_OBJECT} ic.item as jo and then
							attached jo.item (jk) as jv
						then
							if cond = Void or else cond (jv) then
								Result.extend (jo)
							end
						end
					end
				end
			end
			if Result = Void then
				create Result.make_empty
			end
		end

	expression_condition (a_condition: READABLE_STRING_GENERAL): detachable PREDICATE [JSON_VALUE]
		local
			cond: STRING_32
			l_arg: STRING_32
		do
			cond := a_condition
			cond.adjust
			if cond.is_whitespace then
				-- No condition
			elseif cond.starts_with ("<=") then
				l_arg := cond.substring (3, cond.count); l_arg.adjust
				Result := agent json_value_less_than_or_equal (?, l_arg)
			elseif cond.starts_with ("<") then
				l_arg := cond.substring (2, cond.count); l_arg.adjust
				Result := agent json_value_less_than (?, l_arg)
			elseif cond.starts_with (">=") then
				l_arg := cond.substring (3, cond.count); l_arg.adjust
				Result := agent json_value_greater_than_or_equal (?, l_arg)
			elseif cond.starts_with (">") then
				l_arg := cond.substring (2, cond.count); l_arg.adjust
				Result := agent json_value_greater_than (?, l_arg)
			elseif cond.starts_with ("=") then
				l_arg := cond.substring (2, cond.count); l_arg.adjust
				Result := agent json_value_equal (?, l_arg)
			elseif cond.starts_with ("===") then -- JS syntax
				l_arg := cond.substring (4, cond.count); l_arg.adjust
				Result := agent json_value_equal (?, l_arg)
			elseif cond.starts_with ("/=") then
				l_arg := cond.substring (3, cond.count); l_arg.adjust
				Result := agent json_value_not_equal (?, l_arg)
			elseif cond.starts_with ("!==") then
				l_arg := cond.substring (4, cond.count); l_arg.adjust
				Result := agent json_value_not_equal (?, l_arg)
			end
		end

	range_lower_upper (a_json_array: JSON_ARRAY; s: READABLE_STRING_GENERAL): detachable TUPLE [start_index, end_index, step: INTEGER]
			-- [lower:upper:step] with Eiffel indexes (starting at 1).
		local
			i,j: INTEGER
		do
			i := next_range_delimiter (s, 1, ':')
			if i > 0 then
				Result := [1, a_json_array.count, 1]
				if i = 1 then
					Result.start_index := 1
				else
					Result.start_index := range_value (a_json_array, s.substring (1, i - 1))
				end
				if i = s.count then
					Result.end_index := a_json_array.count
				else
					j := next_range_delimiter (s, i + 1, ':')
					if j > 0 then
							-- [lower:upper:step]
						if j = i + 1 then
							Result.end_index := a_json_array.count
						else
							Result.end_index := range_value (a_json_array, s.substring (i + 1, j - 1))
						end
						if j < s.count then
							Result.step := s.substring (j + 1, s.count).to_integer
						end
					else
						Result.end_index := range_value (a_json_array, s.substring (i + 1, s.count))
					end
				end
			end
		end

	range_indexes (a_json_array: JSON_ARRAY; s: READABLE_STRING_GENERAL): detachable LIST [INTEGER]
			-- [i,j,...,n] with Eiffel indexes (starting at 1).
		local
			i,j,n: INTEGER
		do
			n := s.occurrences (',')
			if n > 0 then
				create {ARRAYED_LIST [INTEGER]} Result.make (n + 1)
				from
					i := 1
					j := i
				until
					j <= 0
				loop
					j := next_range_delimiter (s, i, ',')
					if j > i then
						Result.force (range_value (a_json_array, s.substring (i, j - 1)))
					elseif i <= s.count then
						Result.force (range_value (a_json_array, s.substring (i, s.count)))
					end
					i := j + 1
				end
			end
		end

	range_value (a_json_array: JSON_ARRAY; s: READABLE_STRING_GENERAL): INTEGER
		require
			not s.is_whitespace
		do
			if s.is_integer then
				Result := s.to_integer
				if zero_based_index then
					Result := Result + 1
				end
			else
				-- TODO: add support for (@...)
			end
			if Result < 0 then
				Result := a_json_array.count + Result - 1
			end
		end

	next_range_delimiter (s: READABLE_STRING_GENERAL; a_start_index: INTEGER; a_delimiter: CHARACTER): INTEGER
		local
			in_parenthesis: BOOLEAN
		do
			from
				Result := a_start_index
			until
				Result > s.count or else s [Result] = a_delimiter
			loop
				if in_parenthesis then
					in_parenthesis := s [Result] /= ')'
				elseif s [Result] = '(' then
					in_parenthesis := True
				end
				Result := Result + 1
			end
			if Result > s.count then
				Result := s.count
			end
			if s [Result] /= a_delimiter then
				Result := 0
			end
		end

	strings_as_keys (strs: READABLE_STRING_GENERAL): ARRAYED_LIST [JSON_STRING]
		local
			s: STRING_32
		do
			create Result.make (strs.occurrences (',') + 1)
			across
				strs.split (',') as ic
			loop
				s := ic.item
				s.adjust
				Result.force (create {JSON_STRING}.make_from_string_general (s))
			end
		end

feature {NONE} -- Comparision

	json_value_less_than_or_equal (v1: JSON_VALUE; v2: READABLE_STRING_GENERAL): BOOLEAN
		do
			if attached {JSON_NUMBER} v1 as n1 and v2.is_integer then
				Result := n1.integer_64_item <= v2.to_integer_64
			elseif attached {JSON_STRING} v1 as s1 then
				Result := s1.unescaped_string_32 <= v2
			else
				-- False
			end
		end

	json_value_less_than (v1: JSON_VALUE; v2: READABLE_STRING_GENERAL): BOOLEAN
		do
			if attached {JSON_NUMBER} v1 as n1 and v2.is_integer then
				Result := n1.integer_64_item < v2.to_integer_64
			elseif attached {JSON_STRING} v1 as s1 then
				Result := s1.unescaped_string_32 < v2
			else
				-- False
			end
		end

	json_value_greater_than_or_equal (v1: JSON_VALUE; v2: READABLE_STRING_GENERAL): BOOLEAN
		do
			if attached {JSON_NUMBER} v1 as n1 and v2.is_integer then
				Result := n1.integer_64_item >= v2.to_integer_64
			elseif attached {JSON_STRING} v1 as s1 then
				Result := s1.unescaped_string_32 >= v2
			else
				-- False
			end
		end

	json_value_greater_than (v1: JSON_VALUE; v2: READABLE_STRING_GENERAL): BOOLEAN
		do
			if attached {JSON_NUMBER} v1 as n1 and v2.is_integer then
				Result := n1.integer_64_item > v2.to_integer_64
			elseif attached {JSON_STRING} v1 as s1 then
				Result := s1.unescaped_string_32 > v2
			else
				-- False
			end
		end

	json_value_equal (v1: JSON_VALUE; v2: READABLE_STRING_GENERAL): BOOLEAN
		do
			if attached {JSON_NUMBER} v1 as n1 and v2.is_integer then
				Result := n1.integer_64_item = v2.to_integer_64
			elseif attached {JSON_STRING} v1 as s1 then
				Result := s1.same_string (v2)
			else
				-- False
			end
		end

	json_value_not_equal (v1: JSON_VALUE; v2: READABLE_STRING_GENERAL): BOOLEAN
		do
			if attached {JSON_NUMBER} v1 as n1 and v2.is_integer then
				Result := n1.integer_64_item /= v2.to_integer_64
			elseif attached {JSON_STRING} v1 as s1 then
				Result := not s1.same_string (v2)
			else
				-- False
			end
		end

note
	copyright: "2010-2022, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	maintainer: "Jocelyn Fiat, Eiffel Software"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
