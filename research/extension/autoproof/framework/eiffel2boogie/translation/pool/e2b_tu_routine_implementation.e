note
	description: "[
		Translation unit for the implementatino of an Eiffel routine.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_TU_ROUTINE_IMPLEMENTATION

inherit

	E2B_TU_FEATURE

create
	make

feature -- Access

	base_id: STRING = "routine-impl"
			-- <Precursor>

feature -- Basic operations

	translate
			-- <Precursor>
		local
			l_translator: E2B_ROUTINE_TRANSLATOR
		do
			create l_translator.make
			l_translator.translate_routine_implementation (feat, type)
		end

end
