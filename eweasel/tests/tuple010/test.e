class
	TEST

inherit
	INTERNAL

create
	make
		
feature	{NONE} -- Initialization
 
	make
			-- Entry point.
		do
			if attached {TUPLE} new_instance_of (dynamic_type_from_string ("TUPLE[TEST]")) as t then
				t.put (Current, 1)
				io.put_string (t.generating_type.name_32.to_string_8)
				io.put_new_line
			end
		end
 
end
