indexing
	description: "[
				Formatting decorator for class ast (flat, flat/short , clickable format & documentation).
				Works as a mediator between output strategy and text formatter.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class TEXT_FORMATTER_DECORATOR

inherit
	SHARED_SERVER

	SHARED_INST_CONTEXT

	SHARED_RESCUE_STATUS

	SHARED_FORMAT_INFO

	SHARED_ERROR_HANDLER

	COMPILER_EXPORTER

	CHARACTER_ROUTINES
		export
			{NONE} all
		end

	TEXT_FORMATTER
		redefine
			process_character_text,
			process_generic_text,
			process_indexing_tag_text,
			process_local_text,
			process_number_text,
			process_assertion_tag_text,
			process_string_text,
			process_reserved_word_text,
			process_difference_text_item,
			process_feature_error,
			process_tooltip_item,
			process_feature_dec_item,
			process_column_text,
			process_call_stack_item,
			process_menu_text,
			process_class_menu_text
		end

create
	make, make_for_case, make_for_appending

feature {NONE} -- Initialization

	make (c: CLASS_C; a_text_formatter: like text_formatter) is
			-- Initialize Current for bench.
		require
			valid_c: c /= Void
		do
			current_class := c
			current_class_only := False
			reset_format_booleans
			initialize (a_text_formatter)
		ensure
			class_c_set: current_class /= Void and then current_class = c
			batch_mode:	not in_bench_mode
			analyze_ancestors: not current_class_only
			do_flat: not is_short
		end

	make_for_case (a_text_formatter: like text_formatter) is
			-- Initialize current for simple
			-- format for eiffelcase (to get
			-- image of precondition and postcondition).
		do
			is_for_case := True
			initialize (a_text_formatter)
		end

	make_for_appending (a_text_formatter: like text_formatter) is
			-- Create context for appending an AST item to `a_text'.
		do
			reset_format_booleans
			initialize (a_text_formatter)
		end

	initialize (a_formatter: TEXT_FORMATTER) is
			-- Initialize structures for Current.
		do
			create format_stack.make
			text_formatter := a_formatter
			create format
			format_stack.extend (format)
			create ast_output_strategy.make (Current)
			setup_output_strategy
		end

feature -- Initialization

	init_uncompiled_feature_context (a_source_class: CLASS_C; a_feature_as: FEATURE_AS) is
			-- Initialize Current context to analyze
			-- uncompiled feature ast `a_feature_as'.
			-- This ast is not in the feature table (ie has
			-- not been compiled) but has been entered by
			-- the user.
		require
			valid_source_class: a_source_class /= Void
			valid_ast: a_feature_as /= Void
		do
			source_class := a_source_class
			source_feature := a_source_class.feature_of_feature_id (a_feature_as.id)
			setup_output_strategy
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
			source_feature := source
			assertion_source_feature := source
			target_feature := target
			source_class := source.written_class
			setup_output_strategy
		end

	init_variant_context is
			-- Initialize context as processing in variant.
		do
			source_feature := Void
			setup_output_strategy
			set_in_assertion
		end

feature -- Case properties

	name_of_current_feature: STRING;
			-- Name of feature currently being processed

	dotnet_name_of_current_feature: STRING;
			-- .NET name of feature currently being processed

feature -- Status report

	is_for_case: BOOLEAN
			-- Is Current format done for EiffelCase?

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

	is_feature_visible: BOOLEAN  is
			-- should the feature be visible
		do
			Result := client = Void
				or else target_feature /= Void and then target_feature.is_exported_for (client)
		end

	first_assertion: BOOLEAN
			-- Are we about to format the first assertion?

	current_class_only: BOOLEAN
			-- Is Current only processing `class_c' and not
			-- its ancestors?

	execution_error: BOOLEAN
			-- Did an error occur during `execute'?

	rescued: BOOLEAN
			-- Was Current format rescued?


