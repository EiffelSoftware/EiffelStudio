-- Abstract description of an entry in a routine table (instance of 
-- POLY_TABLE)

deferred class ENTRY

inherit

	COMPARABLE
		undefine
			is_equal
		end;
	SHARED_WORKBENCH;

feature

	type_id: INTEGER;
			-- Type id of the entry

	type: TYPE_I;
			-- Result type fo the entry

	set_type_id (i: INTEGER) is
			-- Assign `i' to `type_id'.
		do
			type_id := i;
		end;

	set_type (t: TYPE_I) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

	infix "<" (other: ENTRY): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			Result := type_id < other.type_id
		end;

	used: BOOLEAN is
			-- Is the entry used ?
		deferred
		end;

	static_feature_type_id: INTEGER is
			-- Type id of the Result type
		local
			class_type: CL_TYPE_I;
		do
			class_type ?= type;
			if not (
				class_type = Void
				or else
				class_type.is_basic
				--or else
				--class_type.is_expanded
			) then
				Result := class_type.associated_class_type.id.id;
			end;
		end;

	generated_static_feature_type_id: STRING is
			-- Textual representation of type id of the Result type
		local
			class_type: CL_TYPE_I
		do
			class_type ?= type;
			if
				not ( class_type = Void or else class_type.is_basic
				--or else-class_type.is_expanded
				)
			then
				Result := class_type.associated_class_type.id.generated_id
			else
				Result := "-1"
			end
		end;

	feature_type_id: INTEGER is
			-- Type id of the Result type
		local
			class_type: CL_TYPE_I;
		do
			class_type ?= type;
			if not (
				class_type = Void
				or else
				class_type.is_basic
				--or else
				--class_type.is_expanded
			) then
				Result := class_type.type_id;
			end;
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for current entry.
		deferred
		end;

end
