-- Temporary data structure of a class produced after first pass.
-- Instances of PARENT_AS produced by Yacc are transformed into instances
-- of PARENT_C: renamings, redefinings etc.. are inserted into hash table
-- for quick interrogations for inheritance analysis and infix/prefix
-- notation are interpreted. Those structures are forgotten after second
-- pass.
-- Attribute `features' is useful for iteratiing on it during second
-- pass in order to analyze local features written in a class.

class CLASS_INFO 

inherit
	SHARED_ERROR_HANDLER;
	SHARED_EXPORT_STATUS;
	SHARED_SERVER
		export
			{ANY} all
		end;
	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		end

	COMPILER_EXPORTER

feature -- Access

	parents: PARENT_LIST;
			-- Compiled parent clause

	index: HASH_TABLE [READ_INFO, INTEGER];
			-- Indexes left by the server `Tmp_ast_server' during
			-- execution of feature `pass1' of CLASS_C. Useful
			-- for second pass

	invariant_info: READ_INFO;
			-- Index of invariant clause

	creators: EIFFEL_LIST [CREATE_AS];
			-- Creators

	unique_values: HASH_TABLE [INTEGER, STRING];
			-- Stores the values of the unique attributes

	features: EIFFEL_LIST [FEATURE_CLAUSE_AS] is
			-- Feature abstract syntax
		require
			ast_server_ok: Tmp_ast_server.has (class_id) or else Ast_server.has (class_id);
		do
			if Tmp_ast_server.has (class_id) then
				Result := Tmp_ast_server.item (class_id).features;
			else
				Result := Ast_server.item (class_id).features;
			end;
		end;

	creation_table (feat_table: FEATURE_TABLE): EXTEND_TABLE [EXPORT_I, STRING] is
			-- Creators table
		require
			good_argument: feat_table /= Void;
		local
			feature_name: STRING;
			a_class: CLASS_C;
			a_feature: FEATURE_I;
			feature_list: EIFFEL_LIST [FEATURE_NAME];
			clients: CLIENT_AS;
			c_reation: CREATE_AS;
			export_status: EXPORT_I;
			vgcp1: VGCP1;
			vgcp2: VGCP2;
			vgcp21: VGCP21;
			vgcp3: VGCP3;
			vgcp4: VGCP4;
		do
			a_class := feat_table.associated_class;
			if creators = Void then
				-- Do nothing
			elseif a_class.is_deferred then
				!!vgcp1;
				vgcp1.set_class (a_class);
				Error_handler.insert_error (vgcp1);
			else
				from
					!! Result.make (creators.count);
					creators.start;
				until
					creators.after
				loop
					c_reation := creators.item;
					if c_reation.feature_list /= Void then
						from
							clients := c_reation.clients;
							if clients /= Void then
								export_status := clients.export_status;
							else
								export_status := Export_all;
							end;
							feature_list := c_reation.feature_list;
							feature_list.start
						until
							feature_list.after
						loop
							feature_name := feature_list.item.internal_name;
							a_feature := feat_table.item (feature_name);
							if a_feature = Void then
								!!vgcp2;
								vgcp2.set_class (a_class);
								vgcp2.set_feature_name (feature_name);
								Error_handler.insert_error (vgcp2);
							else
								if Result.has (feature_name) then
									!!vgcp3;
									vgcp3.set_class (a_class);
									vgcp3.set_feature_name (feature_name);
									Error_handler.insert_error (vgcp3);
								else
									Result.put (export_status, feature_name);
								end;
								if not a_feature.type.is_void then
									!!vgcp21;
									vgcp21.set_class (a_class);
									vgcp21.set_feature_name (feature_name);
									Error_handler.insert_error (vgcp21);
								end;
								if a_class.is_expanded 
									and then
									(
										Result.count > 1
										or else
										a_feature.argument_count > 0
									)
								then
									!!vgcp4;
									vgcp4.set_class (a_class);
									vgcp4.set_feature_name (feature_name);
									Error_handler.insert_error (vgcp4);
									Error_handler.checksum
								end;
							end;
							feature_list.forth;
						end;
					end
					creators.forth;
				end;
			end;
		end;

feature -- Settings

	set_invariant_info (i: like invariant_info) is
			-- Assign `i' to `invariant_info'.
		do
			invariant_info := i;
		end;

	set_parents (p: like parents) is
			-- Assign `p' to `parents'.
		do	
			parents := p;
		end;

	set_index (i: like index) is
			-- Assign `i' to `index'.
		do
			index := i;
		end;

	set_creators (c: like creators) is
			-- Assign `c' to `creators'.
		do
			creators := c;
		end;

	set_unique_values (u: HASH_TABLE [INTEGER, STRING]) is
			-- Assign `u' to `unique_values'.
		do
			unique_values := u;
		end;

end