feature -- Properties

	dot_needed: BOOLEAN is
			-- Will next processing need dot at beginning?
		do
			Result := format.dot_needed
		end

	match_list: LEAF_AS_LIST is
			-- Match list for roundtrip parser.
		local
			l_id: INTEGER
		do
			if client /= Void then
				l_id := client.class_id
			else
				l_id := current_class.class_id
			end
			Result := match_list_server.item (l_id)
		end

	format_stack: LINKED_STACK [LOCAL_FORMAT]
			-- Stack to keep track of all formats.
			-- Push at begin, pop at commit and rollback.

	client: CLASS_C
			-- Client class for Current flat

	class_name: STRING
			-- Class name of `current_class'

	feature_comments: EIFFEL_COMMENTS
			-- Comments for current analyzed feature

	format_registration: FORMAT_REGISTRATION
			-- Structure registerd for formatting

	feature_clause_order: ARRAY [STRING]
			-- Array of feature clause comment ordering

	current_class: CLASS_C
			-- Current class being processed

	source_class: CLASS_C
			-- Source class from current AST comes.

	source_feature, target_feature, assertion_source_feature: FEATURE_I
			-- Source feature, target feature and assertion source feature.
			-- When processin assertion, `source_feature' will not change,
			-- we access soure feature by `assertion_source_feature'.

	format: LOCAL_FORMAT
			-- Current internal formatting directives

	arguments: AST_EIFFEL
			-- Arguments for Current feature being analyzed

	special_nl_symbol: STRING
			-- When set, we process `special_nl_symbol' within `put_new_line'.

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
				text_formatter.process_indentation (i)
			end
			tabs_emitted := True
		end

feature -- Access

	chained_assertion: CHAINED_ASSERTIONS is
			-- Chained assertion for current analyzed feature.
		do
			if target_feature /= Void then
				Result := format_registration.chained_assertion
			end
		end

	formal_name (pos: INTEGER): ID_AS is
			-- Formal name of class_c generics at position `pos.
		do
			Result := current_class.generics.i_th (pos).name.as_upper
		end

feature -- Setting

	set_indent_depth (d: INTEGER) is
			-- Assign `d' to `indent_depth'.
		do
			format.set_indent_depth (d)
		ensure
			assigned: d = indent_depth
		end

	set_separator (s: STRING) is
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
			-- Set `source_class' to `c'.
		require
			good_class: c /= Void
		do
			ast_output_strategy.set_source_class (c)
			source_class := c
		end

	set_source_feature_for_assertion (source: FEATURE_I) is
			-- Set source feature to be analyzed to `source'.
		require
			valid_source: source /= Void
		do
			assertion_source_feature := source
		end

	set_without_tabs is
			-- Set next insertion without tabs.
		do
			without_tabs := true
		end

	set_for_documentation (a_doc: DOCUMENTATION_ROUTINES) is
			-- Set `is_for_documentation'
		do
			create {AST_DOCUMENTATION_OUTPUT_STRATEGY}ast_output_strategy.make (Current, a_doc)
			setup_output_strategy
		end

feature -- Setting local format details

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
				class_name := current_class.name

				if is_short then
					client := system.any_class.compiled_class
				end

				create format_registration.make (current_class, client)
				if is_flat_short then
					format_registration.initialize_creators
				end

				if not order_same_as_text then
					format_registration.set_feature_clause_order (feature_clause_order)
				end

				format_registration.fill (current_class_only)
				System.set_current_class (current_class)

				if format_registration.target_ast /= Void then
					Inst_context.set_cluster (current_class.cluster)
						-- We initialize source class as current class
						-- when processing the header of a class.
					ast_output_strategy.set_current_class (current_class)
					ast_output_strategy.set_source_class (current_class)
					ast_output_strategy.format (format_registration.target_ast)
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
			format_stack.extend (new_format)
			format := new_format
		end

	commit is
			-- Go back to previous format.
			--| Keep text modifications.
		do
			format_stack.remove
			format := format_stack.item
		end

