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
			meta_type, is_basic, internal_conform_to,
			good_generics, is_valid, error_generics,
			is_equivalent
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

feature {COMPILER_EXPORTER}

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		local
			other_class: CLASS_C
		do
			if other.is_none then
				Result := False
			else
				other_class := other.actual_type.associated_class
					-- Note that Void type has no associated class
				if other_class /= Void then
					Result :=  (not other.is_true_expanded)
							and then associated_class.conform_to (other_class)
				end
			end
		end

	feature_type (f: FEATURE_I): TYPE_A is
			-- Type of the feature `f' in the context of Current
		do
			Result ?= f.type
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): like Current is
			-- Instantiated type in the context of `type'
		do
			Result := Current
		end

	instantiation_of (type: TYPE; a_class_id: INTEGER): TYPE_A is
			-- Insatiation of `type' in s simple type
		do
			Result := type.actual_type
		end

	type_i: BASIC_I is
			-- Instantiated type
		deferred
		end

	meta_type: BASIC_I is
			-- Associated meta type
		do
			Result := type_i
		end

	good_generics: BOOLEAN is
			-- Has the current type the right number of generic types ?
		do
			Result := True
		end

	error_generics: VTUG is
		do
		end

end -- class BASIC_A
