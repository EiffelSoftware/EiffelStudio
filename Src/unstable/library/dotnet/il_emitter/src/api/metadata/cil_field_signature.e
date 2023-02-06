note
	description: "Summary description for {CIL_FIELD_SIGNATURE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_FIELD_SIGNATURE


create
	make


feature {NONE} -- Initialization

	make (a_type: CIL_BASIC_TYPE)
		do
			create type.make (a_type)
		end

	make_with_pointer_level (a_type: CIL_BASIC_TYPE; a_pointer_level: INTEGER)
		do
			create type.make_with_pointer_level( a_type, a_pointer_level)
		end

	make_with_container (a_container: CIL_DATA_CONTAINER)
		do
			create type.make_with_container (a_container)
		end


feature -- Access		


	type: CIL_TYPE
		-- type of the field.
end
