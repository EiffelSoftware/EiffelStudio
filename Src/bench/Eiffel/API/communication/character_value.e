class CHARACTER_VALUE

inherit
	
	DEBUG_VALUE;
	BASIC_ROUTINES

creation
	make

feature

	 append_value (cw: CLICK_WINDOW) is 
		local
			tmp_code: INTEGER
		do 
			cw.put_string (" = ");
			if (value < ' ') then
				cw.put_string ("Ctrl-");
				cw.put_string (charconv (charcode (value) + charcode ('@')).out)
			elseif charcode (value) > 127 then
				tmp_code := charcode (value) - 128;
				if tmp_code < charcode (' ') then
					cw.put_string ("Ext-Ctrl-");
					cw.put_string (charconv (tmp_code + charcode ('@')).out)
				else
					cw.put_string ("Ext-");
					cw.put_string (charconv (tmp_code).out)
				end;
			else
				cw.put_string ("'");
				cw.put_string (value.out);
				cw.put_string ("'")
			end
		end;

	value: CHARACTER;

	make (v: like value) is
		do
			value := v
		end

end

