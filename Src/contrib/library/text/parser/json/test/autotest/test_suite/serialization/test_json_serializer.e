note
	description: "Summary description for {TEST_JSON_SERIALIZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_JSON_SERIALIZER

inherit
	EQA_TEST_SET

	TEST_JSON_I

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
			ctx_deser.register_deserializer (create {LIST_JSON_DESERIALIZER [PERSON]}, {ARRAYED_LIST [PERSON]})
			ctx_deser.register_deserializer (create {LIST_JSON_DESERIALIZER [ENTITY]}, {ARRAYED_LIST [ENTITY]})

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

end
