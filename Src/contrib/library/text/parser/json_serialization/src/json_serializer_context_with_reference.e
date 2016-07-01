note
	description: "Context for JSON serialization."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_SERIALIZER_CONTEXT_WITH_REFERENCE

inherit
	JSON_SERIALIZER_CONTEXT
		redefine
			default_create,
			reset,
			is_accepted_object,
			on_object_serialization_start,
			on_object_serialization_end,
			to_json
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create serialized_references.make
		end

feature -- Settings / behavior		

	is_reference_reused: BOOLEAN = True

feature -- Status

	is_accepted_object (obj: detachable ANY): BOOLEAN
			-- Is `obj' accepted for serialization?
			-- ie: when cycle are forbidden, it should be recursively expanded.
		do
			Result := True
		end

feature -- Cleaning

	reset
			-- Clean any temporary data, to release memory or reset computation.
		do
			Precursor
			serialized_references.reset
		end

feature -- Callback events		

	on_object_serialization_start (a_obj: ANY)
			-- Event triggered just before processing object `a_obj'.
		do
			Precursor (a_obj)
			if attached {READABLE_STRING_GENERAL} a_obj then
					-- Do not record string value!
			else
				record_reference (Void, a_obj)
			end
		end

	on_object_serialization_end (j_value: JSON_VALUE; a_obj: ANY)
			-- Event triggered just after having object `a_obj' processed with associated `j_value' json value..
			--| `j_value' is either JSON_STRING, JSON_OBJECT or JSON_ARRAY.
		do
			Precursor (j_value, a_obj)
			record_reference (j_value, a_obj)
		end

feature -- References		

	record_reference (j_value: detachable JSON_VALUE; a_obj: ANY)
			-- Record json value `j_value' for object `a_obj'
			-- and associate with a reference identifier computed internally.
		do
			serialized_references.record (a_obj, j_value, Current)
		end

	recorded_json_value (obj: ANY): detachable JSON_OBJECT
			-- JSON value representing the reference `obj' if any.
		do
			if attached serialized_references.item (obj) as s_ref then
				create Result.make_with_capacity (1)
				Result.put_string (s_ref, "$REF")
			end
		end

feature -- Helpers

	to_json (obj: ANY; a_caller_serializer: detachable JSON_SERIALIZER): detachable JSON_VALUE
		do
			if attached recorded_json_value (obj) as j then
				Result := j
			else
				Result := Precursor (obj, a_caller_serializer)
			end
		end

feature {NONE} -- Implementation: cycle

	serialized_references: JSON_SERIALIZER_REFERENCE_COLLECTION

;note
	copyright: "2016-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)"
end
