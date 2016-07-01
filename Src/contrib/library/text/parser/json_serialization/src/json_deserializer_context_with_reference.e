note
	description: "Context for the deserialization."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_DESERIALIZER_CONTEXT_WITH_REFERENCE

inherit
	JSON_DESERIALIZER_CONTEXT
		redefine
			default_create,
			value_from_json,
			on_object,
			on_object_referenced,
			reset
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create deserialized_references.make (1)
		end

feature -- Cleaning

	reset
			-- Clean any temporary data, to release memory or reset computation.
		do
			deserialized_references.wipe_out
			Precursor
		end

feature -- Factory

	value_from_json (a_json: detachable JSON_VALUE; a_type: detachable TYPE [detachable ANY]): detachable ANY
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
				Result := Precursor (a_json, a_type)
			end
		end

feature -- Callback event

	on_object (obj: ANY; a_json_object: JSON_OBJECT)
			-- Event triggered when object `obj' is just instantiated or fully deserialized from `a_json_object'.
		do
			Precursor (obj, a_json_object)

				-- If it has a "$REF#" field, another value is referencing this `obj'
				-- thus record it for later access by the other value.
			if attached {JSON_STRING} a_json_object.item ("$REF#") as j_str then
				record_deserialized_reference (obj, j_str.unescaped_string_32)
			end
		end

	on_object_referenced (obj: ANY; a_ref_id: READABLE_STRING_GENERAL)
			-- Event trigger when an object `obj' is associated with an identifier `a_ref_id'.
		do
			Precursor (obj, a_ref_id)
			record_deserialized_reference (obj, a_ref_id)
		end

feature -- References record

	deserialized_references: STRING_TABLE [detachable ANY]

	record_deserialized_reference (obj: ANY; a_ref_id: READABLE_STRING_GENERAL)
		do
			deserialized_references.force (obj, a_ref_id)
		end

	discard_deserialized_reference (a_ref_id: READABLE_STRING_GENERAL)
		do
			deserialized_references.remove (a_ref_id)
		end

	reference_identifier_from (a_json_object: JSON_OBJECT): detachable READABLE_STRING_GENERAL
		do
			if attached {JSON_STRING} a_json_object.item ("$REF") as s_ref then
				Result := s_ref.unescaped_string_32
			end
		end

	recorded_deserialized_reference (a_ref: READABLE_STRING_GENERAL): detachable ANY
		do
			if Result = Void then
				Result := deserialized_references.item (a_ref)
			end
		end

;note
	copyright: "2016-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)"
end
