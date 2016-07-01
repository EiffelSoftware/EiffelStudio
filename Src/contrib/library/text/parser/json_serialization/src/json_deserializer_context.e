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

	value_from_json (a_json: detachable JSON_VALUE; a_type: detachable TYPE [detachable ANY]): detachable ANY
		local
			conv: like deserializer
		do
			if a_type = Void then
				conv := default_deserializer
			else
				conv := deserializer (a_type)
			end
			if conv /= Void then
				Result := conv.from_json (a_json, Current, a_type)
				if Result /= Void and attached {JSON_OBJECT} a_json as j_object then
					on_object (Result, j_object)
				end
			end
		end

feature -- Callback event

	on_object (obj: ANY; a_json_object: JSON_OBJECT)
			-- Event triggered when object `obj' is just instantiated or fully deserialized from `a_json_object'.
		do
		end

	on_object_referenced (obj: ANY; a_ref_id: READABLE_STRING_GENERAL)
			-- Event trigger when an object `obj' is associated with an identifier `a_ref_id'.
		do
		end

	on_value_skipped (a_json: JSON_VALUE; a_type: detachable TYPE [detachable ANY])
			-- Value skipped!
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
