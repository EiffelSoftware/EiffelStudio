indexing
	description: "Actual type for simple types."
	date: "$Date$"
	revision: "$Revision $"

deferred class
	BASIC_A

inherit
	CL_TYPE_A	
		undefine
			type_i
		redefine
			feature_type, instantiation_in, instantiation_of,
			meta_type, is_basic,
			good_generics, is_valid, error_generics,
			is_equivalent, reference_actual_type
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Access

	is_basic: BOOLEAN is True
			-- Is the current actual type a basic one ?

	is_valid: BOOLEAN is True
			-- The associated class is still in the system

	reference_actual_type: CL_TYPE_A is
			-- `actual_type' if not `is_expanded'.
			-- Otherwise associated reference of `actual type'
		do
			create Result.make (class_id)
		end

feature {COMPILER_EXPORTER}

	feature_type (f: FEATURE_I): TYPE_A is
			-- Type of the feature `f' in the context of Current
		do
			Result ?= f.type
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): TYPE_A is
			-- Instantiated type in the context of `type'
		do
			Result := Current
		end

	instantiation_of (type: TYPE; a_class_id: INTEGER): TYPE_A is
			-- Insatiation of `type' in s simple type
		do
			Result := type.actual_type
		end

	meta_type: BASIC_I is
			-- Associated meta type
		do
			Result := type_i
		end

	type_i: BASIC_I is
			-- Instantiated type.
			--| Return type is redefined that's why we need
			--| this declaration.
		deferred
		end
		
	good_generics: BOOLEAN is
			-- Has the current type the right number of generic types ?
		do
			Result := True
		end

	error_generics: VTUG is
		do
		end
		
invariant
	is_basic: is_basic
	is_expanded: is_expanded

end -- class BASIC_A
