indexing
	description: "Server for pre and post conditions.";
	date: "$Date$";
	revision: "$Revision $"

class ASSERTION_SERVER

inherit
	SHARED_SERVER

	COMPILER_EXPORTER

creation
	make, make_for_class_only, make_for_feature

feature -- Initialization

	make (count: INTEGER) is
			-- Initialize Current assertion server with
			-- features from feature_table `f' that is exported to 
			-- `client'.
		do
			!! feature_adapter_table.make (count);
		end;			

	make_for_class_only is 
			-- Initialize structures for processing one class.
		do
			!! feature_adapter_table.make (0);
		end;

	make_for_feature (f: FEATURE_I; ast: FEATURE_AS) is
			-- Initialize structures for processing feature `f'
			-- with ast structure `ast'.
		require
			valid_feat: f /= Void;
			valid_ast: ast /= Void
		local
			assert_id_set: ASSERT_ID_SET;
			i: INTEGER;
			inh_f: INH_ASSERT_INFO;
			body_id: BODY_ID;
			chained_assert: CHAINED_ASSERTIONS;
			other_feat_as: FEATURE_AS;
			f_table: FEATURE_TABLE;
			feat: FEATURE_I;
			assertion: ROUTINE_ASSERTIONS;
			written_in: CLASS_ID;
			true_assertion: ROUTINE_ASSERTIONS;
			origin_assertion_found: BOOLEAN
		do
			assert_id_set := f.assert_id_set;
			if assert_id_set /= Void then
				written_in := f.written_in;
				from
					!! chained_assert.make;
					i := 1
				until
					i > assert_id_set.count
				loop
					inh_f := assert_id_set.item (i);
					body_id := System.body_index_table.item (inh_f.body_index);
					f_table := Feat_tbl_server.item (inh_f.written_in);
					if f_table /= Void then
						feat := f_table.feature_of_body_id (body_id);
						if feat /= Void and then feat.has_assertion then
							other_feat_as := feat.body;
							if other_feat_as /= Void then
								!! assertion.make_for_feature (feat, other_feat_as);
								chained_assert.put_front (assertion);
							end
							if feat.is_origin then
								true_assertion := Void;
								origin_assertion_found := True
									--| Found an origin with an assertion
							end
						elseif feat /= Void and then feat.is_origin then
							!! true_assertion.make_for_feature (feat, Void);
								--| AST is Void, thus this is an origin
								--| without an assertion
						end;
					end;
					i := i + 1;
				end;
				if true_assertion /= Void and then not origin_assertion_found then
					chained_assert.put_front (true_assertion)
						--| There is no origin with an assertion.
						--| We put the last origin without an assertion up front
						--| to be able to travers faster while formatting preconditions.
				end;
				if f.has_assertion then
					!! assertion.make_for_feature (f, ast);
					chained_assert.extend (assertion)
				end;
				current_assertion := chained_assert
			end
		end;

feature -- Properties
						
	current_assertion: CHAINED_ASSERTIONS;
			-- Chained assertion for a feature 

	feature_adapter_table: EXTEND_TABLE [FEATURE_ADAPTER, BODY_INDEX];
			-- Feature adapters hash on `body_index'

feature -- Element change

	register_adapter (feat_adapter: FEATURE_ADAPTER) is
			-- Register adapter `feat_adapter'.
		require
			valid_adapter: feat_adapter /= Void
		do
			if feat_adapter.body_index /= Void then
				feature_adapter_table.put (feat_adapter, feat_adapter.body_index);
			end;
		end

	update_current_assertion (feat_adapter: FEATURE_ADAPTER) is
			-- Update `current_assertion' from `feat_adapter'.
		require
			valid_adapter: feat_adapter /= Void;
			valid_body_index: feat_adapter.body_index /= Void
		local
			assert_id_set: ASSERT_ID_SET;
			i: INTEGER;
			inh_f: INH_ASSERT_INFO;
			body_id: BODY_ID;
			chained_assert: CHAINED_ASSERTIONS;
			other_feat_as: FEATURE_AS;
			f_table: FEATURE_TABLE;
			feat: FEATURE_I;
			source_feature: FEATURE_I;
			assertion: ROUTINE_ASSERTIONS;
			written_in: CLASS_ID
			chained_assertions: CHAINED_ASSERTIONS;
			target_feat: FEATURE_I;
			inh_feat_adapter: FEATURE_ADAPTER;
			true_assertion: ROUTINE_ASSERTIONS;
			origin_assertion_found: BOOLEAN
		do
			if feat_adapter.body_index /= Void then
				target_feat := feat_adapter.target_feature;
				assert_id_set := target_feat.assert_id_set;
				!! chained_assert.make;
				if assert_id_set /= Void then
					from
						i := 1
					until
						i > assert_id_set.count
					loop
						inh_f := assert_id_set.item (i);
						inh_feat_adapter := feature_adapter_table.item 
								(inh_f.body_index);
						if inh_feat_adapter /= Void then
							feat := inh_feat_adapter.source_feature;
							if feat.has_assertion then
								other_feat_as := inh_feat_adapter.ast;
								!! assertion.make_for_feature (feat, other_feat_as);
								chained_assert.put_front (assertion);
								if feat.is_origin then
									true_assertion := Void;
									origin_assertion_found := True
										--| Found an origin with an assertion
								end
							elseif feat.is_origin then
								!! true_assertion.make_for_feature (feat, Void);
									--| AST is Void, thus
									--| this is an origin without an assertion
							end
						end;
						i := i + 1;
					end;
				end;
				if true_assertion /= Void and not origin_assertion_found then
					chained_assert.put_front (true_assertion)
						--| There is no origin with an assertion.
						--| We put the last origin without an assertion up front
						--| to be able to travers faster while formatting preconditions.
				end;
				source_feature := feat_adapter.source_feature;
				if source_feature.has_assertion then
					!! assertion.make_for_feature (source_feature, feat_adapter.ast);
					chained_assert.extend (assertion)
				end;
				current_assertion := chained_assert
			end
		end;

	reset_current_assertion is
			-- Reset `current_assertion' to Void.
		do
			current_assertion := Void
		end;

feature -- Debug

	trace is
		do	
			io.error.putstring ("*** Feature Table ***%N");
			from
				feature_adapter_table.start
			until
				feature_adapter_table.after
			loop
				io.error.putstring ("body id: ");
				io.error.putstring (feature_adapter_table.key_for_iteration.out);
				io.error.new_line;
				feature_adapter_table.forth
			end
		end
			
end	
