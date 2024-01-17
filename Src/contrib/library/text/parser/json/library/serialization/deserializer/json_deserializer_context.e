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
			Precursor
			create deserializers.make (1)
			set_default_deserializer (create {JSON_CORE_DESERIALIZER})
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


feature -- Error		

	reset_error
			-- Reset `has_error' value.
		do
			error := Void
		ensure
			has_no_error: not has_error
		end

	report_error (e: JSON_DESERIALIZER_ERROR)
		local
			l_err: like error
		do
			l_err := error
			if l_err /= Void then
				e.set_previous (l_err)
			end
			error := e
		ensure
			has_error: has_error
		end

	has_error: BOOLEAN
			-- Error occurred?
		do
			Result := error /= Void
		end

	error: detachable JSON_DESERIALIZER_ERROR

feature -- Live status		

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
			l_deserializer: detachable JSON_DESERIALIZER
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
						k_type.conforms_to (o_type) and then
						o_type.conforms_to (k_type) and then
						attached o_type.generating_type.attempted (k_type)
					then
							-- Found
					else
						if o_type.conforms_to (k_type) then
							if l_deserializer = Void then
								l_deserializer := Result
							elseif l_deserializer.conforms_to (Result) then
								l_deserializer := Result
							end
						end
						Result := Void
					end
				end

				if Result = Void then
					if l_deserializer /= Void then
						Result := l_deserializer
					elseif attached default_deserializer as dft then
						Result := dft
					end
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
				if Result /= Void and then a_type /= Void and then a_type.attempted (Result) = Void then
						-- Bad returned object !
					Result := Void
				end
				if Result /= Void and attached {JSON_OBJECT} a_json as j_object then
					on_object (Result, j_object)
				end
			end
		end

feature -- Callback event access

	last_object: detachable ANY

	last_feature_name: detachable READABLE_STRING_GENERAL

	value_creation_callback: detachable JSON_DESERIALIZER_CREATION_CALLBACK

feature -- Callback event operation

	on_value_creation (a_value_info: JSON_DESERIALIZER_CREATION_INFORMATION)
		do
			if attached value_creation_callback as cb then
				if attached last_object as o then
					a_value_info.set_parent_object (o)
					if attached last_feature_name as fn then
						a_value_info.set_feature_name (fn)
					end
				end
				cb.on_value_creation (a_value_info)
			end
		end

	on_object (obj: ANY; a_json_object: JSON_OBJECT)
			-- Event triggered when object `obj' is just instantiated or fully deserialized from `a_json_object'.
		do
		end

	on_value_skipped (a_json: JSON_VALUE; a_type: detachable TYPE [detachable ANY]; a_message: READABLE_STRING_GENERAL)
			-- Value skipped!
			-- This may be dangerous and break void-safety!
		do
			if a_type /= Void then --and then a_type.is_attached then
				report_error (a_message)
			end
		end

	on_deserialization_field_start (a_obj: ANY; a_field_name: READABLE_STRING_GENERAL)
			-- Event triggered just before processing a reference field `a_field_name' on Current object.
		local
			s: like deserializer_location
		do
			last_object := a_obj
			last_feature_name := a_field_name
			s := deserializer_location
			if s.count > 0 then
				s.append_character ('.')
			end
			s.append_string_general (a_field_name)
		end

	on_deserialization_field_end (a_obj: ANY; a_field_name: READABLE_STRING_GENERAL)
			-- Event triggered just after reference field `a_field_name' on Current object was processed.
		local
			s: like deserializer_location
		do
			s := deserializer_location
			check s.ends_with_general (a_field_name) end
			s.remove_tail (a_field_name.count + 1) -- Include the '.'
			last_object := Void
			last_feature_name := Void
		end

feature -- Element change

	set_value_creation_callback (cb: like value_creation_callback)
		do
			value_creation_callback := cb
		end

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
	copyright: "2010-2024, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
