note
	description: "Summary description for {TEST_JSON_SERIALIZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_JSON_SERIALIZER

inherit
	EQA_TEST_SET

feature -- Tests

	test_reflector_without_type_name
		local
			obj: TEAM
			conv_to: JSON_REFLECTOR_SERIALIZER
			conv_from: JSON_REFLECTOR_DESERIALIZER
			ctx: detachable JSON_SERIALIZER_CONTEXT
			d_ctx: JSON_DESERIALIZER_CONTEXT
			s: STRING
		do
			obj := new_group
			create conv_to
			create ctx
			ctx.set_pretty_printing
			ctx.set_default_serializer (conv_to)
			ctx.is_type_name_included := False

			s := conv_to.to_json_string (obj, ctx)

			create d_ctx
			d_ctx.set_default_deserializer (conv_from)
			create conv_from
			if attached conv_from.from_json_string (s, d_ctx, {TEAM}) as o then
				assert ("deserialized ok", recursively_one_includes_other (obj, o, Void))
			else
				assert ("deserialized reported error and returned Void", d_ctx.has_error)
			end
		end

	test_reflector_with_type_name
		local
			obj: TEAM
			conv_to: JSON_REFLECTOR_SERIALIZER
			conv_from: JSON_REFLECTOR_DESERIALIZER
			ctx: detachable JSON_SERIALIZER_CONTEXT
			d_ctx: JSON_DESERIALIZER_CONTEXT
			s: STRING
		do
			obj := new_group
			assert ("test ok", recursively_one_includes_other (obj, obj, Void))

			create conv_to
			create ctx
			ctx.set_pretty_printing
			ctx.set_default_serializer (conv_to)
			ctx.is_type_name_included := True

			s := conv_to.to_json_string (obj, ctx)

			create conv_from
			create d_ctx
			d_ctx.set_default_deserializer (conv_from)
			if attached conv_from.from_json_string (s, d_ctx, {TEAM}) as o then
				assert ("deserialized ok", recursively_one_includes_other (obj, o, Void))
			else
				assert ("deserialized reported error and returned Void", d_ctx.has_error)
			end
		end

	test_reflector_auto_with_callback
		local
			obj: TEAM
			conv_to: JSON_REFLECTOR_SERIALIZER
			conv_from: JSON_REFLECTOR_DESERIALIZER
			ctx: detachable JSON_SERIALIZER_CONTEXT
			ctx_deser: detachable JSON_DESERIALIZER_CONTEXT
			s: STRING
		do
			obj := new_full_team

				-- Auto serialization, handling table iterable as JSON Object, and iterable as ARRAY. Without typename.
			create conv_to
			create ctx
			ctx.set_pretty_printing
			ctx.set_is_type_name_included (False)
			ctx.set_default_serializer (create {JSON_REFLECTOR_SERIALIZER})
			ctx.register_serializer (create {TABLE_ITERABLE_JSON_SERIALIZER [detachable ANY, READABLE_STRING_GENERAL]}, {TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL]})
			ctx.register_serializer (create {ITERABLE_JSON_SERIALIZER [detachable ANY]}, {ITERABLE [detachable ANY]})

			s := conv_to.to_json_string (obj, ctx)

			create conv_from
			create ctx_deser
			ctx_deser.set_value_creation_callback (create {JSON_DESERIALIZER_CREATION_AGENT_CALLBACK}.make (agent (a_info: JSON_DESERIALIZER_CREATION_INFORMATION)
					do
						if
							attached {TEAM} a_info.parent_object as l_team and then
							attached a_info.feature_name as fn and then
							fn.is_case_insensitive_equal ("persons")
						then
							a_info.set_object (create {ARRAYED_LIST [PERSON]}.make (0))
						elseif
							attached {PERSON} a_info.parent_object as l_person and then
							attached a_info.feature_name as fn and then
							fn.is_case_insensitive_equal ("co_workers")
						then
							a_info.set_object (create {ARRAYED_LIST [ENTITY]}.make (0))
						elseif a_info.static_type = {STRING_TABLE [READABLE_STRING_32]} then
							a_info.set_object (create {STRING_TABLE [READABLE_STRING_32]}.make (0))
						end
					end)
				)
			ctx_deser.set_default_deserializer (create {JSON_REFLECTOR_DESERIALIZER})
			ctx_deser.register_deserializer (create {LIST_JSON_DESERIALIZER [detachable ANY]}, {LIST [detachable ANY]})
			ctx_deser.register_deserializer (create {TABLE_JSON_DESERIALIZER [detachable ANY]}, {TABLE [detachable ANY, READABLE_STRING_GENERAL]})

			if attached conv_from.from_json_string (s, ctx_deser, {TEAM}) as o then
				assert ("deserialized ok", recursively_one_includes_other (obj, o, Void))
			else
				assert ("deserialized ok (not yet fully implemented!) thus failure", False)
			end
		end

	test_reflector_custom
		local
			obj: TEAM
			conv_to: JSON_REFLECTOR_SERIALIZER
			conv_from: TEAM_JSON_DESERIALIZER
			ctx: detachable JSON_SERIALIZER_CONTEXT
			ctx_deser: detachable JSON_DESERIALIZER_CONTEXT
			s: STRING
		do
			obj := new_full_team

			create conv_to
			create ctx
			ctx.set_pretty_printing
			ctx.register_serializer (create {TEAM_JSON_SERIALIZER}, {TEAM})
			ctx.register_serializer (create {PERSON_JSON_SERIALIZER}, {PERSON})
			ctx.register_serializer (create {PERSON_DETAILS_JSON_SERIALIZER}, {PERSON_DETAILS})
			ctx.set_default_serializer (create {JSON_REFLECTOR_SERIALIZER})

			s := conv_to.to_json_string (obj, ctx)

			create conv_from
			create ctx_deser
			ctx_deser.set_default_deserializer (create {JSON_REFLECTOR_DESERIALIZER})
			ctx_deser.register_deserializer (create {TEAM_JSON_DESERIALIZER}, {TEAM})
			ctx_deser.register_deserializer (create {PERSON_JSON_DESERIALIZER}, {PERSON})
			ctx_deser.register_deserializer (create {ARRAYED_LIST_JSON_DESERIALIZER [PERSON]}, {ARRAYED_LIST [PERSON]})
			ctx_deser.register_deserializer (create {ARRAYED_LIST_JSON_DESERIALIZER [ENTITY]}, {ARRAYED_LIST [ENTITY]})

			if attached conv_from.from_json_string (s, ctx_deser, {TEAM}) as o then
				assert ("deserialized ok", recursively_one_includes_other (obj, o, Void))
			else
				assert ("deserialized ok", False)
			end
		end

	test_custom_serialization
		local
			obj: TEAM
			js: JSON_SERIALIZATION
			s: STRING
		do
			obj := new_group

			create js
			js.register (create {TEAM_JSON_SERIALIZATION}, {TEAM})
			js.register (create {PERSON_JSON_SERIALIZATION}, {PERSON})
			js.register_default (create {JSON_REFLECTOR_SERIALIZATION})

			js.set_pretty_printing


			s := js.to_json_string (obj)
			assert ("not empty", not s.is_empty)

			if attached js.from_json_string (s, {TEAM}) as o then
