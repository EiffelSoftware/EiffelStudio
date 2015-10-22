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
			process_qualified_anchored_type_as,
			process_formal_as, process_class_type_as,
			process_generic_class_type_as, process_none_type_as,
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

	INTERNAL_COMPILER_STRING_EXPORTER

feature -- Status report

	evaluate_type (a_type: TYPE_AS; a_context_class: CLASS_C): detachable TYPE_A
			-- Given a TYPE_AS node, find its equivalent TYPE_A node.
		require
			a_type_not_void: a_type /= Void
			a_context_class_not_void: a_context_class /= Void
		local
			old_current_class: like current_class
			old_last_type: like last_type
		do
			old_current_class := current_class
			old_last_type := last_type
			current_class := a_context_class
			a_type.process (Current)
			Result := last_type
			current_class := old_current_class
			last_type := old_last_type
		end

feature {NONE} -- Implementation: Access

	last_type: TYPE_A
			-- Last resolved type of checker

	current_class: CLASS_C
			-- Current class where current type is resolved

feature {NONE} -- Visitor implementation

	process_like_id_as (l_as: LIKE_ID_AS)
		local
			t: UNEVALUATED_LIKE_TYPE
		do
			create t.make (l_as.anchor.name)
			last_type := updated_type_with_annotations (l_as, t)
		end

	process_like_cur_as (l_as: LIKE_CUR_AS)
		local
			l_cur: LIKE_CURRENT
		do
			create l_cur.make (current_class.actual_type)
			last_type := updated_type_with_annotations (l_as, l_cur)
				-- Regardless of where `like Current' appears, the type is a frozen one.
			last_type.set_is_implicitly_frozen
		end

	process_qualified_anchored_type_as (l_as: QUALIFIED_ANCHORED_TYPE_AS)
			-- <Precursor>
		local
			t: UNEVALUATED_QUALIFIED_ANCHORED_TYPE
			n: SPECIAL [INTEGER_32]
			i: INTEGER
		do
			l_as.qualifier.process (Current)
			if attached last_type as q then
					-- Qualifier type is processed without an error.
					-- Make an array of names in the chain.
				create n.make_filled (0, l_as.chain.count)
				across l_as.chain as l_chain loop
					n [i] := l_chain.item.name.name_id
					i := i + 1
				end
				create t.make (q, n)
				last_type := updated_type_with_annotations (l_as, t)
			end
		end

	process_formal_as (l_as: FORMAL_AS)
		local
			f: FORMAL_A
			types_done: LINKED_LIST [INTEGER]
			todo_attached: LINKED_LIST [INTEGER]
			todo_separate: LINKED_LIST [INTEGER]
			l: CONSTRAINT_LIST_AS
			t: TYPE_AS
			i: INTEGER
			j: INTEGER
			s: BOOLEAN
			l_is_frozen: BOOLEAN
		do
			create f.make (l_as.is_reference, l_as.is_expanded, l_as.position)
				-- The formal generic is separate by default.
			s := True
				-- If the associated formal of the current class is marked frozen,
				-- we make sure that `f' is known to be intrinsically frozen.
			if current_class.generics [l_as.position].formal.has_frozen_mark then
				f.set_frozen_mark
			end
			if current_class.generics [l_as.position].constraints /= Void then
					-- Check attachment and separateness status of constraints.
					-- The loop iterates over all constraints recursively.
					-- The condition to terminate it for attachment status is to
					-- find an expanded type, since than the type is known to be
					-- attached, but the initialization is not required.
					-- The condition to terminate for separate status is to
					-- find a non-separate constraint since then the formal
					-- is not separate.
				from
					create types_done.make
					create todo_attached.make
					create todo_separate.make
					todo_attached.extend (l_as.position)
					todo_separate.extend (l_as.position)
				until
					todo_attached.is_empty and then todo_separate.is_empty
				loop
					from
						if not todo_attached.is_empty then
							todo_attached.start
							j := todo_attached.item_for_iteration
							todo_attached.remove
								-- Remove this item from `todo_separate'.
							todo_separate.search (j)
							if not todo_separate.exhausted then
								todo_separate.remove
							end
						else
							todo_separate.start
							j := todo_separate.item_for_iteration
							todo_separate.remove
						end
						l := current_class.generics [j].constraints
						types_done.extend (j)
						i := l.count
					until
						i <= 0
					loop
						t := l [i].type
						if t.has_frozen_mark then
								-- One of the constraint is marked frozen, it can only be frozen by nature.
							l_is_frozen := True
						end
						if
							attached {CLASS_TYPE_AS} t as ct and then
							(ct.is_expanded or else
							attached universe.class_named (ct.class_name.name, current_class.group) as ci and then
							ci.is_compiled and then
							attached ci.compiled_class as c and then
							c.is_expanded)
						then
								-- The actual type should be expanded.
							f.set_is_expanded
							f.set_is_attached
							todo_attached.wipe_out
								-- The generic is not separate.
							s := False
							todo_separate.wipe_out
								-- Terminate iteration.
							i := 1
						elseif attached {FORMAL_AS} t as ff then
								-- Record new formal generic for processing (if not done yet).
							if not types_done.has (ff.position) then
									-- This is a new formal generic type.
								if current_class.generics [ff.position].constraints = Void then
										-- Formal generic without constraints does not provide attachment status
										-- not specifies non-separate status.
									types_done.extend (ff.position)
								else
									if t.has_detachable_mark then
											-- Skip the detachable type because it does not allow to see
											-- if the formal is always attached or not.
									else
										if t.has_attached_mark and then not f.has_detachable_mark then
											f.set_is_attached
										end
										if not todo_attached.has (ff.position) then
												-- The constraints have to be checked.
											todo_attached.extend (ff.position)
										end
									end
									if s then
											-- The formal is still considered separate.
										if t.has_separate_mark then
												-- Skip separate type because it does not allow to see
												-- if the formal is always non-separate.
										elseif not todo_separate.has (ff.position) then
												-- The constraints have to be checked.
											todo_separate.extend (ff.position)
										end
									end
								end
							end
						else
								-- The type must be a class type.
							if t.has_detachable_mark then
									-- Skip the detachable constraint because it does not allow to see
									-- if the formal is always attached or not.
							elseif
								(t.has_attached_mark or else
								current_class.lace_class.is_attached_by_default) and then
								not f.has_detachable_mark
							then
									-- The type must be a class type with an attached mark
									-- or without any attachment marks. Let's use the `current_class'
									-- default attachment settings in the latter case.
								f.set_is_attached
							end
							if not t.has_separate_mark then
									-- The generic is not separate.
								s := False
								todo_separate.wipe_out
							end
						end
						i := i - 1
					end
				end
			end
			if s then
				f.set_is_separate
			end
			if l_is_frozen then
				f.set_frozen_mark
			end
			last_type := updated_type_with_annotations (l_as, f)
		end

	process_class_type_as (l_as: CLASS_TYPE_AS)
		local
			l_class_i: CLASS_I
			l_class_c: CLASS_C
			l_actual_generic: detachable ARRAYED_LIST [TYPE_A]
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
						create l_actual_generic.make (count)
					until
						i > count or l_has_error
					loop
						l_generics.i_th (i).process (Current)
						l_has_error := last_type = Void
						l_actual_generic.extend (last_type)
						i := i + 1
					end
				end
				if l_has_error then
					last_type := Void
				else
					l_type := l_class_c.partial_actual_type (l_actual_generic, l_as, current_class)
					last_type := updated_type_with_annotations (l_as, l_type)
				end
			else
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
			l_actual_generic: ARRAYED_LIST [TYPE_A]
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
					create l_actual_generic.make (count)
					create l_names.make_filled (0, count)
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
						l_actual_generic.extend (last_type)
						l_names.put (l_id_list.item, i - 1)
						i := i + 1
						l_id_list.forth
					end
					g := g + 1
				end
				create l_type.make (l_class_c.class_id, l_actual_generic, l_names)
				if l_has_error then
					last_type := Void
				else
					check attached l_type end
					last_type := updated_type_with_annotations (l_as, l_type)
				end
			else
				last_type := Void
			end
		end

	process_type_dec_as (l_as: TYPE_DEC_AS)
		do
			l_as.type.process (Current)
		end

	process_none_type_as (l_as: NONE_TYPE_AS)
		do
			last_type := updated_type_with_annotations (l_as, none_type)
		end

