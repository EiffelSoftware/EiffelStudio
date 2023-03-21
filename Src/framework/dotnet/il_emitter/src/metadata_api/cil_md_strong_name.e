note
	description: "Summary description for {CIL_STRONG_NAME}."
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_MD_STRONG_NAME

create
	make

feature {NONE} -- Initialization

	make
		do
			snk_file := ""
		end

	snk_file: STRING_32

end
