class VISIBLE_SEPARATE_I

inherit

	VISIBLE_I
		redefine
			is_visible, mark_visible, has_visible,
			generate_cecil_table, make_byte_code
		end;
	SHARED_AST_CONTEXT;
	SHARED_SERVER;
	SHARED_CECIL;
	COMPILER_EXPORTER
	
feature

	is_visible (feat: FEATURE_I; class_id: INTEGER): BOOLEAN is
			-- Is feature name `feat_name' visible in context 
			-- of class `class_id'?
		do
			Result := True;
		end;

	has_visible: BOOLEAN is True
			-- Has the current object some visible features ?

	mark_visible (remover: REMOVER; feat_table: FEATURE_TABLE) is
			-- Mark visible features from `feat_table'.
		local
			a_feature: FEATURE_I;
		do
			from
				feat_table.start
			until
				feat_table.after
			loop
				a_feature := feat_table.item_for_iteration;
				remover.record (a_feature, a_feature.written_class)
				feat_table.forth;
			end;
		end;

	generate_cecil_table (a_class: CLASS_C) is
			-- Generate cecil table
		local
			types: TYPE_LIST;
			buffer: GENERATION_BUFFER
		do
			buffer := generation_buffer
			prepare_table (a_class.feature_table);

				-- Generation
			Cecil1.generate_name_table (buffer, a_class.class_id);
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
				Cecil1.generate_precomp_workbench (buffer, a_class.class_id);
			else
				Cecil1.generate_workbench (buffer, a_class.class_id);
			end;
		end;

	make_byte_code (ba: BYTE_ARRAY; feat_table: FEATURE_TABLE) is
			-- Produce byte code for current visible clause.
		do
			prepare_table (feat_table);

			Cecil1.make_byte_code (ba);
		end;

	prepare_table (feat_table: FEATURE_TABLE) is
			-- Prepare hash table
		local
			a_feature: FEATURE_I
			a_class: CLASS_C
			class_id: INTEGER
			nb: INTEGER
		do
			a_class := feat_table.associated_class;
			class_id := a_class.class_id
			Cecil1.wipe_out;

			from
				feat_table.start
			until
				feat_table.after
			loop
				a_feature := feat_table.item_for_iteration;
				if
					not (a_feature.is_deferred or else a_feature.is_attribute)
				then
					nb := nb + 1;
				end;
				feat_table.forth;
			end;

				-- Insertion in the cecil table of the effective features
			from
				Cecil1.init (prime_size (nb));
				a_class.set_visible_table_size (Cecil1.capacity)
				feat_table.start
			until
				feat_table.after
			loop
				a_feature := feat_table.item_for_iteration;
				if
					not (a_feature.is_deferred or else a_feature.is_attribute)
				then
					Cecil1.put (a_feature, real_name (a_feature, class_id));
				end;
				feat_table.forth;
			end;
		end;

end
