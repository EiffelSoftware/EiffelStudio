indexing
	description: "Formatting context for class ast (flat, flat/short & clickable format)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class FORMAT_CONTEXT

inherit
	SHARED_SERVER

	SHARED_TEXT_ITEMS

	SHARED_INST_CONTEXT

	SHARED_RESCUE_STATUS

	SHARED_FORMAT_INFO

	SHARED_ERROR_HANDLER

	COMPILER_EXPORTER

	CHARACTER_ROUTINES
		export
			{NONE} all
		end

	SYNTAX_STRINGS
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

create
	make, make_for_case, make_for_appending

feature {NONE} -- Initialization

	make (c: CLASS_C) is
			-- Initialize Current for bench.
		require
			valid_c: c /= Void
		do
			class_c ?= c
			current_class_only := False
			reset_format_booleans
			last_was_printed := True
			initialize
		ensure
			class_c_set: class_c /= Void and then class_c = c
			batch_mode:	not in_bench_mode
			analyze_ancestors: not current_class_only
			do_flat: not is_short
		end

	make_for_case is
			-- Initialize current for simple
			-- format for eiffelcase (to get
			-- image of precondition and postcondition).
		do
			is_for_case := True
			initialize
		end

	make_for_appending (a_text: like text) is
			-- Create context for appending an AST item to `a_text'.
		do
			reset_format_booleans
			last_was_printed := True
			initialize
			text := a_text
		end

	initialize is
			-- Initialize structures for Current.
		do
			create format_stack.make
			create text.make
			create format
			format_stack.extend (format)
			create formatter.make (Current)
		end

feature -- Initialization

	init_uncompiled_feature_context (source_class: CLASS_C; feature_as: FEATURE_AS) is
			-- Initialize Current context to analyze
			-- uncompiled feature ast `feature_as'.
			-- This ast is not in the feature table (ie has
			-- not been compiled) but has been entered by
			-- the user.
		require
			valid_source_class: source_class /= Void
			valid_ast: feature_as /= Void
		do
			create global_adapt.make_with_classes (source_class, class_c)
			global_adapt.set_locals (feature_as)
			create unnested_local_adapt
			unnested_local_adapt.update_from_global (global_adapt)
			local_adapt := unnested_local_adapt
		ensure
			valid_global_adapt: global_adapt /= Void
			valid_unnested_local_adapt: unnested_local_adapt /= Void
			valid_unnested_local_adapt: local_adapt /= Void
		end

	init_feature_context (source, target: FEATURE_I;
				feature_as: FEATURE_AS) is
			-- Initialize Current context to analyze
			-- `source' and `target' features.
			-- Use `feature_as' to set up locals.
		require
			valid_source: source /= Void
			valid_ast: feature_as /= Void
			valid_target: target /= Void
		do
			create global_adapt.make (source, target, class_c)
			global_adapt.set_locals (feature_as)
			create unnested_local_adapt
			unnested_local_adapt.update_from_global (global_adapt)
			local_adapt := unnested_local_adapt
		ensure
			valid_global_adapt: global_adapt /= Void
			valid_unnested_local_adapt: unnested_local_adapt /= Void
			valid_unnested_local_adapt: local_adapt /= Void
		end

feature -- Case properties

	name_of_current_feature: STRING;
			-- Name of feature currently being processed

	dotnet_name_of_current_feature: STRING;
			-- .NET name of feature currently being processed

feature -- Properties

	match_list: LEAF_AS_LIST is
			-- Match list for roundtrip parser.
		local
			l_id: INTEGER
		do
			if client /= Void then
				l_id := client.class_id
			else
				l_id := class_c.class_id
			end
			Result := match_list_server.item (l_id)
		end

	is_for_case: BOOLEAN
			-- Is Current format done for EiffelCase?

	format_stack: LINKED_STACK [LOCAL_FORMAT]
			-- Stack to keep track of all formats.
			-- Push at begin, pop at commit and rollback.

	text: STRUCTURED_TEXT
			-- Formatted text

	client: CLASS_C
			-- Client class for Current flat

	class_name: STRING
			-- Class name of `class_c'

	feature_comments: EIFFEL_COMMENTS
			-- Comments for current analyzed feature

	last_class_printed: TYPE_A
			-- Last class printed (used for !TYPE! creation)

	first_assertion: BOOLEAN
			-- Are we about to format the first assertion?

	format_registration: FORMAT_REGISTRATION
			-- Structure registerd for formatting

	current_class_only: BOOLEAN
			-- Is Current only processing `class_c' and not
			-- its ancestors?

	feature_clause_order: ARRAY [STRING]
			-- Array of feature clause comment ordering

	is_clickable_format: BOOLEAN is
			-- Is the generated format the "clickable" format?
		do
			Result := current_class_only and not is_short
		end

	is_flat_short: BOOLEAN is
			-- Is the Current format doing a flat-short?
		do
			Result := is_short and then not current_class_only
		end

	is_feature_short: BOOLEAN is
			-- Is the Current format doing a flat-short?
		do
			Result := is_short
		end

	class_c: CLASS_C
			-- Current class being processed

	format: LOCAL_FORMAT
			-- Current internal formatting directives

	last_was_printed: BOOLEAN
			-- Were we able to print a structure?

	was_infix_arguments: BOOLEAN
			-- Were the arguments when preparing for
			-- a feature came from an infix?

	must_abort_on_failure: BOOLEAN is
			-- Must we abort on failure?
		require
			valid_format: format /= Void
		do
			Result := format.must_abort_on_failure
		end

	arguments: AST_EIFFEL
			-- Arguments for Current feature being analyzed

	is_feature_visible: BOOLEAN  is
			-- should the feature be visible
		do
			Result := client = Void
				or else local_adapt.is_visible (client)
		end

	global_adapt: GLOBAL_FEAT_ADAPTATION
			-- Has 2 purposes:
			-- 1. Store information for each main feature
			-- being adapted
			-- 2. Store source and target enclosing class
			--| Analyzing features 1 and 2 is used
			--| Analyzing invariants and inherit clauses 2 is used

	saved_global_adapt: GLOBAL_FEAT_ADAPTATION
			-- Saved feature adaptation information for enclosing
			-- features being analyzed

	unnested_local_adapt: LOCAL_FEAT_ADAPTATION
			-- Feature adaptation information for non nested features
			-- within the enclosing features

	saved_unnested_local_adapt: LOCAL_FEAT_ADAPTATION
			-- Saved feature adaptation information for non nested features
			-- within the enclosing features

	local_adapt: LOCAL_FEAT_ADAPTATION
			-- Current feature adaptation information for features
			-- within the enclosing features

	saved_local_adapt: LOCAL_FEAT_ADAPTATION
			-- Saved Current feature adaptation information for features
			-- within the enclosing features

	execution_error: BOOLEAN
			-- Did an error occur during `execute'?

	rescued: BOOLEAN
			-- Was Current format rescued?

	special_nl_symbol: TEXT_ITEM

