-- Information for reading a feature in file ".AST"

class READ_INFO 

inherit
	SERVER_INFO
		redefine
			trace
		end

	COMPILER_EXPORTER
	
feature -- Access

	class_id: CLASS_ID;
			-- Id of the class

	object_count: INTEGER;
			-- Number of objects to retrieve

feature -- Update

	set_position (i: INTEGER) is
			-- Assign `i' to `offset'.
		do
			position := i;
		end;

	set_object_count (i: INTEGER) is
			-- Assign `i' to `object_count'.
		do
			object_count := i;
		end;

	set_class_id (i: CLASS_ID) is
			-- Assign `i' to `class_id'.
		do
			class_id := i;
		end;

feature -- Trace

	trace is
		do
			io.error.putstring ("READ_INFO:%NPosition: ");
			io.error.putint (Position);
			io.error.putstring ("%NClass_id: ");
			class_id.trace;
			io.error.putstring ("%Nobject_count: ");
			io.error.putint (object_count);
			io.error.new_line;
		end;

end
