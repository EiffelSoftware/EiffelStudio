indexing
	description: "Perform resolution of TYPE_AS into TYPE_A without validity checking."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_TYPE_A_GENERATOR

inherit
	AST_NULL_VISITOR
		redefine
			process_like_id_as, process_like_cur_as,
			process_formal_as, process_class_type_as, process_none_type_as,
			process_bits_as, process_bits_symbol_as,
			process_named_tuple_type_as, process_type_dec_as
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_TYPES
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

feature -- Status report

	evaluate_type_if_possible (a_type: TYPE_AS; a_context_class: CLASS_C): TYPE_A is
			-- Given a TYPE_AS node, try to find its equivalent CL_TYPE_A node.
		require
			a_type_not_void: a_type /= Void
			a_context_class_not_void: a_context_class /= Void
		do
			is_failure_enabled := True
			current_class := a_context_class
			a_type.process (Current)
			Result := last_type
			current_class := Void
			last_type := Void
		end

	evaluate_type (a_type: TYPE_AS; a_context_class: CLASS_C): TYPE_A is
			-- Given a TYPE_AS node, find its equivalent TYPE_A node.
		require
			a_type_not_void: a_type /= Void
			a_context_class_not_void: a_context_class /= Void
			a_type_is_in_universe: True -- All class identifiers of `a_type' are in the universe.
		do
			is_failure_enabled := False
			current_class := a_context_class
			a_type.process (Current)
			Result := last_type
			current_class := Void
			last_type := Void
		ensure
			evaluate_type_not_void: Result /= Void
		end

	evaluate_class_type (a_class_type: CLASS_TYPE_AS; a_context_class: CLASS_C): CL_TYPE_A is
			-- Given a CLASS_TYPE_AS node, find its equivalent CL_TYPE_A node.
		require
			a_class_type_not_void: a_class_type /= Void
			a_context_class_not_void: a_context_class /= Void
			a_type_is_in_universe: True -- All class identifiers of `a_class_type' are in the universe.
		do
			is_failure_enabled := False
			current_class := a_context_class
			a_class_type.process (Current)
			Result ?= last_type
			current_class := Void
			last_type := Void
		ensure
			evaluate_type_not_void: Result /= Void
		end

feature {NONE} -- Implementation: Access

	last_type: TYPE_A
			-- Last resolved type of checker

	current_class: CLASS_C
			-- Current class where current type is resolved

	is_failure_enabled: BOOLEAN
			-- Is failure authorized?

