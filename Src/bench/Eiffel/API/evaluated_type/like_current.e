indexing
	description:"Actual type like Current."
	date: "$Date$"
	revision: "$Revision $"

class
	LIKE_CURRENT

inherit
	LIKE_TYPE_A
		redefine
			is_basic, has_associated_class,
			associated_eclass, is_like_current
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
			Result := evaluated_type /= Void
		end

	associated_eclass: CLASS_C is
			-- Associated class
		do
			Result := actual_type.associated_eclass
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
			Result.append ("(like Current)")
			Result.append (actual_dump)
		end

	append_to (st: STRUCTURED_TEXT) is
		do
			st.add_string ("(like Current) ")
			actual_type.append_to (st)
		end

feature {COMPILER_EXPORTER} -- Primitives

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): LIKE_CURRENT is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		do
			!!Result
			Result.set_actual_type (feat_table.associated_class.actual_type)
		end

	instantiation_in (type: TYPE_A; written_id: CLASS_ID): LIKE_CURRENT is
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

feature {COMPILER_EXPORTER} -- Storage information for EiffelCase

	storage_info_with_name, storage_info (classc: CLASS_C): S_BASIC_TYPE_INFO is
			-- Storage info for Current type in class `classc'
		do
			!! Result.make ("like Current")
		end

end -- class LIKE_CURRENT
