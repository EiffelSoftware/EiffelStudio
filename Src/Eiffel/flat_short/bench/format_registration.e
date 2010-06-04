note

	description:
		"Register ast structures for formatting ast."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class FORMAT_REGISTRATION

inherit

	SHARED_FORMAT_INFO;
	SHARED_SERVER;
	SHARED_ERROR_HANDLER;
	SHARED_EIFFEL_PARSER
	AST_REGISTRATION
		rename
			class_ast as current_ast
		end;
	COMPILER_EXPORTER

create
	make

feature -- Initialization

	make (target, cl: CLASS_C)
			-- Initialize current with client class
			-- `cl' and target_class `target'.
		require
			valid_target: target /= Void
		do
			target_class := target;
			client := cl;
			initialize;
		end;

	initialize
			-- Initialize Current structures.
		do
			create ancestors.make (5);
			create categories.make;
			create invariant_server.make;
			create current_category.make;
			create creation_table.make (2);
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

	creation_table: HASH_TABLE [FEATURE_ADAPTER, STRING];
			-- Table of feature adapter for a given feature name

	categories:	PART_SORTED_TWO_WAY_LIST [CATEGORY];
			-- Categories for class_c

	current_category: CATEGORY;
			-- Current category

	client: CLASS_C;
			-- Export requirement for short

	target_ast: like current_ast;
			-- Ast structure for target_class

	ancestors: ARRAYED_LIST [CLASS_C];
			-- Ancestors of target class

	assert_server: ASSERTION_SERVER;
			-- Assertion server for pre and post conditions

	invariant_server: INVARIANT_SERVER;
			-- Invariant server

	target_replicated_feature_table: HASH_TABLE [
			ARRAYED_LIST [FEATURE_I], INTEGER];
	   		-- Table containing replicated (conceptual) features of
	   		-- class being flattend indexed by body_index

feature -- Access

	chained_assertion: CHAINED_ASSERTIONS
			-- Chained assertion for feature id `fid'
		do
			Result := assert_server.current_assertion
		end;

	feature_clause_comments (ast: FEATURE_CLAUSE_AS): EIFFEL_COMMENTS
			-- Feature clause comments for `ast'
		require
			non_void_ast: ast /= Void;
		do
			Result := ast.comment (match_list)
		end;

	feature_comments (ast: FEATURE_AS): EIFFEL_COMMENTS
			-- Feature comments for feature `ast'
		require
			non_void_ast: ast /= Void;
		do
			Result := ast.comment (match_list)
		end;

feature -- Setting

	set_feature_clause_order (fco: like feature_clause_order)
			-- Set `feature_clause_order' to `fco'.
		require
			valid_fco: fco /= Void
		do
			feature_clause_order := fco
		ensure
			set: feature_clause_order = fco
		end;

	set_class (target: CLASS_C)
			-- Set target_class to `target'.
			--| For EiffelCase.
		require
			valid_categories: categories /= Void;
			valid_ancestors: ancestors /= Void;
			valid_current_category: current_category /= Void;
		do
			target_class := target;
		ensure
			target_class = target
		end;

feature -- Element change

	fill (current_class_only: BOOLEAN)
			-- Fill data structures. If current_class_only is true
			-- then only fill the data structures for target_class.
			-- Otherwize, fill the data structures of the inherited
			-- classes.
		require
			valid_target_class: target_class /= Void
		local
			class_id: INTEGER
		do
			class_id := target_class.class_id
			if target_class.has_feature_table then
				target_feature_table := target_class.feature_table
			else
				create target_feature_table.make (0)
			end

			if not current_class_only then
				target_replicated_feature_table :=
					target_feature_table.replicated_features;
			end;
			if current_class_only then
				create assert_server.make_for_class_only
			else
				create assert_server.make (target_feature_table.count);
			end;
			current_class := target_class;
			System.set_current_class (current_class);
debug ("FLAT_SHORT")
	io.error.put_string ("%TParsing & Registering class: ");
	io.error.put_string (current_class.name);
	io.error.put_new_line;
end;
			current_ast := current_class_ast;
			target_ast := current_ast;
			register_current_ast;
			if not current_class_only then
				parse_ancestors;
			end;
			wipe_out_parse_info
debug ("FLAT_SHORT")
	io.error.put_string ("Finished parsing and registering%N")
end;
		end;

	record_replicated_feature (feat_adapter: FEATURE_ADAPTER)
			-- Record replicated feature `f' in `category'.
		require
			valid_feat_adapter: feat_adapter /= Void
		do
			current_category.add (feat_adapter);
		end;

	record_feature (feat_adapter: FEATURE_ADAPTER)
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

	record_invariant (inv: INVARIANT_ADAPTER)
			-- Record invariant `inv' in format.
		require
			valid_inv: inv /= Void
		do
			if target_class = inv.source_class then
				invariant_server.put_front (inv)
			else
				invariant_server.extend (inv)
			end
		end

	record_creation_feature (feat_adapter: FEATURE_ADAPTER)
			-- Record adapter feature `feat' if it is
			-- a creation routine.
		require
			valid_feat_adapter: feat_adapter /= Void
		local
			l_target_feature: FEATURE_I;
		do
			l_target_feature := feat_adapter.target_feature
			if target_class.valid_creation_procedure_32 (l_target_feature.feature_name_32) then
				creation_table.put (feat_adapter, l_target_feature.feature_name_32)
			end
		end;

	register_feature (feature_as: FEATURE_AS)
			-- Register feature `feature_as' for format
			-- processing
		local
			feat_adapter: FEATURE_ADAPTER;
		do
			create feat_adapter;
			feat_adapter.register (feature_as, Current);
		end;

	register_feature_clause (feature_clause: FEATURE_CLAUSE_AS)
			-- Register feature clause `feature_clause' after registering
			-- features.
			--| The reason that the feature clause is register last is
			--| is that the registered features might change their export
			--| policy and would require it to be placed in a separate
			--| feature clause.
		local
			comments: EIFFEL_COMMENTS
		do
			if not current_category.is_empty then
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
			create current_category.make;
		end;

	register_invariant (invariant_part: INVARIANT_AS)
			-- Register invariant `invariant_part'.
		local
			inv_adapter: INVARIANT_ADAPTER
		do
			create inv_adapter;
			inv_adapter.register (invariant_part, Current);
		end;

	register_invariants
			-- Register the invariants defined in `target_class'.
		local
			l_inv: INVARIANT_AS
		do
				-- Properly initialize `current_class'.
			current_class := target_class

				-- Register invariant for `target_class' first.
			l_inv := target_class.invariant_ast
			if l_inv /= Void then
				register_invariant (l_inv)
			end

				-- Then the inherited invariants.
			from
				record_ancestors_of_class (target_class, Void)
				ancestors.start
			until
				ancestors.after
			loop
				current_class := ancestors.item
				l_inv := current_class.invariant_ast
				if l_inv /= Void then
					register_invariant (l_inv)
				end
				ancestors.forth
			end
		end

