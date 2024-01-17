note
	description: "[
			JSON deserializer that convert JSON to standard Eiffel object from EiffelBase.
			 - JSON object -> STRING_TABLE [detachable ANY]
			 - JSON array -> ARRAYED_LIST [detachable ANY]
			 - JSON null -> Void
			 - JSON string -> STRING_32
			 - JSON integer -> INTEGER_64
			 - JSON boolean -> BOOLEAN
			 - JSON real -> REAL_64
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_BASIC_SERIALIZATION

create
	make

feature {NONE} -- Initialization

	make
		local
			conv: like serialization
			cb: JSON_DESERIALIZER_CREATION_AGENT_CALLBACK
		do
			create conv
			serialization := conv
			conv.register_default (create {JSON_BASIC_SERIALIZER})
			conv.register_default (create {JSON_BASIC_DESERIALIZER [detachable ANY]})

				-- Serializers
			conv.register (create {TABLE_ITERABLE_JSON_SERIALIZER [detachable ANY, READABLE_STRING_GENERAL]}, {TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL]})
			conv.register (create {ITERABLE_JSON_SERIALIZER [detachable ANY]}, {ITERABLE [detachable ANY]})

				-- Deserializers
			conv.register (create {TABLE_JSON_DESERIALIZER [detachable ANY]}, {TABLE [detachable ANY, READABLE_STRING_GENERAL]})
			conv.register (create {LIST_JSON_DESERIALIZER [detachable ANY]}, {LIST [detachable ANY]})

			create cb.make (agent (inf: JSON_DESERIALIZER_CREATION_INFORMATION)
					do
						if inf.static_type = Void or inf.static_type = {detachable ANY} then
							if attached {JSON_OBJECT} inf.json_value then
								inf.set_object (create {STRING_TABLE [detachable ANY]}.make (0))
							elseif attached {JSON_ARRAY} inf.json_value then
								inf.set_object (create {ARRAYED_LIST [detachable ANY]}.make (0))
							end
						elseif inf.static_type = {STRING_TABLE [detachable ANY]} then
							inf.set_object (create {STRING_TABLE [detachable ANY]}.make (0))
						elseif inf.static_type = {ARRAYED_LIST [detachable ANY]} then
							inf.set_object (create {ARRAYED_LIST [detachable ANY]}.make (0))
						elseif inf.static_type = {LIST [detachable ANY]} then
							inf.set_object (create {ARRAYED_LIST [detachable ANY]}.make (0))
						end
					end
				)
			conv.context.deserializer_context.set_value_creation_callback (cb)
		end

feature -- Settings change

	set_pretty_printing
			-- Generate pretty indented JSON for `to_json_string'.
		do
			serialization.set_pretty_printing
		end

	set_compact_printing
			-- Generate compact JSON for `to_json_string'.
		do
			serialization.set_compact_printing
		end

	use_reflector_serializer (a_is_type_name_included: BOOLEAN)
			-- Use reflection mechanism to serialize object structure,
			-- include type name if `a_is_type_name_included` is True.
			-- note: it will not deserialize automatically such serialization.
		do
			serialization.register (create {JSON_REFLECTOR_SERIALIZER}, {ANY})
			serialization.context.serializer_context.is_type_name_included := a_is_type_name_included
		end

feature -- Status report

	has_deserialization_error: BOOLEAN
		do
			Result := serialization.has_deserialization_error
		end

feature -- Conversion to JSON

	to_json (obj: detachable ANY): JSON_VALUE
		do
			Result := serialization.to_json (obj)
		end

	append_to_json_string (obj: detachable ANY; a_output: STRING_GENERAL)
		do
			serialization.append_to_json_string (obj, a_output)
		end

	to_json_string (obj: detachable ANY): STRING
		do
			Result := serialization.to_json_string (obj)
		end

feature -- Conversion from JSON

	table_from_json_string (a_json_string: STRING): detachable STRING_TABLE [detachable ANY]
		do
			if attached {like table_from_json_string} from_json_string (a_json_string) as tb then
				Result := tb
			end
		end

	list_from_json_string (a_json_string: STRING): detachable LIST [detachable ANY]
		do
			if attached {like list_from_json_string} from_json_string (a_json_string) as lst then
				Result := lst
			end
		end

	from_json (a_json: detachable JSON_VALUE): detachable ANY
		do
			if attached {JSON_OBJECT} a_json then
				Result := serialization.from_json (a_json, {STRING_TABLE [detachable ANY]})
			elseif attached {JSON_ARRAY} a_json then
				Result := serialization.from_json (a_json, {ARRAYED_LIST [detachable ANY]})
			else
				Result := serialization.context.value_from_json (a_json, Void)
			end
		end

	from_json_string (a_json_string: STRING): detachable ANY
		do
			Result := from_json (serialization.json_from_string (a_json_string))
		end

feature {NONE} -- Implementation

	serialization: JSON_SERIALIZATION

invariant
	serialization /= Void

note
	copyright: "2010-2024, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
