
-- Command to display classes in the universe, in alphabetic order.

class SHOW_CLASS_LIST 

inherit

	SHARED_WORKBENCH;
	LONG_FORMATTER
		redefine
			dark_symbol, display_temp_header, post_fix
		end

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is 
		do 
			init (c, a_text_window)
		end; 

	symbol: PIXMAP is 
		once 
			Result := bm_Showclass_list 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showclass_list 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showclass_list end;

	title_part: STRING is do Result := l_Class_list_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Show universe: classes in alphabetic order, in `text_window'.
		local
			ewb_class_list: EWB_CLASS_LIST
		do
			!! ewb_class_list;
			ewb_class_list.set_output_window (text_window)
			ewb_class_list.display
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Exploring and sorting classes...")
		end;

	post_fix: STRING is "alf";

end
