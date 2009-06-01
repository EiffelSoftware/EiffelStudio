note
	description: "Routines used by debugger to access compiler's data..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_COMPILER_UTILITIES

inherit
	ANY

	COMPILER_EXPORTER
			--| Just to be able to access E_FEATURE::associated_feature_i :(
			--| and other expression evaluation purpose
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

feature -- Class c

	exception_class_c: CLASS_C
			-- EXCEPTION class
		local
			cl_i: CLASS_I
		do
			cl_i := Eiffel_system.system.exception_class
			if cl_i /= Void then
				Result := cl_i.compiled_class
			end
		end

	any_class_c: CLASS_C
			-- ANY class
		local
			cl_i: CLASS_I
		do
			cl_i := Eiffel_system.system.any_class
			if cl_i /= Void then
				Result := cl_i.compiled_class
			end
		end

feature -- Entry point

	frozen entry_point_class_feature: TUPLE [cl: CLASS_C; feat: FEATURE_I]
			-- System entry point feature
		local
			cl_c: CLASS_C
			s: STRING
			l_creator: SYSTEM_ROOT
		do
			if eiffel_project.system_defined and then not eiffel_system.system.root_creators.is_empty then
					-- NOTE: This code needs to be updated to support multiple root classes/features
				l_creator := eiffel_system.system.root_creators.first
				cl_c := l_creator.root_class.compiled_class
				if cl_c /= Void then
					s := l_creator.procedure_name
					if s /= Void then
						Result := [cl_c, cl_c.feature_table.item (s)]
					end
				end
			end
		end

	frozen entry_point_feature: E_FEATURE
			-- System entry point api feature
		local
			t: like entry_point_class_feature
		do
			t := entry_point_class_feature
			if t /= Void then
				Result := t.feat.api_feature (t.cl.class_id)
			end
		end

	frozen is_equal_feature (a_class: CLASS_C): FEATURE_I
		require
			a_class_attached: a_class /= Void
		local
			f: FEATURE_I
		do
			f := any_class_c.feature_named ("is_equal")
			Result := fi_version_of_class (f, a_class)
		end

feature -- Type adaptation

	frozen adapted_class_type (ctype: CLASS_TYPE; f: FEATURE_I): CLASS_TYPE
			-- Adapted class_type receiving the call of `f'
			--| Note: Only used by dotnet debugger so far.
		local
			l_f_class_c: CLASS_C
			l_cl_type_a: CL_TYPE_A
			tl: TYPE_LIST
		do
				--| Get the real class_type
			l_f_class_c := f.written_class
			if ctype.associated_class.is_equal (l_f_class_c) then
					--| The feature is not inherited
				Result := ctype
			else
				tl := l_f_class_c.types
				check tl_attached: tl /= Void end
				if tl.count = 1 then
					Result := tl.first
				elseif l_f_class_c.is_basic then
					Result := tl.first
				else
						--| The feature is inherited

						--| let's search and find the correct CLASS_TYPE among the parents
						--| this will solve the problem of inherited once and generic class
						--| the level on inheritance is represented by the CLASS_C
						--| then the derivation of the GENERIC by the CLASS_TYPE
						--| among the parent we know the right CLASS_TYPE
						--| so first we localite the CLASS_C then we keep the CLASS_TYPE					
					l_cl_type_a := ctype.type
					Result := l_cl_type_a.find_class_type (l_f_class_c).associated_class_type (ctype.type)
				end
			end
		end

	frozen ancestor_version_of (fi: FEATURE_I; an_ancestor: CLASS_C): FEATURE_I
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

	frozen associated_basic_class_type (cl: CLASS_C): CLASS_TYPE
			-- Associated classtype for type `cl'
		require
			cl_not_void: cl /= Void
			cl_is_basic: cl.is_basic
		local
			t: CL_TYPE_A
		do
			t := cl.actual_type
			if t.has_associated_class_type (Void) then
				Result := t.associated_class_type (Void)
			end
		ensure
			associated_basic_class_type_not_void: Result /= Void
		end

	frozen associated_reference_basic_class_type (cl: CLASS_C): CLASS_TYPE
			-- Associated _REF classtype for type `cl'
			--| for instance return INTEGER_REF for INTEGER
		require
			cl_not_void: cl /= Void
			cl_is_basic: cl.is_basic
		local
			l_basic: BASIC_A
		do
			l_basic ?= cl.actual_type
			check
				l_basic_not_void: l_basic /= Void
			end
			Result := l_basic.associated_reference_class_type
		ensure
			associated_reference_basic_class_type_not_void: Result /= Void
		end

	frozen class_c_from_type_a (t: TYPE_A; a_ctx_class: CLASS_C): CLASS_C
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
						debug ("refactor_fixme")
							fixme("Handle multi constrained type...")
						end
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

	frozen class_c_from_type_i (a_type_i: TYPE_A): CLASS_C
			-- Class C related to `a_type_i' if exists.
		require
			a_type_i_not_void: a_type_i /= Void
		local
			l_type_a: TYPE_A
		do
			if a_type_i /= Void then
				l_type_a := a_type_i
				if l_type_a.has_associated_class then
					Result := l_type_a.associated_class
				end
			end
		end

	frozen static_class_for_local_from_type_a (a_type_a: TYPE_A; a_rout_i: FEATURE_I; a_class: CLASS_C): CLASS_C
			-- Static class for local represented by `a_type_a' and `a_rout_i'
			-- `a_class' should be `a_rout_i.written_class'.
		require
			a_type_a_attached: a_type_a /= Void
		local
			l_type_a: TYPE_A
		do
			type_a_checker.init_for_checking (a_rout_i, a_class, Void, Void)
			l_type_a := type_a_checker.solved (a_type_a, Void)
			if l_type_a /= Void and then l_type_a.has_associated_class then
				Result := l_type_a.associated_class
			end
		end

	frozen static_class_for_local (a_type: TYPE_AS; a_rout_i: FEATURE_I; a_class: CLASS_C): CLASS_C
			-- Static class for local represented by `a_type' and `a_rout_i'
			-- `a_class' should be `a_rout_i.written_class'.
		local
			l_type_a: TYPE_A
		do
			if a_type /= Void then
				l_type_a := type_a_generator.evaluate_type (a_type, a_class)
				Result := static_class_for_local_from_type_a (l_type_a, a_rout_i, a_class)
			end
		end

feature -- Feature access

	frozen feature_from_runtime_data (a_dynamic_class: CLASS_C; a_written_class: CLASS_C; a_featname: STRING): E_FEATURE
			-- Feature attached to `a_dynamic_class' from feature with name `a_feat_name' on `a_written_class'
		require
			written_class_attached: a_written_class /= Void
			featname_attached: a_featname /= Void and then not a_featname.is_empty
		local
			f: E_FEATURE
		do
			if is_invariant_feature_name (a_featname) then
				if attached a_written_class.invariant_feature as inv then
					Result := inv.api_feature (a_written_class.class_id)
				end
			else
				Result := a_written_class.feature_with_name (a_featname)
				if Result = Void then
					if attached {EIFFEL_CLASS_C} a_written_class as eclc then
						Result := eclc.api_inline_agent_of_name (a_featname)
					end
				end
					-- Adapt `Result' to `a_dynamic_class' and handles precursor case.
					--
					-- Note that `a_dynamic_class' does not always conform to `a_written_class' in the
					-- case where we do a static call to an external routine
					-- (e.g. when stepping into `sp_count' from ISE_RUNTIME from `count' of SPECIAL.)
				if
					a_dynamic_class /= Void and then
					a_dynamic_class /= a_written_class and then
					Result /= Void and then
					not Result.is_inline_agent and then
					a_dynamic_class.simple_conform_to (a_written_class)
				then
					f := a_dynamic_class.feature_with_rout_id (Result.rout_id_set.first)
					if f.written_in = a_written_class.class_id then
							-- Not the precursor case.
						Result := f
					end
				end
			end
		end

	frozen fi_version_of_class (fi: FEATURE_I; a_class: CLASS_C): FEATURE_I
			-- Feature in `a_class' of which `Current' is derived.
			-- `Void' if not present in that class.
		require
			fi_not_void: fi /= Void
			a_class_not_void: a_class /= Void
		local
			rids: ROUT_ID_SET
		do
			if a_class.is_valid and then a_class.has_feature_table then
				rids := fi.rout_id_set
				Result := a_class.feature_of_rout_id_set (rids)
			end
		end

	frozen agent_feature_for_class_and_type_id (ct_id, fe_id: INTEGER): E_FEATURE
			-- Agent feature related to `ct_id' and `fe_id'
		require
			id_valid: ct_id > 0 and fe_id > 0
		local
			l_ct: CLASS_TYPE
			l_cc: CLASS_C
			l_fi: FEATURE_I
		do
			l_ct := eiffel_system.system.class_type_of_static_type_id (ct_id)
			if l_ct /= Void then
				l_cc := l_ct.associated_class
				if l_cc /= Void and then fe_id /= 0 then
					check is_not_is_precompiled: not l_cc.is_precompiled end
					if attached {EIFFEL_CLASS_C} l_cc as l_ecc then
						Result := l_ecc.feature_with_feature_id (fe_id)
						if Result = Void then
							l_fi := l_ecc.inline_agent_of_id (fe_id)
							if l_fi /= Void then
									--| Test l_fi.is_fake_inline_agent to deal with agent on attribute
								Result := l_fi.api_feature (l_ecc.class_id)
							end
						end
					end
				end
			end
		end

	frozen agent_feature_for_origin_and_offset (a_orig, a_offset: INTEGER): E_FEATURE
			-- Agent feature related to `a_orig' and `a_offset'
		require
			id_valid: a_orig > 0 and a_offset > 0
		local
			l_ct: CLASS_TYPE
			l_cc: CLASS_C
			l_fi: FEATURE_I
		do
			l_ct := eiffel_system.system.class_type_of_static_type_id (a_orig)
			if l_ct /= Void then
				l_cc := l_ct.associated_class
				if l_cc /= Void then
					check is_precompiled: l_cc.is_precompiled end
					if attached {EIFFEL_CLASS_C} l_cc as l_ecc then
						l_fi := feature_i_for_class_and_offset (l_cc, a_offset)
						if l_fi /= Void then
							Result := l_fi.api_feature (l_ecc.class_id)
						end
					end
				end
			end
		end

	feature_i_for_class_and_offset (a_class: CLASS_C; a_offset: INTEGER): FEATURE_I
			-- Feature associated with `a_class' and `a_offset'
		require
			a_class_attached: a_class /= Void
			a_class_precompiled: a_class.is_precompiled
		local
			ri_table: ROUT_INFO_TABLE
			rid: INTEGER
		do
			ri_table := eiffel_system.system.rout_info_table
			from
				ri_table.start
			until
				ri_table.after or rid /= 0
			loop
				if attached ri_table.item_for_iteration as ri then
					if
						ri.offset = a_offset and
						ri.origin = a_class.class_id
					then
						rid := ri_table.key_for_iteration
					end
				end
				ri_table.forth
			end
			if rid /= 0 then
				Result := a_class.feature_of_rout_id (rid)
			end
		end

	frozen real_feature (a_feat: E_FEATURE): E_FEATURE
			-- real feature of `a_feat'
			-- i.e: either `a_feat' or the feature inlining `a_feat' in case of inline agent
		require
			a_feat /= Void
		local
			l_tokens: LIST [STRING]
			l_class_id, l_feature_id: INTEGER
			l_class: CLASS_C
		do
			l_tokens := a_feat.name.split ('#')
			if l_tokens.count /= 5 or else not equal ("fake inline-agent", l_tokens.i_th (1)) then
				Result := a_feat
			elseif not l_tokens.i_th (3).is_integer_32 or not l_tokens.i_th (4).is_integer_32 then
				Result := a_feat
			else
				l_class_id := l_tokens.i_th (3).to_integer
				l_feature_id := l_tokens.i_th (4).to_integer
				l_class := eiffel_system.class_of_id (l_class_id)
				if l_class /= Void then
					Result := l_class.feature_with_feature_id (l_feature_id)
					if Result = Void then
						Result := a_feat
					end
				else
					Result := a_feat
				end
			end
		ensure
			Result /= Void
		end

feature -- Access on Byte node

	frozen feature_i_from_call_access_b_in_context (cl: CLASS_C; a_call_access_b: CALL_ACCESS_B): FEATURE_I
			-- Return FEATURE_I corresponding to `a_call_access_b' in class `cl'
			-- (this handles the feature renaming cases)
		require
			cl_not_void: cl /= Void
			a_call_access_b_not_void: a_call_access_b /= Void
		local
			wcl: CLASS_C
			l_cl: CLASS_C
		do
			--FIXME:jfiat:2009-03-27: review this code, since it looks pretty complicated ...
			if cl.is_basic then
				l_cl := associated_reference_basic_class_type (cl).associated_class
				Result := l_cl.feature_of_rout_id (a_call_access_b.routine_id)
			else
				if cl.class_id = a_call_access_b.written_in then
						--| if same class, this is straight forward
					Result := cl.feature_of_feature_id (a_call_access_b.feature_id)
				else
					Result := cl.feature_of_rout_id (a_call_access_b.routine_id)
					if Result = Void then
						Result := cl.feature_of_name_id (a_call_access_b.feature_name_id)
						if Result = Void then
								--| let's search from written_class
							wcl := eiffel_system.class_of_id (a_call_access_b.written_in)
							check wcl_not_void: wcl /= Void end
							Result := wcl.feature_of_rout_id (a_call_access_b.routine_id)
							if Result /= Void and then wcl /= cl then
								Result := fi_version_of_class (Result, cl)
							end
						end
					end
					if Result = Void then
							--| from _B target static type ...
						if a_call_access_b.parent /= Void and then a_call_access_b.parent.target /= Void then
							l_cl := class_c_from_expr_b (a_call_access_b.parent.target)
							if l_cl /= Void then
								Result := l_cl.feature_of_rout_id (a_call_access_b.routine_id)
								if Result /= Void and then l_cl /= cl then
									Result := fi_version_of_class (Result, cl)
								end
							end
						end

						--| else giveup, no need to find an erroneous feature which leads to debuggee crash
					end
				end
			end
		end

	frozen class_c_from_expr_b (a_expr_b: EXPR_B): CLASS_C
			-- Class C related to `a_expr_b' if exists.
		require
			a_expr_b_not_void: a_expr_b /= Void
		local
			l_type_i: TYPE_A
		do
			l_type_i := a_expr_b.type
			if l_type_i /= Void then
				Result := class_c_from_type_i (l_type_i)
			end
		end

feature -- Query

	frozen descendants_type_names_for (n: STRING): DS_LIST [STRING]
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

	frozen descendants_type_names (cl: CLASS_C): DS_LIST [STRING]
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

	frozen descendants_from (cl: CLASS_C): ARRAYED_LIST [CLASS_C]
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

feature -- Status report

	is_invariant_feature_name (fn: STRING): BOOLEAN
			-- Is `fn' an _invariant routine name?
		do
			Result := fn.item (1) = '_' and then fn.is_equal (invariant_routine_name)
		end

	invariant_routine_name: STRING = "_invariant"
			-- Invariant's feature name

;note
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
