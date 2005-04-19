indexing
	description: "Create a PARENT_C instance from a PARENT_AS one."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_PARENT_C_GENERATOR

inherit
	AST_EXPORT_STATUS_GENERATOR
		redefine
			process_parent_as,
			process_export_item_as,
			process_feature_list_as,
			process_all_as,
			reset
		end

feature -- Status report

	compiled_parent (a_class: CLASS_C; a_parent: PARENT_AS): PARENT_C is
			-- Compiled version of a parent. The second pass needs:
			-- 1. Internal name for features, that means infix/prefix
			--	features must have a string name
			-- 2. Search table for renaming, redefining, defining and
			--	selecting clauses (which are more efficient than
			--	simple fixed lists for queries).
		require
			a_class_not_void: a_class /= Void
			a_parent_not_void: a_parent /= Void
		do
			current_class := a_class
			process_parent_as (a_parent)
			Result := last_parent_c
		ensure
			compiled_parent_not_void: Result /= Void
		end

feature {NONE} -- Implementation: Reset

	reset is
		do
			last_parent_c := Void
			current_class := Void
			last_export_adaptation := Void
			last_export_status := Void
		end

feature {NONE} -- Implementation: Access

	last_parent_c: PARENT_C
			-- Last computed parent

	last_export_adaptation: EXPORT_ADAPTATION
			-- Last computed export adaptation

feature {NONE} -- Implementation

	process_parent_as (l_as: PARENT_AS) is
		local
			l_renaming_c: HASH_TABLE [STRING, STRING]
			l_rename_pair: RENAME_AS
			l_old_name, l_new_name: FEATURE_NAME
			l_vhrc2: VHRC2
			l_str: STRING
		do
			create last_parent_c
			last_parent_c.set_parent_type (l_as.type.actual_type)
			if l_as.exports /= Void then
				from
					create last_export_adaptation.make (5)
					last_parent_c.set_exports (last_export_adaptation)
					l_as.exports.start
				until
					l_as.exports.after
				loop
					process_export_item_as (l_as.exports.item)
					l_as.exports.forth
				end
			end
			if l_as.renaming /= Void then
				from
					create l_renaming_c.make (l_as.renaming.count)
					last_parent_c.set_renaming (l_renaming_c)
					l_as.renaming.start
				until
					l_as.renaming.after
				loop
					l_rename_pair := l_as.renaming.item
					l_old_name := l_rename_pair.old_name
					l_new_name := l_rename_pair.new_name
					l_str := l_old_name.internal_name
					if l_renaming_c.has (l_str) then
						create l_vhrc2
						l_vhrc2.set_class (current_class)
						l_vhrc2.set_parent (last_parent_c.parent)
						l_vhrc2.set_feature_name (l_old_name.internal_name)
						l_vhrc2.set_location (l_old_name.start_location)
						Error_handler.insert_error (l_vhrc2)
					else
						l_renaming_c.put (l_new_name.internal_name, l_str)
					end

					l_as.renaming.forth
				end
			end
			if l_as.redefining /= Void then
				last_parent_c.set_redefining (search_table (l_as, l_as.redefining, Redef))
			end
			if l_as.undefining /= Void then
				last_parent_c.set_undefining (search_table (l_as, l_as.undefining, Undef))
			end
			if l_as.selecting /= Void then
				last_parent_c.set_selecting (search_table (l_as, l_as.selecting, Selec))
			end
		end

	process_export_item_as (l_as: EXPORT_ITEM_AS) is
		do
			l_as.clients.process (Current)
			check
				last_export_status_set: last_export_status /= Void
			end
			l_as.features.process (Current)
		end
		
	process_feature_list_as (l_as: FEATURE_LIST_AS) is
		local
			l_feature_name: STRING
			l_vlel3: VLEL3
			l_export_status: like last_export_status
			l_export_adapt: like last_export_adaptation
		do
			from
				l_as.features.start
				l_export_status := last_export_status
				l_export_adapt := last_export_adaptation
			until
				l_as.features.after
			loop
				l_feature_name := l_as.features.item.internal_name
				if not l_export_adapt.has (l_feature_name) then
					l_export_adapt.put (l_export_status, l_feature_name)
				else
					create l_vlel3
					l_vlel3.set_class (current_class)
					l_vlel3.set_parent (last_parent_c.parent)
					l_vlel3.set_feature_name (l_feature_name)
					l_vlel3.set_location (l_as.features.item.start_location)
					error_handler.insert_error (l_vlel3)
				end
				l_as.features.forth
			end
		end

	process_all_as (l_as: ALL_AS) is
		local
			l_vlel1: VLEL1
		do
			if last_export_adaptation.all_export = Void then
				last_export_adaptation.set_all_export (last_export_status)
			else
				create l_vlel1
				l_vlel1.set_class (current_class)
				l_vlel1.set_parent (last_parent_c.parent)
				l_vlel1.set_location (l_as.start_location)
				error_handler.insert_error (l_vlel1)
			end		
		end
		
feature {NONE} -- Implementation

	search_table (l_as: PARENT_AS; clause: EIFFEL_LIST [FEATURE_NAME]; flag: INTEGER): SEARCH_TABLE [STRING] is
			-- Conversion of `clause' into a search table
		require
			l_as_not_void: l_as /= Void
			clause_exists: clause /= Void
		local
			l_vdrs3: VDRS3
			l_str: STRING
		do
			from
				create Result.make (clause.count)
				clause.start
			until
				clause.after
			loop
				l_str := clause.item.internal_name;	
				if Result.has (l_str) then
						-- Twice the same name in a parent clause
					inspect
						flag
					when Redef then
						create l_vdrs3
					when Undef then
						create {VDUS4} l_vdrs3
					when Selec then
						create {VMSS3} l_vdrs3
					end
					l_vdrs3.set_class (current_class)
					l_vdrs3.set_parent_name (l_as.type.class_name)
					l_vdrs3.set_feature_name (clause.item.internal_name)
					l_vdrs3.set_location (clause.item.start_location)
					Error_handler.insert_error (l_vdrs3)
				else
					Result.put (l_str)
				end
				clause.forth
			end
		end

feature {NONE} -- Implementation

	Redef: INTEGER is 1
	Undef: INTEGER is 2
	Selec: INTEGER is 3

end
