indexing
	description	: "Evaluates (adapts) source and target feature_i for a feature%
				  %ast structure which is used in the format context."
	date		: "$Date$";
	revision	: "$Revision $"

class FEATURE_ADAPTER

inherit
	COMPILER_EXPORTER

	PART_COMPARABLE

	SHARED_FORMAT_INFO
		undefine 
			is_equal
		end

feature -- Properties

	ast: FEATURE_AS
			-- Feature ast

	body_index: INTEGER
			-- Body index of source_feature

	source_feature: FEATURE_I
			-- Source feature_i where ast is defined

	target_feature: FEATURE_I
			-- Target feature where ast must be adapted to

	source_class: CLASS_C
			-- Source class of ast (used when source_feature
			-- and target_feature are not found)

	comments: EIFFEL_COMMENTS
			-- Comments for ast

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is Current adaptation less than `other'?
		do	
			Result := ast < other.ast
		end

feature -- Element change

	register (feature_as: FEATURE_AS; format_reg: FORMAT_REGISTRATION) is
			-- Initialize and register Current adapter (if possible)
			-- with ast `feature_ast' and evaluate the source and target
			-- feature. Also set comments to `c'.
		require
			valid_ast: feature_as /= Void;
			valid_format_reg: format_reg /= Void
		local
			same_class: BOOLEAN
			adapter: FEATURE_ADAPTER
			new_feature_as: like ast
			eiffel_list, names: EIFFEL_LIST [FEATURE_NAME]
			i, l_count: INTEGER
			list: ARRAYED_LIST [FEATURE_I]
			t_feat: FEATURE_I
			rep_table: EXTEND_TABLE [ARRAYED_LIST [FEATURE_I], INTEGER]
			f_name: FEATURE_NAME
			is_precompiled: BOOLEAN
		do
			names := feature_as.feature_names;
			if names.count > 1 then
				is_precompiled := format_reg.current_class.is_precompiled;
				from
					--| Separate all the feature names
					--| i.e. one feature name per ast
					i := 1;
					l_count := names.count;
				until
					i > l_count
				loop
					create eiffel_list.make (1);
					eiffel_list.extend (names.i_th (i));
					new_feature_as := clone (feature_as);
					new_feature_as.set_feature_names (eiffel_list);
					create adapter;
					adapter.register (new_feature_as, format_reg);
					adapter.add_comment (synonym_comment (i, names, format_reg.current_class.name), is_precompiled);
					i := i + 1
				end;
			else
				ast := feature_as;
				same_class := (format_reg.current_class
								= format_reg.target_class);
				if same_class then
					immediate_adapt (ast.feature_names.first, format_reg)
				else
					adapt (ast.feature_names.first, format_reg);
					if source_feature /= Void then
						rep_table := format_reg.target_replicated_feature_table;
						list := rep_table.item (source_feature.body_index);
					end
				end;
				if list /= Void then
						--| Also register replicated and unselected routines
					from
						list.start
					until
						list.after
					loop
						t_feat := list.item;	
						new_feature_as := clone (feature_as);
						create adapter;
						f_name := clone (names.first)
						f_name.set_name (source_feature.feature_name);
						create eiffel_list.make (1);
						eiffel_list.extend (f_name);
						new_feature_as.set_feature_names (eiffel_list);
						adapter.replicate_feature (source_feature,
										t_feat, new_feature_as, format_reg);
						list.forth
					end;
						-- Reset entry just in case we have
						-- synomyn features
					rep_table.force (Void, source_feature.body_index);
				end
			end;
		end;

feature {NONE} -- Implementation

	synonym_comment (exclude: INTEGER; names: EIFFEL_LIST [FEATURE_NAME]; class_name: STRING): STRING is
			-- Create comment describing feature synonyms.
			-- Do not include visual name with index `exclude'.
		require
			multiple_visual_names: names.count > 1
			exclude_valid_index: exclude >= 1 and then exclude <= names.count
		local
			others: LINKED_LIST [STRING]
			s: STRING
		do
			create others.make
			from names.start until names.after loop
				if names.index /= exclude then
					others.extend (names.item.visual_name)
				end
				names.forth
			end
			create Result.make (40)
			Result.append (" Was declared")
			if class_name /= Void then
				s := clone (class_name)
				s.to_upper
				Result.append (" in ")
				Result.append (s)
			end
			Result.append (" as synonym of ")
			from others.start until others.after loop
				Result.extend ('`')
				Result.append (others.item)
				Result.extend ('%'')
				others.forth
				if not others.after then
					if others.islast then
						Result.append (" and ")
					else 
						Result.append (", ")
					end
				end
			end
			Result.extend ('.')
		ensure
			not_void: Result /= Void
		end

feature -- Output

	format (ctxt: FORMAT_CONTEXT) is
			-- Format Current feature into `ctxt'.
		local
			format_reg: FORMAT_REGISTRATION
		do
			format_reg := ctxt.format_registration;
			if target_feature /= Void then
				format_reg.assert_server.update_current_assertion (Current);
				ctxt.init_feature_context (source_feature, 
							target_feature, ast);
			else
				format_reg.assert_server.reset_current_assertion;
				ctxt.init_uncompiled_feature_context (source_class, ast);
			end;
			ctxt.set_feature_comments (comments)
			ast.format (ctxt)
		end

feature {FEATURE_ADAPTER} -- Implementation

	replicate_feature (s_feat, t_feat: FEATURE_I;
				f_ast: like ast; format_reg: FORMAT_REGISTRATION) is
			-- Replicated feature information from `feat_adapter'
			-- with target_feature `t_feat' in `format_reg'.
		require
			valid_features: s_feat /= Void and then t_feat /= Void;
			valid_ast: f_ast /= Void
			valid_format_reg: format_reg /= Void
		do
			ast := f_ast;
			source_feature := s_feat;
			target_feature := t_feat;
			body_index := s_feat.body_index;
			register_feature (t_feat, True, format_reg)
		end;

feature {NONE} -- Implementation
			
	adapt (old_name: FEATURE_NAME; format_reg: FORMAT_REGISTRATION) is
			-- Adaptation for feature defined in current class being analyzed.
		require
			diff_class: format_reg.current_class /= format_reg.target_class;
			valid_format_reg: format_reg /= Void
		local
			t_feat, s_feat: FEATURE_I;
			rout_id: INTEGER;
			select_table: SELECT_TABLE;
		do	
			select_table := format_reg.target_feature_table.origin_table;
			s_feat := format_reg.current_feature_table.item
						(old_name.internal_name);
			if s_feat /= Void then
				rout_id := s_feat.rout_id_set.first;
				t_feat := select_table.item (rout_id);
				if t_feat /= Void then
					body_index := s_feat.body_index;
					source_feature := s_feat;
					target_feature := t_feat;
					format_reg.assert_server.register_adapter (Current);
					if t_feat.written_in = s_feat.written_in and then
						t_feat.body_index = s_feat.body_index
					then
						-- Only register if the target and source
						-- feature are written in the same class
						-- and are refering to the same body
						register_feature (t_feat, False, format_reg);
					end
				end
			else
					-- Newly added feature which hasn't been compiled
				register_uncompiled_feature (format_reg)
			end;
		end;

	immediate_adapt (name: FEATURE_NAME; format_reg: FORMAT_REGISTRATION) is
			-- Adaptation for feature defined in target_class.
		require
			same_class: format_reg.current_class = format_reg.target_class;
			valid_format_reg: format_reg /= Void
		local
			feat: FEATURE_I
		do
			feat := format_reg.target_feature_table.item (name.internal_name);
			if feat = Void then
					-- Newly added feature which hasn't been compiled
				register_uncompiled_feature (format_reg)
			else
				body_index := feat.body_index;
				source_feature := feat;
				target_feature := feat;
				format_reg.assert_server.register_adapter (Current);
				register_feature (feat, False, format_reg);
			end;
		end;				

	register_feature (feat: FEATURE_I; 
				is_replicated: BOOLEAN;
				format_reg: FORMAT_REGISTRATION) is
			-- Register feature `feat'.
		require
			valid_feat: feat /= Void
			valid_format_reg: format_reg /= Void
		do
			comments := format_reg.feature_comments (ast)
			if format_reg.client = void or else 
				feat.is_exported_for (format_reg.client) 
			then
					--| for renaming (sorting within feature clause)
					--| features such as _infix_ _prefix_
				--ast.feature_names.first.set_name (feat.feature_name);
				if not is_short or else
					not feat.is_obsolete
				then
					--| VB 06/13/2000 (Moved up) comments := format_reg.feature_comments (ast)
					if is_replicated then
						format_reg.record_replicated_feature (Current);
					else
						format_reg.record_feature (Current);
					end;
				end;
			end;
				-- Record as creation feature.
				-- `record_creation_feature' checks if `Current' is
				-- a creation procedure and if so, adds it to format_reg.creation_table.
			format_reg.record_creation_feature (Current)
		end;

	register_uncompiled_feature (format_reg: FORMAT_REGISTRATION) is
			-- Register uncompiled feature.
		do
			comments := format_reg.feature_comments (ast);
			source_class := format_reg.current_class;
			format_reg.record_feature (Current)
		end;

feature {FEATURE_ADAPTER} -- Element change

	add_comment (comment: STRING; is_precompiled: BOOLEAN) is
			-- Add `comment' to `comments'.
		require
			valid_comment: comment /= Void
		do
			if comments = Void then
				create comments.make 
			elseif is_precompiled then
					-- Duplicate the result since it could be referencing
					-- the same comments of other synonym precompiled feature asts.
				comments.start;
				comments := comments.duplicate (comments.count)
			end;
			comments.extend (comment)
		end;

feature {FORMAT_REGISTRATION} -- Element chage

	register_for_assertions (s_feature: FEATURE_I) is
			-- Register feature adapter only for the purpose of retrieving
			-- chained assertions if `source_feature' is redefined in descendant.
		require
			valid_s_feature: s_feature /= Void 
		do
			source_feature := s_feature;
			ast := s_feature.body;	
			body_index := s_feature.body_index;
		end;
			
end -- class FEATURE_ADAPTER
