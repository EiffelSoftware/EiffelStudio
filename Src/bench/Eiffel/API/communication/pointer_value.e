class POINTER_VALUE

inherit
	DEBUG_VALUE

creation
	make

feature

     append_value (cw: CLICK_WINDOW) is 
		local
			pointer_class: CLASS_I
        do 
			pointer_class := System.pointer_class;
			if pointer_class.compiled then
				pointer_class.compiled_class.append_clickable_name (cw)
			else
				pointer_class.append_clickable_name (cw)
			end;
			cw.put_string (" = C pointer ");
			cw.put_string (value)
        end;


	value: STRING;

	make (v: POINTER) is
		do
			value := v.out
		end

end

