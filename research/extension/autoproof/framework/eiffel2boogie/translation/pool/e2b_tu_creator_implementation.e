note
	description: "[
		Translation unit for the implementation of a creation routine.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_TU_CREATOR_IMPLEMENTATION

inherit

	E2B_TU_FEATURE

create
	make

feature -- Access

	base_id: STRING = "creator-impl"
			-- <Precursor>

feature -- Basic operations

	translate
			-- <Precursor>
		local
			l_translator: E2B_ROUTINE_TRANSLATOR
		do
			create l_translator.make
			l_translator.translate_creator_implementation (feat, type)
		end

end
