note
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
			process_class_menu_text,
			set_context_group,
			context_group,
			set_meta_data
		end

create
	make, make_for_case, make_for_appending

feature {NONE} -- Initialization

	make (c: CLASS_C; a_text_formatter: like text_formatter)
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

	make_for_case (a_text_formatter: like text_formatter)
			-- Initialize current for simple
			-- format for eiffelcase (to get
			-- image of precondition and postcondition).
		do
			is_for_case := True
			initialize (a_text_formatter)
		end

	make_for_appending (a_text_formatter: like text_formatter)
			-- Create context for appending an AST item to `a_text'.
		do
			reset_format_booleans
			initialize (a_text_formatter)
		end

	initialize (a_formatter: TEXT_FORMATTER)
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

	init_uncompiled_feature_context (a_source_class: CLASS_C; a_feature_as: FEATURE_AS)
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
				feature_as: FEATURE_AS)
			-- Initialize Current context to analyze
			-- `source' and `target' features.
			-- Use `feature_as' to set up locals.
		require
			valid_source: source /= Void
			valid_ast: feature_as /= Void
			valid_target: target /= Void
		do
			source_feature := source
			target_feature := target
			if source.is_replicated_directly then
				source_class := source.access_class
			else
				source_class := source.written_class
			end
			setup_output_strategy
		end

	init_variant_context (s: CLASS_C)
			-- Initialize context to process an invariant of a class `s'.
		do
			set_source_class (s)
			source_feature := s.invariant_feature
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

	is_clickable_format: BOOLEAN
			-- Is the generated format the "clickable" format?
		do
			Result := current_class_only and not is_short
		end

	is_flat_short: BOOLEAN
			-- Is the Current format doing a flat-short?
		do
			Result := is_short and then not current_class_only
		end

	is_feature_short: BOOLEAN
			-- Is the Current format doing a flat-short?
		do
			Result := is_short
		end

	is_feature_visible: BOOLEAN
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

	is_in_note_clause: BOOLEAN
			-- Is in note clause formatting?

feature -- Properties

	dot_needed: BOOLEAN
			-- Will next processing need dot at beginning?
		do
			Result := format.dot_needed
		end

	match_list: LEAF_AS_LIST
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

	feature_clause_order: ARRAY [STRING_32]
			-- Array of feature clause comment ordering

	current_class: CLASS_C
			-- Current class being processed

	source_class: CLASS_C
			-- Source class from current AST comes.

	source_feature, target_feature: FEATURE_I
			-- Source feature, target feature .

	format: LOCAL_FORMAT
			-- Current internal formatting directives

	arguments: AST_EIFFEL
			-- Arguments for Current feature being analyzed

	special_nl_symbol: STRING
			-- When set, we process `special_nl_symbol' within `put_new_line'.

	context_group: CONF_GROUP
			-- Context group
		do
			Result := text_formatter.context_group
		end

