class REAL_VALUE

inherit
	DEBUG_VALUE

creation
	make

feature

     append_value (cw: CLICK_WINDOW) is 
		local
			real_class: CLASS_I
        do 
			real_class := System.real_class;
			if real_class.compiled then
				real_class.compiled_class.append_clickable_name (cw)
			else
				real_class.append_clickable_name (cw)
			end;
			cw.put_string (" = ");
            cw.put_string (value.out)
        end;


	value: REAL;

	make (v: like value) is
		do
			value := v
		end

end

