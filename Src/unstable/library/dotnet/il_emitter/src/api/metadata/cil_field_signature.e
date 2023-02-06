note
	description: "Summary description for {CIL_FIELD_SIGNATURE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_FIELD_SIGNATURE


create
	make



feature {NONE} -- Initialization

	make
		do
			create field.make ("",create {CIL_TYPE}.make (create {CIL_BASIC_TYPE}.void_), create {CIL_QUALIFIERS}.make)
		end

feature -- Access		


	field: CIL_FIELD
		-- The field

feature -- Change Element

	set_name (a_name: READABLE_STRING_GENERAL)
			-- Set field name with `a_name'
		do
			field.set_name (a_name)
		end


	set_field_type (a_type: CIL_TYPE)
			-- Set field type with `a_type'
		do
			field.set_type (a_type)
		end


	set_flags (a_flags: CIL_QUALIFIERS)
			-- Set field flags with `a_flags'.
		do
			field.set_flags (a_flags)
		end

end
