indexing
	description: "Actual type for boolean type."
	date: "$Date$"
	revision: "$Revision $"

class BOOLEAN_A

inherit
	BASIC_A
		redefine
			is_boolean, type_i, associated_class, same_as,
			internal_conform_to, associated_eclass
		end

feature -- Property

	is_boolean: BOOLEAN is True
			-- Is the current type a boolean type ?

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_boolean
		end

	associated_eclass: CLASS_C is
			-- Associated eiffel class
		once
			Result := Eiffel_system.boolean_class.compiled_class
		end

feature {COMPILER_EXPORTER}

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		do
			if in_generics then
				Result := other.is_boolean
			else
				Result := {BASIC_A} precursor (other, False)
			end
		end

	type_i: BOOLEAN_I is
			-- C type
		once
			Result := Boolean_c_type
		end

	associated_class: CLASS_C is
			-- Class BOOLEAN
		require else
			System.boolean_class.compiled
		once
			Result := System.boolean_class.compiled_class
		end

end -- class BOOLEAN_A
