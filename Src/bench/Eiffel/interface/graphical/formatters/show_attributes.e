
-- Command to display class attributes.

class SHOW_ATTRIBUTES 

inherit

	ROUTINE_FORM

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
		do
			init (c, a_text_window)
		end;

	symbol: PIXMAP is 
		once 
			!!Result.make; 
			Result.read_from_file (bm_Showattributes) 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showattributes end;

	title_part: STRING is do Result := l_Attributes_of end;

	criterium (f: FEATURE_I): BOOLEAN is
		do
			Result := any_criterium (f);
			Result := Result and f.is_attribute
		end

end
