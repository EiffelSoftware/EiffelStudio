class BOOLEAN_VALUE

inherit
	DEBUG_VALUE

creation
	make

feature

	 append_value (cw: CLICK_WINDOW) is 
		do 
			cw.put_string ("BOOLEAN = ");
			cw.put_string (value.out)
		end;

	value: BOOLEAN;

	make (v: like value) is
		do
			value := v
		end

end

