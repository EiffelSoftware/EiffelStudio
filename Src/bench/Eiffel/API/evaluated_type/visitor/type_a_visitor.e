indexing
	description: "Visitor for BYTE_NODE objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TYPE_A_VISITOR

feature -- Status report

	is_valid: BOOLEAN is
			-- Is current valid for visiting?
		do
			Result := True
		end

	is_type_valid (a_type: TYPE_A): BOOLEAN is
			-- Is `a_type' valid for current visitor?
		require
			a_type_not_void: a_type /= Void
		do
			Result := True
		end

feature {TYPE_A} -- Helpers

	frozen safe_process (a_type: TYPE_A) is
			-- Process `a_type'. Nothing if `a_type' is Void.
		require
			is_valid: is_valid
			is_type_valid: a_type /= Void implies is_type_valid (a_type)
		do
			if a_type /= Void then
				a_type.process (Current)
			end
		end

feature {TYPE_A} -- Visitors

	process_bits_a (a_type: BITS_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_bits_symbol_a (a_type: BITS_SYMBOL_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_boolean_a (a_type: BOOLEAN_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_character_a (a_type: CHARACTER_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_cl_type_a (a_type: CL_TYPE_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_formal_a (a_type: FORMAL_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_gen_type_a (a_type: GEN_TYPE_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_integer_a (a_type: INTEGER_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_like_argument (a_type: LIKE_ARGUMENT) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_like_current (a_type: LIKE_CURRENT) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_like_feature (a_type: LIKE_FEATURE) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_manifest_integer_a (a_type: MANIFEST_INTEGER_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_manifest_natural_64_a (a_type: MANIFEST_NATURAL_64_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_named_tuple_type_a (a_type: NAMED_TUPLE_TYPE_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_native_array_type_a (a_type: NATIVE_ARRAY_TYPE_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_natural_a (a_type: NATURAL_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_none_a (a_type: NONE_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_open_type_a (a_type: OPEN_TYPE_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_pointer_a (a_type: POINTER_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_real_32_A (a_type: REAL_32_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_real_64_a (a_type: REAL_64_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_tuple_type_a (a_type: TUPLE_TYPE_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_typed_pointer_a (a_type: TYPED_POINTER_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_unevaluated_bits_symbol_a (a_type: UNEVALUATED_BITS_SYMBOL_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_unevaluated_like_type (a_type: UNEVALUATED_LIKE_TYPE) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
		end

	process_void_a (a_type: VOID_A) is
			-- Process `a_type'.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_valid: is_type_valid (a_type)
		deferred
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
end
