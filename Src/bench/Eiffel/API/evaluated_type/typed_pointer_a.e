indexing
	description: "Actual type for typed pointer type."
	date: "$Date$"
	revision: "$Revision$"

class TYPED_POINTER_A

inherit
	BASIC_A
		rename
			make as cl_make
		undefine
			hash_code, generics, has_like, parent_type,
			deep_actual_type, ext_append_to, conform_to,
			has_formal_generic, is_loose, valid_generic, actual_argument_type,
			instantiated_in, good_generics, error_generics, check_constraints,
			expanded_deferred, valid_expanded_creation, update_dependance,
			solved_type, has_expanded, format, dump, duplicate,
			is_equivalent, instantiation_of, same_as, instantiation_in,
			is_full_named_type
		redefine
			is_typed_pointer, type_i, associated_class
		end
		
	GEN_TYPE_A
		undefine
			meta_type, is_basic, feature_type, is_valid
		redefine
			is_typed_pointer, type_i, associated_class
		end

create
	make, make_typed

feature {NONE} -- Initialization

	make_typed (a_type: TYPE_A) is
			-- Set `pointed_type' with `a_type'.
		require
			a_type_not_void: a_type /= Void
		do
			create generics.make (1, 1)
			generics.put (a_type, 1)
			cl_make (associated_class.class_id)
		ensure
			pointed_type_set: pointed_type = a_type
		end
		
feature -- Property

	is_typed_pointer: BOOLEAN is True
			-- Is current type a typed pointer type?

	associated_class: CLASS_C is
			-- Class POINTER
		once
			Result := System.typed_pointer_class.compiled_class
		end

	pointed_type: TYPE_A is
			-- Type pointed by current if any.
		do
			Result := generics.item (1)
		end

feature {COMPILER_EXPORTER}

	type_i: TYPED_POINTER_I is
			-- Pointer C type
		do
			create Result.make (class_id, pointed_type)
		end

end -- class TYPED_POINTER_A
