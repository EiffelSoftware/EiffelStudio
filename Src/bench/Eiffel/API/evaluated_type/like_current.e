indexing

	description: 
		"Actual type like Current.";
	date: "$Date$";
	revision: "$Revision $"

class LIKE_CURRENT

inherit

	TYPE_A
		redefine
			actual_type, solved_type, has_like, instantiation_in, is_like,
			is_basic, instantiated_in, same_as, is_like_current,
			meta_type, has_associated_class
		end

feature -- Properties

	actual_type: TYPE_A;
			-- Actual type of the type `like Current' in a given class

	is_like_current: BOOLEAN is
			-- Is the current type an anchored type on Current ?
		do
			Result := True;
		end;

	is_like: BOOLEAN is
			-- Is the type an anchored one ?
		do
			Result := True;
		end;

	is_basic: BOOLEAN is
			-- Is the current actual type a basic one ?
		do
			Result := actual_type.is_basic;
		end;

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_like_current
		end;

	has_associated_class: BOOLEAN is
			-- Does Current have an associated class?
		do
			Result := evaluated_type /= Void
		end;

	associated_eclass: E_CLASS is
			-- Associated class
		do
			Result := actual_type.associated_eclass;
		end;

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
			actual_dump: STRING;
		do
			actual_dump := actual_type.dump;
			!!Result.make (15 + actual_dump.count);
			Result.append ("(like Current)");
			Result.append (actual_dump);
		end;

	append_to (st: STRUCTURED_TEXT) is
		do
			st.add_string ("(like Current) ");
			actual_type.append_to (st);
		end;

feature {COMPILER_EXPORTER} -- Primitives

	set_actual_type (a: TYPE_A) is
			-- Assign `a' to `actual_type'.
		do
			actual_type := a;
		end;

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): LIKE_CURRENT is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		do
			!!Result;
			Result.set_actual_type (feat_table.associated_class.actual_type);
		end;

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to `actual_type' ?
		do
			Result := actual_type.internal_conform_to (other, in_generics);
		end;

	instantiation_in (type: TYPE_A; written_id: CLASS_ID): LIKE_CURRENT is
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		do
			!!Result;
			Result.set_actual_type (type);
		end;

	instantiated_in (class_type: CL_TYPE_A): like Current is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		do
			Result := clone (Current);
			Result.set_actual_type (actual_type.instantiated_in (class_type));
		end;

	associated_class: CLASS_C is
			-- Associated class
		require else
			actual_type_not_void: actual_type /= Void
		do
			Result := actual_type.associated_class;
		end;

	has_like: BOOLEAN is
			-- Does the type have anchored types in its definition ?
		do
			Result := True;
		end;

	type_i: TYPE_I is
			-- Reduced type of `actual_type'
		do
			Result := actual_type.type_i;
		end;

	meta_type: TYPE_I is
			-- C type for `actual_type'
		do
			Result := actual_type.meta_type
		end;

	create_info: CREATE_CURRENT is
			-- Byte code information for entity type creation
		once
			!!Result
		end;

feature {COMPILER_EXPORTER} -- Storage information for EiffelCase

	storage_info_with_name, storage_info (classc: CLASS_C): S_BASIC_TYPE_INFO is
			-- Storage info for Current type in class `classc'
		do
			!! Result.make ("like Current")
		end;

end -- class LIKE_CURRENT
