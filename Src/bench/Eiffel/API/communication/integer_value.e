class INTEGER_VALUE

inherit
	DEBUG_VALUE

creation
	make

feature

     append_value (cw: CLICK_WINDOW) is 
		local
			integer_class: CLASS_I
        do 
			integer_class := System.integer_class;
			if integer_class.compiled then
				integer_class.compiled_class.append_clickable_name (cw)
			else
				integer_class.append_clickable_name (cw)
			end;
			cw.put_string (" = ");
            cw.put_string (value.out)
        end;


	value: INTEGER;

	make (v: like value) is
		do
			value := v
		end

end

