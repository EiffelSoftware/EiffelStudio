-- Abstract description of an entry in a routine table (instance of 
-- POLY_TABLE)

deferred class ENTRY

inherit
	COMPARABLE
		undefine
			is_equal
		end

	SHARED_WORKBENCH

	COMPILER_EXPORTER

feature -- comparison

	infix "<" (other: ENTRY): BOOLEAN is
			-- Is `other' greater than Current?
		do
			Result := type_id < other.type_id	
		end

feature -- from ENTRY

	type_id: INTEGER
			-- Type id of the entry

	type: TYPE_I
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

feature -- for dead code removal

	is_attribute: BOOLEAN is
			-- is the feature_i associated an attribute ?
		do
		end
	
	feature_id: INTEGER
			-- feature id of the feature associated to the entry
	
	set_feature_id (i: INTEGER) is
		do
			feature_id := i
		end

feature -- Previously in POLY_UNIT

	class_id: INTEGER
			-- Id of the class associated to the current_unit

	type_a: TYPE_A
			-- Result type of the polymorphic entry

	set_class_id (i: INTEGER) is
			-- Assign `i' to `class_id'
		do
			class_id := i
		end

	set_type_a (t: TYPE_A) is
			-- Assign `t' to `type_a'.
		do
			type_a := t
		end;

feature -- previously in POLY_UNIT

	new_poly_table (routine_id: INTEGER): POLY_TABLE [ENTRY] is
			-- New associated polymophic unit table
		require
			valid_routine_id: routine_id /= 0
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
			Result := type_a.actual_type.type_i
			if Result.has_formal then
				gen_type ?= class_type.type;
				Result := Result.instantiation_in (gen_type);
			end;
		end;

feature -- updates

	update (class_type: CLASS_TYPE) is
			-- Enlarged current entry to manage correctly polymorphism with generics.
		do
			set_type_id (class_type.type_id)
			set_type (feature_type (class_type))
		end

feature -- from ENTRY

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
			if
				not ( class_type = Void or else class_type.is_basic
				--or else --class_type.is_expanded
				)
			then
				Result := class_type.associated_class_type.static_type_id;
			end;
		end;

	generated_static_feature_type_id (buffer: GENERATION_BUFFER) is
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
				buffer.generate_type_id (class_type.associated_class_type.static_type_id)
			else
				buffer.putint (-1)
			end
		end;

	feature_type_id: INTEGER is
			-- Type id of the Result type
		local
			class_type: CL_TYPE_I;
		do
			class_type ?= type;
			if
				not ( class_type = Void or else class_type.is_basic
				--or else --class_type.is_expanded
				)
			then
				Result := class_type.type_id;
			end;
		end;

	is_generic : BOOLEAN is
			-- Is `type' a generic type?
		local
			gtype : GEN_TYPE_I
		do
			gtype ?= type;
			Result := (gtype /= Void)
		end;

	generate_cid (buffer: GENERATION_BUFFER; final_mode: BOOLEAN) is
			-- Generate list of type id's of generic type
			-- separated by commas.
		require
			is_generic : is_generic
		do
			type.generate_cid (buffer, final_mode, False)
		end

	make_gen_type_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for type of current entry.
		require
			is_generic : is_generic
		do
			type.make_gen_type_byte_code (ba, False)
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for current entry.
		deferred
		end;

end
