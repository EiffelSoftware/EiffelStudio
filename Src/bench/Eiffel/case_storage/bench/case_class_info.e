-- Class information relevant for EiffelCase
class CASE_CLASS_INFO

inherit
	
	SHARED_WORKBENCH;
	SHARED_INST_CONTEXT;
	SHARED_CASE_INFO;

creation

	make

feature {NONE}

	make (c: like classc) is
		do
			classc := c
		end;

feature {CASE_CLUSTER_INFO}

	s_class_data: S_CLASS_DATA;
			-- Class data for EiffelCase

	classc: CLASS_C;
			-- Class to be used for case information

	formulate_class_data (flat_struct: FLAT_STRUCT) is
			-- Record renamings, suppliers, parents, is_def ...
			-- in `s_class_data'. 
		require
			valid_classc: classc /= Void;
		local
			class_ast: CLASS_AS_B;
			record_relation_com: CASE_RECORD_SUPPLIERS;
			record_inherit_info_com: CASE_RECORD_INHERIT_INFO;
			record_chart_info_com: CASE_RECORD_CHART_INFO
		do
			flat_struct.set_class (classc);
			flat_struct.fill (True);
			class_ast := flat_struct.ast;
			Inst_context.set_cluster (classc.cluster);
				-- Record index, and name
			s_class_data := class_ast.header_storage_info (classc);
				-- Record id
			s_class_data.set_id (classc.id);
				-- Record features, invariant
			flat_struct.store_case_information (s_class_data);
				-- Record base file name
			s_class_data.set_file_name (classc.lace_class.base_name);
				-- Must have processed the features
				-- before we do the final process of the
				-- class for renamings and redefinitions.
				-- Record renamings, suppliers, parents, is_def ...
			Inst_context.set_cluster (Void);
			s_class_data.set_booleans (classc.is_deferred,
					False, 
					classc.feature_table.has_introduced_new_externals,
					False,
					False,
					classc.class_name.is_equal (System.root_class_name));
						-- The above is possible since there is
						-- no renaming of classes in the compiler yet.

				-- Record other case information
			!! record_relation_com.make (classc, s_class_data);
			record_relation_com.execute;
			!! record_inherit_info_com.make (classc, s_class_data);
			record_inherit_info_com.execute;

				-- removed: processing is done by EiffelCase
			--!! record_chart_info_com.make (classc, s_class_data);
			--record_chart_info_com.execute;

			process_old_info;
		end


	process_old_info is
				-- Get old descrition and explanation for data (if any) 
				-- and update s_class_data
		local
			old_class_info: OLD_CASE_LINKABLE_INFO;
		do
			old_class_info := old_classes_info.item (s_class_data.name);
			if old_class_info /= Void then
				if old_class_info.description /= Void then
					s_class_data.set_description (old_class_info.description)
				end
				if old_class_info.explanation /= Void then
					s_class_data.set_explanation 
						(old_class_info.explanation)
				end
			end;
		end;

end
