indexing

	description: 
		"Evaluates (adapts) source and target feature_i for a feature%
		%ast structure which is used in the format context."
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_ADAPTER

inherit

	COMPARABLE;
	SHARED_FORMAT_INFO
		undefine 
			is_equal
		end

feature -- Properties

	ast: FEATURE_AS_B;
			-- Feature ast

	body_index: INTEGER;
			-- Body index of source_feature

	source_feature: FEATURE_I;
			-- Source feature_i where ast is defined

	target_feature: FEATURE_I;
			-- Target feature where ast must be adapted to

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is Current adaptation less than `other'?
		do	
			Result := ast < other.ast
		end;

feature -- Element change
			
	register (feature_as: FEATURE_AS_B; format_reg: FORMAT_REGISTRATION) is
			-- Initialize and register Current adapter (if possible)
			-- with ast `feature_ast' and evaluate the source and target
			-- feature.
		require
			valid_ast: feature_as /= Void;
			valid_format_reg: format_reg /= Void
		local
			same_class: BOOLEAN;
			adapter: FEATURE_ADAPTER;
			new_feature_as: like ast;
			eiffel_list, names: EIFFEL_LIST_B [FEATURE_NAME_B];
			i, l_count: INTEGER
			list: ARRAYED_LIST [FEATURE_I];
			feat: FEATURE_I;
			rep_table: EXTEND_TABLE [ARRAYED_LIST [FEATURE_I], INTEGER];
			f_name: FEATURE_NAME_B;
		do
			names := feature_as.feature_names;
			if names.count > 1 then
				from
					--| Separate all the feature names
					--| i.e. one feature name per ast
					i := 1;
					l_count := names.count;
				until
					i > l_count
				loop
					!! eiffel_list.make (1);
					eiffel_list.put_i_th (names.i_th (i), 1);
					new_feature_as := clone (feature_as);
					new_feature_as.set_feature_names (eiffel_list);
					!! adapter;
					adapter.register (new_feature_as, format_reg);
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
						feat := list.item;	
						new_feature_as := clone (feature_as);
						!! adapter;
						f_name := clone (names.first)
						f_name.set_name (feat.feature_name);
						!! eiffel_list.make (1);
						eiffel_list.put_i_th (f_name, 1);
						new_feature_as.set_feature_names (eiffel_list);
						adapter.replicate_feature (source_feature, 
										feat, new_feature_as, format_reg);
						list.forth
					end
				end
			end;
		end;


feature -- Output

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Format Current feature into `ctxt'.
		do
			ctxt.init_feature_context (source_feature, 
						target_feature, ast);
				-- For troff format
			ctxt.prepare_feature (target_feature.feature_name,
					target_feature.is_prefix, target_feature.is_infix);
			ast.format (ctxt);
		end;

feature {FEATURE_ADAPTER} -- Implementation

	replicate_feature (s_feat, t_feat: FEATURE_I; 
				f_ast: like ast; format_reg: FORMAT_REGISTRATION) is
			-- Replicated feature information for current adapter.
			-- Also register the feature.
		require
			valid_features: s_feat /= Void and then t_feat /= Void;
			valid_ast: f_ast /= Void
			valid_format_reg: format_reg /= Void
		local
			rout_id: INTEGER;
			select_table: SELECT_TABLE;
		do
			ast := f_ast;
			source_feature := s_feat;
			target_feature := t_feat;
			body_index := s_feat.body_index;
			register_feature (t_feat, True, format_reg)
		end;

feature {NONE} -- Implementation
			
	adapt (old_name: FEATURE_NAME_B; format_reg: FORMAT_REGISTRATION) is
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
			rout_id := s_feat.rout_id_set.first;
			if rout_id < 0 then
				rout_id := - rout_id
			end;
			t_feat := select_table.item (rout_id);
			if s_feat /= Void and then t_feat /= Void then
				format_reg.assert_server.register (Current);
				body_index := s_feat.body_index;
				source_feature := s_feat;
				target_feature := t_feat;
				if (t_feat.written_in = s_feat.written_in) and then
					(t_feat.body_index = s_feat.body_index)
				then
						-- Only register if the target and source
						-- feature are written in the same class
						-- and are refering to the same body
					register_feature (t_feat, False, format_reg);
				end
			end;
		end;

	immediate_adapt (name: FEATURE_NAME_B; format_reg: FORMAT_REGISTRATION) is
			-- Adaptation for feature defined in target_class.
		require
			same_class: format_reg.current_class = format_reg.target_class;
			valid_format_reg: format_reg /= Void
		local
			feat: FEATURE_I
		do
			feat := format_reg.target_feature_table.item (name.internal_name);
			if feat /= Void then
				body_index := feat.body_index;
				source_feature := feat;
				target_feature := feat;
				format_reg.assert_server.register (Current);
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
			if format_reg.client = void or else 
				feat.is_exported_for (format_reg.client) 
			then
					--| for renaming (sorting within feature clause)
					--| features such as _infix_ _prefix_
				--ast.feature_names.first.set_name (feat.feature_name);
				if not is_short or else
					not feat.is_obsolete
				then
					if is_replicated then
						format_reg.register_replicated_feature (Current);
					else
						format_reg.register_feature (Current)
					end
				end;
			end;
		end;

feature -- Case storage output

	storage_info: S_FEATURE_DATA_R331 is
			-- Storage information for Current
		require else
			valid_target_feature: target_feature /= Void
		local
			text: ARRAY [STRING];
			i: INTEGER;
			feature_comments: S_FREE_TEXT_DATA;
			f_name: STRING;
			comment: EIFFEL_COMMENTS
		do
			!! f_name.make (0);
			f_name.append (target_feature.feature_name);
			!! Result.make (f_name);
			Result.set_reversed_engineered;
			ast.store_information (Result);
			target_feature.store_case_information (Result);
			if Result.comments = Void then
				comment := ast.comment;
				if comment /= Void and comment.count > 0 then
					text := comment.text;
					!! feature_comments.make (comment.count)
					from
						i := 1;
						feature_comments.start
					until
						i > comment.count
					loop
						feature_comments.replace (clone (text.item (i)));
						feature_comments.forth
						i := i + 1
					end
					Result.set_comments (feature_comments)
				end
			end
		end

end -- class FEATURE_ADAPTER
