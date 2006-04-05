indexing
	description: "Actual type for typed pointer type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			has_expanded, format, dump, duplicate,
			is_equivalent, instantiation_of, same_as, instantiation_in,
			is_full_named_type
		redefine
			is_typed_pointer, type_i, associated_class, process
		end

	GEN_TYPE_A
		undefine
			meta_type, is_basic, feature_type, is_valid
		redefine
			is_typed_pointer, type_i, associated_class, process
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

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_typed_pointer_a (Current)
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class TYPED_POINTER_A
