-- Record suppliers for EiffelCase
class CASE_RECORD_SUPPLIERS

inherit
	
	CASE_CLASS_COMMAND;
	SHARED_SERVER;

creation

	make

feature 

	execute is
			-- Record parents and suppliers for class `classc' into
			-- `s_class_data'.
		do
			if s_class_data.features /= Void then
				record_suppliers 
			end;
		end;

feature {NONE} -- Recording information for eiffelcase

	record_suppliers is
		local
			suppliers: SUPPLIER_LIST;
			c_l: ARRAYED_LIST [S_CLI_SUP_DATA];
			cli_sup_data: S_CLI_SUP_DATA;
			supplier: CLASS_C;
			label: STRING;
			class_dep: CLASS_DEPENDANCE;
			feat_dep: FEATURE_DEPENDANCE;
			sup_class_id: INTEGER;
			features: ARRAYED_LIST [S_FEATURE_DATA];
		do
			class_dep := Depend_server.disk_item (classc.id);
			if not class_dep.empty and then class_dep.count > 1 then
				-- count > 1 is required since the class itself is always
				features := s_class_data.features;
				!! c_l.make (1);
				from
					features.start
				until
					features.after
				loop
						-- Suppliers resulting from implementation
					feat_dep := class_dep.item (features.item.name);
					if feat_dep /= Void then
						from
							feat_dep.start
						until
							feat_dep.after
						loop
							if classc.id /= sup_class_id then
								sup_class_id := feat_dep.item.id;
								from
									c_l.start
								until
									c_l.after or else 
									c_l.item.supplier = sup_class_id
								loop
									c_l.forth
								end;
								if not c_l.after then
										-- Was not found
									!! cli_sup_data;
									cli_sup_data.set_implementation (True);
									cli_sup_data.set_class_links (classc.id,
											sup_class_id);
									c_l.extend (cli_sup_data);
								end;
							end;
							feat_dep.forth
						end
					end
					features.forth
				end;
				record_supplier_labels (c_l);
				if not c_l.empty then
					s_class_data.set_client_links (c_l);
				end;
			end
		end

	record_supplier_labels (c_l: ARRAYED_LIST [S_CLI_SUP_DATA]) is
		require
			valid_cl: c_l /= Void
		local
			sup_class_id: INTEGER;
			features: ARRAYED_LIST [S_FEATURE_DATA];
			feature_data: S_FEATURE_DATA;
			result_type: S_CLASS_TYPE_INFO;
			feat_arg: FIXED_LIST [S_ARGUMENT_DATA];
			real_class_ids: LINKED_LIST [INTEGER]
            cli_sup_data: S_CLI_SUP_DATA;
            label: STRING;
			gen_type: S_GEN_TYPE_INFO;
			type_a: TYPE_A
		do
			features := s_class_data.public_features;
			from
				features.start
			until
				features.after
			loop
				feature_data := features.item;
debug ("CASE_FEATURE")
	io.error.putstring ("%T%T%Tanalyzing feature: ");
	io.error.putstring (feature_data.name);
	io.error.new_line;
end;
				if feature_data.result_type /= Void then
					result_type ?= feature_data.result_type.type	
					if result_type /= Void then
						real_class_ids := result_type.real_class_ids;
							-- Class_type would have 1
							-- Basic_type would have 0
							-- Gen_type would have more than one
						from
							real_class_ids.start
						until
							real_class_ids.after
						loop
							sup_class_id :=  real_class_ids.item;
							from
								c_l.start
							until
								c_l.after or else 
								c_l.item.supplier = sup_class_id
							loop
								c_l.forth
							end;
							if c_l.after then
									-- Supplier hasn't been record 
								!! cli_sup_data;
								cli_sup_data.set_class_links (classc.id,
										sup_class_id);
								c_l.extend (cli_sup_data);
							else
								cli_sup_data := c_l.item;
								cli_sup_data.set_implementation (False);
							end
							if sup_class_id = classc.id then
								cli_sup_data.set_reflexive (True)
							end;
							label := cli_sup_data.label;
							if label = Void then
								!! label.make (0);
								label.append (feature_data.name);
								cli_sup_data.set_label (label);
							else
								label.append (", ");	
								label.append (feature_data.name);
debug ("CASE_FEATURE")
	io.error.putstring ("%T%T%TResult: ");
	io.error.putstring (System.class_of_id (result_type.class_id).class_name);
	io.error.new_line;
end
							end;
							if result_type.has_generics then
								gen_type ?= result_type;
								label.append (": ");	
								label.append (gen_type.string_value_minus_id 
										(sup_class_id))
							end
							cli_sup_data.set_implementation (False);
							real_class_ids.forth
						end
					end;
				end;
				feat_arg := feature_data.arguments;
				if feat_arg /= Void then
					from
						feat_arg.start
					until
						feat_arg.after
					loop
						result_type ?= feat_arg.item.type;
						if result_type /= Void then
							real_class_ids := result_type.real_class_ids;
								-- Class_type would have 1
								-- Basic_type would have 0
								-- Gen_type would have more than one
							from
								real_class_ids.start
							until
								real_class_ids.after
							loop
								sup_class_id := real_class_ids.item;
								from
									c_l.start
								until
									c_l.after or else 
									c_l.item.supplier = sup_class_id
								loop
									c_l.forth
								end;
debug ("CASE_FEATURE")
	io.error.putstring ("%T%T%TArgument: ");
	io.error.putstring (System.class_of_id (result_type.class_id).class_name);
	io.error.new_line;
end
								if c_l.after then
										-- Supplier hasn't been record 
									!! cli_sup_data;
									cli_sup_data.set_class_links (classc.id,
											sup_class_id);
									c_l.extend (cli_sup_data);
								else
									cli_sup_data :=  c_l.item;
									cli_sup_data.set_implementation (False)
								end;
								if sup_class_id = classc.id then
									cli_sup_data.set_reflexive (True)
								end;
								real_class_ids.forth
							end
						end
						feat_arg.forth
					end;
				end
				features.forth
			end;
		end;

end
