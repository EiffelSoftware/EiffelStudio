indexing
	description:"Actual type like Current."
	date: "$Date$"
	revision: "$Revision $"

class
	LIKE_CURRENT

inherit
	LIKE_TYPE_A
		redefine
			has_associated_class, is_like_current
		end

feature -- Properties

	is_like_current: BOOLEAN is True
			-- Is the current type an anchored type on Current ?

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
			create Result.make (15 + actual_dump.count)
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
			create Result
			Result.set_actual_type (feat_table.associated_class.actual_type)
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): LIKE_CURRENT is
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		do
			create Result
				-- Special cases for calls on a target which is a manifest integer
				-- that might be compatible with _8 or _16. The returned
				-- `actual_type' should not take into consideration the
				-- `compatibility_size' of `type', just its intrinsic type.
				-- Because manifest integers are by default 32 bits, when
				-- you apply a routine whose result is of type `like Current'
				-- then it should really be a 32 bits integer. Note that in the
				-- past we were keeping the size of the manifest integers and the
				-- following code was accepted:
				-- i16: INTEGER_16
				-- i8: INTEGER_8
				-- i16 := 0x00FF & i8
				-- Now the code is rejected because target expect an INTEGER_16
				-- and not an INTEGER, therefore the code needs to be fixed with:
				-- i16 := (0x00FF).to_integer_16 & i8
				-- or
				-- i16 := (0x00FF & i8).to_integer_16
			Result.set_actual_type (type.intrinsic_type)
		end

	create_info: CREATE_CURRENT is
			-- Byte code information for entity type creation
		once
			create Result
		end

end -- class LIKE_CURRENT
