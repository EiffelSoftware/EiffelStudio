-- Call unit description

class CALL_UNIT 

inherit

	HASHABLE
		redefine
			is_equal
		end;
	SHARED_ENCODER
		redefine
			is_equal
		end;
	SHARED_SERVER
		redefine
			is_equal
		end;
	SHARED_EXTERNALS
		redefine
			is_equal
		end;
	SHARED_TYPE_I
		redefine
			is_equal
		end;
	SHARED_PATTERN_TABLE
		redefine
			is_equal
		end;
	
feature 

	class_type: CLASS_TYPE;
			-- Class type to which the unit belongs to

	id: INTEGER;
			-- Second part of the unit description

	index: INTEGER;
			-- Index of the unit in an array

	set_class_type (t: CLASS_TYPE) is
			-- Assign `t' to `class_type'.
		do
			class_type := t
		end;

	set_id (i: INTEGER) is
			-- Assign `i' to `id'.
		do
			id := i;
		end;

	set_index (i: INTEGER) is
			-- Assign `i' to `index'.
		do
			index := i;
		end;

	type_id: INTEGER is
			-- Type id of `class_type'
		require
			class_type_exists: class_type /= Void
		do
			Result := class_type.type_id
		end;

	hash_code: INTEGER is 
			-- Hash code
		do
			Result := type_id * Mask + id;
		end;

	is_equal (other: CALL_UNIT): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := 	type_id = other.type_id
						and then
						id = other.id
		end;

	Mask: INTEGER is 32768;

end
