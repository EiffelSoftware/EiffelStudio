-- Command to display class onces.

class SHOW_ONCES 

inherit

	ROUTINE_FORM
		redefine
			display_feature
		end

creation

	make

feature 

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
		do
			init (c, a_text_window)
		end;

	symbol: PIXMAP is 
		once 
			Result := bm_Showonces 
		end;
	
feature {NONE}

	command_name: STRING is do Result := l_Showonces end;

	title_part: STRING is do Result := l_Onces_of end;

	criterium (f: FEATURE_I): BOOLEAN is
		do
			Result := any_criterium (f);
			Result := Result and then (f.is_once or else
							f.is_constant)
		end;

	display_feature (f: FEATURE_I; c: CLASS_C) is
		local
			const: CONSTANT_I
		do
			f.append_clickable_signature (text_window, c);
			if f.is_constant then
				text_window.put_string (" is ");
				const ?= f;	--| Cannot fail
				text_window.put_string (const.value.dump);
			end
		end;

end
