note
	description: "[
		{XTAG_F_INPUT_SECRET_TAG}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_INPUT_SECRET_TAG

inherit
	XTAG_F_INPUT_TAG

create
	make

feature -- Initialization

	make
		do
			make_base
		end

feature -- Implementation


	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; variable_table: TABLE [STRING, STRING])
			-- <Precursor>
		do
		end

end
