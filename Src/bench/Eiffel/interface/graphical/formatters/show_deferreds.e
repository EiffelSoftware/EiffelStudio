-- Command to display class deferred routines.

class SHOW_DEFERREDS 

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
			Result := bm_Showdeferreds 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showdeferreds end;

	title_part: STRING is do Result := l_Deferreds_of end;

	criterium (f: FEATURE_I): BOOLEAN is
		do
			Result := any_criterium (f);
			Result := Result and f.is_deferred
		end

end
