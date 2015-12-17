note
	description: "Process a TYPE_A for formatting in a TEXT_FORMATTER_DECORATOR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_A_FORMATTER

inherit
	TYPE_A_VISITOR
		redefine
			is_valid
		end

	SHARED_TEXT_ITEMS
		export
			{NONE} all
		end

feature -- Formatting

	format (a_formatter: TEXT_FORMATTER_DECORATOR; a_type: TYPE_A)
			-- Format `a_type' using `a_formatter'.
		require
			a_formatter_not_void: a_formatter /= Void
			a_type_not_void: a_type /= Void
		do
			ctxt := a_formatter
			a_type.process (Current)
			ctxt := Void
		end

feature -- Status report

	is_valid: BOOLEAN
			-- Is current object valid prior to a call to one of the process routines?
		do
			Result := ctxt /= Void
		end

feature {NONE} -- Implementation

	ctxt: TEXT_FORMATTER_DECORATOR
			-- Formatter object.

feature {TYPE_A} -- Visitors

	process_boolean_a (a_type: BOOLEAN_A)
			-- Process `a_type'.
		do
			process_cl_type_a (a_type)
		end

	process_character_a (a_type: CHARACTER_A)
			-- Process `a_type'.
		do
			process_cl_type_a (a_type)
		end

	process_cl_type_a (a_type: CL_TYPE_A)
			-- Process `a_type'.
		do
			ctxt.put_classi (a_type.base_class.lace_class)
		end

	process_formal_a (a_type: FORMAL_A)
			-- Process `a_type'.
		do
			ctxt.process_generic_text (ctxt.formal_name (a_type.position))
		end

	process_gen_type_a (a_type: GEN_TYPE_A)
			-- Process `a_type'.
		local
			i, count: INTEGER
			tuple_index: INTEGER
			is_comma_needed: BOOLEAN
			t: TYPE_A
		do
			ctxt.put_classi (a_type.base_class.lace_class)
				-- TUPLE may have zero generic parameters.
			count := a_type.generics.count
				-- A type may also have a single tuple parameter without any actual generics.
			tuple_index := a_type.base_class.tuple_parameter_index
			if
				count > 0 and then
				(tuple_index /= 1 or else
				count > 1 or else
				not attached {TUPLE_TYPE_A} a_type.generics [1] as tt or else
				(attached tt.generics as g and then not g.is_empty))
			then
				ctxt.put_space
				ctxt.process_symbol_text (ti_L_bracket)
				from
					i := 1
				until
					i > count
				loop
					if is_comma_needed then
						ctxt.process_symbol_text (ti_Comma)
						ctxt.put_space
					end
					is_comma_needed := True
					t := a_type.generics [i]
					if tuple_index = i then
							-- Fold the tuple parameter.
						if not t.is_tuple then
								-- The actual generic is not a tuple.
								-- This could be because a type formatter did not wrap the actual generic into a tuple.
								-- Preserve the actual parameter as is.
							t.process (Current)
						elseif not attached t.generics as g or else g.is_empty then
								-- Omit the parameter altogether.
							is_comma_needed := False
						elseif g.count = 1 and then g [1].is_tuple then
								-- Preserve tuple actual parameter for the cases like "A [TUPLE [TUPLE [...]]]".
							t.process (Current)
						else
								-- Remove tuple wrapping.
								-- If there is a parameter before tuple parameter, a comma is already printed.
							is_comma_needed := False
							across
								g as gg
							loop
								if is_comma_needed then
									ctxt.process_symbol_text (ti_Comma)
									ctxt.put_space
								end
								is_comma_needed := True
								gg.item.process (Current)
							end
						end
					else
							-- Apply general formatting rules.
						t.process (Current)
					end
					i := i + 1
				end
				ctxt.process_symbol_text (ti_R_bracket)
			end
		end

	process_integer_a (a_type: INTEGER_A)
			-- Process `a_type'.
		do
			process_cl_type_a (a_type)
		end

	process_like_argument (a_type: LIKE_ARGUMENT)
			-- Process `a_type'.
		do
			ctxt.process_string_text (a_type.dump, Void)
		end

	process_like_current (a_type: LIKE_CURRENT)
			-- Process `a_type'.
		do
			ctxt.process_string_text (a_type.dump, Void)
		end

	process_like_feature (a_type: LIKE_FEATURE)
			-- Process `a_type'.
		do
			ctxt.process_string_text (a_type.dump, Void)
		end

	process_local (a_type: LOCAL_TYPE_A)
			-- <Precursor>
		do
			ctxt.process_string_text (a_type.dump, Void)
		end

	process_manifest_integer_a (a_type: MANIFEST_INTEGER_A)
			-- Process `a_type'.
		do
			process_cl_type_a (a_type)
		end

	process_manifest_natural_64_a (a_type: MANIFEST_NATURAL_64_A)
			-- Process `a_type'.
		do
			process_cl_type_a (a_type)
		end

	process_manifest_real_a (a_type: MANIFEST_REAL_A)
			-- Process `a_type'.
		do
			process_cl_type_a (a_type)
		end

	process_named_tuple_type_a (a_type: NAMED_TUPLE_TYPE_A)
			-- Process `a_type'.
		do
			process_gen_type_a (a_type)
		end

	process_native_array_type_a (a_type: NATIVE_ARRAY_TYPE_A)
			-- Process `a_type'.
		do
			process_gen_type_a (a_type)
		end

	process_natural_a (a_type: NATURAL_A)
			-- Process `a_type'.
		do
			process_cl_type_a (a_type)
		end

	process_none_a (a_type: NONE_A)
			-- Process `a_type'.
		do
			ctxt.process_string_text (a_type.dump, Void)
		end

	process_pointer_a (a_type: POINTER_A)
			-- Process `a_type'.
		do
			process_cl_type_a (a_type)
		end

	process_qualified_anchored_type_a (a_type: QUALIFIED_ANCHORED_TYPE_A)
			-- Process `a_type'.
		do
			ctxt.process_string_text (a_type.dump, Void)
		end

	process_real_a (a_type: REAL_A)
			-- Process `a_type'.
		do
			process_cl_type_a (a_type)
		end

	process_tuple_type_a (a_type: TUPLE_TYPE_A)
			-- Process `a_type'.
		do
			process_gen_type_a (a_type)
		end

	process_typed_pointer_a (a_type: TYPED_POINTER_A)
			-- Process `a_type'.
		do
			process_gen_type_a (a_type)
		end

	process_unevaluated_like_type (a_type: UNEVALUATED_LIKE_TYPE)
			-- Process `a_type'.
		do
			ctxt.process_string_text (a_type.dump, Void)
		end

	process_unevaluated_qualified_anchored_type (a_type: UNEVALUATED_QUALIFIED_ANCHORED_TYPE)
			-- Process `a_type'.
		do
			ctxt.process_string_text (a_type.dump, Void)
		end

	process_void_a (a_type: VOID_A)
			-- Process `a_type'.
		do
			ctxt.process_string_text (a_type.dump, Void)
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