feature -- Indentation

	indent_depth: INTEGER
			-- Number of tabs leading the next line.
		do
			Result := format.indent_depth
		end

	tabs_emitted: BOOLEAN
			-- Have leading tabs already been emitted?

	emit_tabs
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

	chained_assertion: CHAINED_ASSERTIONS
			-- Chained assertion for current analyzed feature.
		do
			if target_feature /= Void then
				Result := format_registration.chained_assertion
			end
		end

	formal_name (pos: INTEGER): STRING_32
			-- Formal name of class_c generics at position `pos.
		do
			Result := current_class.generics.i_th (pos).name.name_8.as_upper
		end

	e_feature: E_FEATURE
		-- Current feature.

	breakpoint_index: INTEGER;
		-- Breakpoint index in feature

feature -- Setting

	set_indent_depth (d: INTEGER)
			-- Assign `d' to `indent_depth'.
		do
			format.set_indent_depth (d)
		ensure
			assigned: d = indent_depth
		end

	set_separator (s: STRING)
			-- Set current separator to `s'.
		do
			format.set_separator (s)
		ensure
			format.separator = s
		end

	set_new_line_between_tokens
			-- Use a new line between tokens.
		do
			format.set_new_line_between_tokens (True)
			format.set_space_between_tokens (False)
		ensure
			format.new_line_between_tokens
			not format.space_between_tokens
		end

	set_no_new_line_between_tokens
			-- Neither new line nor space between tokens.
		do
			format.set_new_line_between_tokens (False)
			format.set_space_between_tokens (False)
		ensure
			not format.new_line_between_tokens
			not format.space_between_tokens
		end

	set_space_between_tokens
			-- Add a space character after the separator.
		do
			format.set_new_line_between_tokens (False)
			format.set_space_between_tokens (True)
		ensure
			not format.new_line_between_tokens
			format.space_between_tokens
		end

	set_feature_clause_order (fco: like feature_clause_order)
			-- Set `feature_clause_order' to `fco'
		require
			valid_fco: fco /= Void
		do
			feature_clause_order := fco
		ensure
			set: feature_clause_order = fco
		end

	set_current_class_only
			-- Set current_class_only to True.
		do
			current_class_only := True;
		ensure
			current_class_only: current_class_only
		end

	set_first_assertion (b: BOOLEAN)
			-- Set first_assertion `b'.
		do
			first_assertion := b
		ensure
			first_assertion = b
		end

	set_source_class (c: CLASS_C)
			-- Set `source_class' to `c'.
		require
			good_class: c /= Void
		do
			ast_output_strategy.set_source_class (c)
			source_class := c
		end

	set_without_tabs
			-- Set next insertion without tabs.
		do
			without_tabs := True
		end

	set_for_documentation (a_doc: DOCUMENTATION_ROUTINES)
			-- Set `is_for_documentation'
		do
			create {AST_DOCUMENTATION_OUTPUT_STRATEGY}ast_output_strategy.make (Current, a_doc)
			setup_output_strategy
		end

	set_for_expression_meta
			-- Set for expression meta.
		do
			create {AST_EXPRESSION_META_OUTPUT_STRATEGY}ast_output_strategy.make (Current)
			setup_output_strategy
		end

	set_context_group (a_group: like context_group)
			-- Set `context_group' with `a_group'.
		do
			text_formatter.set_context_group (a_group)
		end

	restore_attributes (a_feature_comments: EIFFEL_COMMENTS; a_arguments: AST_EIFFEL;
						a_target_feature: FEATURE_I; a_source_feature: FEATURE_I;
						a_ast_output_strategy: like ast_output_strategy;
						a_breakpoint_index: INTEGER; a_e_feature: E_FEATURE)
		do
			feature_comments := a_feature_comments
			arguments := a_arguments
			target_feature := a_target_feature
			source_feature := a_source_feature
			ast_output_strategy := a_ast_output_strategy
			breakpoint_index := a_breakpoint_index
			e_feature := a_e_feature
		end

	set_meta_data (a_data: detachable ANY)
			-- Set `meta_data' with `a_data'.
		do
			Precursor (a_data)
				-- Propagate into the decorated formatter.
			text_formatter.set_meta_data (a_data)
		end

	search_eis_entry_in_note_clause (a_index: detachable INDEX_AS)
			-- Set `is_in_note_clause' with `b'.
		do
			if attached a_index as l_index then
				last_eis_entry_and_source_as := found_eis_entry (l_index, source_feature)
			else
				last_eis_entry_and_source_as := Void
			end
		end

feature -- Setting local format details

	indent
			-- Indent next output line by one tab.
		do
			format.indent
		end

	exdent
			-- Remove one leading tab for next line.
		require
			valid_indent: format.indent_depth > 0
		do
			format.exdent
		end

	need_dot
			-- Formatting needs dot.
		do
			format.set_dot_needed (True)
		ensure
			format.dot_needed
		end

	set_in_indexing_clause (b: BOOLEAN)
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

	execute
				-- Execute the flat or flat_short.
		local
			prev_class: CLASS_C
			prev_cluster: CONF_GROUP
		do
			if not rescued then
				prev_class := System.current_class
				prev_cluster := Inst_context.group
				execution_error := False
				class_name := current_class.name

				if is_short then
					client := system.any_class.compiled_class
				end

				create format_registration.make (current_class, client)

				if not order_same_as_text then
					format_registration.set_feature_clause_order (feature_clause_order)
				end

				format_registration.fill (current_class_only)
				System.set_current_class (current_class)

				if format_registration.target_ast /= Void then
					Inst_context.set_group (current_class.group)
						-- We initialize source class as current class
						-- when processing the header of a class.
					ast_output_strategy.set_current_class (current_class)
					ast_output_strategy.set_source_class (current_class)
					ast_output_strategy.format (format_registration.target_ast)
					Inst_context.set_group (Void)
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
			Inst_context.set_group (prev_cluster)
		rescue
			if Rescue_status.is_error_exception then
				rescued := True
				retry
			end
		end

