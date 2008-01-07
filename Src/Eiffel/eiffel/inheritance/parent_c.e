indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Compiled representation of a parent

class PARENT_C

inherit

	EIFFEL_SYNTAX_CHECKER
		export
			{NONE} all
		end

	PREDEFINED_NAMES
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

feature

	parent_type: CL_TYPE_A
			-- Actual type of the parent

	renaming: HASH_TABLE [RENAMING, INTEGER]
			-- Rename pairs with alias names (if any)

	redefining: SEARCH_TABLE [INTEGER]
			-- Redefinitions

	undefining: SEARCH_TABLE [INTEGER]
			-- Definitions

	selecting: SEARCH_TABLE [INTEGER]
			-- Selections

	exports: EXPORT_ADAPTATION
			-- Export adaptation

	new_export_for (feature_name_id: INTEGER): EXPORT_I is
			-- New export status for feature named `feature_name_id'.
			-- Void if none.
		require
			good_argument: feature_name_id > 0
		do
			if exports /= Void then
				Result := exports.new_export_for (feature_name_id)
			end
		end

	class_name: STRING is
			-- Parent class name
		require
			parent_exists: parent /= Void;
		do
			Result := parent.name;
		end;

	set_parent_type (t: like parent_type) is
			-- Assign `parent_type' to `parent_type'.
		do
			parent_type := t;
		end;

	set_renaming (t: like renaming) is
			-- Assign `t' to `renaming'.
		do
			renaming := t;
		end;

	set_redefining (t: like redefining) is
			-- Assign `t' to `redefining'.
		do
			redefining := t;
		end;

	set_undefining (t: like undefining) is
			-- Assign `t' to `undefining'.
		do
			undefining := t
		end;

	set_selecting (t: like selecting) is
			-- Assign `t' to `selecting'.
		do
			selecting := t;
		end;

	set_exports (e: like exports) is
			-- Assign `e' to `exports'.
		do
			exports := e;
		end;

	parent: CLASS_C is
			-- Parent class
		do
			Result := parent_type.associated_class
		end;

	is_renaming (feature_name_id: INTEGER): BOOLEAN is
			-- Is the current parent renaming `feature_name_id'?
		do
			Result := 	renaming /= Void
						and then renaming.has (feature_name_id)
		end;

	is_redefining (feature_name_id: INTEGER): BOOLEAN is
			-- is the current parent redefining `feature_name_id'?
		do
			Result := 	redefining /= Void
						and then
						redefining.has (feature_name_id)
		end

	is_undefining (feature_name_id: INTEGER): BOOLEAN is
			-- Is the current parent undefining `feature_name_id'?
		do
			Result :=	undefining /= Void
						and then
						undefining.has (feature_name_id)
		end

	is_selecting (feature_name_id: INTEGER): BOOLEAN is
			-- Is the current parent selecting `feature_name_id'?
		do
			Result :=	selecting /= Void
						and then
						selecting.has (feature_name_id)
		end

	check_validity1 is
			-- Check validity of renamings
		local
			parent_table: FEATURE_TABLE
			vhrc1: VHRC1
			vhrc4: VHRC4
			vhrc5: VHRC5
			vfav: VFAV_VHRC
			old_name_id: INTEGER
			old_name: STRING
			feature_renaming: RENAMING
			new_name_id: INTEGER
			new_name: STRING
			alias_name_id: INTEGER
			alias_name: STRING
			f: FEATURE_I
			local_renaming: like renaming
		do
			local_renaming := renaming
			if local_renaming /= Void then
				from
					parent_table := parent.feature_table
					local_renaming.start
				until
					local_renaming.after
				loop
					old_name_id := local_renaming.key_for_iteration
					old_name := names_heap.item (old_name_id)
					feature_renaming := local_renaming.item_for_iteration
					new_name_id := feature_renaming.feature_name_id
					new_name := names_heap.item (new_name_id)
					alias_name_id := feature_renaming.alias_name_id
					if not parent_table.has_id (old_name_id) then
						create vhrc1
						vhrc1.set_class (System.current_class)
						vhrc1.set_parent (parent)
						vhrc1.set_feature_name (old_name)
						Error_handler.insert_error (vhrc1)
					elseif is_mangled_infix (new_name) then
						f := parent_table.item_id (old_name_id)
						if f.argument_count /= 1 or else f.type.is_void then
							create vhrc5
							vhrc5.set_class (System.current_class)
							vhrc5.set_parent (parent)
							vhrc5.set_feature_name (old_name)
							Error_handler.insert_error (vhrc5)
						end;
					elseif is_mangled_prefix (new_name) then
						f := parent_table.item_id (old_name_id)
						if f.argument_count /= 0 or else f.type.is_void then
							create vhrc4
							vhrc4.set_class (System.current_class)
							vhrc4.set_parent (parent)
							vhrc4.set_feature_name (old_name)
							Error_handler.insert_error (vhrc4)
						end
					elseif alias_name_id > 0 then
						vfav := Void
						f := parent_table.item_id (old_name_id)
						if alias_name_id = bracket_symbol_id then
							if f.argument_count = 0 or else f.type.is_void then
									-- Bracket features should have at least one argument and a return type.
								create {VFAV2_VHRC} vfav
							elseif feature_renaming.has_convert_mark then
									-- Bracket alias cannot have convert mark
								create {VFAV3_VHRC} vfav
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
									local_renaming.item_for_iteration.set_alias_name_id (names_heap.found_item)
								else
										-- Ensure the alias name is in unary form.
									names_heap.put (prefix_feature_name_with_symbol (alias_name))
									local_renaming.item_for_iteration.set_alias_name_id (names_heap.found_item)
									if feature_renaming.has_convert_mark then
											-- Unary operator cannot have convert mark
										create {VFAV3_VHRC} vfav
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
					end
					local_renaming.forth
				end
			end
		end

	check_validity2 is
			-- Check validity of the redefine clause and select clause.
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

					if real_name_id <= 0 or else not parent_table.has_id (real_name_id) then
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

					if real_name_id <= 0 or else not parent_table.has_id (real_name_id) then
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

					if real_name_id <= 0 or else not parent_table.has_id (real_name_id) then
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

					if real_name_id <= 0 or else not parent_table.has_id (real_name_id) then
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

	check_validity4 is
			-- Look for useless selections
		require
			has_selection: selecting /= Void
		local
			vmss2: VMSS2
			local_selecting: SEARCH_TABLE [INTEGER]
			local_selected: LINKED_LIST [INTEGER]
		do
			from
				local_selecting := selecting
				local_selected := Selected
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

	renaming_of (feature_name_id: INTEGER): INTEGER is
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

	trace is
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
					if renaming.item_for_iteration.alias_name_id > 0 then
						io.error.put_string (" alias %"")
						io.error.put_string (names_heap.item (renaming.item_for_iteration.alias_name_id))
						io.error.put_string ("%"")
						if renaming.item_for_iteration.has_convert_mark then
							io.error.put_string (" convert")
						end
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

	trace_list (a_list: SEARCH_TABLE [INTEGER]) is
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
