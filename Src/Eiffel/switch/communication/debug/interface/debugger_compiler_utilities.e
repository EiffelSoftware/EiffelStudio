indexing
	description: "Routines used by debugger to access compiler's data..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_COMPILER_UTILITIES

inherit
	SHARED_EIFFEL_PROJECT

	COMPILER_EXPORTER
			--| Just to be able to access E_FEATURE::associated_feature_i :(
			--| and other expression evaluation purpose
		export
			{NONE} all
		end

inherit {NONE}
	REFACTORING_HELPER

feature -- Class c

	exception_class_c: CLASS_C is
			-- EXCEPTION class
		local
			cl_i: CLASS_I
		do
			cl_i := Eiffel_system.system.exception_class
			if cl_i /= Void then
				Result := cl_i.compiled_class
			end
		end

feature -- Type adaptation

	frozen adapted_class_type (ctype: CLASS_TYPE; f: FEATURE_I): CLASS_TYPE is
			-- Adapted class_type receiving the call of `f'
		local
			l_f_class_c: CLASS_C
			l_cl_type_a: CL_TYPE_A
		do
			if ctype.associated_class.is_basic then
				Result := associated_reference_basic_class_type (ctype.associated_class)
			else
					--| Get the real class_type
				l_f_class_c := f.written_class
				if ctype.associated_class.is_equal (l_f_class_c) then
						--| The feature is not inherited
					Result := ctype
				else
					if l_f_class_c.types.count = 1 then
						Result := l_f_class_c.types.first
					elseif l_f_class_c.is_basic then
						Result := l_f_class_c.types.first
					else
							--| The feature is inherited

							--| let's search and find the correct CLASS_TYPE among the parents
							--| this will solve the problem of inherited once and generic class
							--| the level on inheritance is represented by the CLASS_C
							--| then the derivation of the GENERIC by the CLASS_TYPE
							--| among the parent we know the right CLASS_TYPE
							--| so first we localite the CLASS_C then we keep the CLASS_TYPE					
						l_cl_type_a := ctype.type.type_a
						Result := l_cl_type_a.find_class_type (l_f_class_c).type_i.associated_class_type
					end
				end
			end
		end

	frozen ancestor_version_of (fi: FEATURE_I; an_ancestor: CLASS_C): FEATURE_I is
			-- Feature in `an_ancestor' of which `Current' is derived.
			-- `Void' if not present in that class.
		require
			fi_not_void: fi /= Void
			an_ancestor_not_void: an_ancestor /= Void
		local
			n, nb: INTEGER
			ris: ROUT_ID_SET
			rout_id: INTEGER
		do
			if
				an_ancestor.is_valid
				and then an_ancestor.has_feature_table
			then
				ris := fi.rout_id_set
				from
					n := ris.lower
					nb := ris.count
				until
					n > nb or else Result /= Void
				loop
					rout_id := ris.item (n)
					if rout_id > 0 then
						Result := an_ancestor.feature_table.feature_of_rout_id (rout_id)
					end
					n := n + 1
				end
			end
		end

	frozen associated_basic_class_type (cl: CLASS_C): CLASS_TYPE is
			-- Associated classtype for type `cl'
		require
			cl_not_void: cl /= Void
			cl_is_basic: cl.is_basic
		local
			t: CL_TYPE_I
		do
			t := cl.actual_type.type_i
			if t.has_associated_class_type then
				Result := t.associated_class_type
			end
		ensure
			associated_basic_class_type_not_void: Result /= Void
		end

	frozen associated_reference_basic_class_type (cl: CLASS_C): CLASS_TYPE is
			-- Associated _REF classtype for type `cl'
			--| for instance return INTEGER_REF for INTEGER
		require
			cl_not_void: cl /= Void
			cl_is_basic: cl.is_basic
		local
			l_basic: BASIC_I
		do
			l_basic ?= cl.actual_type.type_i
			check
				l_basic_not_void: l_basic /= Void
			end
			Result := l_basic.associated_reference_class_type
		ensure
			associated_reference_basic_class_type_not_void: Result /= Void
		end

	frozen class_c_from_type_a (t: TYPE_A; a_ctx_class: CLASS_C): CLASS_C is
			-- instance of CLASS_C associated with type `t', in context of class `a_ctx_class'.
		require
			t_not_void: t /= Void
			a_ctx_class_not_void: a_ctx_class /= Void
		local
			l_type: TYPE_A
			l_formal: FORMAL_A
--			l_last_type_set: TYPE_SET_A
		do
			if t.has_associated_class then
				Result := t.associated_class
			else
				l_type := t.actual_type
				if l_type.is_formal then
					l_formal ?= l_type
					if l_formal.is_multi_constrained (a_ctx_class) then
						fixme("Handle multi constrained type...")
--						l_last_type_set := l_type.to_type_set.constraining_types (a_ctx_class)
--						l_type := l_last_type_set.instantiated_in (a_ctx_class.actual_type)
--						if l_type.is_formal then
--							l_formal ?= l_type
--							l_type := l_formal.constrained_type (a_ctx_class)
--						end
						l_type := Void
					else
						l_type := l_formal.constrained_type (a_ctx_class)
					end
				end
				if l_type /= Void and then not l_type.is_none then
					Result := l_type.associated_class
				else
					Result := Void
				end
			end
		end

feature -- Query

	descendants_type_names_for (n: STRING): DS_LIST [STRING] is
			-- CLASS_C associated to `n'
		require
			n_not_void: n /= Void
		local
			lst: like descendants_type_names
			clis: LIST [CLASS_I]
			cl_i: CLASS_I
		do
			clis := eiffel_system.universe.classes_with_name (n)
			if clis /= Void and then not clis.is_empty then
				from
					clis.start
					create {DS_ARRAYED_LIST [STRING]} Result.make_equal (0)
				until
					clis.after
				loop
					cl_i := clis.item_for_iteration
					if cl_i /= Void and then cl_i.is_compiled then
						lst := descendants_type_names (cl_i.compiled_class)
						if lst /= Void then
							Result.append_last (lst)
						end
					end
					clis.forth
				end
			end
		ensure
			Result /= Void implies Result.equality_tester /= Void
		end

	descendants_type_names (cl: CLASS_C): DS_LIST [STRING] is
			-- Type names for available EXCEPTION types
		local
			lst: LIST [CLASS_C]
		do
			if cl /= Void then
				lst := descendants_from (cl)
				if lst /= Void then
					from
						lst.start
						create {DS_ARRAYED_LIST [STRING]} Result.make_equal (lst.count)
					until
						lst.after
					loop
						Result.put_last (lst.item.name_in_upper)
						lst.forth
					end
				end
			end
		ensure
			Result /= Void implies Result.equality_tester /= Void

		end

	descendants_from (cl: CLASS_C): ARRAYED_LIST [CLASS_C] is
			-- Descendant of class `cl'.
		require
			cl_not_void: cl /= Void
		local
			desc, lst: LIST [CLASS_C]
		do
			desc := cl.direct_descendants
			if desc /= Void then
				create Result.make (desc.count)
				from
					desc.start
				until
					desc.after
				loop
					Result.force (desc.item)
					lst := descendants_from (desc.item)
					if lst /= Void then
						Result.append (lst)
					end
					desc.forth
				end
			end
		end

;indexing
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
