-- Unit of polymorhism

deferred class POLY_UNIT

inherit

	COMPARABLE
		undefine
			is_equal
		end;
	SHARED_WORKBENCH;
	COMPILER_EXPORTER

feature

	id: CLASS_ID;
			-- Id of the class associated to the current unit

	type: TYPE_A;
			-- Result type of the polymorphic unit

	set_type (t: TYPE_A) is
			-- Assign `t' to `type'.
		do
			type := t
		end;

	set_id (i: CLASS_ID) is
			-- Assign `i' to `id'.
		do
			id := i
		end;

	infix "<" (other: POLY_UNIT): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			Result := id < other.id
		end;

	new_poly_table (pattern_id: PATTERN_ID): POLY_UNIT_TABLE [POLY_UNIT] is
			-- New associated polymophic unit table
		deferred
		end;

	entry (class_type: CLASS_TYPE): ENTRY is
			-- Entry in a poly-table for final mode
		deferred
		end;

	feature_type (class_type: CLASS_TYPE): TYPE_I is
			-- Type id of the result type in `class_type'.
		require
			good_argument: class_type /= Void
		local
			gen_type: GEN_TYPE_I;
		do
			Result := type.actual_type.type_i;
			if Result.has_formal then
				gen_type ?= class_type.type;
				Result := Result.instantiation_in (gen_type);
			end;
		end;

feature -- Trace

	trace is
		do
			io.putstring ("Class ");	
			io.putstring (System.class_of_id (id).name);	
			io.new_line
		end

end
