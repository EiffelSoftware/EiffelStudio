class INTEGER_VALUE

inherit
	DEBUG_VALUE

creation
	make

feature

     append_value (cw: CLICK_WINDOW) is 
		local
			c_stone: STONE
        do 
			c_stone := Universe.class_stone ("integer");
			cw.put_clickable_string (c_stone, "INTEGER");
			cw.put_string (" = ");
            cw.put_string (value.out)
        end;


	value: INTEGER;

	make (v: like value) is
		do
			value := v
		end

end

