indexing
	description: "Actual type for boolean type."
	date: "$Date$"
	revision: "$Revision $"

class BOOLEAN_A

inherit
	BASIC_A
		redefine
			is_boolean, type_i, associated_class, same_as,
			internal_conform_to
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

	associated_class: CLASS_C is
			-- Class BOOLEAN
		once
			Result := System.boolean_class.compiled_class
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
		do
			create Result
		end

end -- class BOOLEAN_A