feature -- Setting

	set_feature_comments (c: like feature_comments)
			-- Set feature_comment to `c'
		do
			feature_comments := c
		ensure
			feature_comments = c
		end

feature -- Update

	begin
			-- Save current format before a change.
			-- (To keep track of indent depth, separator etc.)
		local
			new_format: like format
		do
			new_format := format.twin
			format_stack.extend (new_format)
			format := new_format
		end

	commit
			-- Go back to previous format.
			--| Keep text modifications.
		do
			format_stack.remove
			format := format_stack.item
		end

feature -- Element change

	put_classi (c: CLASS_I)
			-- Append class name to `text_formatter'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.add_class (c)
		end

	put_origin_comment
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

	new_expression
			-- Prepare for a new expression.
		do
			format.set_dot_needed (False)
		end

feature -- Output

	register_invariants
			-- Register the invariants for target class.
		do
			create format_registration.make (current_class, client)
			format_registration.register_invariants
		end

	format_categories
			-- Format the categories for `current_class'.
		do
			format_registration.format_categories (Current)
		end

	format_invariants
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

	format_indexing_with_no_keyword (an_indexing_clause: INDEXING_CLAUSE_AS)
			-- Format `an_indexing_clause' without putting the `indexing' keyword
			-- nor doing any indentation.
		require
			an_indexing_clause_not_void: an_indexing_clause /= Void
		do
			ast_output_strategy.format_indexing_with_no_keyword (an_indexing_clause)
		end

	format_ast (ast: AST_EIFFEL)
			-- Call simple_for on `ast'.
		require
			ast_not_void: ast /= Void
		do
			ast_output_strategy.format (ast)
		end

	put_separator
			-- Append the current separator to `text_formatter'.
		local
			l_sep: STRING
		do
			l_sep := format.separator
			if l_sep /= Void and then l_sep /= ti_empty then
				if l_sep = ti_comma or else l_sep = ti_semi_colon or else l_sep = ti_dot then
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

	put_space
			-- Append space.
		do
			text_formatter.add_space
		end

	put_manifest_string (s: READABLE_STRING_GENERAL)
			-- Append `s' to `text_formatter'.
		require
			s_exists: s /= Void
		do
			if not tabs_emitted then
				emit_tabs
			end
			text_formatter.add_manifest_string (s)
		end

	put_breakable
			-- Put breakable point.
			--| Do nothing - convenience routine.
		do
		end

	put_quoted_string_item (s: STRING_32)
			-- Append `s' as string text to `text_formatter'. Emit tabs if needed.
		require
			s_not_void: s /= Void
		local
			new: STRING_32
		do
			new := eiffel_string_32 (s)
			new.precede ('"')
			new.extend ('"')
			put_string_item (new)
		end

	put_string_item (s: READABLE_STRING_GENERAL)
			-- Append `s' as string text to `text_formatter'. Emit tabs if needed.
			-- If `in_indexing_clause', we separate string.
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

	put_string_item_with_as (s: READABLE_STRING_GENERAL; a_as: STRING_AS)
			-- Append `s' as string text to `text_formatter'. Emit tabs if needed.
			-- If `in_indexing_clause', we separate string.
		require
			s_not_void: s /= Void
			a_as_not_void: a_as /= Void
		local
			l_context: ES_EIS_ENTRY_HELP_CONTEXT
			l_pos: INTEGER
		do
			if not tabs_emitted then
				emit_tabs
			end
			if in_indexing_clause then
				if attached last_eis_entry_and_source_as as l_tuple and then l_tuple.source = a_as then
					create l_context.make (l_tuple.entry, False)
					l_pos := s.substring_index ({ES_EIS_TOKENS}.value_assignment, 1)
					if l_pos > 0 then
						text_formatter.process_string_text (s.substring (1, l_pos), Void)
						text_formatter.process_string_text_with_pebble (s.substring (l_pos + 1, s.count - 1), create {EIS_LINK_STONE}.make (l_context))
						text_formatter.process_string_text ("%"", Void)
					else
						text_formatter.process_string_text_with_pebble (s, create {EIS_LINK_STONE}.make (l_context))
					end
				else
					text_formatter.add_indexing_string (s)
				end
			else
				text_formatter.add_manifest_string (s)
			end
		end

	put_new_line
			-- Put a new line, following `special_nl_symbol'.
		do
			text_formatter.add_new_line
			if special_nl_symbol /= Void then
				text_formatter.add (special_nl_symbol)
			end
			tabs_emitted := False
		end

	put_comments (comments: EIFFEL_COMMENTS)
			-- Put `comments' in `text_formatter'.
		require
			valid_comments: comments /= Void
		local
			txt: STRING_32
		do
			from
				comments.start
			until
				comments.after
			loop
				txt := comments.item.content_32
				if txt.is_empty or else txt.item (1) /= '|' then
					process_comment_text (ti_Dashdash, Void)
					put_comment_text (txt)
					put_new_line
				end
				comments.forth
			end
		end

	put_comment_text (c: READABLE_STRING_GENERAL)
			-- Separate `c'
			-- and append it to `text_formatter'.
			-- We do not use it if not necessary, as it slow.
		require
			c_not_void: c /= Void
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			if not c.is_empty then
				text_formatter.add_comment_text (c)
			end
		end

