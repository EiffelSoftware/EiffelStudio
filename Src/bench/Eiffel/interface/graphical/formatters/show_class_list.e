indexing

	description:	
		"Command to display classes in the universe, in alphabetic order.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_CLASS_LIST 

inherit

	LONG_FORMATTER
		redefine
			dark_symbol, display_temp_header, post_fix
		end

creation

	make
	
feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Showclass_list 
		end;
 
	dark_symbol: PIXMAP is 
			-- Dark version of `symbol'.
		once 
			Result := Pixmaps.bm_Dark_showclass_list 
		end;

feature {NONE} -- Properties

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Showclass_list
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showclass_list
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	title_part: STRING is
		do
			Result := Interface_names.t_Class_list_of
		end;

	post_fix: STRING is "alf";

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
			-- Show universe: classes in alphabetical order.
		local
			cmd: E_SHOW_CLASSES;
		do
			!! Result.make;
			!! cmd.make (Result);
			cmd.execute;
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Exploring and sorting classes...")
		end;

end -- class SHOW_CLASS_LIST
