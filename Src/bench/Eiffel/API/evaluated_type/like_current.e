indexing
	description:"Actual type like Current."
	date: "$Date$"
	revision: "$Revision $"

class
	LIKE_CURRENT

inherit
	LIKE_TYPE_A
		redefine
			is_basic, has_associated_class, is_like_current
		end

feature -- Properties

	is_like_current: BOOLEAN is True
			-- Is the current type an anchored type on Current ?

	is_basic: BOOLEAN is
			-- Is the current actual type a basic one ?
		do
			Result := actual_type.is_basic
		end

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_like_current
		end

	has_associated_class: BOOLEAN is
			-- Does Current have an associated class?
		do
			Result := actual_type /= Void
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (actual_type, other.actual_type)
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		local
			actual_dump: STRING
		do
			actual_dump := actual_type.dump
			!!Result.make (15 + actual_dump.count)
			Result.append ("[like Current] ")
			Result.append (actual_dump)
		end

	ext_append_to (st: STRUCTURED_TEXT; f: E_FEATURE) is
		do
			st.add (ti_L_bracket)
			st.add (ti_Like_keyword)
			st.add_space
			st.add (ti_Current)
			st.add (ti_R_bracket)
			st.add_space
			actual_type.ext_append_to (st, f)
		end

feature {COMPILER_EXPORTER} -- Primitives

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): LIKE_CURRENT is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		do
			!!Result
			Result.set_actual_type (feat_table.associated_class.actual_type)
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): LIKE_CURRENT is
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		do
			!!Result
			Result.set_actual_type (type)
		end

	create_info: CREATE_CURRENT is
			-- Byte code information for entity type creation
		once
			!!Result
		end

end -- class LIKE_CURRENT