feature -- Element change

	put_classi (c: CLASS_I) is
			-- Append class name to `text_formatter'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_class_name_text (c.name, c, false)
		end

	put_origin_comment is
			-- Put original comment.
		do
			if source_class /= current_class then
				process_comment_text (ti_Dashdash, Void)
				text_formatter.add_space
				process_comment_text ("(from ", Void)
				set_without_tabs
				put_classi (source_class.lace_class)
				process_comment_text (")", Void)
				put_new_line
			end
		end

	new_expression is
			-- Prepare for a new expression.
		do
			format.set_dot_needed (False)
		end

feature -- Output

	register_invariants is
			-- Register the invariants for target class.
		do
			create format_registration.make (current_class, client)
			format_registration.register_invariants
		end

	format_categories is
			-- Format the categories for `current_class'.
		do
			format_registration.format_categories (Current)
		end

	format_invariants is
			-- Format the invariants for `current_class'.
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
			ast_output_strategy.format_indexing_with_no_keyword (an_indexing_clause)
		end

	format_ast (ast: AST_EIFFEL) is
			-- Call simple_for on `ast'.
		require
			ast_not_void: ast /= Void
		do
			ast_output_strategy.format (ast)
		end

	put_separator is
			-- Append the current separator to `text_formatter'.
		local
			l_sep: STRING
		do
			l_sep := format.separator
			if l_sep /= Void and then l_sep /= ti_empty then
				if l_sep = ti_comma or else l_sep = ti_semi_colon then
					text_formatter.process_symbol_text (l_sep)
				elseif l_sep = ti_new_line then
					put_new_line
				else
					text_formatter.add (l_sep)
				end
			end
			if format.space_between_tokens then
				text_formatter.add_space
			elseif format.new_line_between_tokens then
				put_new_line
			end
		end

	put_space is
			-- Append space.
		do
			text_formatter.add_space
		end

	put_manifest_string (s: STRING) is
			-- Append `s' to `text_formatter'.
		require
			s_exists: s /= Void
		do
			if not tabs_emitted then
				emit_tabs
			end
			text_formatter.add_manifest_string (s)
		end

	put_breakable is
			-- Put breakable point.
			--| Do nothing - convenience routine.
		do
		end

	put_quoted_string_item (s: STRING) is
			-- Append `s' as string text to `text_formatter'. Emit tabs if needed.
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
			-- Append `s' as string text to `text_formatter'. Emit tabs if needed.
			-- If `in_indexing_clause', we seperate string.
		require
			s_not_void: s /= Void
		do
			if not tabs_emitted then
				emit_tabs
			end
			if in_indexing_clause then
				text_formatter.add_indexing_string (s)
			else
				text_formatter.add_manifest_string (s)
			end
		end

	put_new_line is
			-- Put a new line, following `special_nl_symbol'.
		do
			text_formatter.add_new_line
			if special_nl_symbol /= Void then
				text_formatter.add (special_nl_symbol)
			end
			tabs_emitted := False
		end

	put_comments (comments: EIFFEL_COMMENTS) is
			-- Put `comments' in `text_formatter'.
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
					process_comment_text (ti_Dashdash, Void)
					put_comment_text (comments.item)
					put_new_line
				end
				comments.forth
			end
		end

	put_comment_text (c: STRING) is
			-- Separate `c'
			-- and append it to `text_formatter'.
			-- We do not use it if not necessary, as it slow.
		require
			c_not_void: c /= Void
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			if not c.is_empty then
				text_formatter.add_comment_text (c)
			end
		end

