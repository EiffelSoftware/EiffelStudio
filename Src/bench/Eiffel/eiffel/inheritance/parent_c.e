-- Compiled representation of a parent

class PARENT_C 

inherit

	SHARED_WORKBENCH;
	SHARED_SELECTED;
	SHARED_ERROR_HANDLER;
	
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
			Result := parent.class_name;
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
			Result := parent_type.base_type;
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
		do
			if renaming /= Void then
				from
					parent_table := parent.feature_table;
					renaming.start
				until
					renaming.offright
				loop
					if not parent_table.has (renaming.key_for_iteration) then
						!!vhrc1;
						vhrc1.set_class_id (System.current_class.id);
						vhrc1.set_parent_id (parent_id);
						vhrc1.set_feature_name (renaming.key_for_iteration);
						Error_handler.insert_error (vhrc1);
					end;
					renaming.forth
				end;
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
		do
			parent_table := parent.feature_table;
			if redefining /= Void then
				from
					redefining.start
				until
					redefining.offright
				loop
					feature_name := redefining.item_for_iteration;
						-- Take care of renaming
					real_name := renaming_of (feature_name);
					
					if real_name = Void or else not parent_table.has (real_name) then
						!!vdrs1;
						vdrs1.set_class_id (System.current_class.id);
						vdrs1.set_parent_id (parent_id);
						vdrs1.set_feature_name (feature_name);
						Error_handler.insert_error (vdrs1);
					end;

					redefining.forth;
				end;		
			end;
			if selecting /= Void then
				from
					selecting.start
				until
					selecting.offright
				loop	
					feature_name := selecting.item_for_iteration;
						-- Take care of renaming
					real_name := renaming_of (feature_name);

					if real_name = Void or else not parent_table.has (real_name) then
						!!vmss1;
						vmss1.set_class_id (System.current_class.id);
						vmss1.set_parent_id (parent_id);
						vmss1.set_feature_name (feature_name);
						Error_handler.insert_error (vmss1);
					end;

					selecting.forth;
				end;
			end;
			if undefining /= Void then
				from
					undefining.start
				until	
					undefining.offright
				loop
					feature_name := undefining.item_for_iteration;
						-- Take care of renaming
					real_name := renaming_of (feature_name);

					if real_name = Void or else not parent_table.has (real_name) then
						!!vdus1;
						vdus1.set_class_id (System.current_class.id);
						vdus1.set_parent_id (parent_id);
						vdus1.set_feature_name (feature_name);
						Error_handler.insert_error (vdus1);
					end;
	
					undefining.forth;
				end;
			end;
			if exports /= Void then
				from
					exports.start
				until
					exports.offright
				loop
					feature_name := exports.key_for_iteration;
						-- Take care of renamings
					real_name := renaming_of (feature_name);
	
					if real_name = Void or else not parent_table.has (real_name) then
						!!vlel2;
						vlel2.set_class_id (System.current_class.id);
                    	vlel2.set_parent_id (parent_id);
                    	vlel2.set_feature_name (feature_name);
                    	Error_handler.insert_error (vlel2);
                	end;
                	exports.forth;
				end;
			end;
		end;

	check_validity4 is
			-- Look for useless selections
		require
			has_selection: selecting /= Void;
		local
			vmss2: VMSS2;
		do
			from
				selecting.start
			until
				selecting.offright
			loop
				Selected.start;
				Selected.search_equal (selecting.item_for_iteration);
				if Selected.offright then
					!!vmss2;
					vmss2.set_class_id (System.current_class.id);
					vmss2.set_parent_id (parent_id);
					vmss2.set_feature_name (selecting.item_for_iteration);
					Error_handler.insert_error (vmss2);
				end;
				selecting.forth;
			end;
		end;

	renaming_of (feature_name: STRING): STRING is
			-- Original name associated to `feature_name'
		require
			good_argument: feature_name /= Void;
		local
			new_name: STRING;
		do
			if renaming /= Void then
				from
					renaming.start
				until
					renaming.offright or else Result /= Void
				loop
					new_name := renaming.item_for_iteration;
					if new_name.is_equal (feature_name) then
						Result := renaming.key_for_iteration;
					end;
					renaming.forth;
				end;
				if Result = Void then
					if not renaming.has (feature_name) then
						Result := feature_name;
					end;
				end;
			else
				Result := feature_name;
			end;
		end;

end
