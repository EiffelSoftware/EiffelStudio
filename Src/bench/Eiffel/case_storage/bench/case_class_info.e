-- Class information relevant for EiffelCase
class CASE_CLASS_INFO

inherit
	
	SHARED_INST_CONTEXT;
	SHARED_SERVER;
	S_CASE_INFO

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
			class_ast: CLASS_AS;
		do
			flat_struct.set_class (classc);
			flat_struct.fill (True);
			class_ast := flat_struct.ast;
			Inst_context.set_cluster (classc.cluster);
				-- Record index, and name
			s_class_data := class_ast.header_storage_info;
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
					False,
					False,
					False,
					classc.class_name.is_equal (System.root_class_name));
						-- The above is possible since there is
						-- no renaming of classes in the compiler yet.
			process_class_relations; 
			process_class_inherit_clause;
		end;

feature {NONE} -- Process Class information

	process_class_relations is
			-- Record parents and suppliers for class `classc' into
			-- `s_class_data'.
		do
			record_suppliers;
			record_parents;
		end;

	process_class_inherit_clause is
			-- Record renamings and redefinitions for class `classc' into
			-- `s_class_data'.
		local
			class_info: CLASS_INFO;
			parents: PARENT_LIST
		do
				-- Get class_info directly from disk
			class_info := Class_info_server.disk_item (classc.id);
			parents := class_info.parents;
			record_renamings (parents);
			record_redefinitions (parents);
		end;

