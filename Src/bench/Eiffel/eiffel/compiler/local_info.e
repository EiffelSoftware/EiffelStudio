class LOCAL_INFO 
	
feature 

	position: INTEGER;
			-- Position of the local in the sequence of local
			-- declarations

	type: TYPE_A;
			-- Local type

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		do
			position := i;
		end;

	set_type (t: TYPE_A) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

	actual_type: TYPE_A is
			-- Actual type of `type'.
		require
			type_exists: type /= Void
		do
			Result := type.actual_type;
		end;

end
