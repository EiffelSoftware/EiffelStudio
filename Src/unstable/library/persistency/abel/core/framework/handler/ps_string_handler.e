note
	description: "Handler for different STRING types."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_STRING_HANDLER

inherit

	PS_VALUE_TYPE_HANDLER

	PS_TYPE_TABLE
		undefine
			default_create
		end

create
	make, default_create

feature {NONE} -- Implementation

	internal_can_handle_type (type: PS_TYPE_METADATA): BOOLEAN
			-- <Precursor>
		do
			Result :=
				type.type.type_id = ({detachable STRING_8}).type_id
				or else type.type.type_id = ({detachable STRING_32}).type_id
				or else attached {TYPE [detachable IMMUTABLE_STRING_GENERAL]} type.type
		end

feature {PS_ABEL_EXPORT} -- String conversion

	build_from_string (value: STRING; type: PS_TYPE_METADATA): detachable ANY
			-- <Precursor>
		local
			conv: UTF_CONVERTER
			string32: STRING_32
			id: INTEGER
		do
			id := type.type.type_id

			if id = ({detachable STRING_8}).type_id then
				Result := value.twin

			elseif id = ({detachable STRING_32}).type_id then
				string32 := conv.utf_8_string_8_to_string_32 (value)
				string32.adapt_size
				Result := string32

			elseif id = ({detachable IMMUTABLE_STRING_8}).type_id then
				create {IMMUTABLE_STRING_8} Result.make_from_string (value)

			elseif id = ({detachable IMMUTABLE_STRING_32}).type_id  then
				string32 := conv.utf_8_string_8_to_string_32 (value)
				create {IMMUTABLE_STRING_32} Result.make_from_string_32 (string32)

			end
		end

	as_string (object: PS_OBJECT_DATA): STRING
			-- <Precursor>
		local
			conv: UTF_CONVERTER
		do
			fixme ("We need to escape STRING and STRING_32 here, to prevent SQL injection.")

			if attached {READABLE_STRING_32} object.reflector.object as string_32 then
				Result := conv.string_32_to_utf_8_string_8 (string_32)
			else
				Result := object.reflector.object.out
			end
		end

end
