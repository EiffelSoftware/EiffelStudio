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
	MEMORY

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
			processed_parents.extend (System.any_class.compiled_class);
		end;

	initialize is
			-- Initialize Current structures.
		do
			!! processed_parents.make (5);
			!! categories.make;
			!! current_category.make;
			!! invariant_server.make;
			!! class_comments.make;
		end;

feature -- Properties
		
	target_class: CLASS_C;
			-- Compiled class being formatted

	target_feature_table: FEATURE_TABLE;
			-- Feature table for target_class

	current_class: CLASS_C;
			-- Class being analyzed

	current_feature_table: FEATURE_TABLE;
			-- Feature table for for current_ast structure

	comments_server: EIFFEL_FILE;
			-- Server for comments

	categories:	SORTED_TWO_WAY_LIST [CATEGORY];
			-- Categories for class_c

	current_category: CATEGORY;
			-- Current category 
			
	client: CLASS_C;
			-- Export requirement for short

	target_ast: like current_ast;
			-- Ast structure for target_class

	current_ast: CLASS_AS_B;
			-- Current ast structure being analyzed

	processed_parents: ARRAYED_LIST [CLASS_C];
			-- Processed parents when analyzing ancestors

	assert_server: ASSERTION_SERVER;
			-- Assertion server for pre and post conditions

	invariant_server: INVARIANT_SERVER;
			-- Invariant server

	target_replicated_feature_table: EXTEND_TABLE [
			ARRAYED_LIST [FEATURE_I], INTEGER];
	   		-- Table containing replicated (conceptual) features of
	   		-- class being flattend indexed by body_index

	class_comments: LINKED_LIST [EIFFEL_COMMENTS];
			-- Comments at the top of the class 
			-- text file for target_class

feature -- Access

	chained_assertion_of_fid (fid: INTEGER): CHAINED_ASSERTIONS is
			-- Chained assertion for feature id `fid'
		do
			Result := assert_server.chained_assertion_of_fid (fid)
		end;

feature -- Setting

	set_class (target: CLASS_C) is
			-- Set target_class to `target'.
			--| For EiffelCase.
		require
			valid_categories: categories /= Void;
			valid_processed_parents: processed_parents /= Void;
			valid_current_category: current_category /= Void;
			valid_class_comments: class_comments /= Void;
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
		local
			local_comments: EIFFEL_COMMENTS;
		do
		-- initialize
			target_feature_table := feat_tbl_server.item (target_class.id);
			if not current_class_only then
				target_replicated_feature_table := 
					target_feature_table.replicated_features;
			end;
			if current_class_only then
				!! assert_server.make_for_class_only
			else
				!! assert_server.make (target_feature_table, client);
			end;
			current_class := target_class;
			System.set_current_class (current_class);
debug ("FLAT_SHORT")
	io.error.putstring ("%TParsing & Registering class: ");
	io.error.putstring (current_class.class_name);
	io.error.new_line;
end;
			current_ast := current_class_ast;
			target_ast := current_ast;
			current_ast.register (Current);
			from
				comments_server.go_before (1);
				local_comments := comments_server.trailing_comment;
			until
				local_comments = void
			loop
				class_comments.extend (local_comments);
				local_comments := comments_server.next_comment;
			end;
			if not current_class_only then
				parse_ancestors;
			end;
			wipe_out_parse_info
debug ("FLAT_SHORT")
	io.error.putstring ("Finished parsing and registering%N")
end;
		end;

	register_replicated_feature (feat_adapter: FEATURE_ADAPTER) is
			-- Register replicated feature `f'.
		require
			valid_feat_adapter: feat_adapter /= Void
		do
			current_category.add (feat_adapter);
		end;

	register_feature (feat_adapter: FEATURE_ADAPTER) is
			-- Register feature `f'.
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

	register_feature_clause (feature_clause: FEATURE_CLAUSE_AS) is
			-- Register feature_clause `feature_clause' after
			-- registering the features.
		require
			valid_feature_clause: feature_clause /= Void
		do
			if not current_category.empty then
				current_category.set_comment (feature_clause.comment);
				if order_same_as_text then
					categories.finish;
					categories.put_right (current_category);
				else
					search_comment (feature_clause.comment);
					if not categories.after then
						categories.item.merge (current_category);
					else
						categories.extend (current_category);
					end;
				end
			end;
			!! current_category.make;
		end;
	
	register_invariant (inv: INVARIANT_ADAPTER) is
			-- Register invariant `i'.
		require
			valid_inv: inv /= Void
		do
			invariant_server.extend (inv);
		end;

feature -- Removal

	wipe_out is
			-- Wipe out Current structure.
		do
			target_ast := Void;
			target_feature_table := Void;
			current_class := Void;
			current_feature_table := Void;
			processed_parents.wipe_out;
			categories.wipe_out;
			current_category.wipe_out;
			class_comments.wipe_out;
			assert_server := Void;
			target_replicated_feature_table := Void;
		end;

	wipe_out_parse_info is
			-- Wipe out information related to parsing.
		do
			target_feature_table := Void;
			current_class := Void;
			current_feature_table := Void;
			target_replicated_feature_table := Void;
		end;

feature -- Output
					
	format_categories (ctxt: FORMAT_CONTEXT_B) is
			-- Format categories into `ctxt'.
		require
			valid_ctxt: ctxt /= Void
		do
			from
				categories.start;
			until
				categories.after
			loop
				categories.item.format (ctxt);
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

	format_class_comments (ctxt: FORMAT_CONTEXT_B) is
			-- Format comments into `ctxt'.
		do
			from
				class_comments.start
			until
				class_comments.after
			loop
				ctxt.put_comment (class_comments.item);
				ctxt.new_line;
				ctxt.new_line;
				class_comments.forth;
			end;
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
				invariant_server.storage_info (s);
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
			--!! comments_server.make (file);
			!! comments_server.dummy_make;
			if current_class.is_precompiled or else
				not current_class.lace_class.date_has_changed
			then
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
		local
			stop: BOOLEAN
		do
			from
				categories.start;
			until	
				categories.after
				or else stop
			loop
				stop := categories.item.same_comment (comment);
				if not stop then
					categories.forth;
				end
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
					current_ast.register (Current);
					processed_parents.extend (current_class);
					index := parents.index;
					parse_ancestors;
					parents.go_i_th (index);
				end;
				parents.forth;
			end;
		end;

feature {NONE} -- External features

	c_parse (f: POINTER; s: POINTER): CLASS_AS_B is
		external
			"C"
		end;

end -- class FORMAT_REGISTRATION
