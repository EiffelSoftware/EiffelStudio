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

inherit {NONE}

	REFACTORING_HELPER

create
	make

feature {PS_EIFFELSTORE_EXPORT} -- Access

	basic_attribute_value: STRING
			-- The value of the basic attribute as a string.
		do
			fixme ("We need to escape STRING and STRING_32 here, to prevent SQL injection. Addtionally, a check to see if we really only get basic types would be helpful for security")
			if attached {CHARACTER_8} represented_object as char then
				Result := char.natural_32_code.out
			elseif attached {CHARACTER_32} represented_object as char then
				Result := char.natural_32_code.out
			else
				Result := represented_object.out
			end
		end

feature {PS_EIFFELSTORE_EXPORT} -- Status report

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