feature -- Indentation

	indent_depth: INTEGER is
			-- Number of tabs leading the next line.
		do
			Result := format.indent_depth
		end

	tabs_emitted: BOOLEAN
			-- Have leading tabs already been emitted?

	emit_tabs is
			-- Emit tabs according to indent depth of current `format'.
		require
			not_tabs_emitted: not tabs_emitted
		local
			i: INTEGER
		do
			i := format.indent_depth
			if i > 0 then
				text.add (tab_with (i))
			end
			tabs_emitted := True
		end

feature -- Access

	has_feature_i: BOOLEAN is
			-- Does the currently analyzed features has
			-- associated feature_i (ie. is it compiled)?
		do
			Result := global_adapt.target_enclosing_feature /= Void
		ensure
			Result implies global_adapt.target_enclosing_feature /= Void
		end

	chained_assertion: CHAINED_ASSERTIONS is
			-- Chained assertion for current analyzed feature.
		require
			valid_global_adapt: global_adapt /= Void
		do
			if global_adapt.target_enclosing_feature /= Void then
				Result := format_registration.chained_assertion
			end
		end

	formal_name (pos: INTEGER): ID_AS is
			-- Formal name of class_c generics at position `pos.
		do
			Result := class_c.generics.i_th (pos).name.as_upper
		end

