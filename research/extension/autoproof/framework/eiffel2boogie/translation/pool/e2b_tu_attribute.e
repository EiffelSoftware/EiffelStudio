note
	description: "[
		Translation unit for an Eiffel attribute.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_TU_ATTRIBUTE

inherit

	E2B_TU_FEATURE

create
	make

feature -- Access

	base_id: STRING = "attribute"
			-- <Precursor>

feature -- Basic operations

	translate
			-- <Precursor>
		local
			l_translator: E2B_ATTRIBUTE_TRANSLATOR
		do
			create l_translator
			l_translator.translate (feat, type)
		end

end
