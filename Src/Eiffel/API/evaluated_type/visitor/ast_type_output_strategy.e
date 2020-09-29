note
	description: "Formats TYPE_A instances using TEXT_FORMATTER."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_TYPE_OUTPUT_STRATEGY

inherit
	TYPE_A_VISITOR

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_TEXT_ITEMS
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	default_create

feature -- Initialization

	process (a_type: TYPE_A; a_text_formatter: TEXT_FORMATTER; a_class: CLASS_C; a_feature: detachable FEATURE_I)
			-- Output `a_type' into `a_text_formatter' using context of `a_class' and `a_feature'.
			-- `a_feature' is only used when resolving anchors to argument.
		require
			a_text_formatter_not_void: a_text_formatter /= Void
			a_class_not_void: a_class /= Void
		do
			text_formatter := a_text_formatter
			current_class := a_class
			current_feature := a_feature
			a_type.process (Current)
			text_formatter := Void
			current_class := Void
			current_feature := Void
		ensure
			no_state: text_formatter = Void and current_class = Void and current_feature = Void
		end

feature -- Access

	text_formatter: TEXT_FORMATTER
			-- Output formatter.

	current_class: CLASS_C
			-- Type is being viewed in this class.

	current_feature: FEATURE_I
			-- Current feature where type appears.

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
		local
			l_class: CLASS_C
		do
			process_annotations (a_type)
			if a_type.has_expanded_mark then
				text_formatter.process_keyword_text (ti_expanded_keyword, Void)
				text_formatter.add_space
			elseif a_type.has_reference_mark then
				text_formatter.process_keyword_text (ti_reference_keyword, Void)
				text_formatter.add_space
			end
			l_class := a_type.base_class
			if l_class /= Void  then
				l_class.append_name (text_formatter)
			else
					-- Very rare case when a type refers to a class that has been removed
					-- from the universe.
				text_formatter.add ("Class_" + a_type.class_id.out + "_does_not_exist")
			end
		end

	process_formal_a (a_type: FORMAL_A)
			-- Process `a_type'.
		do
			process_annotations (a_type)
			if current_feature /= Void and then current_feature.has_replicated_ast then
					-- Current feature may be Void.
					-- If not we check if the feature has a replicated AST, in which case
					-- we query the written class for type information.
				text_formatter.process_generic_text (current_feature.written_class.generics.i_th (a_type.position).name.name_8.as_upper)
			else
				text_formatter.process_generic_text (current_class.generics.i_th (a_type.position).name.name_8.as_upper)
			end
		end

	process_gen_type_a (a_type: GEN_TYPE_A)
			-- Process `a_type'.
		local
			i, count: INTEGER
			tuple_index: INTEGER
			is_comma_needed: BOOLEAN
			t: TYPE_A
		do
			process_cl_type_a (a_type)
				-- TUPLE may have zero generic parameters
			count := a_type.generics.count
				-- A type may also have a single tuple parameter without any actual generics.
			tuple_index := a_type.base_class.tuple_parameter_index
			if count > 0 and then
				(tuple_index /= 1 or else count > 1 or else not attached {TUPLE_TYPE_A} a_type.generics [1] as tt or else (attached tt.generics as g and then not g.is_empty))
			then
				text_formatter.add_space
				text_formatter.process_symbol_text (ti_l_bracket)
				from
					i := 1
				until
					i > count
				loop
					if is_comma_needed then
						text_formatter.process_symbol_text (ti_comma)
						text_formatter.add_space
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
									text_formatter.process_symbol_text (ti_comma)
									text_formatter.add_space
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
				text_formatter.process_symbol_text (ti_r_bracket)
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
			process_annotations (a_type)
			text_formatter.process_keyword_text (ti_like_keyword, Void)
			text_formatter.add_space
			if current_feature /= Void and then current_feature.argument_count <= a_type.position then
				text_formatter.process_local_text (Void, current_feature.arguments.item_name_32 (a_type.position))
			else
				text_formatter.add (ti_argument_index)
				text_formatter.add_int (a_type.position)
			end
		end

	process_like_current (a_type: LIKE_CURRENT)
			-- Process `a_type'.
		do
			process_annotations (a_type)
			text_formatter.process_keyword_text (ti_like_keyword, Void)
			text_formatter.add_space
			text_formatter.process_keyword_text (ti_current, Void)
		end

	process_like_feature (a_type: LIKE_FEATURE)
			-- Process `a_type'.
		local
			l_feat: E_FEATURE
		do
			process_annotations (a_type)
			text_formatter.process_keyword_text (ti_like_keyword, Void)
			text_formatter.add_space
			l_feat := current_class.feature_with_rout_id (a_type.routine_id)
			check
				l_feat_not_void: l_feat /= Void
			end
			l_feat.append_name (text_formatter)
		end

	process_local (a_type: LOCAL_TYPE_A)
			-- <Precursor>
		do
			text_formatter.add (ti_local_keyword)
			text_formatter.add_char ({CHARACTER_32} '#')
			text_formatter.add_int (a_type.position)
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
		local
			i, count: INTEGER
		do
			process_cl_type_a (a_type)
				-- TUPLE may have zero generic parameters
			count := a_type.generics.count
			if count > 0 then
				text_formatter.add_space
				text_formatter.process_symbol_text (ti_l_bracket)
				from
					i := 1
				until
					i > count
				loop
					text_formatter.process_local_text (Void, a_type.label_name (i))
					text_formatter.process_symbol_text (ti_colon)
					text_formatter.add_space
					a_type.generics.i_th (i).process (Current)
					if i /= count then
						text_formatter.process_symbol_text (ti_semi_colon)
						text_formatter.add_space
					end
					i := i + 1
				end
				text_formatter.process_symbol_text (ti_r_bracket)
			end
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
			process_annotations (a_type)
			text_formatter.add (ti_none_class)
		end

	process_pointer_a (a_type: POINTER_A)
			-- Process `a_type'.
		do
			process_cl_type_a (a_type)
		end

	process_qualified_anchored_type_a (a_type: QUALIFIED_ANCHORED_TYPE_A)
			-- Process `a_type'.
		local
			c: CLASS_C
			n: INTEGER_32
			i: INTEGER
		do
			process_annotations (a_type)
			if a_type.qualifier.is_like then
				a_type.qualifier.process (Current)
			else
				text_formatter.process_keyword_text (ti_like_keyword, Void)
				text_formatter.add_space
				text_formatter.process_symbol_text (ti_l_curly)
				a_type.qualifier.process (Current)
				text_formatter.process_symbol_text (ti_r_curly)
			end
			from
				c := a_type.qualifier.base_class
			until
				i >= a_type.chain.count
			loop
				text_formatter.process_symbol_text (ti_dot)
				n := a_type.chain [i]
				if c /= Void and then attached c.feature_with_name_id (n) as f then
					f.append_name (text_formatter)
					c := f.type.base_class
				else
					text_formatter.process_feature_name_text (names_heap.item_32 (n), c)
				end
				i := i + 1
			end
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
			process_annotations (a_type)
			text_formatter.process_keyword_text (ti_like_keyword, Void)
			text_formatter.add_space
			text_formatter.process_local_text (Void, a_type.anchor)
		end

	process_unevaluated_qualified_anchored_type (a_type: UNEVALUATED_QUALIFIED_ANCHORED_TYPE)
			-- Process `a_type'.
		local
			i, nb: INTEGER
		do
			process_annotations (a_type)
			if a_type.qualifier.is_like then
				a_type.qualifier.process (Current)
			else
				text_formatter.process_keyword_text (ti_like_keyword, Void)
				text_formatter.add_space
				text_formatter.process_symbol_text (ti_l_curly)
				a_type.qualifier.process (Current)
				text_formatter.process_symbol_text (ti_r_curly)
			end
			from
				i := 0
				nb := a_type.chain.count
			until
				i = nb
			loop
				text_formatter.process_symbol_text (ti_dot)
				text_formatter.process_local_text (Void, names_heap.item_32 (a_type.chain.item (i)))
				i := i + 1
			end
		end

	process_unknown (t: UNKNOWN_TYPE_A)
			-- <Precursor>
		do
			text_formatter.process_symbol_text (ti_question)
		end

	process_void_a (a_type: VOID_A)
			-- Process `a_type'.
		do
			text_formatter.process_keyword_text (ti_void, Void)
		end

feature {NONE} -- Generic visitors

	process_annotations (t: TYPE_A)
			-- Output marks leading marks of `t'.
		require
			t_attached: attached t
		do
			if t.has_frozen_mark then
				text_formatter.process_keyword_text (ti_frozen_keyword, Void)
				text_formatter.add_space
			elseif t.has_variant_mark then
				text_formatter.process_keyword_text (ti_variant_keyword, Void)
				text_formatter.add_space
			end
			if t.has_attached_mark then
				text_formatter.process_keyword_text (ti_attached_keyword, Void)
				text_formatter.add_space
			elseif t.has_detachable_mark then
				text_formatter.process_keyword_text (ti_detachable_keyword, Void)
				text_formatter.add_space
			end
			if t.has_separate_mark then
				text_formatter.process_keyword_text (ti_separate_keyword, Void)
				text_formatter.add_space
			end
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
