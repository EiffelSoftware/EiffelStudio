class REAL_VALUE

inherit
	DEBUG_VALUE

creation
	make

feature

     append_value (cw: CLICK_WINDOW) is 
		local
			c_stone: STONE
        do 
			c_stone := Universe.class_stone ("real");
			cw.put_clickable_string (c_stone, "REAL");
			cw.put_string (" = ");
            cw.put_string (value.out)
        end;


	value: REAL;

	make (v: like value) is
		do
			value := v
		end

end

