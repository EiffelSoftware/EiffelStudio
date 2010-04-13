note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class 
	CLASS_STRUCTURE_EDITOR_APPLICATION

inherit
	EV_APPLICATION

create 
	make_and_launch

feature {NONE} -- Initialization

	arg_filename: STRING
		local
			args: ARGUMENTS
		do
			create args
			Result := args.separate_word_option_value ("filename")
		end

	make_and_launch
		do
			default_create
			create main_window
			main_window.show
			if attached arg_filename as s and then not s.is_empty then
				main_window.set_filename (s)
			end
			launch
		end

feature {NONE} -- Implementation

	main_window: CLASS_STRUCTURE_EDITOR_WINDOW

end -- class CLASS_STRUCTURE_EDITOR_APPLICATION
