class VISIBLE_EXPORT_I

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
		local
			creators: HASH_TABLE [EXPORT_I, STRING]
		do
			Result := feat.export_status.is_all
			if not Result then
					-- If it is a creation routine, we can export
					-- it, so that we match the Eiffel way to create
					-- an object.
				creators := System.class_of_id (class_id).creators
				if creators /= Void then
					Result := creators.has (feat.feature_name)
				end
			end
		end;

	has_visible: BOOLEAN is True
			-- Has the current object some visible features ?

	mark_visible (remover: REMOVER; feat_table: FEATURE_TABLE) is
			-- Mark visible features from `feat_table'.
		local
			a_feature: FEATURE_I
			class_id: INTEGER
		do
			from
				class_id := feat_table.feat_tbl_id
				feat_table.start
			until
				feat_table.after
			loop
				a_feature := feat_table.item_for_iteration;

				if is_visible (a_feature, class_id) then
debug ("DEAD_CODE_REMOVAL")
	io.error.put_string (generator);
	io.error.put_string (": Recording feature ");
	io.error.put_string (a_feature.feature_name);
	io.error.put_string (" of class ");
	io.error.put_string (a_feature.written_class.name);
	io.error.put_new_line;
end;
					remover.record (a_feature, a_feature.written_class)
else
debug ("DEAD_CODE_REMOVAL")
	io.error.put_string (generator);
	io.error.put_string ("Export	status of: ");
	io.error.put_string (a_feature.feature_name);
	io.error.put_string (" of class ");
	io.error.put_string (a_feature.written_class.name);
	io.error.put_string (" is ");
	io.error.put_string (a_feature.export_status.generator);
	io.error.put_string (" ");
	a_feature.export_status.trace;
	io.error.put_new_line;
end;
				end;

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
			cecil_routine_table.generate_name_table (buffer, a_class.class_id);
			if byte_context.final_mode then
				from
					types := a_class.types;
					types.start
				until
					types.after
				loop
					cecil_routine_table.generate_final (buffer, types.item);
					types.forth
				end;
			elseif a_class.is_precompiled then
				cecil_routine_table.generate_precomp_workbench (buffer, a_class.class_id);
			else
				cecil_routine_table.generate_workbench (buffer, a_class.class_id);
			end;
		end;

	make_byte_code (ba: BYTE_ARRAY; feat_table: FEATURE_TABLE) is
			-- Produce byte code for current visible clause.
		do
			prepare_table (feat_table);

			cecil_routine_table.make_byte_code (ba);
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
			cecil_routine_table.wipe_out;

			from
				feat_table.start
			until
				feat_table.after
			loop
				a_feature := feat_table.item_for_iteration;
				if
					not (a_feature.is_deferred or else a_feature.is_attribute)
					and then is_visible (a_feature, class_id)
				then
					nb := nb + 1;
				end;
				feat_table.forth;
			end;

				-- Insertion in the cecil table of the effective features
			from
				cecil_routine_table.init (nb);
				a_class.set_visible_table_size (cecil_routine_table.capacity)
				feat_table.start
			until
				feat_table.after
			loop
				a_feature := feat_table.item_for_iteration;
				if
					not (a_feature.is_deferred or else a_feature.is_attribute)
					and then is_visible (a_feature, class_id)
				then
					cecil_routine_table.put (a_feature, real_name (a_feature, class_id));
				end;
				feat_table.forth;
			end;
		end;

end
