class POINTER_VALUE

inherit
	DEBUG_VALUE

creation
	make

feature

     append_value (cw: CLICK_WINDOW) is 
        do 
			cw.put_string (" = C pointer ");
            cw.put_string (value.out)
        end;


	value: POINTER;

	make (v: like value) is
		do
			value := v
		end

end