feature {NONE} -- Type marks

	updated_type_with_annotations (a: TYPE_AS; t: TYPE_A): TYPE_A
			-- Update `t' with respects to annotations found in `a'.
			--| The implementation might duplicate `t' in the event it is the
			--| value of a once function as to not modify the default annotations
			--| found in the once.
		require
			a_attached: attached a
			t_attached: attached t
		local
			is_shared: BOOLEAN
		do
				-- Basic and NONE type descriptors may be shared, so we duplicate
				-- if needed to avoid modifying once values. We only do that for
				-- deanchored types.
			is_shared := attached {DEANCHORED_TYPE_A} t and then (t.is_basic or else t.is_none)
			Result := t

				-- Handle frozen/variant mark.
			if a.has_frozen_mark then
					-- Avoid modifying once values.
				if is_shared then
					Result := Result.duplicate
				end
				Result.set_frozen_mark
			elseif a.has_variant_mark then
					-- Avoid modifying once values.
				if is_shared then
					Result := Result.duplicate
				end
				Result.set_variant_mark
			end

				-- Handle any attachment mark.
			if a.has_attached_mark then
					-- Avoid modifying once values.
				if is_shared then
					Result := Result.duplicate
				end
				Result.set_attached_mark
				check Result.is_attached end
			elseif a.has_detachable_mark then
					-- Avoid modifying once values.
				if is_shared then
					Result := Result.duplicate
				end
				Result.set_detachable_mark
			elseif
				current_class.lace_class.is_attached_by_default and then
				attached {DEANCHORED_TYPE_A} Result and then
				not attached {FORMAL_A} Result
			then
					-- Avoid modifying once values.
				if is_shared then
					Result := Result.duplicate
				end
				Result.set_is_attached
			end

				-- Handle separate mark.
			if a.has_separate_mark then
					-- Avoid modifying once values.
				if is_shared then
					Result := Result.duplicate

				end
				Result.set_separate_mark
			end
		ensure
			result_attached: attached Result
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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

