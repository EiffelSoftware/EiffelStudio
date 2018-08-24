note
	description: "[
		Translation unit for the write frame function of an Eiffel routine.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_TU_WRITE_FRAME

inherit

	E2B_TU_FEATURE

create
	make

feature -- Access

	base_id: STRING = "write-frame"
			-- <Precursor>

feature -- Basic operations

	translate
			-- <Precursor>
		local
			l_translator: E2B_ROUTINE_TRANSLATOR
		do
			create l_translator.make
			l_translator.translate_frame_function (feat, type, False)
		end

end