--				assert ("deserialized ok", recursively_same_objects (obj, o, Void))
				assert ("deserialized ok", s.same_string (js.to_json_string (o)))
			else
				assert ("deserialized reported error and returned Void", js.context.has_deserialization_error)
			end
		end

	test_serialization
		local
			obj: TEAM
			js: JSON_SERIALIZATION
			s: STRING
		do
			obj := new_group

			create js
			js.register_default (create {JSON_REFLECTOR_SERIALIZATION})

			js.set_pretty_printing


			s := js.to_json_string (obj)
			assert ("not empty", not s.is_empty)

			if attached js.from_json_string (s, {TEAM}) as o then
--				assert ("deserialized ok", recursively_same_objects (obj, o, Void))
				assert ("deserialized ok", s.same_string (js.to_json_string (o)))
			else
				assert ("deserialized reported error and returned Void", js.context.has_deserialization_error)
			end
		end

feature -- Factory

	new_group: TEAM
		local
			p: PERSON
			d: PERSON_DETAILS
		do
			create Result.make ("test-group")
			Result.add_vector ("FooBar")
			create p.make ("John", "Smith")
			create d
			d.set_country ("France")
			d.set_city_name ("Paris")
			d.set_zip (75000)
			p.set_details (d)

			Result.put (p)
			Result.put (create {PERSON}.make ("Paul", "Doe"))
		end

	new_full_team: TEAM
		do
			Result := new_group
			if attached Result.persons as lst and then not lst.is_empty then
				Result.set_owner (lst.first)
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

end
