indexing

	description: 
		"Register ast structures for formatting ast.";
	date: "$Date$";
	revision: "$Revision $"

class FORMAT_REGISTRATION
	
inherit

	SHARED_FORMAT_INFO;
	SHARED_SERVER;
	SHARED_ERROR_HANDLER;
	SHARED_RESCUE_STATUS;
	AST_REGISTRATION
		rename
			class_ast as current_ast
		end;
	MEMORY;
	COMPILER_EXPORTER

creation

	make, initialize

feature -- Initialization

	make (target, cl: CLASS_C) is
			-- Initialize current with client class
			-- `cl' and target_class `target'.
		require
			valid_target: target /= Void
		do
			target_class := target;
			client := cl;	
			initialize;
			if not order_same_as_text then
				creators := target.creators;
			end;
			processed_parents.extend (System.any_class.compiled_class);
		end;

	initialize is
			-- Initialize Current structures.
		do
			!! processed_parents.make (5);
			!! categories.make;
			!! invariant_server.make;
			!! current_category.make;
			!! creation_table.make (2);
		end;

feature -- Properties
		
	target_class: CLASS_C;
			-- Compiled class being formatted

	target_feature_table: FEATURE_TABLE;
			-- Feature table for target_class

	creators: EXTEND_TABLE [EXPORT_I, STRING]
			-- Creators of `target_class'

	current_class: CLASS_C;
			-- Class being analyzed

	current_feature_table: FEATURE_TABLE;
			-- Feature table for for current_ast structure

	creation_table: HASH_TABLE [FEATURE_ADAPTER, STRING];
			-- Table of feature adapter for a given feature name

	categories:	PART_SORTED_TWO_WAY_LIST [CATEGORY];
			-- Categories for class_c

	class_comments: CLASS_COMMENTS;
			-- Class comments for precompiled current_class

	current_category: CATEGORY;
			-- Current category 
			
	client: CLASS_C;
			-- Export requirement for short

	target_ast: like current_ast;
			-- Ast structure for target_class

	processed_parents: ARRAYED_LIST [CLASS_C];
			-- Processed parents when analyzing ancestors

	assert_server: ASSERTION_SERVER;
			-- Assertion server for pre and post conditions

	invariant_server: INVARIANT_SERVER;
			-- Invariant server

	target_replicated_feature_table: EXTEND_TABLE [
			ARRAYED_LIST [FEATURE_I], BODY_INDEX];
	   		-- Table containing replicated (conceptual) features of
	   		-- class being flattend indexed by body_index

feature -- Access

	already_extracted_comments: BOOLEAN is
			-- Has the comments been extracted for the
			-- current class ast being registered
		do
			Result := eiffel_file = Void
		ensure then
			valid_result: Result implies current_class.is_precompiled
		end;

	chained_assertion: CHAINED_ASSERTIONS is
			-- Chained assertion for feature id `fid'
		do
			Result := assert_server.current_assertion
		end;

	feature_clause_comments (ast: FEATURE_CLAUSE_AS_B): EIFFEL_COMMENTS is
			-- Feature clause comments for `ast'
		require
			non_void_ast: ast /= Void;
			consistency: not current_class.is_precompiled implies
					eiffel_file.current_feature_clause = ast
		do
			if current_class.is_precompiled then
				Result := class_comments.item (ast.position)
			else
				Result := eiffel_file.current_feature_clause_comments
			end
		end;

	feature_comments (ast: FEATURE_AS_B): EIFFEL_COMMENTS is
			-- Feature comments for feature `ast'
		require
			non_void_ast: ast /= Void;
			consistency: not current_class.is_precompiled implies
					eiffel_file.current_feature.has_feature_name 
								(ast.feature_names.first)
		do
			if current_class.is_precompiled then
				Result := class_comments.item (ast.start_position)
			else
				Result := eiffel_file.current_feature_comments
			end
		end;

