class
	TEST

inherit
	INTERNAL

create
	make
		
feature	{NONE} -- Initialization
 
	make is
			-- Entry point.
		local
			t: TUPLE
		do
			t ?= new_instance_of (dynamic_type_from_string ("TUPLE[TEST]"))
			t.put (Current, 1)
			io.put_string (t.generating_type)
			io.put_new_line
		end
 
end