feature -- Removal

	wipe_out
			-- Wipe out Current structure.
		do
			target_ast := Void;
			target_feature_table := Void;
			current_class := Void;
			current_feature_table := Void;
			ancestors.wipe_out;
			categories.wipe_out;
			current_category.wipe_out;
			assert_server := Void;
			creation_table := Void;
			target_replicated_feature_table := Void;
		end;

	wipe_out_parse_info
			-- Wipe out information related to parsing.
		do
			target_feature_table := Void;
			current_class := Void;
			current_feature_table := Void;
			target_replicated_feature_table := Void;
		end;

feature -- Output

	format_categories (ctxt: TEXT_FORMATTER_DECORATOR)
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

	format_invariants (ctxt: TEXT_FORMATTER_DECORATOR)
			-- Format the invariants.
		require
			valid_ctxt: ctxt /= Void
		do
			invariant_server.format (ctxt);
		end;

feature {NONE} -- Implementation

	current_class_ast: CLASS_AS
			-- Retrieve the ast structure for current_class
			--| (If class is out of date with compiled
			--| structures reparse class)
		local
			class_id: INTEGER
		do
debug ("FLAT_SHORT")
io.error.put_string ("Retrieving class ast: ");
io.error.put_string (current_class.name);
io.error.put_new_line;
end;
			class_id := current_class.class_id

			if current_class.has_feature_table then
				current_feature_table := current_class.feature_table
			else
				create current_feature_table.make (0)
			end

			if ast_server.has (class_id) then
				Result := ast_server.item (class_id)
			else
				Result := tmp_ast_server.item (class_id)
			end
		end;

	search_comment (comment: EIFFEL_COMMENTS)
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

	parse_ancestors
			-- Parse the ancestores of target_class.
			-- (class ANY is skipped)
		local
			class_id: INTEGER
		do
			from
				record_ancestors_of_class (current_class, Void)
				ancestors.start
			until
				ancestors.after
			loop
				current_class := ancestors.item
				if not current_class.is_true_external then
					class_id := current_class.class_id
					if current_class.has_feature_table then
						current_feature_table := current_class.feature_table
					else
						create current_feature_table.make (0)
					end

					System.set_current_class (current_class)

					debug ("FLAT_SHORT")
						io.error.put_string ("%TParsing & Registering class: ")
						io.error.put_string (current_class.name)
						io.error.put_new_line
					end

					current_ast := current_class_ast
					register_current_ast

				end
				ancestors.forth
			end
		end

	register_skipped_classes_assertions (l: LINKED_LIST [CLASS_C])
			-- Register the assertions of classes that have
			-- been skipped (eg ANY)
		local
			f: FEATURE_I;
			t: FEATURE_TABLE;
			id: INTEGER;
			f_adapter: FEATURE_ADAPTER;
			inv_as: INVARIANT_AS
		do