feature -- Setting

	set_feature_clause_order (fco: like feature_clause_order) is
			-- Set `feature_clause_order' to `fco'.
		require
			valid_fco: fco /= Void
		do
			feature_clause_order := fco
		ensure
			set: feature_clause_order = fco
		end;

	set_class (target: CLASS_C) is
			-- Set target_class to `target'.
			--| For EiffelCase.
		require
			valid_categories: categories /= Void;
			valid_processed_parents: processed_parents /= Void;
			valid_current_category: current_category /= Void;
		do
			target_class := target;
		ensure
			target_class = target
		end;

feature -- Element change

	fill (current_class_only: BOOLEAN) is
			-- Fill data structures. If current_class_only is true
			-- then only fill the data structures for target_class. 
			-- Otherwize, fill the data structures of the inherited
			-- classes.
		require
			valid_target_class: target_class /= Void
		local
			l: LINKED_LIST [CLASS_C]
		do
			target_feature_table := feat_tbl_server.item (target_class.id);
			if not current_class_only then
				target_replicated_feature_table := 
					target_feature_table.replicated_features;
			end;
			if current_class_only then
				!! assert_server.make_for_class_only
			else
				!! assert_server.make (target_feature_table.count);
			end;
			!! l.make;
			l.extend (System.general_class.compiled_class);
			register_skipped_classes_assertions (l);
			current_class := target_class;
			System.set_current_class (current_class);
debug ("FLAT_SHORT")
	io.error.putstring ("%TParsing & Registering class: ");
	io.error.putstring (current_class.class_name);
	io.error.new_line;
end;
			current_ast := current_class_ast;
			target_ast := current_ast;
			register_current_ast;
			if not current_class_only then
				parse_ancestors;
			end;
			wipe_out_parse_info
debug ("FLAT_SHORT")
	io.error.putstring ("Finished parsing and registering%N")
end;
		end;

	record_replicated_feature (feat_adapter: FEATURE_ADAPTER) is
			-- Record replicated feature `f' in `category'.
		require
			valid_feat_adapter: feat_adapter /= Void
		do
			current_category.add (feat_adapter);
		end;

	record_feature (feat_adapter: FEATURE_ADAPTER) is
			-- Record feature `f' in `current category'.
		require
			valid_feat_adapter: feat_adapter /= Void
		do
			if order_same_as_text then
					-- Add to the end of last category created
				current_category.add_at_end (feat_adapter);
			else
				current_category.add (feat_adapter);
			end
		end;

	record_invariant (inv: INVARIANT_ADAPTER) is
			-- Record invariant `inv' in format.
		require
			valid_inv: inv /= Void
		do
			invariant_server.extend (inv);
		end;

	record_creation_feature (feat_adapter: FEATURE_ADAPTER) is
			-- Record adapter feature `feat' if it is
			-- a creation routine.
		require
			valid_feat_adapter: feat_adapter /= Void
		local
			target_feature: FEATURE_I;
			tmp_creators: like creators
		do
			tmp_creators := creators;
			if tmp_creators /= Void then
				target_feature := feat_adapter.target_feature;
				if tmp_creators.has (target_feature.feature_name) then
					creation_table.put (feat_adapter, target_feature.feature_name)
				end
			end
		end;

	register_feature (feature_as: FEATURE_AS_B) is
			-- Register feature `feature_as' for format
			-- processing
		local
			feat_adapter: FEATURE_ADAPTER;
		do
			!! feat_adapter;
			feat_adapter.register (feature_as, Current);
		end;

	register_feature_clause (feature_clause: FEATURE_CLAUSE_AS_B) is
			-- Register feature clause `feature_clause' after registering
			-- features.
			--| The reason that the feature clause is register last is
			--| is that the registered features might change their export
			--| policy and would require it to be placed in a separate
			--| feature clause.
		local
			comments: EIFFEL_COMMENTS
		do
			if not current_category.empty then
				comments := feature_clause_comments (feature_clause);
				current_category.set_comments (comments);
				if order_same_as_text then
					categories.finish;
					categories.put_right (current_category);
				else
					search_comment (comments);
					if not categories.after then
						categories.item.merge (current_category);
					else
						categories.put_front (current_category);
					end
				end
			end;
			!! current_category.make;
		end;

	register_invariant (invariant_part: INVARIANT_AS_B) is
			-- Register invariant `invariant_part'. 
		local
			inv_adapter: INVARIANT_ADAPTER
		do
			!! inv_adapter;
			inv_adapter.register (invariant_part, Current);	
		end;

feature -- Removal

	wipe_out is
			-- Wipe out Current structure.
		do
			creators := Void;
			target_ast := Void;
			target_feature_table := Void;
			current_class := Void;
			current_feature_table := Void;
			processed_parents.wipe_out;
			categories.wipe_out;
			current_category.wipe_out;
			assert_server := Void;
			creation_table := Void;
			class_comments := Void;
			target_replicated_feature_table := Void;
		end;

	wipe_out_parse_info is
			-- Wipe out information related to parsing.
		do
			target_feature_table := Void;
			current_class := Void;
			current_feature_table := Void;
			target_replicated_feature_table := Void;
			eiffel_file := Void;
		end;

feature -- Output
					
	format_categories (ctxt: FORMAT_CONTEXT_B) is
			-- Format categories into `ctxt'.
		require
			valid_ctxt: ctxt /= Void
		local
			cat: like current_category
		do
			if not order_same_as_text then
				update_feature_clause_order (feature_clause_order);
				categories.sort
			end;
			from
				categories.start;
			until
				categories.after
			loop
				cat := categories.item;
				cat.format (ctxt);
				categories.forth;
			end;	
		end;

	format_invariants (ctxt: FORMAT_CONTEXT_B) is
			-- Format the invariants.
		require
			valid_ctxt: ctxt /= Void
		do
			invariant_server.format (ctxt);
		end;