feature -- Setting

	set_indent_depth (d: INTEGER) is
			-- Assign `d' to `indent_depth'.
		do
			format.set_indent_depth (d)
		ensure
			assigned: d = indent_depth
		end

	set_last_was_printed (v: BOOLEAN) is
			-- Set `v' to `last_was_printed'.
		do
			last_was_printed := v
		ensure
			last_was_printed_set: last_was_printed = v
		end

	set_class_c (c: CLASS_C) is
		do
			class_c := c
		end

	set_separator (s: TEXT_ITEM) is
			-- Set current separator to `s'.
		do
			format.set_separator (s)
		ensure
			format.separator = s
		end

	set_new_line_between_tokens is
			-- Use a new line between tokens.
		do
			format.set_new_line_between_tokens (True)
			format.set_space_between_tokens (False)
		ensure
			format.new_line_between_tokens
			not format.space_between_tokens
		end

	set_no_new_line_between_tokens is
			-- Neither new line nor space between tokens.
		do
			format.set_new_line_between_tokens (False)
			format.set_space_between_tokens (False)
		ensure
			not format.new_line_between_tokens
			not format.space_between_tokens
		end

	set_space_between_tokens is
			-- Add a space character after the separator.
		do
			format.set_new_line_between_tokens (False)
			format.set_space_between_tokens (True)
		ensure
			not format.new_line_between_tokens
			format.space_between_tokens
		end

	set_feature_clause_order (fco: like feature_clause_order) is
			-- Set `feature_clause_order' to `fco'
		require
			valid_fco: fco /= Void
		do
			feature_clause_order := fco
		ensure
			set: feature_clause_order = fco
		end

	set_type_creation (t: TYPE_AS) is
			-- Set last_class_printed to the actual type of `t'.
		do
			last_class_printed := type_a_generator.evaluate_type (t, class_c)
		end

	set_insertion_point is
			-- Remember text position for parantheses
			-- and prefix operator.
		do
			if not tabs_emitted then
				emit_tabs
			end
			format.set_insertion_point (text.cursor)
		end

	set_current_class_only is
			-- Set current_class_only to True.
		do
			current_class_only := True;
		ensure
			current_class_only: current_class_only
		end

	set_first_assertion (b: BOOLEAN) is
			-- Set first_assertion `b'.
		do
			first_assertion := b
		ensure
			first_assertion = b
		end

	set_source_class (c: CLASS_C) is
			-- Set source class to `c'.
		require
			good_class: c /= Void
		do
			set_classes (c, class_c)
		ensure
			non_void_global: global_adapt /= Void
			source_set: global_adapt.source_enclosing_class = c
			target_set: global_adapt.target_enclosing_class = class_c
		end

	set_classes (source, target: CLASS_C) is
			-- Initialize global_adapt with classes
			-- `source' and `target'.
			--| Used in the inherit clause.
		do
			create global_adapt.make_with_classes (source, target)
			create local_adapt
			if source /= Void then
				local_adapt.update_from_global (global_adapt)
			end
			unnested_local_adapt := local_adapt
		ensure
			valid_global_adapt: global_adapt /= Void
			valid_local_adapt: local_adapt /= Void
			unnested_local_adapt = local_adapt
		end

	set_source_feature_for_assertion (source: FEATURE_I) is
			-- Set source feature to be analyzed to `source'.
		require
			valid_source: source /= Void
		do
			global_adapt := global_adapt.twin
			global_adapt.update_new_source_in_assertion (source)
			create unnested_local_adapt
			unnested_local_adapt.update_from_global (global_adapt)
			local_adapt := unnested_local_adapt
		end

	save_adaptations is
			-- Save adapt.
		do
			saved_global_adapt := global_adapt
			saved_local_adapt := local_adapt
			saved_unnested_local_adapt := unnested_local_adapt
		ensure
			saved_global_adapt = global_adapt
		end

	restore_adaptations is
			-- Restore adaptations.
		require
			valid_saved_global_adapt: saved_global_adapt /= Void
			valid_saved_local_adapt: saved_local_adapt /= Void
			valid_saved_unnested_adapt: saved_unnested_local_adapt /= Void
		do
			global_adapt := saved_global_adapt
			local_adapt := saved_local_adapt
			unnested_local_adapt := saved_unnested_local_adapt
			saved_global_adapt := Void
			saved_local_adapt := Void
			saved_unnested_local_adapt := Void
		ensure
			saved_global_adapt = Void
			saved_local_adapt = Void
			saved_unnested_local_adapt = Void
			global_adapt_set: (old saved_global_adapt) = global_adapt
			unnested_global_adapt_set: (old saved_unnested_local_adapt) = unnested_local_adapt
			global_adapt_set: (old saved_local_adapt) = local_adapt
		end

feature -- Setting local format details

	abort_on_failure is
			-- Set abort flag for format to be True.
		do
			format.set_must_abort (True)
		ensure
			must_abort_on_failure: must_abort_on_failure
		end

	continue_on_failure is
			-- Set abort flag for format to be False.
		do
			format.set_must_abort (False)
		ensure
			not_must_abort_on_failure: not must_abort_on_failure
		end

	indent is
			-- Indent next output line by one tab.
		do
			format.indent
		end

	exdent is
			-- Remove one leading tab for next line.
		require
			valid_indent: format.indent_depth > 0
		do
			format.exdent
		end

	need_dot is
			-- Formatting needs dot.
		do
			format.set_dot_needed (True)
		ensure
			format.dot_needed
		end

	set_in_indexing_clause (b: BOOLEAN) is
			-- Should manifest strings be formatted over multiple
			-- lines if encountered? For details, see STRING_AS.simple_format.
		do
			in_indexing_clause := b
		end

feature -- Access

	in_indexing_clause: BOOLEAN
			-- Should strings be formatted over multiple lines?
			-- For details, see STRING_AS.simple_format.

feature -- Execution

	execute is
				-- Execute the flat or flat_short.
		local
			prev_class: CLASS_C
			prev_cluster: CLUSTER_I
		do
			if not rescued then
				prev_class := System.current_class
				prev_cluster := Inst_context.cluster
				execution_error := False
				class_name := class_c.name

				if is_short then
					client := system.any_class.compiled_class
				end

				create format_registration.make (class_c, client)
				if is_flat_short then
					format_registration.initialize_creators
				end

				if not order_same_as_text then
					format_registration.set_feature_clause_order (feature_clause_order)
				end

				format_registration.fill (current_class_only)
				System.set_current_class (class_c)

				if format_registration.target_ast /= Void then
					Inst_context.set_cluster (class_c.cluster)
					formatter.format (format_registration.target_ast)
					Inst_context.set_cluster (Void)
				else
					execution_error := True
				end
			else
				Rescue_status.set_is_error_exception (False)
				Error_handler.trace
				execution_error := True
				rescued := False
			end
			System.set_current_class (prev_class)
			Inst_context.set_cluster (prev_cluster)
		rescue
			if Rescue_status.is_error_exception then
				rescued := True
				retry
			end
		end

feature -- Setting

	set_feature_comments (c: like feature_comments) is
			-- Set feature_comment to `c'
		do
			feature_comments := c
		ensure
			feature_comments = c
		end