feature {NONE} -- Recording information for eiffelcase

	record_suppliers is
		local
			suppliers: SUPPLIER_LIST;
			c_l: ARRAYED_LIST [S_CLI_SUP_DATA];
			cli_sup_data: S_CLI_SUP_DATA;
			sup_class_id, class_id: INTEGER;
			supplier: CLASS_C;
			label: STRING;
			gen_der_list: LINKED_LIST [GEN_TYPE_I];
			f_table: FEATURE_TABLE;
			feature_i: FEATURE_I;
			result_type: TYPE_A;
			feat_arg: FEAT_ARG
		do
			class_id := classc.id;
			suppliers := classc.suppliers;
			!! c_l.make (1);
			if not suppliers.empty and then suppliers.count > 1 then
					-- count > 1 is required since the class itself is always
					-- included
				from
					suppliers.start
				until
					suppliers.after
				loop
					if classc /= suppliers.item.supplier then
						!! cli_sup_data;
							-- For the moment let us assume that
							-- each supplier is the result of
							-- implementation.
						cli_sup_data.set_implementation (True);
						cli_sup_data.set_class_links (classc.id,
								suppliers.item.supplier.id);
						c_l.put_right (cli_sup_data);
						c_l.forth;
					end;
					suppliers.forth
				end;
				from
						-- Get it from the disk (don't need it in the server)
					f_table := Feat_tbl_server.disk_item (classc.id); 
					f_table.start
				until
					f_table.after
				loop
					feature_i := f_table.item_for_iteration;
					if feature_i.written_in = classc.id then
							-- First the result type
						result_type ?= feature_i.type;
						supplier := result_type.associated_class;
						if supplier /= Void then
							sup_class_id :=  supplier.id;
							from
								c_l.start
							until
								c_l.after or else 
								c_l.item.supplier = sup_class_id
							loop
								c_l.forth
							end;
							if not c_l.after then
								cli_sup_data := c_l.item;
								label := cli_sup_data.label;
								if label = Void then
									!! label.make (0);
									label.append (feature_i.feature_name);
									cli_sup_data.set_label (label);
								else
									label.append (", ");	
									label.append (feature_i.feature_name);
debug ("CASE")
	io.error.putstring ("%T%TSupplier: ");
	io.error.putstring (supplier.class_name);
	io.error.putstring (" is used for ");
	io.error.putstring (feature_i.feature_name);
	io.error.new_line;
end
								end;
								cli_sup_data.set_implementation (False);
							end;
						end;
						feat_arg := feature_i.arguments;
						if feat_arg /= Void then
							from
								feat_arg.start
							until
								feat_arg.after
							loop
								result_type ?= feat_arg.item;
								supplier := result_type.associated_class;
								if supplier /= Void then
									sup_class_id := supplier.id;
									from
										c_l.start
									until
										c_l.after or else 
										c_l.item.supplier.is_equal (class_id)
									loop
										c_l.forth
									end;
									if not c_l.after then
debug ("CASE")
	io.error.putstring ("%T%TSupplier: ");
	io.error.putstring (supplier.class_name);
	io.error.putstring (" is not implementation");
	io.error.new_line;
end
										c_l.item.set_implementation (False)
									end
								end
								feat_arg.forth
							end;
						end
					end;
					f_table.forth
				end
			end;
			if classc.generics /= Void then
					-- Check generic derivations
				gen_der_list := classc.filters;
				from
					gen_der_list.start
				until
					gen_der_list.after
				loop
					supplier := gen_der_list.item.base_class;
					sup_class_id := supplier.id;
					from
						c_l.start
					until
						c_l.after or else 
						c_l.item.supplier = sup_class_id
					loop
						c_l.forth
					end;
					if c_l.after then
							-- Not found
						!! cli_sup_data;
						cli_sup_data.set_class_links (class_id,
							sup_class_id);
						c_l.extend (cli_sup_data);
					end;
					if classc = supplier then
						cli_sup_data.set_is_reflexive
					end;
debug ("CASE")
	io.error.putstring ("%T%TGeneric Derivative Supplier: ");
	io.error.putstring (supplier.class_name);
	io.error.new_line;
end
					gen_der_list.forth
				end
			end;
			if not c_l.empty then
				s_class_data.set_client_links (c_l);
			end;
		end;

	record_parents is
			-- Record parents for class `classc' into `s_class_data'.
		local
			parents: FIXED_LIST [CL_TYPE_A];
			p_l: FIXED_LIST [S_RELATION_DATA];
			inherit_data: S_RELATION_DATA;
		do
			parents := classc.parents;
			if parents /= Void and then not parents.empty then
				!! p_l.make (parents.count);
				from
					parents.start;
					p_l.start
				until
					parents.after
				loop
					!! inherit_data;
					inherit_data.set_class_links (classc.id,
							parents.item.associated_class.id);
					p_l.replace (inherit_data);
					p_l.forth;
					parents.forth
				end;
				s_class_data.set_heir_links (p_l);
			end
		end;

	record_renamings (parents: PARENT_LIST) is
			-- Record renamings for class `classc' into `s_class_data'.
		local
			renaming: EXTEND_TABLE [STRING, STRING];
			features: ARRAYED_LIST [S_FEATURE_DATA];
			feature_data: S_FEATURE_DATA
			parent: PARENT_C;
			found: BOOLEAN;
			origin_class: CLASS_C;
			origin_feature: FEATURE_I;
			rename_data: S_RENAME_DATA;
			feature_i: FEATURE_I;
			feature_ast: FEATURE_AS;
			temp: STRING
		do
			features := s_class_data.features;
				-- Note: There are a test made to see if compiler information
				-- if valid (i.e whether a feature exists and so on) and
				-- if everything was based solely on the compiler information
				-- then these test are not necessary.
				-- However, the user may modify the class which makes the 
				-- analyzed AST structure not match the compiler structures.
			if features = Void then
				!! features.make (5);
				s_class_data.set_features (features);
			end;
			from
				parents.start
			until
				parents.after
			loop
				renaming := parents.item.renaming;
				if renaming /= Void then
					from
						renaming.start
					until
						renaming.after
					loop
						from
							found := False;
							features.start
						until
							found or else features.after
						loop
							feature_data := features.item;
							found := feature_data.name.is_equal (renaming.item_for_iteration)
							features.forth
						end
						origin_class := parents.item.parent_type.associated_class;
						origin_feature := origin_class.feature_table.item 
												(renaming.key_for_iteration);
						!! rename_data;
						if origin_feature /= Void then
							rename_data.set_origin_feature_key (origin_feature.case_feature_key);
						else
								-- Should not really happen but just in case 
								-- (see above comments) ...
							!! temp.make (0);
							temp.append (renaming.key_for_iteration);
							rename_data.set_free_form_text (renaming.key_for_iteration);
						end;
debug ("CASE")
	io.error.putstring ("%T%TRenamed feature: old - ");
	io.error.putstring (renaming.key_for_iteration);
	io.error.putstring (" new - ");
	io.error.putstring (renaming.item_for_iteration);
	if origin_feature = Void then
		io.error.putstring (".NOT Found.");
	else
		io.error.putstring (".Found.");
	end
	if found then
		io.error.putstring ("Redefined");
		io.error.putstring ("Not Redefined");
	end
	io.error.new_line;
end;
						if not found then
								-- This means that the feature is not redefined.
							!! temp.make (0);
							temp.append (renaming.item_for_iteration);
							!! feature_data.make (temp);
							feature_i := classc.feature_table.item 
														(renaming.key_for_iteration);
							if feature_i /= Void then
								feature_ast := Body_server.item (feature_i.body_id);
								feature_ast.store_information (classc, feature_data);
								feature_i.store_case_information (feature_data);
								features.put_front (feature_data); 
							end
						end;
						feature_data.set_rename_clause (rename_data);
						renaming.forth
					end;
				end;
				parents.forth
			end;
		end;

	record_redefinitions (parents: PARENT_LIST) is
			-- Record redefinitions for class `classc' into `s_class_data'.
		local
			class_info: CLASS_INFO;
			redefining: SEARCH_TABLE [STRING];
			features: ARRAYED_LIST [S_FEATURE_DATA];
			feature_data: S_FEATURE_DATA
			parent: PARENT_C;
			found: BOOLEAN;
		do
			features := s_class_data.features;
			from
				parents.start
			until
				parents.after
			loop
				redefining := parents.item.redefining;
				if redefining /= Void then
					from
						redefining.start
					until
						redefining.after
					loop
						from
							found := False;
							features.start
						until
							found or else features.after
						loop
							feature_data := features.item;
							found := feature_data.name.is_equal (redefining.item_for_iteration)
							features.forth
						end;
						if found then
							-- It should always be found but on the other hand if
							-- the user modified the class the Current AST structure
							-- may not match the compiler structures
							feature_data.set_is_redefined
debug ("CASE")
	io.error.putstring ("%T%TRedefine feature: ");
	io.error.putstring (feature_data.name);
	io.error.new_line;
end;
						end;
						redefining.forth
					end;
				end;
				parents.forth
			end;
			s_class_data.set_feature_number (features.count);
			if not classc.is_deferred then
					-- Determine if classc is effective.
					-- It is effective if any of features are
					-- redefined or effective.
				if redefining /= Void and then not redefining.empty then
					s_class_data.set_is_effective 
				else
					from
						features.start
					until
						features.after or features.item.is_effective
					loop
						features.forth
					end;
					if not features.after then
						s_class_data.set_is_effective 
					end
				end	
			end
		end;

end