feature -- Text formatter decorator

	process_basic_text (text: READABLE_STRING_GENERAL)
			-- Process default basic text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_basic_text (text)
		end

	process_character_text (text: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_character_text (text)
		end

	process_generic_text (text: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_generic_text (text)
		end

	process_indexing_tag_text (text: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_indexing_tag_text (text)
		end

	process_local_text (text: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_local_text (text)
		end

	process_number_text (text: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_number_text (text)
		end

	process_quoted_text (text: READABLE_STRING_GENERAL)
			-- Process the quoted `text' within a comment.
		do
			if not tabs_emitted then
				emit_tabs
			end
			text_formatter.process_quoted_text (text)
		end

	process_assertion_tag_text (text: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_assertion_tag_text (text)
		end

	process_string_text (text, link: READABLE_STRING_GENERAL)
			-- Process string text `text'.
			-- possible `link', can be void.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_string_text (text, link)
		end

	process_reserved_word_text (text: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_reserved_word_text (text)
		end

	process_comment_text (text, url: READABLE_STRING_GENERAL)
			-- Process comment text.
			-- `url' is possible url, which can be void if none.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_comment_text (text, url)
		end

	process_difference_text_item (text: READABLE_STRING_GENERAL)
			-- Process difference text text.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_difference_text_item (text)
		end

	process_class_name_text (text: READABLE_STRING_GENERAL; a_class: CLASS_I; a_quote: BOOLEAN)
			-- Process class name of `a_class'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_class_name_text (text, a_class, a_quote)
		end

	process_cluster_name_text (text: READABLE_STRING_GENERAL; a_cluster: CONF_GROUP; a_quote: BOOLEAN)
			-- Process cluster name of `a_cluster'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_cluster_name_text (text, a_cluster, a_quote)
		end

	process_target_name_text (text: READABLE_STRING_GENERAL; a_target: CONF_TARGET)
			-- Process target name text `text'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_target_name_text (text, a_target)
		end

	process_feature_name_text (text: READABLE_STRING_GENERAL; a_class: CLASS_C)
			-- Process feature name text `text'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_feature_name_text (text, a_class)
		end

	process_feature_error (text: READABLE_STRING_GENERAL; a_feature: E_FEATURE; a_line: INTEGER)
			-- Process error feature text.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_feature_error (text, a_feature, a_line)
		end

	process_feature_text (text: READABLE_STRING_GENERAL; a_feature: E_FEATURE; a_quote: BOOLEAN)
			-- Process feature text `text'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_feature_text (text, a_feature, a_quote)
		end

	process_breakpoint_index (a_feature: E_FEATURE; a_index: INTEGER; a_cond: BOOLEAN)
			-- Process breakpoint index `a_index'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_breakpoint_index (a_feature, a_index, a_cond)
		end

	process_breakpoint (a_feature: E_FEATURE; a_index: INTEGER)
			-- Process breakpoint.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_breakpoint (a_feature, a_index)
		end

	process_padded
			-- Process padded item at start of non breakpoint line.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_padded
		end

	process_new_line
			-- Process new line.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_new_line
		end

	process_indentation (a_indent_depth: INTEGER)
			-- Process indentation `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_indentation (a_indent_depth)
		end

	process_after_class (a_class: CLASS_C)
			-- Process after class `a_class'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_after_class (a_class)
		end

	process_before_class (a_class: CLASS_C)
			-- Process before class `a_class'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_before_class (a_class)
		end

	process_filter_item (text: READABLE_STRING_GENERAL; is_before: BOOLEAN)
			-- Process filter text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_filter_item (text, is_before)
		end

	process_tooltip_item (a_tooltip: READABLE_STRING_GENERAL; is_before: BOOLEAN)
			-- Process tooltip text `t'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_tooltip_item (a_tooltip, is_before)
		end

	process_feature_dec_item (a_feature_name: READABLE_STRING_GENERAL; is_before: BOOLEAN)
			-- Process feature dec.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_feature_dec_item (a_feature_name, is_before)
		end

	process_symbol_text (text: READABLE_STRING_GENERAL)
			-- Process symbol text.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_symbol_text (text)
		end

	process_keyword_text (text: READABLE_STRING_GENERAL; a_feature: E_FEATURE)
			-- Process keyword text.
			-- `a_feature' is possible feature.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_keyword_text (text, a_feature)
		end

	process_operator_text (text: READABLE_STRING_GENERAL; a_feature: E_FEATURE)
			-- Process operator text.
			-- `a_feature' can be void.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_operator_text (text, a_feature)
		end

	process_address_text (a_address, a_name: READABLE_STRING_GENERAL; a_class: CLASS_C)
			-- Process address text.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_address_text (a_address, a_name, a_class)
		end

	process_error_text (text: READABLE_STRING_GENERAL; a_error: ERROR)
			-- Process error text.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_error_text (text, a_error)
		end

	process_cl_syntax (text: READABLE_STRING_GENERAL; a_syntax_message: ERROR; a_class: CLASS_C)
			-- Process class syntax text.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_cl_syntax (text, a_syntax_message, a_class)
		end

	process_column_text (a_column_number: INTEGER)
			-- Process `a_column_number'.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_column_text (a_column_number)
		end

	process_call_stack_item (level_number: INTEGER; display: BOOLEAN)
			-- Process the current callstack text.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_call_stack_item (level_number, display)
		end

	process_menu_text (text, link: READABLE_STRING_GENERAL)
			-- Process menu item. This is only useful for generation to
			-- formats that support hyperlinking.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_menu_text (text, link)
		end

	process_class_menu_text (text, link: READABLE_STRING_GENERAL)
			-- Process class menu item. This is only useful for generation to
			-- formats that support hyperlinking.
		do
			if not without_tabs and then not tabs_emitted then
				emit_tabs
			end
			without_tabs := False
			text_formatter.process_class_menu_text (text, link)
		end

feature {NONE} -- Implementation

	without_tabs : BOOLEAN
			-- Indent before next processing?

	ast_output_strategy: AST_DECORATED_OUTPUT_STRATEGY
			-- Visitor of AST_EIFFEL nodes

	text_formatter: TEXT_FORMATTER;
			-- Text formatter

	setup_output_strategy
			-- Setup attributes in `ast_output_strategy'.
		do
			ast_output_strategy.set_source_class (source_class)
			ast_output_strategy.set_current_class (current_class)
			ast_output_strategy.set_source_feature (source_feature)
			ast_output_strategy.set_current_feature (target_feature)
			ast_output_strategy.wipe_out_error
		end

	found_eis_entry (a_index: INDEX_AS; a_feature: detachable FEATURE_I): detachable TUPLE [entry: EIS_ENTRY; source: AST_EIFFEL]
			-- Found EIS entry and the source AS.
		require
			a_index_not_void: a_index /= Void
		local
			l_eis_extractor: ES_EIS_CLASS_EXTRACTOR
		do
			create l_eis_extractor.make_no_extract (current_class.original_class, True)
			if attached a_feature as l_f then
				Result := l_eis_extractor.source_ast_from_note_clause_ast (a_index, l_f.feature_name_id)
			else
				Result := l_eis_extractor.source_ast_from_note_clause_ast (a_index, 0)
			end
		end

	last_eis_entry_and_source_as: detachable TUPLE [entry: EIS_ENTRY; source: AST_EIFFEL];
			-- Last found EIS entry and the source AS.


note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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

end	 -- class TEXT_FORMATTER_DECORATOR
