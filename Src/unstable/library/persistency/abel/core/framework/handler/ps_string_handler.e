note
	description: "Handler for different STRING types."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_STRING_HANDLER

inherit

	PS_VALUE_TYPE_HANDLER

create
	make, default_create

feature {NONE} -- Implementation

	internal_can_handle_type (type: PS_TYPE_METADATA): BOOLEAN
			-- Can `Current' handle objects of type `type'?
		do
			Result :=
				type.type.type_id = ({detachable STRING_8}).type_id
				or else type.type.type_id = ({detachable STRING_32}).type_id
				or else attached {TYPE[detachable IMMUTABLE_STRING_GENERAL]} type.type
		end

feature {PS_ABEL_EXPORT} -- String pair conversion

	build_from_string (value: STRING; type: PS_TYPE_METADATA): detachable ANY
			-- Create an object from a value type.
		local
			conv: UTF_CONVERTER
			string32: STRING_32
		do
			fixme ("No type comparison based on strings...")

			if type.type.name.is_equal ("STRING_8") then
				Result := value.twin
			elseif type.type.name.is_equal ("STRING_32") then
				string32 := conv.utf_8_string_8_to_string_32 (value)
				string32.adapt_size
				Result := string32
			elseif type.type.name.is_equal ("IMMUTABLE_STRING_8") then
				create {IMMUTABLE_STRING_8} Result.make_from_string (value)

			elseif type.type.name.is_equal ("IMMUTABLE_STRING_32")  then
				string32 := conv.utf_8_string_8_to_string_32 (value)
				string32.adapt_size
				create {IMMUTABLE_STRING_32} Result.make_from_string_32 (string32)
			end
		end

	as_string_pair (object: PS_OBJECT_DATA): TUPLE[value: STRING; type: IMMUTABLE_STRING_8]
			-- The `object' converted to a string pair.
		local
			conv: UTF_CONVERTER
		do
			fixme ("We need to escape STRING and STRING_32 here, to prevent SQL injection.")

			if attached {READABLE_STRING_32} object.reflector.object as string_32 then
				create conv
				Result := [conv.string_32_to_utf_8_string_8 (string_32), object.type.base_class.name]
			else
				Result := [object.reflector.object.out, object.type.base_class.name]
			end
		end

end
