-- Cluster information relevant for EiffelCase
class CASE_CLUSTER_INFO

inherit
	
	SHARED_INST_CONTEXT;
	SHARED_WORKBENCH;
	SHARED_SERVER;
	PROJECT_CONTEXT;
	SHARED_RESCUE_STATUS

creation

	make

feature {NONE}

	make is
		do
			!! clusters.make
		end;

feature {FORMAT_CASE_STORAGE, CASE_CLUSTER_INFO}

	clusters: LINKED_LIST [CASE_CLUSTER_INFO];

	cluster_i: CLUSTER_i;
			-- Cluster_i associated with path name `name'	

	name: STRING;
			-- Cluster name

	set_name (n: STRING) is
			-- Set name to `n'.
		require
			valid_name: n /= Void and then not n.empty
		do
			name := clone (n);
		ensure
			name_set: name.is_equal (n)
		end;

	set_cluster_i (c: like cluster_i) is
			-- Set cluster_i to `i'.
		require
			valid_cluster: c /= Void 
		do
			cluster_i := c
		ensure
			cluster_set: cluster_i = c
		end;

	add_cluster (cluster: CASE_CLUSTER_INFO) is
			-- Add `cluster' to clusters.
		require
			valid_cluster: cluster /= Void;
		do
			clusters.extend (cluster)
		end;

	cluster_item (path_element: STRING): CASE_CLUSTER_INFO is
			-- Does name equal to `path_element'?
		require
			valid_path_element: path_element /= Void
		do
			if path_element.is_equal (name) then
				Result := Current
			else
				from
					clusters.start
				until
					Result /= Void or else clusters.after 
				loop
					Result := clusters.item.cluster_item (path_element)
					clusters.forth
				end
			end
		end;

	storage_info: S_CLUSTER_DATA is
		local
			clust_l: FIXED_LIST [S_CLUSTER_DATA];
			classes_i: EXTEND_TABLE [CLASS_I, STRING];
			classes: LINKED_LIST [CLASS_C];
			class_c: CLASS_C;
			cluster_name: STRING;
			cluster_key: S_CLUSTER_KEY;
			s_cluster_data: S_CLUSTER_DATA
		do
				-- Need to covert to a string since
				-- the dynamic type of cluster name
				-- in cluster_i is ID_SD.
			if cluster_i = Void then
				!! cluster_name.make (0);
				cluster_name.append (name);
			else
				!! cluster_name.make (0);
				cluster_name.append (cluster_i.cluster_name);
			end;
			cluster_name.to_upper;
			!! Result.make (cluster_name);
			!! cluster_key.make (cluster_name);
			Result.set_icon_details (True, 0, 0);
			if cluster_i /= Void then
				classes_i := cluster_i.classes;
				!! classes.make;
				from
					classes_i.start
				until
					classes_i.after
				loop
					class_c := classes_i.item_for_iteration.compiled_class;
					if class_c /= Void then
						classes.put_front (class_c);
					end;
					classes_i.forth
				end;
				classes_i := Void;
				if not classes.empty then
io.error.putstring ("Analyzing cluster: ");
io.error.putstring (cluster_name);
io.error.new_line;
					Result.set_classes (class_storage_information ((classes), cluster_key))
				end;
				classes := Void;
			end
			if not clusters.empty then
				!! clust_l.make (clusters.count);
				from
					clusters.start;
					clust_l.start
				until
					clusters.after
				loop
					s_cluster_data := clusters.item.storage_info;
					s_cluster_data.set_cluster_key (cluster_key);
					clust_l.replace (s_cluster_data);
					clust_l.forth;
					clusters.forth
				end;
				Result.set_clusters (clust_l);
			end
		end;

feature {CASE_CLUSTER_INFO}

	process_clusters (useful_cl: CASE_CLUSTER_INFO) is
			-- Process clusters in Current. Add useful clusters for
			-- EiffelCase in `useful_clusters'.
		require
			valid_useful_cluster: useful_cl /= Void
		local
			has_cluster_i: BOOLEAN;
			cluster_info: like Current
		do
			if cluster_i = Void then
				from
					clusters.start
				until
					has_cluster_i or else clusters.after
				loop
					has_cluster_i := clusters.item.cluster_i /= Void
					clusters.forth
				end;
			else
				has_cluster_i := True
			end;
			if has_cluster_i then
				!! cluster_info.make;
				cluster_info.set_name (name);
				if cluster_i /= Void then
					cluster_info.set_cluster_i (cluster_i);
				end;
				useful_cl.add_cluster (cluster_info);
			end;
			from
				clusters.start
			until
				clusters.after 
			loop
				if cluster_info = Void then
					clusters.item.process_clusters (useful_cl)
				else
					clusters.item.process_clusters (cluster_info)
				end;
				clusters.forth
			end
		end;

