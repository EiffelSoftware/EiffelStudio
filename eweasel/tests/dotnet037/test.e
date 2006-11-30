class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			o: SYSTEM_OBJECT
		do
			o := Current
			io.put_boolean (o.equals (Void))
			io.put_new_line
			io.put_boolean (o.equals (o))
			io.put_new_line
			io.put_boolean (o.equals_object (Void))
			io.put_new_line
			io.put_boolean (o.equals_object (o))
			io.put_new_line
			io.put_boolean (o.equals (Void, Void))
			io.put_new_line
			io.put_boolean (o.equals (Void, o))
			io.put_new_line
			io.put_boolean (o.equals (o, Void))
			io.put_new_line
			io.put_boolean (o.equals (o, o))
			io.put_new_line
			io.put_boolean (o.equals_object_object (Void, Void))
			io.put_new_line
			io.put_boolean (o.equals_object_object (Void, o))
			io.put_new_line
			io.put_boolean (o.equals_object_object (o, Void))
			io.put_new_line
			io.put_boolean (o.equals_object_object (o, o))
			io.put_new_line
		end

end
