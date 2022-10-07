note
	description: "value: a field name (used as an operand)"
	date: "$Date$"
	revision: "$Revision$"

class
	FIELD_NAME

inherit

	VALUE
		rename
			make as make_value
		redefine
			il_src_dump
		end

create
	make

feature {NONE} -- Initialization

	make (a_field: FIELD)
			--| Can be used to make the field a reference to another
			--|assembly, in a rudimentary way
		do
			make_value("", Void)
			field := a_field
		ensure
			field_set: field = a_field
		end

feature -- Access

	field: FIELD
		-- The field reference.		


feature -- Output

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		do
			if field.type.basic_type = {BASIC_TYPE}.class_ref then
				if attached field.type.type_ref as l_type_ref and then
					l_type_ref.flags.flags & {QUALIFIERS_ENUM}.value /= 0
				then
					a_file.put_string ("valuetype ")
				else
					a_file.put_string ("class ")
				end
			end
			Result := field.type.il_src_dump (a_file)
			a_file.put_string (" ")
			a_file.put_string ({QUALIFIERS}.name (field.name, field.parent, False))
			Result := True
		end

end
