indexing
	description: "Information required to read in a file of the EIFGEN/COMP directory."
	date: "$Date$"
	revision: "$Revision$"

class READ_INFO 

inherit
	SERVER_INFO
		redefine
			trace
		end

	COMPILER_EXPORTER
	
feature -- Access

	class_id: INTEGER;
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

	set_class_id (i: INTEGER) is
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
			io.error.putint (class_id);
			io.error.putstring ("%Nobject_count: ");
			io.error.putint (object_count);
			io.error.new_line;
		end;

end
