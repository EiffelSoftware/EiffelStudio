-- Dependance unit

class DEPEND_UNIT 

inherit

	COMPARABLE
		redefine
			is_equal
		end;

	COMPILER_EXPORTER
		redefine
			is_equal
		end

creation

	make, make_expanded_unit, make_creation_unit, make_no_dead_code

feature  -- Initialization

	make (c_id: INTEGER; f: FEATURE_I) is
		do
			class_id := c_id;
			feature_id := f.feature_id
			if f.is_attribute and then f.rout_id_set.count > 1 then
				rout_id := f.rout_id_set.item (2)
			else
				rout_id := f.rout_id_set.first
			end
			written_in := f.written_in
			body_index := f.body_index
			is_external := f.is_external
		end

	make_no_dead_code (c_id: INTEGER; f: INTEGER) is
			-- creation of a depend unit with just a feature_id
			-- cannot be used during the dead code removal
		do
			class_id := c_id
			feature_id := f
		end

	make_expanded_unit (c_id: INTEGER) is
			-- Creation for special depend unit for expanded in local clause.
		do
			class_id := c_id;
			feature_id := -2
		end

	make_creation_unit (c_id: INTEGER) is
			-- Creation for special depend unit for creation instruction without creation routine.
		do
			class_id := c_id;
			feature_id := -1
		end

feature

	class_id: INTEGER;
			-- Class id

	feature_id: INTEGER;
			-- Feature id
			--| Note:	-1 is used for creation without creation routine
			--|			-2 for expanded in local clause

	rout_id: INTEGER

	body_index: INTEGER

	written_in: INTEGER

	is_external: BOOLEAN
			-- is the feature an external

	is_special: BOOLEAN is
			-- Is `Current' a special depend_unit, i.e. used
			-- for propagations
		do
			Result := feature_id < 0
		end;

	infix "<" (other: DEPEND_UNIT): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			Result := class_id < other.class_id or else
				(class_id = other.class_id and then feature_id < other.feature_id);
		end; -- infix "<"

	is_equal (other: like Current): BOOLEAN is
			-- Are `other' and `Current' equal?
		do
			Result := feature_id = other.feature_id and
					class_id = other.class_id
		end

feature -- Debug

	trace is
		do
			io.error.putstring ("Class id: ");
			io.error.putint (class_id)
			io.error.putstring (" feature id: ");
			io.error.putint (feature_id);
			io.error.new_line;
		end;

end
