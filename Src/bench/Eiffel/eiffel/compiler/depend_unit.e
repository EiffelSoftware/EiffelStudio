indexing
	description: "Abstraction of a dependance between a feature and Current"
	date: "$Date$"
	revision: "$Revision$"

class DEPEND_UNIT 

inherit
	COMPARABLE
		redefine
			is_equal
		end

	COMPILER_EXPORTER
		undefine
			is_equal
		end

	DEBUG_OUTPUT
		undefine
			is_equal
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			is_equal
		end

create
	make,
	make_with_level,
	make_expanded_unit,
	make_creation_unit,
	make_no_dead_code

feature {NONE} -- Initialization

	make (c_id: INTEGER; f: FEATURE_I) is
			-- Create new instance of a traditional DEPEND_UNIT. Used for computing
			-- feature dependences.
		do
			make_with_level (c_id, f, 0)	
		end
		
	make_with_level (c_id: INTEGER; f: FEATURE_I; a_context: INTEGER_8) is
			-- Create new instance of a traditional DEPEND_UNIT. Used for computing
			-- feature dependences in a given context.
		do
			class_id := c_id
			if f.is_attribute and then f.rout_id_set.count > 1 then
				rout_id := f.rout_id_set.item (2)
			else
				rout_id := f.rout_id_set.first
			end
			written_in := f.written_in
			body_index := f.body_index
			if f.is_external then
				internal_flags := is_external_flag | a_context;
			else
				internal_flags := a_context;
			end
		end

	make_no_dead_code (c_id: INTEGER; r_id: INTEGER) is
			-- Creation of a depend unit with just a `routine_id'
			-- cannot be used during dead code removal
		do
			class_id := c_id
			rout_id := r_id
			internal_flags := 0
		end

	make_expanded_unit (c_id: INTEGER) is
			-- Creation for special depend unit for expanded in local clause.
		do
			class_id := c_id
			internal_flags := is_special_flag
		end

	make_creation_unit (c_id: INTEGER) is
			-- Creation for special depend unit for creation instruction with implicit creation routine
			-- in case of expanded classes.
		do
			class_id := c_id
			internal_flags := is_special_flag
		end

feature -- Access

	class_id: INTEGER
			-- Class ID of target of call.

	rout_id: INTEGER
			-- Routine ID.

	body_index: INTEGER
			-- Body index.

	written_in: INTEGER
			-- Class ID where current feature is written in.

	is_external: BOOLEAN is
			-- Is Current an external feature?
		do
			Result := internal_flags & is_external_flag = is_external_flag
		end

	is_special: BOOLEAN is
			-- Is `Current' a special depend_unit, i.e. used
			-- for propagations
		do
			Result := internal_flags & is_special_flag = is_special_flag
		end
		
	is_needed_for_dead_code_removal: BOOLEAN is
			-- Is `Current' needed for dead code removal?
			-- True if not used in assertions (and no assertions
			-- are kept) and not marked as special.
		local
			l_flags: like internal_flags
		do
			l_flags := internal_flags
			if not System.keep_assertions then
					-- Special optimization when no assertions are
					-- generated, we only traverse code that is reachable
					-- from outside assertions.
				Result := ((l_flags & (is_special_flag | is_in_assertion_mask)) = 0)
			else
				Result := (l_flags & is_special_flag) = 0
			end
		end

feature -- Comparison

	infix "<" (other: DEPEND_UNIT): BOOLEAN is
			-- Is `other' greater than Current ?
		local
			l_id, l_oid: INTEGER
		do
				-- We use `class_id', `rout_id' and `internal_flags' to perform
				-- comparison.
			l_id := class_id
			l_oid := other.class_id
			if l_id = l_oid then
				l_id := rout_id
				l_oid := other.rout_id
				if l_id = l_oid then
					Result := internal_flags < other.internal_flags
				else
					Result := l_id < l_oid
				end
			else
				Result := l_id < l_oid
			end
		end

	is_equal (other: like Current): BOOLEAN is
			-- Are `other' and `Current' equal?
		do
			Result := class_id = other.class_id and rout_id = other.rout_id and
				internal_flags = other.internal_flags
		end

	same_as (other: DEPEND_UNIT): BOOLEAN is
			-- Does `other' and `Current' correspond to the same routine?
			-- Used to find callers of a routine.
		do
			Result := class_id = other.class_id and rout_id = other.rout_id
		end

feature {DEPEND_UNIT} -- Access

	internal_flags: INTEGER_8
			-- Flags to store some info about current unit.

feature {NONE} -- Implementation: flags

	is_external_flag: INTEGER_8 is 0x01
	is_special_flag: INTEGER_8 is 0x02

	is_in_assertion_mask: INTEGER_8 is 0x3C
	
feature -- Flags

	is_in_require_flag: INTEGER_8 is 0x04
	is_in_check_flag: INTEGER_8 is 0x08
	is_in_ensure_flag: INTEGER_8 is 0x10
	is_in_invariant_flag: INTEGER_8 is 0x20
			-- Mask used for internal property.

feature -- Debug

	trace is
		do
			io.error.putstring ("Class id: ")
			io.error.putint (class_id)
			io.error.putstring (" body index: ")
			io.error.putint (body_index)
			io.error.new_line
		end

feature {NONE} -- Debug

	debug_output: STRING is
			-- Display info about current routine.
		local
			l_class: CLASS_C
			l_feat: FEATURE_I
		do
			l_class := System.class_of_id (class_id)
			if l_class /= Void and l_class.has_feature_table then
				l_feat := l_class.feature_table.feature_of_body_index (body_index)
				if l_feat /= Void then
					Result := l_class.name_in_upper + ": " + l_feat.feature_name
				else
					Result := "Feature not in class."
				end
			else
				Result := "Class not in system or not compiled yet."
			end
		end
		
invariant
	valid_class_id: class_id > 0

end -- end class DEPEND_UNIT