feature -- EiffelCase output

	store_case_information (s: S_CLASS_DATA) is
			-- Store information relevant for EiffelCase
			-- in `s' (feature_data and invariants).
		local
			f_l: ARRAYED_LIST [S_FEATURE_DATA];
			s_clauses: ARRAYED_LIST [S_FEATURE_CLAUSE];
			f_clause: S_FEATURE_CLAUSE;
			public_export: S_EXPORT_ALL_I;
			private_export: S_EXPORT_NONE_I;
		do
			if not categories.empty then
				!! s_clauses.make (2);
				from
					!! f_l.make (5);
					categories.start
				until
					categories.after
				loop
					f_l.append (categories.item.public_features_storage_info);
					categories.forth
				end;
				if not f_l.empty then
					!! public_export;
					!! f_clause.make (f_l, public_export)
					s_clauses.extend (f_clause)
				end;
				from
					!! f_l.make (5);
					categories.start
				until
					categories.after
				loop
					f_l.append (categories.item.private_features_storage_info);
					categories.forth
				end;
				if not f_l.empty then
					!! private_export;
					!! f_clause.make (f_l, private_export)
					s_clauses.extend (f_clause)
				end;
				s.set_feature_clause_list (s_clauses)
				invariant_server.store_case_info (s);
			end;
		end;

feature {NONE} -- Implementation

	current_class_ast: CLASS_AS_B is
			-- Retrieve the ast structure for current_class
			--| (If class is out of date with compiled
			--| structures reparse class)
		local
			file: RAW_FILE;
			class_file_name: STRING;
			vd21: VD21;
		do
			if current_class.is_precompiled or else
				not current_class.lace_class.date_has_changed
			then
debug ("FLAT_SHORT")
	io.error.putstring ("Retrieving class ast: ");
	io.error.putstring (current_class.class_name);
	io.error.new_line;
end;
				current_feature_table := current_class.feature_table;
				Result := Ast_server.item (current_class.id)
			else
debug ("FLAT_SHORT")
	io.error.putstring ("Reparsing class ast: ");
	io.error.putstring (current_class.class_name);
	io.error.new_line;
end;
				class_file_name := current_class.file_name;
				!! file.make (class_file_name);
				if
					not (file.exists and then file.is_readable and then
						file.is_plain)
				then
					!!vd21;
					vd21.set_cluster (current_class.cluster);
					vd21.set_file_name (current_class.file_name);
					Error_handler.insert_error (vd21);
					Error_handler.raise_error;
				end;
				file.open_read;
				collection_off;
				Result := c_parse (file.file_pointer, $class_file_name);
				collection_on;
				file.close;
			end
		rescue
			if Rescue_status.is_error_exception then
					-- Error happened
				collection_on;
				if not (file = Void or else file.is_closed) then
					file.close;
				end;
			end;
		end;

	search_comment (comment: EIFFEL_COMMENTS) is
			-- Search comment `comment' for a category.
		do
			from
				categories.start;
			until	
				categories.after or else 
				categories.item.same_comment (comment)
			loop
				categories.forth
			end;
		end;

	parse_ancestors is
			-- Parse the ancestores of target_class.
		local
			parents: FIXED_LIST [CL_TYPE_A];
			index: INTEGER;	
		do
			from 
				parents := current_class.parents;
				parents.start
			until
				parents.after
			loop
				current_class := parents.item.associated_class;
				if not processed_parents.has (current_class) then
					current_feature_table := current_class.feature_table;
					System.set_current_class (current_class);
