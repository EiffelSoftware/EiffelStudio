class INTEGER_VALUE

inherit
	DEBUG_VALUE

creation
	make

feature

     append_value (cw: CLICK_WINDOW) is 
        do 
			cw.put_string ("INTEGER = ");
            cw.put_string (value.out)
        end;


	value: INTEGER;

	make (v: like value) is
		do
			value := v
		end

end

