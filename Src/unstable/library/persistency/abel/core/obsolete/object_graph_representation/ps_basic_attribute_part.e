note
	description: "Represents a single attribute of a basic type in the object graph."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_BASIC_ATTRIBUTE_PART

inherit

	PS_SIMPLE_PART
		redefine
			basic_attribute_value
		end

	REFACTORING_HELPER

create
	make

feature {PS_ABEL_EXPORT} -- Access

	basic_attribute_value: STRING
			-- The value of the basic attribute as a string.
		local
			managed: MANAGED_POINTER
			conv: UTF_CONVERTER
		do
			fixme ("We need to escape STRING and STRING_32 here, to prevent SQL injection. Addtionally, a check to see if we really only get basic types would be helpful for security")
			if attached {CHARACTER_8} represented_object as char then
				Result := char.natural_32_code.out
			elseif attached {CHARACTER_32} represented_object as char then
				Result := char.natural_32_code.out
			elseif attached {REAL_32} represented_object as real then
				create managed.make ({PLATFORM}.real_32_bytes)
				managed.put_real_32_be (real, 0)
				Result := managed.read_integer_32_be(0).out

--				Reversed:
--				managed.put_integer_32_be (Result.to_integer, 0)
--				real := managed.read_real_32_be (0)

			elseif attached {REAL_64} represented_object as real then
				create managed.make ({PLATFORM}.real_64_bytes)
				managed.put_real_64_be (real, 0)
				Result := managed.read_integer_64_be(0).out
			elseif attached {READABLE_STRING_32} represented_object as string_32 then
				create conv
				Result := conv.string_32_to_utf_8_string_8 (string_32)
			else
				Result := represented_object.out
			end
		end

feature {PS_ABEL_EXPORT} -- Status report

	is_representing_object: BOOLEAN = True
			-- Is `Current' representing an existing object?

feature {NONE} -- Initialization

	make (a_value: ANY; meta: PS_TYPE_METADATA; a_root: PS_OBJECT_GRAPH_ROOT)
			-- Initialization for `Current'.
		do
			default_make (a_root)
			represented_object := a_value
			internal_metadata := meta
		end

end