feature {FORMAT_CASE_STORAGE}

	useful_clusters: like Current is
			-- Relevant clusters for EiffelCase
		do
			!! Result.make;
			Result.set_name (name);
			from
				clusters.start
			until
				clusters.after 
			loop
				clusters.item.process_clusters (Result)
				clusters.forth
			end;
		end;

feature {FORMAT_CASE_STORAGE, CASE_CLUSTER_INFO} -- Debug

	trace is
		do
			io.error.putstring ("parent name: ");
			io.error.putstring (name);
			io.error.new_line;
			from
				clusters.start
			until
				clusters.after
			loop
				clusters.item.trace;
				clusters.forth
			end
		end;

	had_io_problems: BOOLEAN;

feature {NONE} -- Class information

	class_storage_information
			 (classes: LINKED_LIST [CLASS_C]; key: S_CLUSTER_KEY): FIXED_LIST [INTEGER] is
			-- Storage information for `classes'
		require
			valid_classes: classes /= Void and then not classes.empty;
			valid_key: key /= Void
		local
			class_c: CLASS_C;
			flat_struct: FLAT_STRUCT;
			class_ast: CLASS_AS;
			i: INTEGER;
			s_class_data: S_CLASS_DATA;
		do
			--if classes.count > 1 then
				--!! Result.make (1);
			--else
				!! Result.make (classes.count);
			--end
			----!! Result.make (classes.count);
			!! flat_struct.initialize;
			from
				classes.start;
				Result.start;
				i := 1
			until
				--i > 1 or else 
					classes.after
			loop
				class_c := classes.item;
				io.error.putstring ("%TAnalyzing class ");
				io.error.putstring (class_c.class_name);
				io.error.new_line;
				flat_struct.set_class (class_c);
				flat_struct.fill (True);
				class_ast := flat_struct.ast;
					-- Case information
					Inst_context.set_cluster (class_c.cluster);
						-- Record index, and name
					s_class_data := class_ast.header_storage_info;
						-- Record features, invariant
					flat_struct.store_case_information (s_class_data);
						-- Record parent cluster
					s_class_data.set_cluster_key (key);
						-- Must have processed the features
						-- before we do the final process of the
						-- class for renamings and redefinitions.
						-- Record renamings, suppliers, parents, is_def ...
					process_class (class_c, s_class_data);
					Inst_context.set_cluster (Void);
				Result.replace (class_c.id);
				Result.forth;
				classes.forth;
				i := i + 1
			end
		ensure
			valid_result: result /= Void;
			--same_count_as_classes: classes.count = Result.count
		end;


feature {NONE} 

	process_class (classc: CLASS_C; s_class_data: S_CLASS_DATA) is
			-- Record renamings, suppliers, parents, is_def ...
			-- in `s_class_data'
		require
			valid_classc: classc /= Void;
			valid_class_data: s_class_data /= Void;
		do
			s_class_data.set_booleans (classc.is_deferred,
					False, 
					False,
					False,
					False,
					classc.class_name.is_equal (System.root_class_name));
						-- The above is possible since there is
						-- no renaming of classes in the compiler yet.
			process_class_relations (classc, s_class_data);
			process_class_inherit_clause (classc, s_class_data);
			store_class_to_disk (classc, s_class_data);
		end;

	store_class_to_disk (classc: CLASS_C; class_data: S_CLASS_DATA) is
			-- Store `class_data' to disk.
		require
			valid_class_info: classc /= Void and then class_data /= Void;
			valid_cluster_key: class_data.cluster_key /= Void
		local
			path: STRING;
			dir: DIRECTORY;
		do
			if not had_io_problems then
				path := clone (Case_storage_path);
				path.extend (Directory_separator);
				path.append (class_data.cluster_key.cluster_name);
				!! dir.make (path);
				if not dir.exists then
					dir.create
				end;
				path.extend (Directory_separator);
				path.append_integer (classc.id);
				class_data.store_to_disk (path);
			end
		rescue
			if Rescue_status.is_unexpected_exception then
				had_io_problems := True;
			end
		end;

	process_class_relations (classc: CLASS_C; s_class_data: S_CLASS_DATA) is
			-- Record parents and suppliers for class `classc' into
			-- `s_class_data'.
		local
			suppliers: SUPPLIER_LIST;
			parents: FIXED_LIST [CL_TYPE_A];
			p_l: FIXED_LIST [S_RELATION_DATA];
			c_l: LINKED_LIST [S_CLI_SUP_DATA];
			inherit_data: S_RELATION_DATA;
			cli_sup_data: S_CLI_SUP_DATA;
		do
			suppliers := classc.suppliers;			
			parents := classc.parents;			
			if not suppliers.empty and then suppliers.count > 1 then
				!! c_l.make; 
				from
					suppliers.start
				until
					suppliers.after
				loop
					if classc /= suppliers.item.supplier then
						!! cli_sup_data;
						cli_sup_data.set_class_links (classc.case_class_key,
								suppliers.item.supplier.case_class_key);
						--if classc = suppliers.item.supplier then
							--cli_sup_data.set_is_reflexive
						c_l.put_right (cli_sup_data);
						c_l.forth;
					end;
					suppliers.forth
				end;
				s_class_data.set_client_links (c_l);
			end
			if parents /= Void and then not parents.empty then
				!! p_l.make (parents.count);
				from
					parents.start;
					p_l.start
				until
					parents.after
				loop
					!! inherit_data;
					inherit_data.set_class_links (classc.case_class_key,
							parents.item.associated_class.case_class_key);
					p_l.replace (inherit_data);
					p_l.forth;
					parents.forth
				end;
				s_class_data.set_heir_links (p_l);
			end
		end;

	process_class_inherit_clause (classc: CLASS_C; s_class_data: S_CLASS_DATA) is
			-- Record renamings and redefinitions for class `classc' into
			-- `s_class_data'.
		local
			class_info: CLASS_INFO;
			parents: PARENT_LIST;
			renaming: EXTEND_TABLE [STRING, STRING];
			redefining: SEARCH_TABLE [STRING];
			features: LINKED_LIST [S_FEATURE_DATA];
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
				-- Get class_info directly from disk
			class_info := Class_info_server.disk_item (classc.id);
			parents := class_info.parents;
			features := s_class_data.features;
			if features = Void then
				!! features.make
				s_class_data.set_features (features);
			end;
				-- Note: There are a test made to see if compiler information
				-- if valid (i.e whether a feature exists and so on) and
				-- if everything was based solely on the compiler information
				-- then these test are not necessary.
				-- However, the user may modify the class which makes the 
				-- analyzed AST structure not match the compiler structures.
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
							features.start
						until
							found or else features.after
						loop
							feature_data := features.item;
							found := feature_data.name.is_equal (renaming.key_for_iteration)
							features.forth
						end
						origin_class := parents.item.parent_type.associated_class;
						origin_feature := origin_class.feature_table.item 
												(renaming.key_for_iteration);
						!! rename_data;
						if origin_feature /= Void then
							rename_data.set_origin_feature_key (origin_feature.case_feature_key);
						else
								-- Should not really happen but just in case (see above
								-- comments) ...
							!! temp.make (0);
							temp.append (renaming.key_for_iteration);
							rename_data.set_free_form_text (renaming.key_for_iteration);
						end;
						if not found then
								-- This means that the feature is not redefined.
							!! temp.make (0);
							temp.append (renaming.item_for_iteration);
							!! feature_data.make (temp, classc.case_class_key);
							feature_i := classc.feature_table.item 
														(renaming.key_for_iteration);
							if feature_i /= Void then
								feature_ast := Body_server.item (feature_i.body_id);
								feature_ast.store_information (classc, feature_data);
								feature_i.store_case_information (feature_data);
								features.put_front (feature_data);
							end
						end;
						feature_data.set_rename_clause (rename_data)
						renaming.forth
					end;
				end;
				parents.forth
			end;
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
						end;
						redefining.forth
					end;
				end;
				parents.forth
			end;
			s_class_data.set_feature_number (features.count);
		end;

end
