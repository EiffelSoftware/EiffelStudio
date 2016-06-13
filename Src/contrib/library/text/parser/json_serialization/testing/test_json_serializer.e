note
	description: "Summary description for {TEST_TO_JSON_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_JSON_SERIALIZER

inherit
	EQA_TEST_SET

feature -- Tests

	test_reflector
		local
			obj: TEAM
			conv_to: expanded JSON_REFLECTOR_SERIALIZER
			conv_from: expanded JSON_REFLECTOR_DESERIALIZER
			ctx: detachable JSON_SERIALIZER_CONTEXT
			s: STRING
		do
			obj := new_group
			conv_to.type_name_included := False

			create ctx
			ctx.set_pretty_printing

			s := conv_to.to_json_string (obj, ctx)

			ctx := Void
			conv_to.type_name_included := True
			s := conv_to.to_json_string (obj, ctx)

			if attached conv_from.from_json_string (s, Void) as o then
				assert ("deserialized ok", recursively_one_includes_other (obj, o, Void))
			end
			assert ("not empty", not s.is_empty)
		end

	test_serialization
		local
			obj: TEAM
			js: JSON_SERIALIZATION
			l_deserializer: JSON_DESERIALIZER
			s: STRING
		do
			obj := new_group

			create js
			js.register (create {TEAM_JSON_SERIALIZATION}, {TEAM})
			js.register (create {PERSON_JSON_SERIALIZATION}, {PERSON})
			js.register (create {JSON_REFLECTOR_SERIALIZATION}, Void)

			js.set_pretty_printing


			s := js.to_json_string (obj)
			assert ("not empty", not s.is_empty)

			if attached js.from_json_string (s, {TEAM}) as o then
				assert ("deserialized ok", recursively_same_objects (obj, o, Void))
			end
		end

feature -- Factory

	new_group: TEAM
		local
			p: PERSON
			d: PERSON_DETAILS
		do
			create Result.make ("test-group")
			create p.make ("John", "Smith")
			create d
			d.set_country ("France")
			d.set_city_name ("Paris")
			d.set_zip (75000)
			p.set_details (d)

			Result.put (p)
			Result.put (create {PERSON}.make ("Paul", "Doe"))
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
				Result := other = Void
			elseif other = Void then
				Result := True -- one includes other, not the reverse
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
						check never_reached: False end
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

end
