-- Definition of deferred inherited features by another non-deferred
-- inherited feature

class DEFINITION 

inherit

	FEATURE_ADAPTATION
		redefine
			check_redeclaration
		end;
	SHARED_WORKBENCH;
	COMPILER_EXPORTER


creation

	make
	
feature 

	make (old_feats: INHERIT_FEAT; new_feat: FEATURE_I) is
			-- Creation
		require
			good_argument: not (old_feats = Void or else new_feat = Void);
		do
			old_features := old_feats;
			new_feature := new_feat;
		end;

	check_adaptation (feat_tbl: FEATURE_TABLE) is
			-- Check signature conformance beetween the precursors contained
			-- in `old_features' and the feature `new_feature'. Since it
			-- is a definition, there is no merging of assertions.
		local
			deferred_features, features: LINKED_LIST [INHERIT_INFO];
			new_feat: FEATURE_I;
		do
				-- The signature of the new feature in the context of
				-- `feat_tbl' has been already evaluated by feature
				-- `check_types' of FEATURE_TABLE (See class INHERIT_TABLE).
			new_feat := feat_tbl.item_id (new_feature.feature_name_id);
			check
				new_feat /= Void
			end;
			if new_feat /= new_feature then
				--| If it does not have the same reference then
				--| replication of new_feature has occurred.
				--! Hence, we need to update the new_feature
				--| so it is referenced correctly.
				new_feature := new_feat;
			end;
			deferred_features := old_features.deferred_features;
			if not deferred_features.is_empty then
				check_list (deferred_features, feat_tbl);
			end;
			features := old_features.features;
			if not features.is_empty then
				check_list (features, feat_tbl);
			end;
		end;

	check_list (feats: LINKED_LIST [INHERIT_INFO]; tbl: FEATURE_TABLE) is
			-- Check signature conformance of the redefinition of the
			-- features contained into `features' into `new_feature'.
		require
			good_argument: feats /= Void;
			not_empty: not feats.is_empty;
		local
			feature_i: FEATURE_I;
		do
			from
				feats.start
			until
				feats.after
			loop
				feature_i := feats.item.a_feature;

					-- Evaluates signature of the old feature in the
					-- context of `feat_tbl' and take care of possible
					-- redeclarations of anchored types.
				feature_i.solve_types (tbl);
				
					-- Signature checking
				new_feature.check_signature (feature_i);

				feats.forth;
			end;
		end;

	check_redeclaration
		(	new_tbl, old_tbl: FEATURE_TABLE;
			pattern_list: LINKED_LIST [STRING];
			origin_table: ORIGIN_TABLE)
	is
			-- Check redeclaration into an attribute.
		local
			attribute, old_attribute: ATTRIBUTE_I;
			attr_precursor: ATTRIBUTE_I;
			constant: CONSTANT_I
			rout_id_set: ROUT_ID_SET;
			new_rout_id: INTEGER;
			attribute_list: LINKED_LIST [INHERIT_INFO];
			stop: BOOLEAN;
			info: INHERIT_INFO;
		do
			if new_feature.is_attribute then
				attribute ?= new_feature;
				if not old_features.all_attributes then
						-- At least, the attribute is a redeclaration
						-- of a deferred routine or an implemented function.
						-- Remember to generate a function
					if attribute.generate_in = 0 then
						attribute.set_has_function_origin (True);
						attribute.set_generate_in (new_tbl.feat_tbl_id);
							-- Remember to process a pattern for this
						pattern_list.put_front (attribute.feature_name);
					end;
					rout_id_set := attribute.rout_id_set;
					if not rout_id_set.has_attribute_origin then
							-- We have to give a new routine id to the
							-- attribute. If possible, take the same given
							-- during a previous compilation
						old_attribute ?= old_tbl.item_id (attribute.feature_name_id);
						if 	old_attribute /= Void
							and then
							old_attribute.has_function_origin
						then
							new_rout_id := old_attribute.rout_id_set.first
						else
							new_rout_id := attribute.new_rout_id
						end;
							-- Insertion into the routine info table.
						System.rout_info_table.put (new_rout_id, System.current_class);
						rout_id_set.force (new_rout_id);
					end;
				else
					attribute.set_has_function_origin (False);
						-- Case of a redefinition of attributes into
						-- an attribute: new funciton if one precursor
						-- is associated to a function
					from
						attribute_list := old_features.features;
						attribute_list.start
					until
						attribute_list.after or else stop
					loop
						attr_precursor ?= attribute_list.item.a_feature;
						stop :=  attr_precursor.generate_in /= 0;
						attribute_list.forth
					end;
					if stop then
						attribute.set_generate_in (new_tbl.feat_tbl_id);
							-- Remember to process a pattern for this function
						pattern_list.put_front (attribute.feature_name);
					end;
				end
			elseif new_feature.is_constant then
				constant ?= new_feature
					-- We do not need to force the generation of a constant
					-- which is generated as a once function since it is
					-- always generated in class where it is written.
					--
					-- Otherwise, an encapsulation function is required in
					-- class that does the redefinition/merge.
				if not constant.is_once and then constant.generate_in = 0 then
					constant.set_generate_in (new_tbl.feat_tbl_id)
						-- Remember to process a pattern for this function
					pattern_list.put_front (constant.feature_name)
				end
			end

				-- Insert the feature with new rout id in the origin
				-- table for later process of a selection table
			create info.make (new_feature)
			origin_table.insert (info);
		end;

end
