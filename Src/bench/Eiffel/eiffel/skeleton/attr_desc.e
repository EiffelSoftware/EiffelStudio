-- Description of an attribute in an instance of CLASS_TYPE

deferred class ATTR_DESC 

inherit
	COMPARABLE
		undefine
			is_equal
		end

	SHARED_LEVEL

	SK_CONST

	COMPILER_EXPORTER
	
feature 

	feature_id: INTEGER;
			-- Feature id of an attribute

	attribute_name: STRING;
			-- Attribute name

	rout_id: ROUTINE_ID;
			-- Attribute routine id

	set_feature_id (i: INTEGER) is
			-- Assign `i' to `feature_id'.
		do
			feature_id := i;
		end;

	set_attribute_name (s: STRING) is
			-- Assign `s' to `attribute_name'.
		do
			attribute_name := s;
		end;

	set_rout_id (i: ROUTINE_ID) is
			-- Assign `i' to `rout_id'.
		do
			rout_id := i
		end;

	level: INTEGER is
			-- Comparison criteria
		deferred
		end;

	sk_value: INTEGER is
			-- Skeleton characteristic value
		deferred
		end;

	real_sk_value: INTEGER is
			-- sk_value including the type_id
		do
			Result := sk_value
		end

	infix "<" (other: like Current): BOOLEAN is
			-- Is `other' greater then Current ?
		do
			Result := level < other.level
				or else (level = other.level and then rout_id.id < other.rout_id.id)
		end;

	is_reference: BOOLEAN is
			-- Is the attribute a reference ?
		do
		end;

	is_boolean: BOOLEAN is
			-- is the attribute a boolean one ?
		do
		end;

	is_character: BOOLEAn is
			-- Is the attribute a character ?
		do
		end;

	is_integer: BOOLEAN is
			-- Is the attribute an integer ?
		do
		end;

	is_real: BOOLEAN is
			-- Is the attribute a real ?
		do
		end;

	is_double: BOOLEAN is
			-- is the attribute a double one ?
		do
		end;

	is_bits: BOOLEAN is
			-- Is the attribute a BIT one ?
		do
		end;

	is_expanded: BOOLEAN is
			-- Is the attribute an expanded one ?
		do
		end;

	is_pointer: BOOLEAN is
			-- Is the attribute a pointer one ?
		do
		end;

	has_formal: BOOLEAN is
			-- Is the attribute a formal generic one ?
		do
			-- Do nothing
		end;

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- file `file'.
		require
			buffer /= Void;
		deferred
		end;

	instantiation_in (class_type: CLASS_TYPE): ATTR_DESC is
			-- Instantiation in `class_type' of the current
			-- attribute description
		require
			good_argument: class_type /= Void
		do
			Result := Current;
		ensure
			no_formal: not Result.has_formal
		end;

	same_as (other: ATTR_DESC): BOOLEAN is
			-- Is `other' the same as Current ?
		require
			good_argument: other /= Void
		do
			Result := 	other.level = level
						and other.feature_id = feature_id
						and other.rout_id.is_equal (rout_id)
		end;

	trace is
			-- Debug purpose
		deferred
		end;

end
