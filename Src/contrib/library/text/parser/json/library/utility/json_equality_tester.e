note
	description: "[
			Test equality between two valid JSON contents, values.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_EQUALITY_TESTER

feature -- Status

	is_valid_json (j: STRING_8): BOOLEAN
			-- Is `j` a valid JSON content?
		local
			jp: JSON_PARSER
		do
			create jp.make
			jp.parse_string (j)
			if jp.is_parsed and jp.is_valid then
				Result := True
			end
		ensure
			instance_free: class
		end

	same_json (j1, j2: STRING_8): BOOLEAN
			-- Are `j1` and `j2` the same JSON content?
		require
			is_valid_json (j1) and is_valid_json (j2)
		local
			jp: JSON_PARSER
			jv1, jv2: detachable JSON_VALUE
		do
			create jp.make

			jp.parse_string (j1)
			if jp.is_parsed and jp.is_valid then
				jv1 := jp.parsed_json_value
			end
			jp.parse_string (j2)
			if jp.is_parsed and jp.is_valid then
				jv2 := jp.parsed_json_value
			end
			Result := same_json_values (jv1, jv2)
		ensure
			instance_free: class
		end

	same_json_values (jv1, jv2: detachable JSON_VALUE): BOOLEAN
			-- Are `jv1` and `jv2` the same values?	
		local
			i,n: INTEGER
		do
			if jv1 = jv2 then
				Result := True
			elseif jv1 = Void then
				Result := jv2 = Void
			elseif jv2 = Void then
				Result := False
			else
				if jv1.same_type (jv2) then
					Result := True
					if
						attached {JSON_STRING} jv1 as js1 and
						attached {JSON_STRING} jv2 as js2
					then
						Result := js1.item.is_case_insensitive_equal (js2.item)
					elseif
						attached {JSON_NUMBER} jv1 as jn1 and
						attached {JSON_NUMBER} jv2 as jn2
					then
						Result := jn1.item.is_case_insensitive_equal (jn2.item)
					elseif
						attached {JSON_BOOLEAN} jv1 as jb1 and
						attached {JSON_BOOLEAN} jv2 as jb2
					then
						Result := jb1.item = jb2.item
					elseif
						attached {JSON_OBJECT} jv1 as jo1 and
						attached {JSON_OBJECT} jv2 as jo2
					then
						if jo1.count = jo2.count then
								-- note: the order does not matter.
							across
								jo1 as ic
							until
								Result = False
							loop
								if attached jo2.item (ic.key) as v2 then
									Result := same_json_values (ic.item, v2)
								else
									Result := False
								end
							end
						else
							Result := False
						end
					elseif
						attached {JSON_ARRAY} jv1 as ja1 and
						attached {JSON_ARRAY} jv2 as ja2
					then
						n := ja1.count
						if n = ja2.count then
							from
								i := 1
							until
								Result = False or i > n
							loop
								Result := same_json_values (ja1 [i], ja2 [i])
								i := i + 1
							end
						else
							Result := False
						end
					else
						Result := attached {JSON_NULL} jv1 and attached {JSON_NULL} jv2
					end
				end
			end
		ensure
			instance_free: class
		end

note
	copyright: "2010-2022, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
