indexing
	description: "Command to display classes in the universe, in alphabetic order."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_LIST_FORMATTER

inherit
	EB_LONG_FORMATTER
		redefine
			display_temp_header, post_fix
		end

creation

	make
	
feature -- Properties

	symbol: EV_PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Showclass_list 
		end
 
feature {NONE} -- Properties

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Showclass_list
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showclass_list
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	title_part: STRING is
		do
			Result := Interface_names.t_Class_list_of
		end

	post_fix: STRING is "alf"

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
			-- Show universe: classes in alphabetical order.
		local
			cmd: E_SHOW_CLASSES
		do
			create cmd.make
			cmd.execute
			Result := cmd.structured_text
		end

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Exploring and sorting classes...")
		end

end -- class EB_CLASS_LIST_FORMATTER
