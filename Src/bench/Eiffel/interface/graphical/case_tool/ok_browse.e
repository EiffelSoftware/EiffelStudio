indexing
	description: "Fill the text_field of Case_interface"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	OK_BROWSE

inherit
	CASE_COMMAND2
		redefine
			make
		end

creation
	make

feature -- creation

	make ( w : CASE_INTERFACE ; file_sel : FILE_SEL_D ) is
		do
			case_window := w
			file_s := file_sel
		end

	file_s : FILE_SEL_D

feature -- exec

	execute ( a : ANY ) is
		require
			case_w_exists : case_window/= Void
		do
			case_window.text_field1.set_text ( file_s.selected_file)
		end
end -- class OK_BROWSE
