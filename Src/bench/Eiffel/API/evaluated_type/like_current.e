indexing
	description:"Actual type like Current."
	date: "$Date$"
	revision: "$Revision $"

class
	LIKE_CURRENT

inherit
	LIKE_TYPE_A
		redefine
			actual_type, associated_class, conform_to, conformance_type, convert_to,
			generics, has_associated_class, instantiated_in,
			is_basic, is_expanded, is_like_current, is_none, is_reference,
			meta_type, set_actual_type, type_i
		end

feature -- Properties

	actual_type: LIKE_CURRENT
			-- Actual type of the anchored type in a given class

	conformance_type: TYPE_A
			-- Type of the anchored type as specified in `set_actual_type'

	is_like_current: BOOLEAN is True
			-- Is the current type an anchored type on Current ?

	is_expanded: BOOLEAN is
			-- Is type expanded?
		do
			if conformance_type /= Void then
				Result := conformance_type.is_expanded
			end
		end

	is_reference: BOOLEAN is
			-- Is type reference?
		do
			if conformance_type /= Void then
				Result := conformance_type.is_reference
			end
		end

	is_none: BOOLEAN is False
			-- Is current actual type NONE?

	is_basic: BOOLEAN is False
			-- Is the current actual type a basic one?

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_like_current
		end

	has_associated_class: BOOLEAN is
			-- Does Current have an associated class?
		do
			Result :=
				conformance_type /= Void and then
				conformance_type.has_associated_class
		end

	associated_class: CLASS_C is
			-- Associated class
		do
			Result := conformance_type.associated_class
		end

	generics: ARRAY [TYPE_A] is
			-- Actual generic types
		do
			if conformance_type /= Void then
				Result := conformance_type.generics
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := same_as (other)
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		local
			actual_dump: STRING
		do
			actual_dump := conformance_type.dump
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
			conformance_type.ext_append_to (st, f)
		end

feature {COMPILER_EXPORTER} -- Primitives

	set_actual_type (a: TYPE_A) is
			-- Assign `a' to `original_actual_type'.
		do
			conformance_type := a
			actual_type := Current
		end

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): LIKE_CURRENT is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		do
			create Result
			Result.set_actual_type (feat_table.associated_class.actual_type)
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): TYPE_A is
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		do
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
			Result := type.intrinsic_type
		end

	instantiated_in (class_type: TYPE_A): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		do
			Result := class_type
		end

	create_info: CREATE_CURRENT is
			-- Byte code information for entity type creation
		once
			create Result
		end

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does `Current' conform to `other'?
		do
			Result := other.is_like_current or else conformance_type.conform_to (other.conformance_type)
		end

	convert_to (a_context_class: CLASS_C; a_target_type: TYPE_A): BOOLEAN is
			-- Does current convert to `a_target_type' in `a_context_class'?
			-- Update `last_conversion_info' of AST_CONTEXT.
		do
			Result := conformance_type.convert_to (a_context_class, a_target_type)
		end

	type_i: TYPE_I is
			-- C type.
		local
			cl_type : CL_TYPE_I
		do
			Result := conformance_type.type_i
			cl_type ?= Result

			if cl_type /= Void and then not cl_type.is_expanded then
					-- Remember that it's an anchored type, not needed
					-- when handling expanded types.
				cl_type.set_cr_info (create_info)
			end
		end

	meta_type: TYPE_I is
			-- Meta type.
		do
			Result := conformance_type.meta_type
		end

end
