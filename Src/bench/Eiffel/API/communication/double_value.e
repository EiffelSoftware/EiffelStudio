class DOUBLE_VALUE

inherit
	DEBUG_VALUE

creation
	make

feature

	 append_value (cw: CLICK_WINDOW) is 
		do 
			cw.put_string ("DOUBLE = ");
			cw.put_string (value.out)
		end;

	value: DOUBLE;

	make (v: like value) is
		do
			value := v
		end

end

