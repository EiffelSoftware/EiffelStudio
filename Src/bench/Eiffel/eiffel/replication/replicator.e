-- Replicates the AST for the replicated featuer (actual code replication)
class REPLICATOR

inherit

	SHARED_SERVER;
	COMPILER_EXPORTER

creation

	make

feature


	compute_new_name (f_name: STRING): FEATURE_NAME is
			-- Compute new feature name
		local
			infix_as: INFIX_AS;
			prefix_as: PREFIX_AS;
			feature_name_id_as: FEAT_NAME_ID_AS
		do
			if (f_name.item (1) = '_') then
				if (f_name.item (2) = 'i') then 
					f_name.tail (f_name.count - 7);
					!!infix_as;
					infix_as.set_name (f_name);
					Result := infix_as;
				elseif (f_name.item (2) = 'p') then
					f_name.tail (f_name.count - 8);
					!!prefix_as;
					prefix_as.set_name (f_name);
					Result := prefix_as;
				end
			else
				!!feature_name_id_as;
				feature_name_id_as.set_name (f_name);
				Result := feature_name_id_as;
			end
		end;

	make (old_feat, new_feat: FEATURE_I; pairs: S_REP_NAME_LIST;
		 a, d: CLASS_C; f_name: STRING) is
		local
			ctxt: REP_CONTEXT;
			adapter: LOCAL_FEAT_ADAPTATION;
			new_pairs: S_REP_NAME_LIST;
			feat_table: FEATURE_TABLE;
			found: BOOLEAN;
			body_id: INTEGER;
			feature_i: FEATURE_I;
			feature_as: FEATURE_AS;
			new_name: FEATURE_NAME
		do
			!!adapter;
			adapter.set_source_feature (old_feat);
			adapter.set_target_feature (new_feat);
			adapter.set_source_type (a.actual_type);
			adapter.set_target_type (d.actual_type);
			new_pairs := clone (pairs);
			if old_feat.written_class /= a then
				feat_table := Feat_tbl_server.item (a.class_id);		
				from
					new_pairs.start
				until
					new_pairs.after
				loop
					body_id := new_pairs.item.old_feature.body_id;
					from
						feat_table.start;
						found := false
					until
						feat_table.after or else found
					loop
						feature_i := feat_table.item_for_iteration;
						if feature_i.body_id = body_id then
							found := true;
							new_pairs.item.set_old_feature (feature_i);
						else
							feat_table.forth
						end
					end;
					new_pairs.forth
				end
			end;
			new_name := compute_new_name (f_name);
			!! ctxt.make (new_name, new_pairs, adapter);
			feature_as := Body_server.item (old_feat.body_id);
			ast := feature_as.replicate (ctxt);
		end;		
			
					
	ast: FEATURE_AS;

end
