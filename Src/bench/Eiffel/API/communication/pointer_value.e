class POINTER_VALUE

inherit
	DEBUG_VALUE

creation
	make

feature

     append_value (cw: CLICK_WINDOW) is 
		local
			c_stone: STONE
        do 
			c_stone := Universe.class_stone ("pointer");
			cw.put_clickable_string (c_stone, "POINTER");
			cw.put_string (" = C pointer ");
            cw.put_string (value.out)
        end;


	value: POINTER;

	make (v: like value) is
		do
			value := v
		end

end

