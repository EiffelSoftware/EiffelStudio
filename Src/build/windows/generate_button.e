indexing
	description: "Button to generate Eiffel source code."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class 

	GENERATE_BUTTON

inherit

--	LICENCE_COMMAND
--		select
--			init_toolkit
--		end

	EB_BUTTON_COM

	GENERATE
		rename
			raise as raise_exception
		select
			init_toolkit
		end

	COMMAND_ARGS
	
creation

	make

feature {NONE}

	make (a_parent: COMPOSITE) is
		do
			make_visible (a_parent)
			add_button_press_action (3, Current, First)
		end

	create_focus_label is 
		do
			set_focus_string (Focus_labels.generate_code_label)
		end

feature {NONE}

	symbol: PIXMAP is
		do
			Result := Pixmaps.generate_pixmap
		end

end