debug ("FLAT_SHORT")
	io.error.put_string ("%TSkipped classes assertions.");
	io.error.put_new_line;
end
			from
				l.start
			until
				l.after
			loop
				current_class := l.item;
				inv_as ?= current_class.invariant_ast;
				if inv_as /= Void then
					register_invariant (inv_as)
				end;
				t := current_class.feature_table;
				id := t.feat_tbl_id;
				from
					t.start
				until
					t.after
				loop
					f := t.item_for_iteration;
					if id = f.written_in and then
						f.has_assertion
					then
						create f_adapter;
						f_adapter.register_for_assertions (f);
						assert_server.register_adapter (f_adapter);
					end
					t.forth
				end
				l.forth
			end
debug ("FLAT_SHORT")
	io.error.put_string ("%TFinished registrating skipped classes.");
	io.error.put_new_line;
end
		end;

	register_current_ast
			-- Register the current_ast in the format registration.
		do
			register_class (current_ast)
		end;

	record_ancestors_of_class (a_class: CLASS_C; a_processed: SEARCH_TABLE [INTEGER])
			-- Record all ancestores of `a_class' in `ancestors' .
			-- Add processed class to `a_processed' if not Void.
		require
			class_not_void: a_class /= Void
			ancestors_parents_not_void: ancestors /= Void
		local
			parents: FIXED_LIST [CL_TYPE_A];
			a_parent: CLASS_C
			l_processed: SEARCH_TABLE [INTEGER]
		do
			from
				l_processed := a_processed
				if l_processed = Void then
					create l_processed.make (5)
				end
				parents := a_class.parents;
				parents.start
					-- Add `a_class' to list of processed class, to avoid a crash
					-- when a class inherits itself. Of course this is not valid, but
					-- the current system could be in a compilation error state.
					-- Fixes bug#11292.
				l_processed.put (a_class.class_id)
			until
				parents.after
			loop
				a_parent := parents.item.associated_class;
				if not l_processed.has (a_parent.class_id) then
					l_processed.put (a_parent.class_id)
					ancestors.extend (a_parent);
					record_ancestors_of_class (a_parent, l_processed)
				end;
				parents.forth
			end
		end

feature {NONE} -- Implementation

	match_list: LEAF_AS_LIST
			-- Match list for roundtrip parser
		local
			l_id: INTEGER
		do
			if current_class /= Void then
				l_id := current_class.class_id
			else
				l_id := target_class.class_id
			end
			Result := match_list_server.item (l_id)
			if Result = Void then
				create Result.make (1)
			end
		end

	update_feature_clause_order (array: ARRAY [STRING_32])
			-- Update the feature clause order.
		require
			valid_array: array /= Void
		local
			cat: like current_category;
			feature_clause_order_table: HASH_TABLE [INTEGER, STRING];
			default_feature_clause_order: INTEGER;
			order, i, c: INTEGER;
			comment: STRING_32;
			eif_comments: EIFFEL_COMMENTS
		do
			create feature_clause_order_table.make (array.count);
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
				if cat.is_empty then
					categories.remove;
				else
						-- Update order number
					eif_comments := cat.comments;

					if eif_comments = Void or else eif_comments.is_empty then
						order := default_feature_clause_order
					else
						comment := eif_comments.first.content_32
						if comment.is_valid_as_string_8 then
							comment.left_adjust; -- Remove leading blanks
						end
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

	feature_clause_order: ARRAY [STRING_32];
			-- Array of ordered feature clause comments

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class FORMAT_REGISTRATION
