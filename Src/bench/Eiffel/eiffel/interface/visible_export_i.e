class VISIBLE_EXPORT_I

inherit

	VISIBLE_I
		redefine
			is_visible, mark_visible, has_visible,
			generate_cecil_table, nb_visible, make_byte_code
		end;
	SHARED_AST_CONTEXT;
	SHARED_SERVER;
	SHARED_CECIL;
	COMPILER_EXPORTER
	
feature

	is_visible (feat: FEATURE_I): BOOLEAN is
			-- Is the feature `feat' visible for external code ?
		do
			Result := feat.export_status.is_all
				or else feat.access_class.creators.has (feat.feature_name)
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

				if is_visible (a_feature) then
debug ("DEAD_CODE_REMOVAL")
	io.error.putstring (generator);
	io.error.putstring (": Recording feature ");
	io.error.putstring (a_feature.feature_name);
	io.error.putstring (" of class ");
	io.error.putstring (a_feature.written_class.name);
	io.error.new_line;
end;
					remover.record (a_feature, a_feature.written_class)
else
debug ("DEAD_CODE_REMOVAL")
	io.error.putstring (generator);
	io.error.putstring ("Export	status of: ");
	io.error.putstring (a_feature.feature_name);
	io.error.putstring (" of class ");
	io.error.putstring (a_feature.written_class.name);
	io.error.putstring (" is ");
	io.error.putstring (a_feature.export_status.generator);
	io.error.putstring (" ");
	a_feature.export_status.trace;
	io.error.new_line;
end;
				end;

				feat_table.forth;
			end;
		end;

	generate_cecil_table (a_class: CLASS_C) is
			-- Generate cecil table
		local
			types: TYPE_LIST;
		do
			prepare_table (a_class.feature_table);

				-- Generation
			Cecil1.generate_name_table (Cecil_file, a_class.id);
			if byte_context.final_mode then
				from
					types := a_class.types;
					types.start
				until
					types.after
				loop
					Cecil1.generate_final (Cecil_file, types.item.type_id);
					if System.has_separate then
						Cecil1.generate_separate_pattern_id_table (Cecil_file, types.item.type_id);
					end;
					types.forth
				end;
			elseif a_class.is_precompiled then
				Cecil1.generate_precomp_workbench (Cecil_file, a_class.id);
			else
				Cecil1.generate_workbench (Cecil_file, a_class.id);
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
			a_feature: FEATURE_I;
			a_class: CLASS_C;
			nb: INTEGER;
		do
			a_class := feat_table.associated_class;
			Cecil1.wipe_out;

			from
				feat_table.start
			until
				feat_table.after
			loop
				a_feature := feat_table.item_for_iteration;
				if
					not (a_feature.is_deferred or else a_feature.is_attribute)
					and then is_visible (a_feature)
				then
					nb := nb + 1;
				end;
				feat_table.forth;
			end;

				-- Insertion in the cecil table of the effective features
			from
				Cecil1.init (prime_size (nb));
				feat_table.start
			until
				feat_table.after
			loop
				a_feature := feat_table.item_for_iteration;
				if
					not (a_feature.is_deferred or else a_feature.is_attribute)
					and then is_visible (a_feature)
				then
					Cecil1.put (a_feature, real_name (a_feature));
				end;
				feat_table.forth;
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
				feat_table.start
			until
				feat_table.after
			loop
				a_feature := feat_table.item_for_iteration;
				if 	not (a_feature.is_deferred or else a_feature.is_attribute)
					and then is_visible (a_feature)
				then
					Result := Result + 1;
				end;
				feat_table.forth;
			end;
		end;

end