feature {NONE} -- Visitor implementation

	process_like_id_as (l_as: LIKE_ID_AS) is
		local
			t: UNEVALUATED_LIKE_TYPE
		do
			create t.make (l_as.anchor.name)
			if l_as.attachment_mark /= Void then
				if l_as.attachment_mark.is_bang then
					t.set_attached_mark
				else
					t.set_detachable_mark
				end
			end
			last_type := t
		end

	process_like_cur_as (l_as: LIKE_CUR_AS) is
		local
			l_cur: LIKE_CURRENT
		do
			create l_cur
			l_cur.set_actual_type (current_class.actual_type)
			if l_as.attachment_mark /= Void then
				if l_as.attachment_mark.is_bang then
					l_cur.set_attached_mark
				else
					l_cur.set_detachable_mark
				end
			end
			last_type := l_cur
		end

	process_formal_as (l_as: FORMAL_AS) is
		do
			create {FORMAL_A} last_type.make (l_as.is_reference, l_as.is_expanded, l_as.position)
			if l_as.attachment_mark /= Void then
				if l_as.attachment_mark.is_bang then
					last_type.set_attached_mark
					check last_type.is_attached end
				else
					last_type.set_detachable_mark
				end
			elseif current_class.lace_class.is_attached_by_default then
					-- It's not clear yet whether ECMA-367 will mark such types as attached or not.
				-- last_type.set_is_attached
			end
		end

	process_class_type_as (l_as: CLASS_TYPE_AS) is
		local
			l_class_i: CLASS_I
			l_class_c: CLASS_C
			l_actual_generic: ARRAY [TYPE_A]
			i, count: INTEGER
			l_has_error: BOOLEAN
			l_type: CL_TYPE_A
		do
				-- Lookup class in universe, it should be present.
			l_class_i := universe.class_named (l_as.class_name.name, current_class.group)
			if l_class_i /= Void and then l_class_i.is_compiled then
				l_class_c := l_class_i.compiled_class
				if l_as.generics /= Void then
					from
						i := 1
						count := l_as.generics.count
						create l_actual_generic.make (1, count)
						l_type := l_class_c.partial_actual_type (l_actual_generic, l_as.is_expanded,
							l_as.is_separate)
					until
						i > count or l_has_error
					loop
						l_as.generics.i_th (i).process (Current)
						l_has_error := last_type = Void
						l_actual_generic.put (last_type, i)
						i := i + 1
					end
					if l_has_error then
						check failure_enabled: is_failure_enabled end
						last_type := Void
					else
						last_type := l_type
					end
				else
					l_type := l_class_c.partial_actual_type (Void, l_as.is_expanded, l_as.is_separate)
					last_type := l_type
				end
				if l_type /= Void then
					if l_as.attachment_mark /= Void then
						if l_as.attachment_mark.is_bang then
							l_type.set_attached_mark
							check l_type.is_attached end
						else
							l_type.set_detachable_mark
						end
					elseif current_class.lace_class.is_attached_by_default then
						l_type.set_is_attached
					end
				end
			else
				check failure_enabled: is_failure_enabled end
				last_type := Void
			end
		end

	process_named_tuple_type_as (l_as: NAMED_TUPLE_TYPE_AS) is
		local
			l_class_i: CLASS_I
			l_class_c: CLASS_C
			l_actual_generic: ARRAY [TYPE_A]
			i, g, count: INTEGER
			l_type: NAMED_TUPLE_TYPE_A
			l_generics: EIFFEL_LIST [TYPE_DEC_AS]
			l_names: SPECIAL [INTEGER]
			l_id_list: CONSTRUCT_LIST [INTEGER]
			l_has_error: BOOLEAN
		do
				-- Lookup class in universe, it should be present.
			l_class_i := System.tuple_class
			if l_class_i /= Void and then l_class_i.is_compiled then
				l_class_c := l_class_i.compiled_class
				l_generics := l_as.generics
				from
					i := 1
					g := 1
					count := l_as.generic_count
					create l_actual_generic.make (1, count)
					create l_names.make (count)
					create l_type.make (l_class_c.class_id, l_actual_generic, l_names)
				until
					i > count or l_has_error
				loop
					l_generics.i_th (g).process (Current)
					l_has_error := last_type = Void
					l_id_list := l_generics.i_th (g).id_list
					from
						l_id_list.start
					until
						l_id_list.after
					loop
						l_actual_generic.put (last_type, i)
						l_names.put (l_id_list.item, i - 1)
						i := i + 1
						l_id_list.forth
					end
					g := g + 1
				end
				if l_has_error then
					check failure_enabled: is_failure_enabled end
					last_type := Void
				else
					last_type := l_type
				end
			else
				check failure_enabled: is_failure_enabled end
				last_type := Void
			end
		end

	process_type_dec_as (l_as: TYPE_DEC_AS) is
		do
			l_as.type.process (Current)
		end

	process_none_type_as (l_as: NONE_TYPE_AS) is
		do
			last_type := none_type
		end

	process_bits_as (l_as: BITS_AS) is
		do
			create {BITS_A} last_type.make (l_as.bits_value.integer_32_value)
		end

	process_bits_symbol_as (l_as: BITS_SYMBOL_AS) is
		do
			create {UNEVALUATED_BITS_SYMBOL_A} last_type.make (l_as.bits_symbol.name)
		end

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
