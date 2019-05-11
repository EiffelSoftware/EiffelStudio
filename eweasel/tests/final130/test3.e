class
	TEST

create
	make

feature {NONE} -- Creation

	make
		local
			c: CELL [detachable A]
		do
			create c.put (Void)
			test ("CELL [A]")
			test ("A")
		end

feature {NONE} -- Testing

	test (type_name: STRING)
			-- Attempt creating an object of type name `type_name` and report results.
		local
			t: like {REFLECTOR}.dynamic_type_from_string
		do
			t := {REFLECTOR}.dynamic_type_from_string (type_name)
			if t = -1 then
				io.put_string ("Type " + type_name + " is not found.%N")
			elseif t = {REFLECTOR}.none_type then
				io.put_string ("Type NONE is returned.%N")
			elseif t < 0 then
				io.put_string ("Negative type ID is returned.%N")
			elseif attached {REFLECTOR}.new_instance_of (t) as o then
				io.put_string ("An object of type " + o.generating_type.name_32.as_string_8 + " has been created.%N")
			else
				io.put_string ("Cannot create an object of type " + type_name + ".%N")
			end
		rescue
			io.put_string ("Aborted with exception: " + if attached {EXCEPTION_MANAGER}.last_exception as e then e.tag.as_string_8 else "" end + "%N")
			{EXCEPTIONS}.die (0)
		end

end
