note
	description: "[
		An output window wrapping multiple output windows ({OUTPUT_WINDOW}).
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_MULTI_OUTPUT_WINDOW

inherit
	OUTPUT_WINDOW
		redefine
			start_processing,
			end_processing,
--			process_basic_text,
--			process_character_text,
--			process_generic_text,
--			process_indexing_tag_text,
--			process_local_text,
--			process_number_text,
--			process_quoted_text,
--			process_assertion_tag_text,
--			process_string_text,
--			process_reserved_word_text,
--			process_comment_text,
--			process_difference_text_item,
--			process_class_name_text,
--			process_cluster_name_text,
--			process_target_name_text,
--			process_feature_name_text,
--			process_feature_error,
--			process_feature_text,
--			process_breakpoint_index,
--			process_breakpoint,
--			process_padded,
--			process_new_line,
--			process_indentation,
--			process_after_class,
--			process_before_class,
--			process_filter_item,
--			process_tooltip_item,
--			process_feature_dec_item,
--			process_symbol_text,
--			process_keyword_text,
--			process_operator_text,
--			process_address_text,
--			process_error_text,
--			process_cl_syntax,
--			process_column_text,
--			process_call_stack_item ,
--			process_menu_text,
--			process_class_menu_text,
--			add_char,
--			add_new_line,
			add_string--,
--			add_local,
--			add_int,
--			add_group,
--			add_before_class,
--			add_end_class,
--			add_classi,
--			add_class,
--			add_error,
--			add_feature,
--			add_breakpoint_index,
--			add_feature_name,
--			add_sectioned_feature_name,
--			add_quoted_text,
--			add_comment,
--			add_address,
--			add_indent,
--			add_indents,
--			add_class_syntax ,
--			add_column_number,
--			add_feature_error,
--			set_context_group,
--			display,
--			clear_window
		end

--	EB_SHARED_WINDOW_MANAGER
--		export
--			{NONE} all
--		end

create
	make

feature {NONE} -- Initialization

	make
		do
			create managed_windows.make (1)
			create new_managed_windows.make (1)
		end

feature {NONE} -- Access

	managed_windows: !ARRAYED_SET [OUTPUT_WINDOW]
			-- Current set of managed output windows.

	new_managed_windows: !ARRAYED_SET [OUTPUT_WINDOW]
			-- New set of managed output windows.
			--|Note: When `start_processing' moves the managed windows from `new_managed_windows' to the
			--|     active and usable `managed_windows'.

feature {OUTPUT_I} -- Status report

	has_window (a_window: !OUTPUT_WINDOW): BOOLEAN
			-- Determines if an output window is part of Current.
			--
			-- `a_window':
			-- `Result': True if the window is part of Current; False otherwise.
		do
			Result := managed_windows.has (a_window) or else new_managed_windows.has (a_window)
		ensure
			managed_windows_has_a_window: Result implies (
				managed_windows.has (a_window) or new_managed_windows.has (a_window))
		end

feature {OUTPUT_I} -- Extension

	extend (a_output: !OUTPUT_WINDOW)
			-- Extend the managed set of windows with a new output window.
			--
			-- `a_window':
		require

		do
			new_managed_windows.extend (a_output)
		end

feature {OUTPUT_I} -- Removal



--feature -- Element change

--	set_context_group (a_group: like context_group)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_formatter: TEXT_FORMATTER
--		do
--			Precursor (a_group)
--			l_windows := managed_windows
--			if not l_windows.is_empty then
--				from l_windows.start until l_windows.after loop
--					l_formatter := l_windows.item
--					if l_formatter /= Void then
--						l_formatter.set_context_group (a_group)
--					end
--					l_windows.forth
--				end
--			end
--		end

--feature -- Output

--	display
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: OUTPUT_WINDOW
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.display
--				end
--				l_windows.forth
--			end
--		end

--	clear_window
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: OUTPUT_WINDOW
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.clear_window
--				end
--				l_windows.forth
--			end
--		end

	put_new_line
			-- <Precursor>
		local
--			l_windows: like managed_windows
--			l_window: OUTPUT_WINDOW
		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.put_new_line
--				end
--				l_windows.forth
--			end
		end

	put_string (a_text: STRING_GENERAL)
			-- <Precursor>
		local
--			l_windows: like managed_windows
--			l_window: OUTPUT_WINDOW
		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.put_string (a_text)
--				end
--				l_windows.forth
--			end
		end

