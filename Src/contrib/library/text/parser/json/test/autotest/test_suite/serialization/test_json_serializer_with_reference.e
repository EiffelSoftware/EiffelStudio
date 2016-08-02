note
	description: "Summary description for {TEST_JSON_SERIALIZER_WITH_REFERENCE}."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_JSON_SERIALIZER_WITH_REFERENCE

inherit
	TEST_JSON_SERIALIZER

feature -- Tests

	test_cycle_reflector
		local
			obj: TEAM
			conv_to: JSON_REFLECTOR_SERIALIZER
			conv_from: JSON_REFLECTOR_DESERIALIZER
			ctx: detachable JSON_SERIALIZER_CONTEXT
			ctx_deser: detachable JSON_DESERIALIZER_CONTEXT
			s: STRING
		do
			obj := new_cycling_full_team

			create conv_to
			create {JSON_SERIALIZER_CONTEXT_WITH_REFERENCE} ctx
			ctx.set_pretty_printing
			ctx.is_type_name_included := False -- Do not include the type name info.

			s := conv_to.to_json_string (obj, ctx)

			create conv_from
			create {JSON_DESERIALIZER_CONTEXT_WITH_REFERENCE} ctx_deser
			ctx_deser.set_default_deserializer (create {JSON_REFLECTOR_DESERIALIZER})

			if attached conv_from.from_json_string (s, ctx_deser, {TEAM}) as o then
				assert ("deserialized error", False)
			else
				assert ("deserialized reported error and returned Void", ctx_deser.has_error)
			end
		end

	test_cycle_reflector_with_type_name
		local
			obj: TEAM
			conv_to: JSON_REFLECTOR_SERIALIZER
			conv_from: JSON_REFLECTOR_DESERIALIZER
			ctx: detachable JSON_SERIALIZER_CONTEXT
			ctx_deser: detachable JSON_DESERIALIZER_CONTEXT
			s: STRING
		do
			obj := new_cycling_full_team

			create conv_to
			create {JSON_SERIALIZER_CONTEXT_WITH_REFERENCE} ctx
			ctx.set_pretty_printing
			s := conv_to.to_json_string (obj, ctx)

			create conv_from
			create {JSON_DESERIALIZER_CONTEXT_WITH_REFERENCE} ctx_deser
			ctx_deser.set_default_deserializer (create {JSON_REFLECTOR_DESERIALIZER})

			if attached conv_from.from_json_string (s, ctx_deser, {TEAM}) as o then
				assert ("deserialized ok", recursively_one_includes_other (obj, o, Void))
			else
				assert ("deserialized ok", False)
			end
		end

	test_cycle_reflector_custom
		local
			obj: TEAM
			conv_to: JSON_REFLECTOR_SERIALIZER
			conv_from: JSON_REFLECTOR_DESERIALIZER
			ctx: detachable JSON_SERIALIZER_CONTEXT_WITH_REFERENCE
			ctx_deser: detachable JSON_DESERIALIZER_CONTEXT
			s: STRING
		do
			obj := new_cycling_full_team

			create conv_to
			create ctx
			ctx.use_verbose_reference_identifier
			ctx.set_pretty_printing
			ctx.register_serializer (create {TEAM_JSON_SERIALIZER}, {TEAM})
			ctx.register_serializer (create {PERSON_JSON_SERIALIZER}, {PERSON})
			ctx.register_serializer (create {PERSON_DETAILS_JSON_SERIALIZER}, {PERSON_DETAILS})
			ctx.set_default_serializer (create {JSON_REFLECTOR_SERIALIZER})

			s := conv_to.to_json_string (obj, ctx)

			create conv_from
			create {JSON_DESERIALIZER_CONTEXT_WITH_REFERENCE} ctx_deser
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

	test_serialization_with_reference
		local
			obj: TEAM
			js: JSON_SERIALIZATION
			s,s2: STRING
		do
			obj := new_cycling_full_team

			create js.make_with_context (create {JSON_SERIALIZATION_CONTEXT_WITH_REFERENCE})
			js.register_default (create {JSON_REFLECTOR_SERIALIZATION})
			js.set_pretty_printing


			s := js.to_json_string (obj)
			assert ("not empty", not s.is_empty)

			if attached js.from_json_string (s, {TEAM}) as o then
--				assert ("deserialized ok", recursively_same_objects (obj, o, Void))
				js.reset
				s2 := js.to_json_string (o)
				assert ("deserialized ok", s.same_string (s2))
			else
				assert ("deserialized failed", js.context.has_deserialization_error)
			end
		end

feature -- Factory

	new_cycling_full_team: TEAM
		do
			Result := new_full_team
			if attached Result.owner as o then
				o.add_co_worker (Result)
			end
		end

end
