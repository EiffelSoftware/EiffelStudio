indexing
	description: "Like types that have not been evaluated (has not gone past Degree 4)."
	date: "$Date$"
	revision: "$Revision $"

class
	UNEVALUATED_LIKE_TYPE

inherit
	LIKE_TYPE_A
		redefine
			is_like_current, has_associated_class,
			type_i, associated_class, internal_conform_to
		end

creation
	make

feature -- Initialization

	make (a_string: like dump) is
			-- Initialize `anchor' to `a_string'
		require
			non_void_string: a_string /= Void
		do
			anchor := a_string
		ensure
			set: anchor = a_string
		end

feature -- Properties

	anchor: STRING
			-- Anchor name

	is_like_current: BOOLEAN
			-- Is Current like Current?

	has_associated_class: BOOLEAN is False
			-- Does Current have associated class?

feature -- Access

	associated_class: CLASS_C is
			-- Class associated to the current type
		do
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := anchor.is_equal (other.anchor) and then
				is_like_current = other.is_like_current
		end

feature -- Setting

	set_like_current is
			-- Set `is_like_current' to True.
		do
			is_like_current := True
		ensure
			is_like_current: is_like_current
		end

feature -- Output

	ext_append_to (st: STRUCTURED_TEXT; f: E_FEATURE) is
			-- Append Current type to `st'.
		do
			st.add (ti_Like_keyword)
			st.add_space
			st.add_default_string (anchor)
		end

	dump: STRING is
		do
			!! Result.make (0)
			Result.append ("like ")
			Result.append (anchor)
		end

feature {NONE} -- Implementation

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
		end

	solved_type (feat_table: FEATURE_TABLE f: FEATURE_I): like Current is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table
		do
		end

	create_info: CREATE_INFO is
			-- Byte code information for entity type creation
		do
		end

	internal_conform_to (other: TYPE_A in_generics: BOOLEAN): BOOLEAN is
			-- Does Current conform to `other' ?
		do
		end
	
	instantiation_in (type: TYPE_A written_id: INTEGER): like Current is
		do
		end

	type_i: TYPE_I is
			-- C type
		do
		end

invariant

	non_void_anchor: anchor /= Void
	is_like_current_implies_current_anchor: is_like_current
				implies anchor.is_equal ("Current")

end -- class UNEVALUATED_LIKE_TYPE