feature -- Text formatter decorator

	process_basic_text (text: STRING) is
			-- Process default basic text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_basic_text (text)
		end

	process_character_text (text: STRING) is
			-- Process string text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_character_text (text)
		end

	process_generic_text (text: STRING) is
			-- Process string text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_generic_text (text)
		end

	process_indexing_tag_text (text: STRING) is
			-- Process string text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_indexing_tag_text (text)
		end

	process_local_text (text: STRING) is
			-- Process string text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_local_text (text)
		end

	process_number_text (text: STRING) is
			-- Process string text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_number_text (text)
		end

	process_quoted_text (text: STRING) is
			-- Process the quoted `text' within a comment.
		do
			if not tabs_emitted then
				emit_tabs
			end
			text_formatter.process_quoted_text (text)
		end

	process_assertion_tag_text (text: STRING) is
			-- Process string text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_assertion_tag_text (text)
		end

	process_string_text (text: STRING; link: STRING) is
			-- Process string text `text'.
			-- possible `link', can be void.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_string_text (text, link)
		end

	process_reserved_word_text (text: STRING) is
			-- Process string text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_reserved_word_text (text)
		end

	process_comment_text (text: STRING; url: STRING) is
			-- Process comment text.
			-- `url' is possible url, which can be void if none.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_comment_text (text, url)
		end

	process_difference_text_item (text: STRING) is
			-- Process difference text text.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_difference_text_item (text)
		end

	process_class_name_text (text: STRING; a_class: CLASS_I; a_quote: BOOLEAN) is
			-- Process class name of `a_class'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_class_name_text (text, a_class, a_quote)
		end

	process_cluster_name_text (text: STRING; a_cluster: CLUSTER_I; a_quote: BOOLEAN) is
			-- Process cluster name of `a_cluster'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_cluster_name_text (text, a_cluster, a_quote)
		end

	process_feature_name_text (text: STRING; a_class: CLASS_C) is
			-- Process feature name text `text'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_feature_name_text (text, a_class)
		end

	process_feature_error (text: STRING; a_feature: E_FEATURE; a_line: INTEGER) is
			-- Process error feature text.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_feature_error (text, a_feature, a_line)
		end

	process_feature_text (text: STRING; a_feature: E_FEATURE; a_quote: BOOLEAN) is
			-- Process feature text `text'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_feature_text (text, a_feature, a_quote)
		end

	process_breakpoint_index (a_feature: E_FEATURE; a_index: INTEGER; a_cond: BOOLEAN) is
			-- Process breakpoint index `a_index'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_breakpoint_index (a_feature, a_index, a_cond)
		end

	process_breakpoint (a_feature: E_FEATURE; a_index: INTEGER) is
			-- Process breakpoint.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_breakpoint (a_feature, a_index)
		end

	process_padded is
			-- Process padded item at start of non breakpoint line.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_padded
		end

	process_new_line is
			-- Process new line.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_new_line
		end

	process_indentation (a_indent_depth: INTEGER) is
			-- Process indentation `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_indentation (a_indent_depth)
		end

	process_after_class (a_class: CLASS_C) is
			-- Process after class `a_class'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_after_class (a_class)
		end

	process_before_class (a_class: CLASS_C) is
			-- Process before class `a_class'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_before_class (a_class)
		end

	process_filter_item (text: STRING; is_before: BOOLEAN) is
			-- Process filter text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_filter_item (text, is_before)
		end

	process_tooltip_item (a_tooltip: STRING; is_before: BOOLEAN) is
			-- Process tooltip text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_tooltip_item (a_tooltip, is_before)
		end

	process_feature_dec_item (a_feature_name: STRING; is_before: BOOLEAN) is
			-- Process feature dec.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_feature_dec_item (a_feature_name, is_before)
		end

	process_symbol_text (text: STRING) is
			-- Process symbol text.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_symbol_text (text)
		end

	process_keyword_text (text: STRING; a_feature: E_FEATURE) is
			-- Process keyword text.
			-- `a_feature' is possible feature.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_keyword_text (text, a_feature)
		end

	process_operator_text (text: STRING; a_feature: E_FEATURE) is
			-- Process operator text.
			-- `a_feature' can be void.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_operator_text (text, a_feature)
		end

	process_address_text (a_address, a_name: STRING; a_class: CLASS_C) is
			-- Process address text.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_address_text (a_address, a_name, a_class)
		end

	process_error_text (text: STRING; a_error: ERROR) is
			-- Process error text.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_error_text (text, a_error)
		end

	process_cl_syntax (text: STRING; a_syntax_message: SYNTAX_MESSAGE; a_class: CLASS_C) is
			-- Process class syntax text.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_cl_syntax (text, a_syntax_message, a_class)
		end

	process_ace_syntax (text: STRING; a_error: ERROR) is
			-- Process Ace syntax text.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_ace_syntax (text, a_error)
		end

	process_column_text (a_column_number: INTEGER) is
			-- Process `a_column_number'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_column_text (a_column_number)
		end

	process_call_stack_item (level_number: INTEGER; display: BOOLEAN) is
			-- Process the current callstack text.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_call_stack_item (level_number, display)
		end

	process_menu_text (text, link: STRING) is
			-- Process menu item. This is only useful for generation to
			-- formats that support hyperlinking.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_menu_text (text, link)
		end

	process_class_menu_text (text, link: STRING) is
			-- Process class menu item. This is only useful for generation to
			-- formats that support hyperlinking.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := false
			text_formatter.process_class_menu_text (text, link)
		end

feature {NONE} -- Implementation

	without_tabs : BOOLEAN
			-- Indent before next processing?

	ast_output_strategy: AST_DECORATED_OUTPUT_STRATEGY
			-- Visitor of AST_EIFFEL nodes

	text_formatter: TEXT_FORMATTER;
			-- Text formatter

	setup_output_strategy is
			-- Setup attributes in `ast_output_strategy'.
		do
			ast_output_strategy.set_source_class (source_class)
			ast_output_strategy.set_current_class (current_class)
			ast_output_strategy.set_source_feature (source_feature)
			ast_output_strategy.set_current_feature (target_feature)
			ast_output_strategy.wipe_out_error
		end

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

end	 -- class TEXT_FORMATTER_DECORATOR
