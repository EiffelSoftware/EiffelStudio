note
	description: "Context for the deserialization."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_DESERIALIZER_CONTEXT

inherit
	JSON_SERIALIZATION_CONTEXT_I
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			create deserializers.make (1)
			set_default_deserializer (create {JSON_REFLECTOR_DESERIALIZER})
			create deserializer_location.make_empty
		end

feature -- Cleaning

	reset
			-- Clean any temporary data, to release memory or reset computation.
		do
			deserializer_location.wipe_out
			deserialized_references := Void
			deserializers_cache := Void
			across
				deserializers as ic
			loop
				ic.item.reset
			end
			reset_error
		end

	reset_error
			-- Reset `has_error' value.
		do
			has_error := False
		end

feature -- Live status		

	has_error: BOOLEAN
			-- Error occurred?

	deserializer_location: STRING_32
			-- String representing the current location in the serialization.
			--| Empty location string represents the root object.
			--| using a.b.c  representation corresponding to `{ "a": { "b": { "c": ... } } }'

--	is_at_root_location: BOOLEAN
--		do
--			Result := deserializer_location.is_empty
--		end

--feature -- Helpers

--	from_json (a_json: detachable JSON_VALUE; a_type: TYPE [detachable ANY]): detachable ANY
--		do
--			if attached deserializer (a_type) as conv then
--				Result := conv.from_json (a_json, Current, a_type)
--			end
--		end

feature -- Access

	default_deserializer: like deserializer assign set_default_deserializer

	deserializer (a_type: TYPE [detachable ANY]): detachable JSON_DESERIALIZER
		local
			o_type, k_type: TYPE [detachable ANY]
			tb: like deserializers_cache
		do
			tb := deserializers_cache
			if tb /= Void then
				Result := tb.item (a_type)
			end
			if Result = Void then
				o_type := a_type
				across
					deserializers as ic
				until
					Result /= Void
				loop
					Result := ic.item
					k_type := ic.key
					if o_type ~ k_type then
							-- Found
					elseif
							-- Hack: use conformance of type, and reverse conformance of type of type.
--						(is_strict implies attached k_type.attempted (o_type)) and then
						attached k_type.attempted (o_type) and then
						attached o_type.generating_type.attempted (k_type)
					then
							-- Found
					else
						Result := Void
					end
				end

				if Result = Void and attached default_deserializer as dft then
					Result := dft
				end
				if Result /= Void then
					if tb = Void then
						create tb.make (1)
						deserializers_cache := tb
					end
					tb.force (Result, a_type)
				end
			end
		end

feature -- Factory

	value_from_json (a_json: detachable JSON_VALUE; a_type: TYPE [detachable ANY]): detachable ANY
		do
			if
				attached {JSON_OBJECT} a_json as j_object and then
				j_object.count = 1 and then
				attached {JSON_STRING} j_object.item ("$REF") as j_ref
			then
					-- Is a reference, since a JSON_OBJECT with a unique field named "$REF"!
				Result := recorded_deserialized_reference (j_ref.unescaped_string_32)
			else
					-- Not a reference, i.e does not have "$REF" as field name !
				if attached deserializer (a_type) as conv then
					Result := conv.from_json (a_json, Current, a_type)
					if Result /= Void and attached {JSON_OBJECT} a_json as j_object then
						on_object (Result, j_object)
					end
				end
			end
		end

feature -- Callback event

--	on_root_object_referenced (obj: ANY)
--			-- Event trigger when root object `obj' is created.
--		do
--			record_deserialized_reference (obj, deserializer_location.string)
--		end

	on_object (obj: ANY; a_json_object: JSON_OBJECT)
			-- Event triggered when object `obj' is just instantiated or fully deserialized from `a_json_object'.
		do
				-- If it has a "$REF#" field, another value is referencing this `obj'
				-- thus record it for later access by the other value.
			if attached {JSON_STRING} a_json_object.item ("$REF#") as j_str then
				record_deserialized_reference (obj, j_str.unescaped_string_32)
			end
		end

	on_object_referenced (obj: ANY; a_ref_id: READABLE_STRING_GENERAL)
			-- Event trigger when an object `obj' is associated with an identifier `a_ref_id'.
		do
			record_deserialized_reference (obj, a_ref_id)
		end

	on_array_skipped (a_json: JSON_ARRAY; a_type: detachable TYPE [detachable ANY])
		do
			if a_type /= Void and then a_type.is_attached then
				has_error := True
			end
		end

	on_object_skipped (a_json: JSON_OBJECT; a_type: detachable TYPE [detachable ANY])
			-- Object skipped!
			-- This may be dangerous and break void-safety!
		do
			if a_type /= Void then --and then a_type.is_attached then
				has_error := True
			end
		end

	on_deserialization_field_start (a_field_name: READABLE_STRING_GENERAL)
			-- Event triggered just before processing a reference field `a_field_name' on Current object.
		local
			s: like deserializer_location
		do
			s := deserializer_location
			if s.count > 0 then
				s.append_character ('.')
			end
			s.append_string_general (a_field_name)
		end

	on_deserialization_field_end (a_field_name: READABLE_STRING_GENERAL)
			-- Event triggered just after reference field `a_field_name' on Current object was processed.
		local
			s: like deserializer_location
		do
			s := deserializer_location
			check s.ends_with_general (a_field_name) end
			s.remove_tail (a_field_name.count + 1) -- Include the '.'
		end

feature -- References record

--	set_root_reference (obj: detachable ANY)
--		do
--			if obj /= Void then
--				record_deserialized_reference (obj, "|")
--			else
--				discard_deserialized_reference ("|")
--			end
--		end

--	root_reference: detachable ANY
--		do
--			Result := recorded_deserialized_reference ("|")
--		end

	deserialized_references: detachable STRING_TABLE [detachable ANY]

	record_deserialized_reference (obj: ANY; a_ref_id: READABLE_STRING_GENERAL)
		local
			refs: like deserialized_references
		do
			refs := deserialized_references
			if refs = Void then
				create refs.make (1)
				deserialized_references := refs
			end
			refs.force (obj, a_ref_id)
		end

	discard_deserialized_reference (a_ref_id: READABLE_STRING_GENERAL)
		local
			refs: like deserialized_references
		do
			refs := deserialized_references
			if refs /= Void then
				refs.remove (a_ref_id)
			end
		end

	recorded_deserialized_reference (a_ref: READABLE_STRING_GENERAL): detachable ANY
		do
			if attached deserialized_references as refs then
				Result := refs.item (a_ref)
			end
		end

feature -- Element change

	register_deserializer (conv: attached like deserializer; a_type: TYPE [detachable ANY])
		do
			deserializers.force (conv, a_type)
		end

	set_default_deserializer (conv: like default_deserializer)
		do
			default_deserializer := conv
		end

feature {NONE} -- Implementation

	deserializers: HASH_TABLE [JSON_DESERIALIZER, TYPE [detachable ANY]]

	deserializers_cache: detachable HASH_TABLE [JSON_DESERIALIZER, TYPE [detachable ANY]]

;note
	copyright: "2016-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)"
end
