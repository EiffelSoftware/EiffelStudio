note
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
			process_formal_as, process_class_type_as,
			process_generic_class_type_as, process_none_type_as,
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

	evaluate_type_if_possible (a_type: TYPE_AS; a_context_class: CLASS_C): TYPE_A
			-- Given a TYPE_AS node, try to find its equivalent CL_TYPE_A node.
		require
			a_type_not_void: a_type /= Void
			a_context_class_not_void: a_context_class /= Void
		local
			old_current_class: like current_class
			old_is_failure_enabled: like is_failure_enabled
			old_last_type: like last_type
		do
			old_current_class := current_class
			old_is_failure_enabled := is_failure_enabled
			old_last_type := last_type
			is_failure_enabled := True
			current_class := a_context_class
			a_type.process (Current)
			Result := last_type
			current_class := old_current_class
			is_failure_enabled := old_is_failure_enabled
			last_type := old_last_type
		end

	evaluate_type (a_type: TYPE_AS; a_context_class: CLASS_C): TYPE_A
			-- Given a TYPE_AS node, find its equivalent TYPE_A node.
		require
			a_type_not_void: a_type /= Void
			a_context_class_not_void: a_context_class /= Void
			a_type_is_in_universe: True -- All class identifiers of `a_type' are in the universe.
		local
			old_current_class: like current_class
			old_is_failure_enabled: like is_failure_enabled
			old_last_type: like last_type
		do
			old_current_class := current_class
			old_is_failure_enabled := is_failure_enabled
			old_last_type := last_type
			is_failure_enabled := False
			current_class := a_context_class
			a_type.process (Current)
			Result := last_type
			current_class := old_current_class
			is_failure_enabled := old_is_failure_enabled
			last_type := old_last_type
		ensure
			evaluate_type_not_void: Result /= Void
		end

	evaluate_class_type (a_class_type: CLASS_TYPE_AS; a_context_class: CLASS_C): CL_TYPE_A
			-- Given a CLASS_TYPE_AS node, find its equivalent CL_TYPE_A node.
		require
			a_class_type_not_void: a_class_type /= Void
			a_context_class_not_void: a_context_class /= Void
			a_type_is_in_universe: True -- All class identifiers of `a_class_type' are in the universe.
		do
			Result ?= evaluate_type (a_class_type, a_context_class)
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

	process_like_id_as (l_as: LIKE_ID_AS)
		local
			t: UNEVALUATED_LIKE_TYPE
		do
			create t.make (l_as.anchor.name)
			if l_as.has_attached_mark then
				t.set_attached_mark
			elseif l_as.has_detachable_mark then
				t.set_detachable_mark
			end
			last_type := t
		end

	process_like_cur_as (l_as: LIKE_CUR_AS)
		local
			l_cur: LIKE_CURRENT
		do
			create l_cur
			l_cur.set_actual_type (current_class.actual_type)
			if l_as.has_attached_mark then
				l_cur.set_attached_mark
			elseif l_as.has_detachable_mark then
				l_cur.set_detachable_mark
			end
			last_type := l_cur
		end

	process_formal_as (l_as: FORMAL_AS)
		local
			f: FORMAL_A
			types_done: LINKED_LIST [INTEGER]
			types_todo: LINKED_LIST [INTEGER]
			l: CONSTRAINT_LIST_AS
			t: TYPE_AS
			i: INTEGER
		do
			create f.make (l_as.is_reference, l_as.is_expanded, l_as.position)
			last_type := f
			if l_as.has_attached_mark then
				f.set_attached_mark
				check f.is_attached end
			elseif l_as.has_detachable_mark then
				f.set_detachable_mark
			elseif current_class.generics [l_as.position].constraints /= Void then
					-- Check attachment status of constraints.
				from
					create types_done.make
					create types_todo.make
					types_todo.extend (l_as.position)
				until
					types_todo.is_empty
				loop
					from
						types_todo.start
						l := current_class.generics [types_todo.item_for_iteration].constraints
						types_done.extend (types_todo.item_for_iteration)
						types_todo.remove
						i := l.count
					until
						i <= 0
					loop
						t := l [i].type
						if t.has_attached_mark then
							f.set_is_attached
							types_todo.wipe_out
							l.finish
						elseif attached {FORMAL_AS} t as ff then
								-- Record new formal generic for processing (if not done yet).
							if not types_done.has (ff.position) and then not types_todo.has (ff.position) then
									-- This is new formal generic type.
								if current_class.generics [ff.position].constraints = Void then
										-- Formal generic without constraints does not provide attachment status.
									types_done.extend (ff.position)
								else
										-- The contraints have to be checked.
									types_todo.extend (ff.position)
								end
							end
						elseif current_class.lace_class.is_attached_by_default then
								-- The type must be a class type, let's use the `current_class' default attachment settings.
							f.set_is_attached
							types_todo.wipe_out
							l.finish
						end
						i := i - 1
					end
				end
			end
		end

	process_class_type_as (l_as: CLASS_TYPE_AS)
		local
			l_class_i: CLASS_I
			l_class_c: CLASS_C
			l_actual_generic: ARRAY [TYPE_A]
			l_generics: TYPE_LIST_AS
			i, count: INTEGER
			l_has_error: BOOLEAN
			l_type: CL_TYPE_A
		do
				-- Lookup class in universe, it should be present.
			l_class_i := universe.class_named (l_as.class_name.name, current_class.group)
			if l_class_i /= Void and then l_class_i.is_compiled then
				l_class_c := l_class_i.compiled_class
				l_generics := l_as.generics
				if l_generics /= Void then
					from
						i := 1
						count := l_generics.count
						create l_actual_generic.make (1, count)
						l_type := l_class_c.partial_actual_type (l_actual_generic, l_as.is_expanded,
							l_as.is_separate)
					until
						i > count or l_has_error
					loop
						l_generics.i_th (i).process (Current)
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
					if l_as.has_attached_mark then
						if l_type.is_basic then
								-- Avoid modifying once values
							l_type := l_type.duplicate
							last_type := l_type
						end
						l_type.set_attached_mark
						check l_type.is_attached end
					elseif l_as.has_detachable_mark then
						if l_type.is_basic then
								-- Avoid modifying once values
							l_type := l_type.duplicate
							last_type := l_type
						end
						l_type.set_detachable_mark
					elseif current_class.lace_class.is_attached_by_default then
						if l_type.is_basic then
								-- Avoid modifying once values
							l_type := l_type.duplicate
							last_type := l_type
						end
						l_type.set_is_attached
					end
				end
			else
				check failure_enabled: is_failure_enabled end
				last_type := Void
			end
		end

	process_generic_class_type_as (l_as: GENERIC_CLASS_TYPE_AS)
		do
			process_class_type_as (l_as)
		end

	process_named_tuple_type_as (l_as: NAMED_TUPLE_TYPE_AS)
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
					if l_type /= Void then
						if l_as.has_attached_mark then
							l_type.set_attached_mark
						elseif l_as.has_detachable_mark then
							l_type.set_detachable_mark
						elseif current_class.lace_class.is_attached_by_default then
							l_type.set_is_attached
						end
					end
					last_type := l_type
				end
			else
				check failure_enabled: is_failure_enabled end
				last_type := Void
			end
		end

	process_type_dec_as (l_as: TYPE_DEC_AS)
		do
			l_as.type.process (Current)
		end

	process_none_type_as (l_as: NONE_TYPE_AS)
		do
			last_type := none_type
		end

	process_bits_as (l_as: BITS_AS)
		do
			create {BITS_A} last_type.make (l_as.bits_value.integer_32_value)
		end

	process_bits_symbol_as (l_as: BITS_SYMBOL_AS)
		do
			create {UNEVALUATED_BITS_SYMBOL_A} last_type.make (l_as.bits_symbol.name)
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
