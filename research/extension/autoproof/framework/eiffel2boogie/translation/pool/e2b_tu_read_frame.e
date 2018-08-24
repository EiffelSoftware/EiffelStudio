note
	description: "[
		Translation unit for the read frame function of an Eiffel function.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_TU_READ_FRAME

inherit

	E2B_TU_FEATURE

create
	make

feature -- Access

	base_id: STRING = "read-frame"
			-- <Precursor>

feature -- Basic operations

	translate
			-- <Precursor>
		local
			l_translator: E2B_ROUTINE_TRANSLATOR
		do
			create l_translator.make
			l_translator.translate_frame_function (feat, type, True)
		end
end