feature -- Update

	begin is
			-- Save current format before a change.
			-- (To keep track of indent depth, separator etc.)
		local
			new_format: like format
		do
			new_format := format.twin
			new_format.set_position (text.cursor)
			format_stack.extend (new_format)
			format := new_format
		end

	commit is
			-- Go back to previous format.
			--| Keep text modifications.
		do
			format_stack.remove
			format := format_stack.item
			last_was_printed := True
		ensure then
			last_was_printed: last_was_printed
		end

	rollback is
			-- Go back to the previous format.
			-- Discard text modifications.
		do
			text.head (format.position_in_text)
			format_stack.remove
			format := format_stack.item
			last_was_printed := False
		ensure
			not_last_was_printed: not last_was_printed
			format_removed: not format_stack.has (old format)
		end

feature -- Element change

	put_class_name (s: STRING) is
			-- Append class name to 'text', treated as a stone.
		local
			classi: CLASS_I
		do
			if not tabs_emitted then
				emit_tabs
			end

				-- For .NET formatting, `class_c' might be Void.
			if not is_for_case and then class_c /= Void then
				classi := Universe.class_named (s, class_c.cluster)
				if classi = Void then
					text.add_string (s)
				else
					text.add_classi (classi, s)
				end
			else
				text.add_string (s)
			end
		end

	put_classi (c: CLASS_I) is
			-- Append class name to 'text', treated as a stone.
		do
			if not tabs_emitted then
				emit_tabs
			end
			text.add_classi (c, c.name)
		end

	put_clusteri (c: CLUSTER_I) is
			-- Append cluster name to 'text', treated as a stone.
		do
			if not tabs_emitted then
				emit_tabs
			end
			text.add_cluster (c, c.cluster_name)
		end

	prepare_class_text is
			-- Append standard text before class.
		do
			text.add_before_class (class_c)
		end

	end_class_text is
			-- Append standard text after class.
		do
			text.add_end_class (class_c)
		end

	put_origin_comment is
			-- Put original comment.
		do
			if global_adapt.source_enclosing_class
				/= global_adapt.target_enclosing_class
			then
				put_text_item (ti_Dashdash)
				text.add_space
				put_comment_text ("(from ")
				put_classi (global_adapt.source_enclosing_class.lace_class)
				put_comment_text (")")
				put_new_line
			end
		end

	new_expression is
			-- Prepare for a new expression.
		local
			f: like format
		do
			f := format
				-- For features that go from
				-- normal to an infix and
				-- for rolling back.
			f.set_insertion_point (text.cursor)
			f.set_dot_needed (False)
			local_adapt := unnested_local_adapt
			last_was_printed := True
		end

	prepare_for_feature (name: STRING; args: EIFFEL_LIST [EXPR_AS]) is
			-- Prepare for features within main features.
		require
			name_not_void: name /= Void
		local
			adapt: like local_adapt
			type: TYPE_A
		do
			if is_for_case then
				name_of_current_feature := name.twin
				arguments := args
			else
				if format.dot_needed then
					type := last_class_printed
					if type /= Void then
							-- Need to update type local_adapt for
							-- ! TYPE ! name.make
						local_adapt.set_source_type (type)
						local_adapt.set_target_type (type)
						local_adapt.set_evaluated_type
						last_class_printed := Void
					end
					adapt := local_adapt.adapt_nested_feature (name, global_adapt)
				else
					last_class_printed := Void
					adapt := unnested_local_adapt.adapt_feature (name, global_adapt)
				end
				local_adapt := adapt
				arguments := args
				was_infix_arguments := False
			end
		end

	prepare_for_main_feature is
			-- Prepare for enclosing context feature.
		do
			local_adapt := global_adapt.adapt_main_feature
			arguments := Void
		end

	prepare_for_current is
			-- Prepare for Current.
		do
			if not is_for_case then
				local_adapt := global_adapt.adapt_current;
			end
			arguments := Void
		end

	prepare_for_result is
			-- Prepare for Result.
		local
			adapt: like local_adapt
			type: TYPE_A
		do
			if not is_for_case then
				adapt := global_adapt.adapt_result
				type := last_class_printed
				if type /= Void then
						-- Clone result adaptation.
						-- Need to update type in result for
						-- ! TYPE ! Result.make
					adapt := adapt.twin
					adapt.set_source_type (type)
					adapt.set_target_type (type)
					adapt.set_evaluated_type
				end
				local_adapt := adapt
			end
			arguments := Void
		end

	prepare_for_infix (internal_name: STRING; visual_name: STRING; right: EXPR_AS) is
			-- Prepare for infix with feature `internal_name'
			-- and arg `right'.
		do
			if is_for_case then
				name_of_current_feature := visual_name;
			else
				local_adapt := local_adapt.adapt_infix (internal_name, visual_name, global_adapt)
				was_infix_arguments := True
			end
			arguments := right
		end

	prepare_for_prefix (internal_name: STRING; visual_name: STRING) is
			-- Prepare for infix with feature `internal_name'.
		do
			if is_for_case then
				name_of_current_feature := visual_name
			else
				local_adapt := local_adapt.adapt_prefix (internal_name, visual_name, global_adapt)
			end
			arguments := Void
		end

	prepare_for_bracket (operands: EIFFEL_LIST [EXPR_AS]) is
			-- Prepare for feature with bracket alias and `operands' arguments.
		require
			operands_not_void: operands /= Void
			operands_not_empty: not operands.is_empty
		do
			if is_for_case then
				name_of_current_feature := bracket_str
			else
				local_adapt := local_adapt.adapt_bracket (global_adapt)
			end
			was_infix_arguments := False
			arguments := operands
		end

	prepare_for_creation_expression_or_static_access (a_type: TYPE_AS; a_name: STRING; args: EIFFEL_LIST [EXPR_AS]) is
			-- Prepare for feature in creation expression or a static access.
		require
			a_type_not_void: a_type /= Void
			a_name_not_void: a_name /= Void
		local
			l_type: TYPE_A
		do
			if is_for_case then
				name_of_current_feature := a_name
			else
				l_type := type_a_generator.evaluate_type (a_type, class_c)
				local_adapt := unnested_local_adapt.adapt_feature ("", global_adapt)
				local_adapt.set_source_type (l_type)
				local_adapt.set_target_type (l_type)
				local_adapt.set_evaluated_type
				last_class_printed := Void
				if not a_name.is_empty then
						-- A creation routine or a static call was specified, use it for the adaptation.
					local_adapt := local_adapt.adapt_nested_feature (a_name, global_adapt)
				end
			end
			was_infix_arguments := False
			arguments := args
		end

feature -- Output

	register_invariants is
			-- Register the invariants for target class.
		do
			create format_registration.make (class_c, client)
			format_registration.register_invariants
		end

	format_categories is
			-- Format the categories for class_c.
		do
			format_registration.format_categories (Current)
		end

	format_invariants is
			-- Format the invariants for class_c.
		local
			old_is_with_breakable: BOOLEAN
		do
			old_is_with_breakable := is_with_breakable
			set_is_without_breakable
			format_registration.format_invariants (Current)
			if old_is_with_breakable then
				set_is_with_breakable
			end
		end

	format_indexing_with_no_keyword (an_indexing_clause: INDEXING_CLAUSE_AS) is
			-- Format `an_indexing_clause' without putting the `indexing' keyword
			-- nor doing any indentation.
		require
			an_indexing_clause_not_void: an_indexing_clause /= Void
		do
			formatter.format_indexing_with_no_keyword (an_indexing_clause)
		end

	format_ast (ast: AST_EIFFEL) is
			-- Call simple_for on `ast'.
		require
			ast_not_void: ast /= Void
		do
			formatter.format (ast)
		end

	put_separator is
			-- Append the current separator to `text'.
		do
			if format.separator /= Void and then format.separator /= ti_empty then
				text.add (format.separator)
			end
			if format.space_between_tokens then
				text.add_space
			elseif format.new_line_between_tokens then
				put_new_line
			end
		end

	put_space is
			-- Append space.
		do
			text.add_space
		end

	put_string (s: STRING) is
			-- Append `s' to `text'.
		require
			s_exists: s /= Void
		do
			if not tabs_emitted then
				emit_tabs
			end
			text.add_string (s)
		end

	put_manifest_string (s: STRING) is
			-- Append `s' to `text'.
		require
			s_exists: s /= Void
		do
			if not tabs_emitted then
				emit_tabs
			end
			text.add_manifest_string (s)
		end

	put_breakable is
			-- Put breakable point.
			--| Do nothing - convenience routine.
		do
		end

	put_text_item_without_tabs (t: TEXT_ITEM) is
			-- Append `t' to `text'. Do not emit tabs.
		do
			text.add (t)
		end

	put_text_item (t: TEXT_ITEM) is
			-- Append `t' to `text'. Emit tabs if needed.
		require
			t_not_void: t /= Void
		do
			if not tabs_emitted then
				emit_tabs
			end
			text.add (t)
		end

	put_quoted_string_item (s: STRING) is
			-- Append `s' as STRING_TEXT to `text'. Emit tabs if needed.
		require
			s_not_void: s /= Void
		local
			new: STRING
		do
			new := eiffel_string (s)
			new.precede ('"')
			new.extend ('"')
			put_string_item (new)
		end

	put_string_item (s: STRING) is
			-- Append `s' as STRING_TEXT to `text'. Emit tabs if needed.
		require
			s_not_void: s /= Void
		do
			if not tabs_emitted then
				emit_tabs
			end
			if in_indexing_clause then
				text.add_indexing_string (s)
			else
				text.add_manifest_string (s)
			end
		end

	put_front_text_item (t: TEXT_ITEM) is
			-- Insert `t' to `text' in front of list.
		do
			text.put_front (t)
			text.finish
		end

	put_new_line is
			-- Go to beginning of next line in `text'.
		do
			text.add_new_line
			if special_nl_symbol /= Void then
				text.add (special_nl_symbol)
			end
			tabs_emitted := False
		end

	put_main_feature_name is
			-- Put feature name of anlayzed feature.
		local
			alias_name: STRING
		do
				-- For infix features and for
				-- features becoming infixes
			format.set_insertion_point (text.cursor)
			if local_adapt.is_normal then
				put_normal_feature
				alias_name := local_adapt.alias_name
				if alias_name /= Void then
					put_space
					put_text_item (ti_alias_keyword)
					put_space
					put_text_item_without_tabs (ti_double_quote)
					text.add (operator_to_item (alias_name, local_adapt))
					put_text_item_without_tabs (ti_double_quote)
					if local_adapt.has_convert_mark then
						put_space
						put_text_item (ti_convert_keyword)
					end
					last_was_printed := True
				end
			elseif local_adapt.is_infix then
					-- Don't want space around `infix'
				put_infix_name (local_adapt)
			else
				put_prefix_feature
			end
		end

	put_current_feature is
			-- Put Current feature.
		local
			arg: EIFFEL_LIST [EXPR_AS]
		do
			if is_for_case then
				if format.dot_needed then
					text.add (ti_Dot)
				elseif not tabs_emitted then
					emit_tabs
				end
				text.add_string (name_of_current_feature)
				arg ?= arguments
				if arg /= Void then
					begin
					set_separator (ti_Comma)
					set_space_between_tokens
					text.add_space
					text.add (ti_L_parenthesis)
					formatter.format (arg)
					text.add (ti_R_parenthesis)
					commit
					arg.start
				end
			else
				if local_adapt.is_normal then
					put_normal_feature
				elseif local_adapt.is_infix then
					put_infix_feature
				elseif local_adapt.is_prefix then
					put_prefix_feature
				else
					put_bracket_feature
				end
			end
		end

	put_comments (comments: EIFFEL_COMMENTS) is
			-- Put `comment' in `text'.
		require
			valid_comments: comments /= Void
		local
			txt: STRING
		do
			from
				comments.start
			until
				comments.after
			loop
				txt := comments.item
				if txt.is_empty or else txt.item (1) /= '|' then
					put_text_item (ti_Dashdash)
					put_comment_text (comments.item)
					put_new_line
				end
				comments.forth
			end
		end

	put_comment_text (c: STRING) is
			-- Interprets the ` and ' signs of the comment
			-- and append it to `text'.
		require
			c_not_void: c /= Void
		do
			--| VB 06/15/2000 Entire implementation removed.
			--| Quoted text will now be taken care of by STRUCTURED_TEXT.add_comment_text.
			if not c.is_empty then
				text.add_comment_text (c)
			end
		end

