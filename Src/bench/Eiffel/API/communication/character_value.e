class CHARACTER_VALUE

inherit
	
	DEBUG_VALUE;
	CHARACTER_ROUTINES

creation
	make

feature

	 append_value (cw: CLICK_WINDOW) is 
		local
			character_class: CLASS_I;
			tmp_code: INTEGER
		do 
			character_class := System.character_class;
			if character_class.compiled then
				character_class.compiled_class.append_clickable_name (cw)
			else
				character_class.append_clickable_name (cw)
			end;
			cw.put_string (" = ");
			cw.put_char ('%'');
			cw.put_string (char_text (value));
			cw.put_char ('%'')
		end;

	value: CHARACTER;

	make (v: like value) is
		do
			value := v
		end

end

