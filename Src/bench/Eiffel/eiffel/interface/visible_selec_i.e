class VISIBLE_SELEC_I 

inherit

	VISIBLE_I
		redefine
			trace, nb_visible, generate_cecil_table, has_visible, mark_visible,
			is_visible, make_byte_code
		end

	SHARED_AST_CONTEXT

	SHARED_SERVER

	SHARED_CECIL

	COMPILER_EXPORTER
	
feature 

	visible_features: SEARCH_TABLE [STRING];
			-- Visible features

	set_visible_features (t: like visible_features) is
			-- Assign `t' to `visible_features'.
		do
			visible_features := t;
		end;

	is_visible (feat: FEATURE_I): BOOLEAN is
			-- Is `feat' visible from external code ?
		do
			Result := visible_features.has (feat.feature_name);
		end;

	mark_visible (remover: REMOVER; feat_table: FEATURE_TABLE) is
			-- Mark visible features from `feat_table'.
		local	
			a_feature: FEATURE_I;
		do
			from
				visible_features.start
			until
				visible_features.after
			loop
				a_feature := feat_table.item (visible_features.item_for_iteration);

				if a_feature /= Void then
					remover.record (a_feature, a_feature.written_class)
				end;

				visible_features.forth;
			end;
		end;

	has_visible: BOOLEAN is True
			-- Has the current object some visible features ?

	generate_cecil_table (a_class: CLASS_C) is
			-- Generate cecil table
		local
			types: TYPE_LIST;
			buffer: GENERATION_BUFFER
		do
			buffer := generation_buffer
			prepare_table (a_class.feature_table);

				-- Generation
			Cecil1.generate_name_table (buffer, a_class.id);
			if byte_context.final_mode then
				from
					types := a_class.types;
					types.start
				until
					types.after
				loop
					Cecil1.generate_final (buffer, types.item.type_id);
					if System.has_separate then
						Cecil1.generate_separate_pattern_id_table (buffer, types.item.type_id);
					end;
					types.forth
				end;
			elseif a_class.is_precompiled then
				Cecil1.generate_precomp_workbench (buffer, a_class.id);
			else
				Cecil1.generate_workbench (buffer, a_class.id);
			end;
		end;

	make_byte_code (ba: BYTE_ARRAY; feat_table: FEATURE_TABLE) is
			-- Produce byte code for current visible clause
		do
			prepare_table (feat_table);

			Cecil1.make_byte_code (ba);
		end;

	prepare_table (feat_table: FEATURE_TABLE) is
			-- Prepate cecil table.
		local
			a_feature: FEATURE_I;
			a_class: CLASS_C;
		do
			Cecil1.wipe_out;

			a_class := feat_table.associated_class;

				-- Insertion in the cecil table of the effective features
			from
				Cecil1.init (prime_size (visible_features.count));
				visible_features.start
			until
				visible_features.after
			loop
				a_feature := feat_table.item (visible_features.item_for_iteration);

				if a_feature = Void then
					-- FIXME: Illegal feature specified
				else
					if not (a_feature.is_deferred or else a_feature.is_attribute) then
						Cecil1.put (a_feature, real_name (a_feature));
					end;
				end
				visible_features.forth;
			end;
		end;

	nb_visible (a_class: CLASS_C): INTEGER is
			-- Number of visible features from the class `a_class'.
		local
			feat_table: FEATURE_TABLE;
			a_feature: FEATURE_I;
		do
			feat_table := a_class.feature_table;

			from
				visible_features.start
			until
				visible_features.after
			loop
				a_feature := feat_table.item (visible_features.item_for_iteration);
				if a_feature /= Void and then not (a_feature.is_deferred or else a_feature.is_attribute)	then
					Result := Result + 1;
				end;
				visible_features.forth;
			end;
		end;

	trace is
			-- Debug purpose
		do
			{VISIBLE_I} Precursor
			io.error.putstring (" for ");
			from
				visible_features.start;
			until
				visible_features.after
			loop
				io.error.putstring (visible_features.item_for_iteration);
				io.error.putchar (' ');
				visible_features.forth;
			end;
		end;
				
end