feature -- Implementation

	put_normal_feature is
			-- Put normal feature (not infix or prefix feature).
		local
			feature_i: FEATURE_I
			args: like arguments
			item: BASIC_TEXT
			f_name: STRING
			adapt: like local_adapt
		do
			if format.dot_needed then
				text.add (ti_Dot)
			else
				if not tabs_emitted then
					emit_tabs
				end
--| FIXME VB 06/13/2000 Removed this:
--|				if (in_assertion and then not is_feature_visible) then
--|					last_was_printed := False
--|				end
--| ... and suddenly all contracts seem to be printed...!?!
--| I presume the purpose is to hide assertions that have non-exported
--| features in them but that did not work AT ALL.
			end
			if last_was_printed then
				adapt := local_adapt
				feature_i := adapt.target_feature
				f_name := adapt.final_name
				if feature_i /= Void and then in_bench_mode then
					create {FEATURE_TEXT} item.make (feature_i.api_feature (adapt.target_class.class_id), f_name)
				else
					create {LOCAL_TEXT} item.make (f_name)
				end
				text.add (item)
				args := arguments
				if args /= Void then
					begin
					if was_infix_arguments then
							-- Feature in source class was
							-- an infix (need to create new_expression).
						new_expression
					end
					set_separator (ti_Comma)
					set_space_between_tokens
					text.add_space
					text.add (ti_L_parenthesis)
					abort_on_failure
					formatter.format (args)
					text.add (ti_R_parenthesis)
					if last_was_printed then
						commit
					else
						rollback
					end
					-- Reestablish local adaptations.
					local_adapt := adapt
				else
					last_was_printed := True
				end;
			end
		end

	put_prefix_feature is
			-- Put prefix feature.
		local
			item: BASIC_TEXT
		do
			if is_for_case then
				if not tabs_emitted then
					emit_tabs
				end
				text.add (operator_to_item (name_of_current_feature, Void))
			else
				item :=  operator_to_item (local_adapt.final_name, local_adapt)
				text.go_to (format.insertion_point)
				text.add (item)
				last_was_printed := True
			end
		end

