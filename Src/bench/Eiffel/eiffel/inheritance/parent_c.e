-- Compiled representation of a parent

class PARENT_C 

inherit

	SHARED_WORKBENCH;
	SHARED_SELECTED;
	SHARED_ERROR_HANDLER;
	COMPILER_EXPORTER
	
feature 

	parent_type: CL_TYPE_A;
			-- Actual type of the parent

	renaming: EXTEND_TABLE [STRING, STRING];
			-- Rename pairs

	redefining: SEARCH_TABLE [STRING];
			-- Redefinitions

	undefining: SEARCH_TABLE [STRING];
			-- Definitions

	selecting: SEARCH_TABLE [STRING];
			-- Selections

	exports: EXPORT_ADAPTATION;
			-- Export adaptation

	new_export_for (feature_name: STRING): EXPORT_I is
			-- New export status for feature named `feature_name'.
			-- Void if none.
		require
			good_argument: feature_name /= Void;
		do
			if exports /= Void then
				Result := exports.new_export_for (feature_name);
			end;
		end;

	class_name: STRING is
			-- Parent class name
		require
			parent_exists: parent /= Void;
		do
			Result := parent.name;
		end;

	set_parent_type (t: CL_TYPE_A) is
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
			Result := System.class_of_id (parent_id);
		end;

	parent_id: INTEGER is
			-- Parent class id
		do
			Result := parent_type.base_class_id
		end;

	has_renamed (feature_name: STRING): BOOLEAN is
			-- Is the current parent renamed a feature to `feature_name' ?
		local
			local_renaming: EXTEND_TABLE [STRING, STRING]
		do
			local_renaming := renaming
			if local_renaming /= Void then
				from
					local_renaming.start
				until
					local_renaming.after or else Result
				loop
					Result := local_renaming.item_for_iteration.is_equal (feature_name);
					local_renaming.forth
				end
			end;
		end;

	is_renaming (feature_name: STRING): BOOLEAN is
			-- Is the current parent renaming `feature_name' ?
		do
			Result := 	renaming /= Void
						and then
						renaming.has (feature_name);
		end;

	is_redefining (feature_name: STRING): BOOLEAN is
			-- is the current parent redefining `feature_name' ?
		do
			Result := 	redefining /= Void
						and then
						redefining.has (feature_name);
		end;

	is_undefining (feature_name: STRING): BOOLEAN is
			-- Is the current parent undefining `feature_name' ?
		do
			Result :=	undefining /= Void
						and then
						undefining.has (feature_name);
		end;

	is_selecting (feature_name: STRING): BOOLEAN is
			-- Is the current parent selecting `feature_name' ?
		do
			Result :=	selecting /= Void
						and then
						selecting.has (feature_name);
		end;

	check_validity1 is
			-- Check validity of renamings
		local
			parent_table: FEATURE_TABLE;
			vhrc1: VHRC1;
			vhrc3: VHRC3;
			vhrc4: VHRC4;
			vhrc5: VHRC5;
			old_name, new_name: STRING;
			f: FEATURE_I;
			local_renaming: EXTEND_TABLE [STRING, STRING]
		do
			local_renaming := renaming
			if local_renaming /= Void then
				from
					parent_table := parent.feature_table;
					local_renaming.start
				until
					local_renaming.after
				loop
					old_name := local_renaming.key_for_iteration;
					new_name := local_renaming.item_for_iteration;
					if old_name.is_equal (new_name) then
						!!vhrc3;
						vhrc3.set_class (System.current_class);
						vhrc3.set_parent (parent);
						vhrc3.set_feature_name (old_name);
						Error_handler.insert_error (vhrc3);
					elseif not parent_table.has (old_name) then
						!!vhrc1;
						vhrc1.set_class (System.current_class);
						vhrc1.set_parent (parent);
						vhrc1.set_feature_name (old_name);
						Error_handler.insert_error (vhrc1);
					elseif is_infix (new_name) then
						f := parent_table.item (old_name);
						if
							(f.argument_count /= 1)
						or else
							(f.type.is_void)
						then
							!!vhrc5;
							vhrc5.set_class (System.current_class);
							vhrc5.set_parent (parent);
							vhrc5.set_feature_name (old_name);
							Error_handler.insert_error (vhrc5);
						end;
					elseif is_prefix (new_name) then
						f := parent_table.item (old_name);
						if
							(f.argument_count /= 0)
						or else
							(f.type.is_void)
						then
							!!vhrc4;
							vhrc4.set_class (System.current_class);
							vhrc4.set_parent (parent);
							vhrc4.set_feature_name (old_name);
							Error_handler.insert_error (vhrc4);
						end;
					end;
					local_renaming.forth
				end;
			end;
		end;

	is_infix (s: STRING): BOOLEAN is
			-- Is `s' the internal name of an infix feature ?
		local
			pre: STRING;
		do
			if s.count > 7 then
				pre := s.substring (1, 7);
				Result := pre.is_equal ("_infix_")
			end;
		end;

	is_prefix (s: STRING): BOOLEAN is
			-- Is `s' the internal name of a prefix feature ?
		local
			pre: STRING;
		do
			if s.count > 8 then
				pre := s.substring (1, 8);
				Result := pre.is_equal ("_prefix_")
			end;
		end;

	check_validity2 is
			-- Check validity of the redefine clause and select clause.
			-- `table' is the feature table produced by the second pass
		local
			parent_table: FEATURE_TABLE;
			feature_name, real_name: STRING;
			vdrs1: VDRS1;
			vmss1: VMSS1;
			vdus1: VDUS1;
			vlel2: VLEL2;
			local_redefining: SEARCH_TABLE [STRING]
			local_selecting: SEARCH_TABLE [STRING]
			local_undefining: SEARCH_TABLE [STRING]
			local_exports: EXPORT_ADAPTATION
		do
			parent_table := parent.feature_table;
			local_redefining := redefining
			if local_redefining /= Void then
				from
					local_redefining.start
				until
					local_redefining.after
				loop
					feature_name := local_redefining.item_for_iteration;
						-- Take care of renaming
					real_name := renaming_of (feature_name);
					
					if real_name = Void or else not parent_table.has (real_name) then
						!!vdrs1;
						vdrs1.set_class (System.current_class);
						vdrs1.set_parent (parent);
						vdrs1.set_feature_name (feature_name);
						Error_handler.insert_error (vdrs1);
					end;

					local_redefining.forth;
				end;		
			end;

			local_selecting := selecting
			if local_selecting /= Void then
				from
					local_selecting.start
				until
					local_selecting.after
				loop	
					feature_name := local_selecting.item_for_iteration;
						-- Take care of renaming
					real_name := renaming_of (feature_name);

					if real_name = Void or else not parent_table.has (real_name) then
						!!vmss1;
						vmss1.set_class (System.current_class);
						vmss1.set_parent (parent);
						vmss1.set_feature_name (feature_name);
						Error_handler.insert_error (vmss1);
					end;

					local_selecting.forth;
				end;
			end;

			local_undefining := undefining
			if local_undefining /= Void then
				from
					local_undefining.start
				until	
					local_undefining.after
				loop
					feature_name := local_undefining.item_for_iteration;
						-- Take care of renaming
					real_name := renaming_of (feature_name);

					if real_name = Void or else not parent_table.has (real_name) then
						!!vdus1;
						vdus1.set_class (System.current_class);
						vdus1.set_parent (parent);
						vdus1.set_feature_name (feature_name);
						Error_handler.insert_error (vdus1);
					end;
	
					local_undefining.forth;
				end;
			end;

			local_exports := exports
			if local_exports /= Void then
				from
					local_exports.start
				until
					local_exports.after
				loop
					feature_name := local_exports.key_for_iteration;
						-- Take care of renamings
					real_name := renaming_of (feature_name);
	
					if real_name = Void or else not parent_table.has (real_name) then
						!!vlel2;
						vlel2.set_class (System.current_class);
						vlel2.set_parent (parent);
						vlel2.set_feature_name (feature_name);
						Error_handler.insert_error (vlel2);
					end;
					local_exports.forth;
				end;
			end;
		end;

	check_validity4 is
			-- Look for useless selections
		require
			has_selection: selecting /= Void;
		local
			vmss2: VMSS2;
			local_selecting: SEARCH_TABLE [STRING]
			local_selected: LINKED_LIST [STRING]
		do
			from
				local_selecting := selecting
				local_selected := Selected
				local_selecting.start
			until
				local_selecting.after
			loop
				local_selected.start;
				local_selected.compare_objects
				local_selected.search (local_selecting.item_for_iteration);
				if local_selected.after then
					!!vmss2;
					vmss2.set_class (System.current_class);
					vmss2.set_parent (parent);
					vmss2.set_feature_name (selecting.item_for_iteration);
					Error_handler.insert_error (vmss2);
				end;
				local_selecting.forth;
			end;
		end;

	renaming_of (feature_name: STRING): STRING is
			-- Original name associated to `feature_name'
		require
			good_argument: feature_name /= Void;
		local
			new_name: STRING;
			local_renaming: EXTEND_TABLE [STRING, STRING]
		do
			local_renaming := renaming
			if local_renaming /= Void then
				from
					local_renaming.start
				until
					local_renaming.after or else Result /= Void
				loop
					new_name := local_renaming.item_for_iteration;
					if new_name.is_equal (feature_name) then
						Result := local_renaming.key_for_iteration;
					end;
					local_renaming.forth;
				end;
				if Result = Void then
					if not local_renaming.has (feature_name) then
						Result := feature_name;
					end;
				end;
			else
				Result := feature_name;
			end;
		end;


feature -- Debug

	trace is
		do
			io.error.putstring ("PARENT_C ");
			io.error.putstring (class_name);
			io.error.new_line;
			if renaming /= Void then
			io.error.putstring ("%TRenamings:%N");
			from
				renaming.start
			until
				renaming.after
			loop
				io.error.putstring ("%T%T");
				io.error.putstring (renaming.key_for_iteration);
				io.error.putstring (" as ");
				io.error.putstring (renaming.item_for_iteration);
				io.error.new_line;
				renaming.forth
			end;
			end;
			if redefining /= Void then
				io.error.putstring ("%TRedefinitions:%N");
				trace_list (redefining);
			end;
			if undefining /= Void then
				io.error.putstring ("%TUndefinitions:%N");
				trace_list (undefining);
			end;
			if selecting /= Void then
				io.error.putstring ("%TSelections:%N");
				trace_list (selecting);
			end;
		end;

	trace_list (a_list: SEARCH_TABLE [STRING]) is
		do
			from
				a_list.start
			until
				a_list.after
			loop
				io.error.putstring ("%T%T");
				io.error.putstring (a_list.item_for_iteration);
				io.error.new_line;
				a_list.forth
			end;
		end;

end
