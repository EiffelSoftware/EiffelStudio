indexing
	description: "Description of an attribute in an instance of CLASS_TYPE"
	date: "$Date$"
	revision: "$Revision$"

deferred class ATTR_DESC 

inherit
	COMPARABLE
		undefine
			is_equal
		end

	SHARED_LEVEL
		export
			{NONE} all
		end

	SK_CONST
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_TYPE_I
		export
			{NONE} all
		end

feature -- Access

	feature_id: INTEGER
			-- Feature id of an attribute

	attribute_name: STRING
			-- Attribute name

	rout_id: INTEGER
			-- Attribute routine id

feature -- Settings

	set_feature_id (i: INTEGER) is
			-- Assign `i' to `feature_id'.
		do
			feature_id := i
		end

	set_attribute_name (s: STRING) is
			-- Assign `s' to `attribute_name'.
		do
			attribute_name := s
		end

	set_rout_id (i: INTEGER) is
			-- Assign `i' to `rout_id'.
		do
			rout_id := i
		end

feature -- Status report

	level: INTEGER is
			-- Comparison criteria
		deferred
		end

	sk_value: INTEGER is
			-- Skeleton characteristic value
		deferred
		end

	type_i: TYPE_I is
			-- Corresponding TYPE_I instance for current description.
		deferred
		end

	is_bits: BOOLEAN is
			-- Is the attribute a BIT one ?
		do
		end

	is_expanded: BOOLEAN is
			-- Is the attribute an expanded one ?
		do
		end

	has_formal: BOOLEAN is
			-- Is the attribute a formal generic one ?
		do
			-- Do nothing
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is `other' greater then Current ?
		do
			Result := level < other.level
				or else (level = other.level and then rout_id < other.rout_id)
		end

	same_as (other: ATTR_DESC): BOOLEAN is
			-- Is `other' the same as Current ?
		require
			good_argument: other /= Void
		do
			Result := other.level = level and other.feature_id = feature_id and
				other.rout_id = rout_id
		end

feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- file `file'.
		require
			buffer_not_void: buffer /= Void
		deferred
		end

	generate_generic_code (buffer: GENERATION_BUFFER; is_final_mode: BOOLEAN; code, idx : INTEGER) is
			-- Generate full type code for current attribute description in
			-- `buffer'.
		require
			buffer_not_void: buffer /= Void
		do
			buffer.putstring ("static int16 g_atype")
			buffer.putint (code)
			buffer.putchar ('_')
			buffer.putint (idx)
			buffer.putstring (" [] = {0,")
			generate_generic_info (buffer, is_final_mode)
			buffer.putstring ("-1};%N")
		end

	generate_generic_info (buffer: GENERATION_BUFFER; is_final_mode: BOOLEAN) is
			-- Generate type array for current attribute description in
			-- `buffer'.
		require
			buffer_not_void: buffer /= Void
			has_type: type_i /= Void
		do
			type_i.generate_cid (buffer, is_final_mode, False)
		end

	instantiation_in (class_type: CLASS_TYPE): ATTR_DESC is
			-- Instantiation in `class_type' of the current
			-- attribute description
		require
			good_argument: class_type /= Void
		do
			Result := Current
		ensure
			no_formal: not Result.has_formal
		end

feature -- Debug

	trace is
			-- Debug purpose
		deferred
		end

end