feature {UNARY_AS, AST_FORMATTER_VISITOR} -- Implementation

	put_prefix_space is
			-- Append extra space after prefix feature.
			-- This used to be automatically added, but this is
			-- not correct, since it also showed up in the
			-- feature declaration (prefix "not "). This function
			-- is called by UNARY_AS.format.
		do
			text.go_to (format.insertion_point)
			text.forth
			text.add (ti_Space)
		end

feature {NONE} -- Implementation

	put_bracket_feature is
			-- Put bracket feature.
		local
			operands: like arguments
			adapt: like local_adapt
		do
			operands := arguments
			adapt := local_adapt
			text.add_space
			text.add (operator_to_item ("[", adapt))
			if operands /= Void then
				begin
				set_separator (ti_Comma)
				set_space_between_tokens
				abort_on_failure
				formatter.format (operands)
				if is_for_case or else last_was_printed then
					commit
				else
					rollback
				end
					-- Reestablish adaptations.
				local_adapt := adapt
			end
			text.add (operator_to_item ("]", adapt))
		end

feature -- Implementation

	put_infix_feature is
			-- Put infix feature.
		local
			args: like arguments
			adapt: like local_adapt
			arg: EXPR_AS
		do
			if is_for_case then
				text.add_space
				text.add (operator_to_item (name_of_current_feature, Void))
				text.add_space
				arg ?= arguments
				if arg /= Void then
					begin
					new_expression
					formatter.format (arg)
					commit
				end
			else
				adapt := local_adapt
				text.add_space
				put_infix_name (adapt)
				text.add_space
				args := arguments
				if args /= Void then
					begin
					new_expression
					formatter.format (args)
					if last_was_printed then
						commit
					else
						rollback
					end
						-- Reestablish adaptations.
					local_adapt := adapt
				end
			end
		end

	put_infix_name (adapt: like local_adapt) is
		do
			text.add (operator_to_item (adapt.final_name, adapt))
			last_was_printed := True
		end

	operator_to_item (a_visual_name: STRING; adapt: like local_adapt): BASIC_TEXT is
			-- Get structured text item for infix/prefix `a_target_feature' with `a_visual_name'.
		do
			if adapt /= Void and then adapt.target_feature /= Void and then in_bench_mode then
				create {OPERATOR_TEXT} Result.make (
					adapt.target_feature.api_feature (
						adapt.target_class.class_id
					),
					a_visual_name
				)
			elseif (a_visual_name @ 1).is_alpha then
				create {KEYWORD_TEXT} Result.make (a_visual_name)
			else
				create {SYMBOL_TEXT} Result.make (a_visual_name)
			end
		end

feature {NONE} -- Implementation

	tabs_array: ARRAY [INDENT_TEXT] is
			-- Array of five tab texts
		once
			Result := <<ti_Tab1, ti_Tab2, ti_Tab3, ti_Tab4, ti_Tab5>>
		end

	tab_with (i: INTEGER): INDENT_TEXT is
			-- Tab text with indent depth of `i'
		require
			positive_i: i > 0
		do
			if i > 5 then
				create Result.make (i)
			else
				Result := tabs_array @ i
			end
		ensure
			valid_result: Result /= Void
		end

	formatter: AST_FORMATTER_VISITOR;
			-- Formatter of AST_EIFFEL nodes

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end	 -- class FORMAT_CONTEXT
