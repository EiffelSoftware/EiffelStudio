-- Information for reading a feature in file ".AST"

class READ_INFO 
	
feature 

	offset: INTEGER;
			-- Offset in file

	class_id: INTEGER;
			-- Id of the class

	object_count: INTEGER;
			-- Number of objects to retrieve

	trace is
		do
			io.error.putstring ("READ_INFO:%NOffset: ");
			io.error.putint (offset);
			io.error.putstring ("%NClass_id: ");
			io.error.putint (class_id);
			io.error.putstring ("%Nobject_count: ");
			io.error.putint (object_count);
			io.error.new_line;
		end;

	set_offset (i: INTEGER) is
			-- Assign `i' to `offset'.
		do
			offset := i;
		end;

	set_object_count (i: INTEGER) is
			-- Assign `i' to `object_count'.
		do
			object_count := i;
		end;

	set_class_id (i: INTEGER) is
			-- Assign `i' to `class_id'.
		do
			class_id := i;
		end;

end
