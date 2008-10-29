indexing
	description: "Visitor to generate generic derivation of a type"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_GENERIC_DERIVATION_TYPE_VISITOR

inherit
	TYPE_A_VISITOR

	COMPILER_EXPORTER

feature -- Basic operation

	derived_type (a_type: TYPE_A; a_context_class: CLASS_C): TYPE_A is
			-- Generic derivation for `a_type' in context `a_context_class'
		require
			a_type_attached: a_type /= Void
			a_context_class_attached: a_context_class /= Void
		do
			context := a_context_class
			a_type.process (Current)
			Result := last_type
		end

feature{NONE} -- Implementation

	context: CLASS_C
			-- Context in which type will be evaluated

	last_type: TYPE_A
			-- Last type created by Current visitor

feature {TYPE_A}

	process_bits_a (a_type: BITS_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_bits_symbol_a (a_type: BITS_SYMBOL_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_boolean_a (a_type: BOOLEAN_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_character_a (a_type: CHARACTER_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_cl_type_a (a_type: CL_TYPE_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_renamed_type_a (a_type: RENAMED_TYPE_A [TYPE_A]) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_formal_a (a_type: FORMAL_A) is
			-- Process `a_type'.
		do
			last_type := context.constraints (a_type.position).first.actual_type
		end

	process_gen_type_a (a_type: GEN_TYPE_A) is
			-- Process `a_type'.
		local
			l_type: GEN_TYPE_A
			l_derived_generics: ARRAY [TYPE_A]
			i, l_upper: INTEGER
		do
			l_type := a_type.duplicate
			create l_derived_generics.make (a_type.generics.lower, a_type.generics.upper)

			from
				i := a_type.generics.lower
				l_upper := a_type.generics.upper
			until
				i > l_upper
			loop
				a_type.generics.item (i).process (Current)
				l_derived_generics.put (last_type, i)
				i := i + 1
			end
			l_type.set_generics (l_derived_generics)
			last_type := l_type
		end

	process_integer_a (a_type: INTEGER_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_like_argument (a_type: LIKE_ARGUMENT) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_like_current (a_type: LIKE_CURRENT) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_like_feature (a_type: LIKE_FEATURE) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_manifest_integer_a (a_type: MANIFEST_INTEGER_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_manifest_natural_64_a (a_type: MANIFEST_NATURAL_64_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_named_tuple_type_a (a_type: NAMED_TUPLE_TYPE_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_native_array_type_a (a_type: NATIVE_ARRAY_TYPE_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_natural_a (a_type: NATURAL_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_none_a (a_type: NONE_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_open_type_a (a_type: OPEN_TYPE_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_pointer_a (a_type: POINTER_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_real_32_A (a_type: REAL_32_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_real_64_a (a_type: REAL_64_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_tuple_type_a (a_type: TUPLE_TYPE_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_typed_pointer_a (a_type: TYPED_POINTER_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_unevaluated_bits_symbol_a (a_type: UNEVALUATED_BITS_SYMBOL_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_unevaluated_like_type (a_type: UNEVALUATED_LIKE_TYPE) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_void_a (a_type: VOID_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

end
