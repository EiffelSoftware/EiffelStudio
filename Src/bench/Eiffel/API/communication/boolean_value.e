class BOOLEAN_VALUE

inherit
	DEBUG_VALUE

creation
	make

feature

	 append_value (cw: CLICK_WINDOW) is 
		local
			boolean_class: CLASS_I
		do 
			boolean_class := System.boolean_class;
			if boolean_class.compiled then
				boolean_class.compiled_class.append_clickable_name (cw)
			else
				boolean_class.append_clickable_name (cw)
			end;
			cw.put_string (" = ");
			cw.put_string (value.out)
		end;

	value: BOOLEAN;

	make (v: like value) is
		do
			value := v
		end

end