feature -- Basic operation

	start_processing (a_append: BOOLEAN)
			-- <Precursor>
		local
			l_window: TEXT_FORMATTER
			l_windows: like managed_windows
			l_new_windows: like new_managed_windows
		do
			l_windows := managed_windows

				-- A new process is starting to add the new output windows to the active list.
			l_new_windows := new_managed_windows
			if not l_new_windows.is_empty then
				from l_new_windows.start until l_new_windows.after loop
					l_windows.extend (l_new_windows.item)
					l_new_windows.forth
				end
			end

			from l_windows.start until l_windows.after loop
				l_window := l_windows.item
				if l_window /= Void then
					l_window.start_processing (a_append)
				end
				l_windows.forth
			end
		end

	end_processing
			-- <Precursor>
		local
			l_windows: like managed_windows
			l_window: TEXT_FORMATTER
		do
			l_windows := managed_windows
			from l_windows.start until l_windows.after loop
				l_window := l_windows.item
				if l_window /= Void then
					l_window.end_processing
				end
				l_windows.forth
			end
		end

--feature -- Process

--	process_basic_text (a_text: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.process_basic_text (a_text)
--				end
--				l_windows.forth
--			end
--		end

--	process_character_text (text: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_generic_text (text: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_indexing_tag_text (text: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_local_text (text: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_number_text (text: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_quoted_text (text: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_assertion_tag_text (text: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_string_text (text: STRING_GENERAL; link: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_reserved_word_text (text: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_comment_text (text: STRING_GENERAL; url: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_difference_text_item (text: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_class_name_text (text: STRING_GENERAL; a_class: CLASS_I; a_quote: BOOLEAN)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_cluster_name_text (text: STRING_GENERAL; a_cluster: CONF_GROUP; a_quote: BOOLEAN)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_target_name_text (text: STRING_GENERAL; a_target: CONF_TARGET)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_feature_name_text (text: STRING_GENERAL; a_class: CLASS_C)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_feature_error (text: STRING_GENERAL; a_feature: E_FEATURE; a_line: INTEGER)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_feature_text (text: STRING_GENERAL; a_feature: E_FEATURE; a_quote: BOOLEAN)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_breakpoint_index (a_feature: E_FEATURE; a_index: INTEGER; a_cond: BOOLEAN)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_breakpoint (a_feature: E_FEATURE; a_index: INTEGER)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_padded
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_new_line
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_indentation (a_indent_depth: INTEGER)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_after_class (a_class: CLASS_C)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_before_class (a_class: CLASS_C)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_filter_item (text: STRING_GENERAL; is_before: BOOLEAN)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_tooltip_item (a_tooltip: STRING_GENERAL; is_before: BOOLEAN)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_feature_dec_item (a_feature_name: STRING_GENERAL; is_before: BOOLEAN)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_symbol_text (text: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_keyword_text (text: STRING_GENERAL; a_feature: E_FEATURE)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_operator_text (text: STRING_GENERAL; a_feature: E_FEATURE)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_address_text (a_address, a_name: STRING_GENERAL; a_class: CLASS_C)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_error_text (text: STRING_GENERAL; a_error: ERROR)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_cl_syntax (text: STRING_GENERAL; a_syntax_message: ERROR; a_class: CLASS_C)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_column_text (a_column_number: INTEGER)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_call_stack_item (level_number: INTEGER; a_display: BOOLEAN)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_menu_text (text, link: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	process_class_menu_text (text, link: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--feature -- Text operator

--	add_char (c: CHARACTER_32)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_new_line
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

	add_string (s: STRING_GENERAL)
			-- <Precursor>
		local
			l_windows: like managed_windows
			l_window: TEXT_FORMATTER
		do
			l_windows := managed_windows
			from l_windows.start until l_windows.after loop
				l_window := l_windows.item
				if l_window /= Void then
					l_window.add_string (s)
				end
				l_windows.forth
			end
		end

--	add_local (s: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_int (i: INTEGER)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_group (e_cluster: CONF_GROUP; str: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_before_class (e_class: CLASS_C)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_end_class (e_class: CLASS_C)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_classi (class_i: CLASS_I; str: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_class (class_i: CLASS_I)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_error (error: ERROR; str: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_feature (feat: E_FEATURE; str: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_breakpoint_index (feat: E_FEATURE; indx: INTEGER; has_cond: BOOLEAN)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_feature_name (f_name: STRING_GENERAL; e_class: CLASS_C)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_sectioned_feature_name (e_feature: E_FEATURE)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_quoted_text (s: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_comment (s: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_address (address: STRING_GENERAL; a_name: STRING_GENERAL; e_class: CLASS_C)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_indent
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_indents (nr: INTEGER)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_class_syntax (syn: ERROR; e_class: CLASS_C; str: STRING_GENERAL)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_column_number (column_num: INTEGER)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

--	add_feature_error (feat: E_FEATURE; str: STRING_GENERAL; a_line: INTEGER)
--			-- <Precursor>
--		local
--			l_windows: like managed_windows
--			l_window: TEXT_FORMATTER
--		do
--			l_windows := managed_windows
--			from l_windows.start until l_windows.after loop
--				l_window := l_windows.item
--				if l_window /= Void then
--					l_window.start_processing (a_append)
--				end
--				l_windows.forth
--			end
--		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end
