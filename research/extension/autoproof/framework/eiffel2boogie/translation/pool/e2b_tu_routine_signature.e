note
	description: "[
		Translation unit for the signature of an Eiffel routine.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_TU_ROUTINE_SIGNATURE

inherit

	E2B_TU_FEATURE

create
	make

feature -- Access

	base_id: STRING = "routine-signature"
			-- <Precursor>

feature -- Basic operations

	translate
			-- <Precursor>
		local
			l_translator: E2B_ROUTINE_TRANSLATOR
		do
			create l_translator.make
			l_translator.translate_routine_signature (feat, type)
		end

end