debug ("FLAT_SHORT")
	io.error.putstring ("%TParsing & Registering class: ");
	io.error.putstring (current_class.class_name);
	io.error.new_line;
end;
					current_ast := current_class_ast;
					register_current_ast;
					processed_parents.extend (current_class);
					index := parents.index;
					parse_ancestors;
					parents.go_i_th (index);
				end;
				parents.forth;
			end;
		end;

	register_skipped_classes_assertions (l: LINKED_LIST [CLASS_C]) is
			-- Register the assertions of classes that have
			-- been skipped (eg ANY)
		local
			f: FEATURE_I;
			t: FEATURE_TABLE;
			id: CLASS_ID;
			f_adapter: FEATURE_ADAPTER
		do
debug ("FLAT_SHORT")
	io.error.putstring ("%TSkipped classes assertions.");
	io.error.new_line;
end
			from
				l.start
			until
				l.after
			loop
				t := l.item.feature_table;
				id := t.feat_tbl_id;
				from
					t.start
				until
					t.after
				loop
					f := t.item_for_iteration;
					if id.is_equal (f.written_in) and then 
						f.has_assertion
					then	
						!! f_adapter;
						f_adapter.register_for_assertions (f);
						assert_server.register_adapter (f_adapter);
					end
					t.forth
				end
				l.forth
			end
debug ("FLAT_SHORT")
	io.error.putstring ("%TFinished registrating skipped classes.");
	io.error.new_line;
end
		end;

	register_current_ast is
			-- Register the current_ast in the format registration.
		do
			if current_class.is_precompiled then
				if Class_comments_server.has (current_class.id) then
					class_comments := Class_comments_server.disk_item (current_class.id);
				else
					!! class_comments.make (current_class.id, 0);
				end;
				debug ("COMMENTS")
					if class_comments = Void then
						io.error.putstring ("Comments not exist for class: ")
						io.error.putstring (current_class.class_name);
						io.error.new_line;
					else
						io.error.putstring ("Comments for class: ")
						io.error.putstring (current_class.class_name);
						io.error.new_line;
						class_comments.trace
					end;
				end;
				eiffel_file := Void;
			else
				class_comments := Void;
				!! eiffel_file.make (current_class.file_name, current_ast.end_position);
			end;
			current_ast.register (Current);
		ensure
			consistency: (eiffel_file = Void) = (class_comments /= Void)
		end;

feature {NONE} -- Implementation

	update_feature_clause_order (array: ARRAY [STRING]) is
			-- Update the feature clause order.
		require
			valid_array: array /= Void 
		local
			cat: like current_category;
			feature_clause_order_table: HASH_TABLE [INTEGER, STRING];
			default_feature_clause_order: INTEGER;
			order, i, c: INTEGER;	
			comment: STRING;
			eif_comments: EIFFEL_COMMENTS
		do
			!! feature_clause_order_table.make (array.count);
			from
				i := 1;
				c := array.count
			until
				i > c
			loop
				comment := array.item (i);
				if comment.is_equal ("*") then
					default_feature_clause_order := i
				else
					feature_clause_order_table.put (i, comment)
				end;
				i := i + 1
			end;
			if default_feature_clause_order = 0 then
				-- Didn't find `*' so make it the
				-- largest value in order to be placed last
				-- in the list.
				default_feature_clause_order := i
			end
			from
				categories.start;
			until
				categories.after
			loop
				cat := categories.item;
				if cat.empty then
					categories.remove;
				else
						-- Update order number
					eif_comments := cat.comments;
					
					if eif_comments = Void or else eif_comments.empty then
						order := default_feature_clause_order
					else
						comment := clone (eif_comments.first);
						comment.left_adjust; -- Remove leading blanks
						order := feature_clause_order_table.item (comment);
						if order = 0 then
								-- Didn't find order - use default
							order := default_feature_clause_order
						end
					end;
					cat.set_order (order);
					categories.forth;
				end;
			end;	
		end;

	feature_clause_order: ARRAY [STRING];
			-- Array of ordered feature clause comments

feature {NONE} -- External features

	c_parse (f: POINTER; s: POINTER): CLASS_AS_B is
		external
			"C"
		end;

invariant
	
	valid_comments: (current_class /= Void and then
				current_class.is_precompiled) implies 
						class_comments /= Void
	valid_eiffel_file: (current_class /= Void and then
				not current_class.is_precompiled) implies 
						eiffel_file /= Void

end -- class FORMAT_REGISTRATION
