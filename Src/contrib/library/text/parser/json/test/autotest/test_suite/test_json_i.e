note
	description: "Summary description for {TEST_JSON_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_JSON_I

inherit
	JSON_PARSER_ACCESS
		undefine
			default_create
		end

	EXCEPTIONS
		undefine
			default_create
		end

feature -- Factory

	new_parser (a_string: READABLE_STRING_8): JSON_PARSER
		do
			create Result.make_with_string (a_string)
		end

	new_empty_parser: JSON_PARSER
		do
			create Result.make
		end

feature -- Comparison

	is_valid (j: STRING_8): BOOLEAN
		local
			jp: JSON_PARSER
		do
			create jp.make
			jp.parse_string (j)
			if jp.is_parsed and jp.is_valid then
				Result := True
			end
		end

	same_json_values (s1, s2: STRING_8): BOOLEAN
		do
			Result := 	attached json_value_from_string (s1) as j1 and then
						attached json_value_from_string (s2) as j2 and then
						j1.representation.same_string (j2.representation)
		end

	same_iterable (i1, i2: ITERABLE [detachable ANY]): BOOLEAN
		local
			c1, c2: ITERATION_CURSOR [detachable ANY]
		do
			c1 := i1.new_cursor
			c2 := i2.new_cursor
			from
				Result := True
			until
				not Result and c1.after or c2.after
			loop
				Result := c1.item ~ c2.item
				c1.forth
				c2.forth
			end
			if not (c1.after and c2.after) then
				Result := False
			end
		end

	recursively_one_includes_other (one, other: detachable ANY; a_path: detachable STRING_8): BOOLEAN
		local
			t: TYPE [detachable ANY]
			ref_one, ref_other: REFLECTED_REFERENCE_OBJECT
			i,n: INTEGER
			fn: READABLE_STRING_8
			l_path: STRING_8
		do

			if one = Void then
					-- Ignore if deserialized object has more (could happen with `found_item' for container).
				Result := True --other = Void
			elseif other = Void then
				Result := not one.generating_type.is_attached -- one includes other, not the reverse
			elseif one ~ other then
				Result := True
			else
				t := one.generating_type
				if t = other.generating_type then
					Result := True
					if attached {READABLE_STRING_GENERAL} one as s_one and attached {READABLE_STRING_GENERAL} one as s_other then
						Result := s_one.same_string (s_other)
					elseif t.is_expanded then
							-- already checked via one ~ other						
						Result := True -- Ignore for now False
					else
						create ref_one.make (one)
						create ref_other.make (other)
						n := ref_one.field_count
						if n = ref_other.field_count then
							from
								i := 1
							until
								i > n or not Result
							loop
									-- should be same field name, as same type!
								if not ref_one.is_field_transient (i) then

									fn := ref_one.field_name (i)
									if a_path = Void then
										create l_path.make_from_string (fn)
									else
										l_path := a_path + "." + fn
									end
									Result := recursively_one_includes_other (ref_one.field (i), ref_other.field (i), l_path)
									if not Result and a_path /= Void then
										a_path.append_character ('.')
										a_path.append (fn)
									end
								end
								i := i + 1
							end
						else
							Result := False -- same type, so never happens.
						end
					end
				else
					Result := False
				end
			end
		end

	recursively_same_objects (o1, o2: detachable ANY; a_path: detachable STRING_8): BOOLEAN
		local
			t: TYPE [detachable ANY]
			ref_1, ref_2: REFLECTED_REFERENCE_OBJECT
			i,n: INTEGER
			fn: READABLE_STRING_8
			l_path: STRING_8
		do

			if o1 = Void or o2 = Void then
				Result := o1 = o2
			elseif o1 ~ o2 then
				Result := True
			else
				t := o1.generating_type
				if t = o2.generating_type then
					Result := True
					if attached {READABLE_STRING_GENERAL} o1 as s1 and attached {READABLE_STRING_GENERAL} o1 as s2 then
						Result := s1.same_string (s2)
					elseif t.is_expanded then
							-- already checked via o1 ~ o2						
						check never_reached: False end
					else
						create ref_1.make (o1)
						create ref_2.make (o2)
						n := ref_1.field_count
						if n = ref_2.field_count then
							from
								i := 1
							until
								i > n or not Result
							loop
									-- should be same field name, as same type!
								fn := ref_1.field_name (i)
								if not ref_1.is_field_transient (i) then
									if a_path = Void then
										create l_path.make_from_string (fn)
									else
										l_path := a_path + "." + fn
									end
									Result := recursively_same_objects (ref_1.field (i), ref_2.field (i), l_path)
									if not Result and a_path /= Void then
										a_path.append_character ('.')
										a_path.append (fn)
									end
								end
								i := i + 1
							end
						else
							Result := False -- same type, so never happens.
						end
					end
				else
					Result := False
				end
			end
		end

feature {NONE} -- Helpers

	json_value_from_string (s: READABLE_STRING_8): detachable JSON_VALUE
		local
			jp: like new_empty_parser
		do
			jp := new_empty_parser
			jp.parse_string (s)
			Result := jp.parsed_json_value
		end

	json_value (obj: detachable ANY): detachable JSON_VALUE
		local
			conv: JSON_BASIC_SERIALIZATION
		do
			create conv.make
			Result := conv.to_json (obj)
		end

	json_object (j: detachable JSON_VALUE; a_base_class: detachable READABLE_STRING_GENERAL): detachable ANY
		local
			conv: JSON_BASIC_SERIALIZATION
		do
			create conv.make
			Result := conv.from_json (j)
		end

end
