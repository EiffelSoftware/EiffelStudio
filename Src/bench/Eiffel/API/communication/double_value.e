class DOUBLE_VALUE

inherit
	DEBUG_VALUE

creation
	make

feature

	 append_value (cw: CLICK_WINDOW) is 
		local
			double_class: CLASS_I
		do 
			double_class := System.double_class;
			if double_class.compiled then
				double_class.compiled_class.append_clickable_name (cw)
			else
				double_class.append_clickable_name (cw)
			end;
			cw.put_string (" = ");
			cw.put_string (value.out)
		end;

	value: DOUBLE;

	make (v: like value) is
		do
			value := v
		end

end

