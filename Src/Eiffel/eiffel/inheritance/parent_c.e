note
	description: "Compiled representation of a parent."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class PARENT_C

inherit

	EIFFEL_SYNTAX_CHECKER
		export
			{NONE} all
		end

	PREFIX_INFIX_NAMES
		export
			{NONE} all
		end

	SHARED_WORKBENCH
	SHARED_SELECTED
	SHARED_ERROR_HANDLER
	SHARED_NAMES_HEAP
	COMPILER_EXPORTER
	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Creation

	make (l: like class_name_token)
			-- Initialize a parent with location `l`.
		do
			class_name_token := l
		end

feature -- Access

	class_name_token: ID_AS
			-- Location of the parent class name.

	parent_type: CL_TYPE_A
			-- Actual type of the parent.

	renaming: HASH_TABLE [RENAMING, INTEGER]
			-- Rename pairs with alias names (if any).

	redefining: SEARCH_TABLE [INTEGER]
			-- Redefinitions.

	undefining: SEARCH_TABLE [INTEGER]
			-- Definitions.

	selecting: SEARCH_TABLE [INTEGER]
			-- Selections.

	exports: EXPORT_ADAPTATION
			-- Export adaptation

feature

	is_non_conforming: BOOLEAN
			-- Is `Current' from a non-conforming inheritance branch?
		do
--			Result := False
		end

	new_export_for (feature_name_id: INTEGER; original_export: EXPORT_I): EXPORT_I
			-- Export status for feature named `feature_name_id` combined with its original export status `original_export`.
		require
			good_argument: feature_name_id > 0
		do
			if attached exports as e and then attached e.new_export_for (feature_name_id) as n then
				Result := n
				if not is_non_conforming then
						-- The new export status extends the inherited one.
					Result := Result.concatenation (original_export)
				end
			else
				Result := original_export
			end
		end

	class_name: STRING
			-- Parent class name
		require
			parent_exists: parent /= Void;
		do
			Result := parent.name;
		end;

	set_parent_type (t: like parent_type)
			-- Assign `parent_type' to `parent_type'.
		do
			parent_type := t;
		end;

	set_renaming (t: like renaming)
			-- Assign `t' to `renaming'.
		do
			renaming := t;
		end;

	set_redefining (t: like redefining)
			-- Assign `t' to `redefining'.
		do
			redefining := t;
		end;

	set_undefining (t: like undefining)
			-- Assign `t' to `undefining'.
		do
			undefining := t
		end;

	set_selecting (t: like selecting)
			-- Assign `t' to `selecting'.
		do
			selecting := t;
		end;

	set_exports (e: like exports)
			-- Assign `e' to `exports'.
		do
			exports := e;
		end;

	parent: CLASS_C
			-- Parent class
		do
			Result := parent_type.base_class
		end;

	has_renaming: BOOLEAN
			-- Does `Current' renaming any features?
		do
			Result := renaming /= Void and then renaming.count > 0
		end

	is_renaming (feature_name_id: INTEGER): BOOLEAN
			-- Is the current parent renaming `feature_name_id'?
		do
			Result := renaming /= Void and then renaming.has (feature_name_id)
		end;

	is_redefining (feature_name_id: INTEGER): BOOLEAN
			-- is the current parent redefining `feature_name_id'?
		do
			Result := redefining /= Void and then redefining.has (feature_name_id)
		end

	has_redefining: BOOLEAN
			-- Does `Current' redefine any features?
		do
			Result := redefining /= Void and then redefining.count > 0
		end

	has_undefining: BOOLEAN
			-- Does `Current' undefine any features?
		do
			Result := undefining /= Void and then undefining.count > 0
		end

	is_undefining (feature_name_id: INTEGER): BOOLEAN
			-- Is the current parent undefining `feature_name_id'?
		do
			Result := undefining /= Void and then undefining.has (feature_name_id)
		end

	is_selecting (feature_name_id: INTEGER): BOOLEAN
			-- Is the current parent selecting `feature_name_id'?
		do
			Result := attached selecting as s and then s.has (feature_name_id)
		end

	check_validity1
			-- Check validity of renamings.
		local
			parent_table: FEATURE_TABLE
			vhrc1: VHRC1
			vhrc4: VHRC4
			vhrc5: VHRC5
			vfav: VFAV_VHRC
			old_name_id: INTEGER
			old_name: STRING
			feature_renaming: RENAMING
			new_name: STRING
			alias_name_id: like {NAMES_HEAP}.id_of
			i, n: like {RENAMING}.alias_name_id.lower
			alias_name: READABLE_STRING_8
			f: FEATURE_I
			local_renaming: like renaming
		do
			local_renaming := renaming
			if local_renaming /= Void then
				from
					parent_table := parent.feature_table
						-- We have to work on a copy because the code below
						-- in `check_inherited_name' needs to modify `renaming'.
						-- When support for `infix/prefix' is completely dropped then
						-- we can remove the line below for improving performance.
					local_renaming := local_renaming.twin
					local_renaming.start
				until
					local_renaming.after
				loop
					old_name_id := local_renaming.key_for_iteration
					old_name := names_heap.item (old_name_id)
					feature_renaming := local_renaming.item_for_iteration
					new_name := names_heap.item (feature_renaming.feature_name_id)
					check_inherited_name (old_name_id, parent_table)
					if not has_inherited_name then
						create vhrc1
						vhrc1.set_class (System.current_class)
						vhrc1.set_parent (parent)
						vhrc1.set_feature_name (old_name)
						Error_handler.insert_error (vhrc1)
					elseif is_mangled_infix (new_name) then
						f := inherited_feature
						if f.argument_count /= 1 or else f.type.is_void then
							create vhrc5
							vhrc5.set_class (System.current_class)
							vhrc5.set_parent (parent)
							vhrc5.set_feature_name (old_name)
							Error_handler.insert_error (vhrc5)
						end;
					elseif is_mangled_prefix (new_name) then
						f := inherited_feature
						if f.argument_count /= 0 or else f.type.is_void then
							create vhrc4
							vhrc4.set_class (System.current_class)
							vhrc4.set_parent (parent)
							vhrc4.set_feature_name (old_name)
							Error_handler.insert_error (vhrc4)
						end
					elseif attached feature_renaming.alias_name_id as alias_name_ids then
						f := inherited_feature
						from
							i := alias_name_ids.lower
							n := alias_name_ids.upper
						until
							i > n
						loop
							alias_name_id := alias_name_ids [i]
							vfav := Void
							if alias_name_id = {PREDEFINED_NAMES}.bracket_symbol_id then
								if f.argument_count = 0 or else f.type.is_void then
										-- Bracket features should have at least one argument and a return type.
									create {VFAV2_VHRC} vfav
								elseif feature_renaming.has_convert_mark then
										-- Bracket alias cannot have convert mark
									create {VFAV5_VHRC} vfav
								end
							elseif alias_name_id = {PREDEFINED_NAMES}.parentheses_symbol_id then
								if f.argument_count = 0 then
										-- Parenthesis alias features should have at least one argument.
									create {VFAV3_VHRC} vfav
								elseif feature_renaming.has_convert_mark then
										-- Parenthesis alias cannot have convert mark
									create {VFAV5_VHRC} vfav
								end
							else
								alias_name := extract_alias_name (names_heap.item (alias_name_id))
								if
									not f.type.is_void and then
									(f.argument_count = 0 and then is_valid_unary_operator (alias_name) or else
									f.argument_count = 1 and then is_valid_binary_operator (alias_name))
								then
									if f.argument_count = 1 then
											-- Ensure the alias name is in binary form.
										names_heap.put (infix_feature_name_with_symbol (alias_name))
										if feature_renaming.alias_name_id = alias_name_ids then
												-- Avoid changing original aliases/
											feature_renaming.set_alias_name_id (alias_name_ids.twin)
										end
										feature_renaming.alias_name_id [i] := names_heap.found_item
									else
											-- Ensure the alias name is in unary form.
										names_heap.put (prefix_feature_name_with_symbol (alias_name))
										if feature_renaming.alias_name_id = alias_name_ids then
												-- Avoid changing original aliases/
											feature_renaming.set_alias_name_id (alias_name_ids.twin)
										end
										feature_renaming.alias_name_id [i] := names_heap.found_item
										if feature_renaming.has_convert_mark then
												-- Unary operator cannot have convert mark
											create {VFAV5_VHRC} vfav
										end
									end
								else
										-- Report wrong argument number or return type for operator alias.
									create {VFAV1_VHRC} vfav
								end
							end
							if vfav /= Void then
								vfav.set_class (System.current_class)
								vfav.set_parent (parent)
								vfav.set_feature_name (old_name)
								Error_handler.insert_error (vfav)
							end
							i := i + 1
						end
					end
						-- Remove it from memory since we do not need it anymore.
					inherited_feature := Void
					local_renaming.forth
				end
			end
		end

	check_validity2
			-- Check validity of the exports, undefine, redefine and select clauses.
			-- `table' is the feature table produced by the second pass
		local
			parent_table: FEATURE_TABLE
			feature_name_id: INTEGER
			real_name_id: INTEGER
			vdrs1: VDRS1
			vmss1: VMSS1
			vdus1: VDUS1
			vlel2: VLEL2
			local_redefining: like redefining
			local_selecting: like selecting
			local_undefining: like undefining
			local_exports: EXPORT_ADAPTATION
		do
			parent_table := parent.feature_table
			local_redefining := redefining
			if local_redefining /= Void then
				from
					local_redefining.start
				until
					local_redefining.after
				loop
					feature_name_id := local_redefining.item_for_iteration
						-- Take care of renaming
					real_name_id := renaming_of (feature_name_id)
					if real_name_id > 0 then
						check_inherited_name (real_name_id, parent_table)
					end
					if real_name_id <= 0 or not has_inherited_name then
						create vdrs1
						vdrs1.set_class (System.current_class)
						vdrs1.set_parent (parent)
						vdrs1.set_feature_name (names_heap.item (feature_name_id))
						Error_handler.insert_error (vdrs1)
					end

					local_redefining.forth
				end
			end

			local_selecting := selecting
			if local_selecting /= Void then
				from
					local_selecting.start
				until
					local_selecting.after
				loop
					feature_name_id := local_selecting.item_for_iteration
						-- Take care of renaming
					real_name_id := renaming_of (feature_name_id)
					if real_name_id > 0 then
						check_inherited_name (real_name_id, parent_table)
					end
					if real_name_id <= 0 or not has_inherited_name then
						create vmss1
						vmss1.set_class (System.current_class)
						vmss1.set_parent (parent)
						vmss1.set_feature_name (names_heap.item (feature_name_id))
						Error_handler.insert_error (vmss1)
					end

					local_selecting.forth
				end
			end

			local_undefining := undefining
			if local_undefining /= Void then
				from
					local_undefining.start
				until
					local_undefining.after
				loop
					feature_name_id := local_undefining.item_for_iteration
						-- Take care of renaming
					real_name_id := renaming_of (feature_name_id)
					if real_name_id > 0 then
						check_inherited_name (real_name_id, parent_table)
					end
					if real_name_id <= 0 or not has_inherited_name then
						create vdus1
						vdus1.set_class (System.current_class)
						vdus1.set_parent (parent)
						vdus1.set_feature_name (names_heap.item (feature_name_id))
						Error_handler.insert_error (vdus1)
					end

					local_undefining.forth
				end
			end

			local_exports := exports
			if local_exports /= Void then
				from
					local_exports.start
				until
					local_exports.after
				loop
					feature_name_id := local_exports.key_for_iteration
						-- Take care of renamings
					real_name_id := renaming_of (feature_name_id)
					if real_name_id > 0 then
						check_inherited_name (real_name_id, parent_table)
					end
					if real_name_id <= 0 or not has_inherited_name then
						create vlel2
						vlel2.set_class (System.current_class)
						vlel2.set_parent (parent)
						vlel2.set_feature_name (names_heap.item (feature_name_id))
						Error_handler.insert_error (vlel2)
					end
					local_exports.forth
				end
			end
		end

	check_validity4
			-- Look for useless selections
		require
			has_selection: selecting /= Void
		local
			vmss2: VMSS2
			local_selecting: like selecting
			local_selected: like selected
		do
			from
				local_selecting := selecting
				local_selected := selected
				local_selecting.start
			until
				local_selecting.after
			loop
				local_selected.start
				local_selected.compare_objects
				local_selected.search (local_selecting.item_for_iteration)
				if local_selected.after then
					create vmss2
					vmss2.set_class (System.current_class)
					vmss2.set_parent (parent)
					vmss2.set_feature_name (names_heap.item (selecting.item_for_iteration))
					Error_handler.insert_error (vmss2)
				end
				local_selecting.forth
			end
		end

	renaming_of (feature_name_id: INTEGER): INTEGER
			-- Original name associated to `feature_name_id'
		require
			good_argument: feature_name_id > 0
		local
			new_name_id: INTEGER
			local_renaming: like renaming
		do
			local_renaming := renaming
			if local_renaming /= Void then
				from
					local_renaming.start
				until
					local_renaming.after or else Result > 0
				loop
					new_name_id := local_renaming.item_for_iteration.feature_name_id
					if new_name_id = feature_name_id then
						Result := local_renaming.key_for_iteration
					end
					local_renaming.forth
				end
				if Result <= 0 and then not local_renaming.has (feature_name_id) then
					Result := feature_name_id
				end
			else
				Result := feature_name_id
			end
		end

feature -- Debug

	trace
		do
			io.error.put_string ("PARENT_C ")
			io.error.put_string (class_name)
			io.error.put_new_line
			if renaming /= Void then
				io.error.put_string ("%TRenamings:%N")
				from
					renaming.start
				until
					renaming.after
				loop
					io.error.put_string ("%T%T")
					io.error.put_string (names_heap.item (renaming.key_for_iteration))
					io.error.put_string (" as ")
					io.error.put_string (names_heap.item (renaming.item_for_iteration.feature_name_id))
					if attached renaming.item_for_iteration.alias_name_id as alias_ids then
						across
							alias_ids as alias_id
						loop
							io.error.put_string (" alias %"")
							io.error.put_string (names_heap.item (alias_id.item))
							io.error.put_character ('"')
						end
					end
					if renaming.item_for_iteration.has_convert_mark then
						io.error.put_string (" convert")
					end
					io.error.put_new_line
					renaming.forth
				end
			end
			if redefining /= Void then
				io.error.put_string ("%TRedefinitions:%N")
				trace_list (redefining)
			end
			if undefining /= Void then
				io.error.put_string ("%TUndefinitions:%N")
				trace_list (undefining)
			end
			if selecting /= Void then
				io.error.put_string ("%TSelections:%N")
				trace_list (selecting)
			end
		end

	trace_list (a_list: SEARCH_TABLE [INTEGER])
		do
			from
				a_list.start
			until
				a_list.after
			loop
				io.error.put_string ("%T%T")
				io.error.put_string (names_heap.item (a_list.item_for_iteration))
				io.error.put_new_line
				a_list.forth
			end
		end

feature {NONE} -- Implementation

	has_inherited_name: BOOLEAN
			-- Check if last call to `check_inherited_name' was successful.

	inherited_feature: detachable FEATURE_I
			-- Object associated to found feature in `check_inherited_name'.
			-- Void if not found.

	check_inherited_name (a_name_id: INTEGER; a_feat_tbl: FEATURE_TABLE)
			-- Does `a_name_id' exist in `a_feat_tbl' taken into account
			-- that if `a_name_id' is a prefix/infix name, and not present
			-- in the ancestor, we check if there is an alias routine with
			-- the same operator.
			-- Set `has_inherited_name' to True if found, False otherwise.
			-- Set `inherited_feature' with feature found, Void otherwise.
		require
			a_name_id_positive: a_name_id > 0
			a_feat_tbl_attached: a_feat_tbl /= Void
		local
			l_name: STRING
		do
			inherited_feature := a_feat_tbl.item_id (a_name_id)
			has_inherited_name := inherited_feature /= Void
			if not has_inherited_name then
				l_name := names_heap.item (a_name_id)
				if is_mangled_infix (l_name) or is_mangled_prefix (l_name) then
					inherited_feature := a_feat_tbl.item_alias_id (a_name_id)
					has_inherited_name := inherited_feature /= Void
					if has_inherited_name then
							-- Find out if there is already a rename clause for `a_name_id', if one is
							-- found, we replace its content with the real inherited name (i.e. the alias
							-- version). If not, we create a new rename entry which uses as old name
							-- the inherited name and the infix/prefix name as new name.
						if renaming /= Void then
							renaming.search (a_name_id)
						end
						if renaming /= Void and then renaming.found then
								-- We replace the exiting renaming `infix "op" as XXX' into
								-- `yyy alias "op" as XXX'.
							renaming.replace_key (inherited_feature.feature_name_id, a_name_id)
						else
							if renaming = Void then
								create renaming.make (1)
							end
							renaming.put (create {RENAMING}.make (a_name_id, create {SPECIAL [like {NAMES_HEAP}.found_item]}.make_filled (a_name_id, 1),
								inherited_feature.has_convert_mark), inherited_feature.feature_name_id)
						end
					end
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
