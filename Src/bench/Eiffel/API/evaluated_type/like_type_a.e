indexing
	description: "Representation of an anchored type"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LIKE_TYPE_A

inherit
	TYPE_A
		undefine
			same_as, solved_type, instantiation_in
		redefine
			actual_type, has_like, is_like,
			is_basic, instantiated_in, meta_type,
			has_associated_class
		end

	SHARED_LIKE_CONTROLER

feature -- Properties

	actual_type: TYPE_A
			-- Actual type of the anchored type in a given class

	is_like: BOOLEAN is True
			-- Is the type anchored one ?

	has_like: BOOLEAN is True
			-- Does the type have anchored type in its definition ?

	rout_id: INTEGER

	set_rout_id (rid: like rout_id) is
			-- Set `set_rout_id' to `rid'.
		do
			rout_id := rid
		end

	class_id: INTEGER
			-- Class ID of the class where the anchor is referenced


	is_basic: BOOLEAN is
			-- Is the current actual type a basic one ?
		do
			Result := actual_type.is_basic
		end

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		deferred
		end

	has_associated_class: BOOLEAN is
			-- Does Current have an associated class?
		do
			Result := actual_type /= Void and then
				actual_type.has_associated_class
		end

	associated_class: CLASS_C is
			-- Associated class
		do
			Result := actual_type.associated_class
		end

feature -- Primitives

	set_actual_type (a: TYPE_A) is
			-- Assign `a' to `actual_type'.
		do
			actual_type := a
		end

	solved_type (feat_table: FEATURE_TABLE f: FEATURE_I): like Current is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table
		deferred
		end

	instantiation_in (type: TYPE_A written_id: INTEGER): like Current is
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		deferred
		end

	instantiated_in (class_type: CL_TYPE_A): like Current is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		do
			Result := clone (Current)
			Result.set_actual_type (actual_type.instantiated_in (class_type))
		end

	internal_conform_to (other: TYPE_A in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to `actual_type' ?
		do
			Result := actual_type.internal_conform_to (other.actual_type, in_generics)
		end

	type_i: TYPE_I is
			-- Reduced type of `actual_type'
		local
			cl_type : CL_TYPE_I
		do
			Result := actual_type.type_i
			cl_type ?= Result

			if cl_type /= Void then
				-- Remember that it's an anchored type 
				cl_type.set_cr_info (create_info)
			end
		end

	meta_type: TYPE_I is
			-- C type for `actual_type'
		do
			Result := actual_type.meta_type
		end

end -- class LIKE_TYPE_A
