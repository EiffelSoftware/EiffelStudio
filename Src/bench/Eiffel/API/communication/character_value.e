class CHARACTER_VALUE

inherit
	
	DEBUG_VALUE;
	BASIC_ROUTINES

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
			if (value < ' ') then
				cw.put_string ("Ctrl-");
				cw.put_char (charconv (charcode (value) + charcode ('@')))
			elseif charcode (value) > 127 then
				tmp_code := charcode (value) - 128;
				if tmp_code < charcode (' ') then
					cw.put_string ("Ext-Ctrl-");
					cw.put_char (charconv (tmp_code + charcode ('@')))
				else
					cw.put_string ("Ext-");
					cw.put_char (charconv (tmp_code))
				end;
			else
				cw.put_char ('%'');
				cw.put_char (value);
				cw.put_char ('%'')
			end
		end;

	value: CHARACTER;

	make (v: like value) is
		do
			value := v
		end

end

