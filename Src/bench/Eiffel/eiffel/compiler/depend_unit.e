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
		redefine
			is_equal
		end

creation
	make,
	make_expanded_unit,
	make_emtpy_creation_unit,
	make_creation_unit,
	make_no_dead_code

feature {NONE} -- Initialization

	make (c_id: INTEGER; f: FEATURE_I) is
			-- Create new instance of a traditional DEPEND_UNIT. Used for computing
			-- feature dependences.
		do
			class_id := c_id
			if f.is_attribute and then f.rout_id_set.count > 1 then
				rout_id := f.rout_id_set.item (2)
			else
				rout_id := f.rout_id_set.first
			end
			written_in := f.written_in
			body_index := f.body_index
			internal_flags := internal_flags.set_bit_with_mask (f.is_external, is_external_mask)
		end

	make_no_dead_code (c_id: INTEGER; f: INTEGER) is
			-- Creation of a depend unit with just a feature_id
			-- cannot be used during dead code removal
		do
			class_id := c_id
		end

	make_expanded_unit (c_id: INTEGER) is
			-- Creation for special depend unit for expanded in local clause.
		do
			class_id := c_id
			set_is_special (True)
		end

	make_emtpy_creation_unit (c_id: INTEGER; f: FEATURE_I) is
			-- Creation for special depend unit for creation instruction without creation routine.
		do
			make (c_id, f)
			set_is_special (True)
		end

	make_creation_unit (c_id: INTEGER) is
			-- Creation for special depend unit for creation instruction with implicit creation routine
			-- in case of expanded classes.
		do
			class_id := c_id
			set_is_special (True)
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
			Result := internal_flags & is_external_mask = is_external_mask
		end

	is_special: BOOLEAN is
			-- Is `Current' a special depend_unit, i.e. used
			-- for propagations
		do
			Result := internal_flags & is_special_mask = is_special_mask
		end

feature -- Comparison

	infix "<" (other: DEPEND_UNIT): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			Result := class_id < other.class_id or else
				(class_id = other.class_id and then body_index < other.body_index)
		end

	is_equal (other: like Current): BOOLEAN is
			-- Are `other' and `Current' equal?
		do
			Result := class_id = other.class_id and body_index = other.body_index
		end

feature {NONE} -- Settings

	set_is_special (b: BOOLEAN) is
			-- Set `is_special' with `b'.
		do
			internal_flags := internal_flags.set_bit_with_mask (True, is_special_mask)
		ensure
			is_special_set: is_special = b
		end

feature {NONE} -- Implementation: flags

	internal_flags: INTEGER_8
			-- Flags to store some info about current unit.

	is_external_mask: INTEGER_8 is 0x01
	is_special_mask: INTEGER_8 is 0x02
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

invariant
	valid_class_id: class_id > 0

end -- end class DEPEND_UNIT
