note
	description: "[
		Translation unit for an Eiffel type.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_TU_TYPE

inherit

	E2B_TRANSLATION_UNIT

create
	make

feature {NONE} -- Implementation

	make (a_type: CL_TYPE_A)
			-- Initialize translation unit for type `a_type'.
		do
			type := a_type
			id := "type/" + type_id (type)
		end

feature -- Access

	type: CL_TYPE_A
			-- Type to be translated.

	id: STRING
			-- <Precursor>

feature -- Basic operations

	translate
			-- <Precursor>
		local
			l_translator: E2B_TYPE_TRANSLATOR
		do
			create l_translator
			l_translator.translate_type (type)
		end

end
