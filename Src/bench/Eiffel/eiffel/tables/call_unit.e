-- Call unit description

deferred class CALL_UNIT 

inherit

	HASHABLE
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
	COMPILER_EXPORTER
		redefine
			is_equal
		end
	
feature 

	class_type: CLASS_TYPE;
			-- Class type to which the unit belongs to

	id: COMPILER_ID;
			-- Second part of the unit description

	index: COMPILER_ID;
			-- Index of the unit in an array

	set_class_type (t: CLASS_TYPE) is
			-- Assign `t' to `class_type'.
		do
			class_type := t
		end;

	set_id (i: like id) is
			-- Assign `i' to `id'.
		do
			id := i;
		end;

	set_index (i: like index) is
			-- Assign `i' to `index'.
		do
			index := i;
		end;

	type_id: INTEGER is
			-- `type_id' of `class_type'
		require
			class_type_exists: class_type /= Void
		do
			Result := class_type.type_id
		end;

	class_type_id: TYPE_ID is
			-- `id' of `class_type'
		require
			class_type_exists: class_type /= Void
		do
			Result := class_type.id
		end;

	is_valid: BOOLEAN is
		deferred
		end;

feature -- Hash coding

	hash_code: INTEGER is 
			-- Hash code
		do
			Result := class_type_id.hash_code * Mask + id.hash_code
		end;

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := 	class_type_id.is_equal (other.class_type_id)
						and then
						equal (id, other.id)
		end;

	Mask: INTEGER is 32768;

end
