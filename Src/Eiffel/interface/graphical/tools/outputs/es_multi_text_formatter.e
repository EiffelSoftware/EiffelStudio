note
	description: "[
		An output window wrapping multiple output windows ({OUTPUT_WINDOW}).
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_MULTI_TEXT_FORMATTER

inherit
	TEXT_FORMATTER
		redefine
			start_processing,
			end_processing,
			process_basic_text,
			process_character_text,
			process_generic_text,
			process_indexing_tag_text,
			process_local_text,
			process_number_text,
			process_quoted_text,
			process_assertion_tag_text,
			process_string_text,
			process_reserved_word_text,
			process_comment_text,
			process_difference_text_item,
			process_class_name_text,
			process_cluster_name_text,
			process_target_name_text,
			process_feature_name_text,
			process_feature_error,
			process_feature_text,
			process_breakpoint_index,
			process_breakpoint,
			process_padded,
			process_new_line,
			process_indentation,
			process_after_class,
			process_before_class,
			process_filter_item,
			process_tooltip_item,
			process_feature_dec_item,
			process_symbol_text,
			process_keyword_text,
			process_operator_text,
			process_address_text,
			process_error_text,
			process_cl_syntax,
			process_column_text,
			process_call_stack_item ,
			process_menu_text,
			process_class_menu_text,
			set_context_group
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			create managed_formatters.make (1)
			create new_managed_formatters.make (1)

				-- Ensure the notifier is part of the managed formatters
			create notifier.make
			managed_formatters.extend (notifier)
		end

feature -- Access

	notifier: ES_NOTIFIER_FORMATTER
			-- Notifier formatter used to notifier clients of text changes.

feature {NONE} -- Access

	managed_formatters: ARRAYED_SET [TEXT_FORMATTER]
			-- Current set of managed output windows.

	new_managed_formatters: ARRAYED_SET [TEXT_FORMATTER]
			-- New set of managed output windows.
			--|Note: When `start_processing' moves the managed windows from `new_managed_formatters' to the
			--|     active and usable `managed_formatters'.

feature {NONE} -- Meansurement

	new_line_count: NATURAL_8
			-- Number of cached new lines awaiting output.

feature -- Status report

	has_formatter (a_formatter: TEXT_FORMATTER): BOOLEAN
			-- Determines if a text formatter is managed by Current.
			--
			-- `a_formatter': A text formatter to check.
			-- `Result': True if the formatter is part of Current; False otherwise.
		require
			a_formatter_attached: a_formatter /= Void
			not_a_formatter_is_current: a_formatter /= Current
		do
			Result := managed_formatters.has (a_formatter) or else new_managed_formatters.has (a_formatter)
		ensure
			managed_formatters_has_a_formatter: Result implies (
				managed_formatters.has (a_formatter) or new_managed_formatters.has (a_formatter))
		end

feature {OUTPUT_I} -- Extension

	extend (a_formatter: TEXT_FORMATTER)
			-- Extend the managed set of formatters with an existing formatter.
			--
			-- `a_formatter': The text formatter to add.
		require
			a_formatter_attached: a_formatter /= Void
			not_a_formatter_is_current: a_formatter /= Current
			not_has_formatter_a_formatter: not has_formatter (a_formatter)
		do
			new_managed_formatters.extend (a_formatter)
		ensure
			has_formatter_a_formatter: has_formatter (a_formatter)
		end

feature {OUTPUT_I} -- Removal

	prune (a_formatter: TEXT_FORMATTER)
			-- Removed an managed formatter from a list of managed formatters.
			--
			-- `a_formatter': The text formatter to remove.
		require
			a_formatter_attached: a_formatter /= Void
			not_a_formatter_is_current: a_formatter /= Current
			has_formatter_a_formatter: has_formatter (a_formatter)
		do
			new_managed_formatters.prune (a_formatter)
			managed_formatters.prune (a_formatter)
		ensure
			not_has_formatter_a_formatter: not has_formatter (a_formatter)
		end

feature -- Element change

	set_context_group (a_group: like context_group)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			Precursor (a_group)
			l_formatters := managed_formatters
			if not l_formatters.is_empty then
				from l_formatters.start until l_formatters.after loop
					if attached l_formatters.item as l_formatter then
						l_formatter.set_context_group (a_group)
					end
					l_formatters.forth
				end
			end
		end

feature -- Basic operations

	reset
			-- Resets any cached data.
		do
			new_line_count := 0
		ensure
			new_line_count_reset: new_line_count = 0
		end

	start_processing (a_append: BOOLEAN)
			 -- <Precursor>
		local
			l_formatters: like managed_formatters
			l_new_windows: like new_managed_formatters
		do
			if not a_append then
					-- Reset new line cache count
				new_line_count := 0
			end

			l_formatters := managed_formatters

				 -- A new process is starting to add the new output windows to the active list.
			l_new_windows := new_managed_formatters
			if not l_new_windows.is_empty then
				from l_new_windows.start until l_new_windows.after loop
					l_formatters.extend (l_new_windows.item)
					l_new_windows.forth
				end
			end

			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.start_processing (a_append)
				end
				l_formatters.forth
			end
		end

	end_processing
			 -- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.end_processing
				end
				l_formatters.forth
			end
		end

feature -- Process

	process_basic_text (a_text: STRING_GENERAL)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_basic_text (a_text)
				end
				l_formatters.forth
			end
		end

	process_character_text (a_text: STRING_GENERAL)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_character_text (a_text)
				end
				l_formatters.forth
			end
		end

	process_generic_text (a_text: STRING_GENERAL)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_generic_text (a_text)
				end
				l_formatters.forth
			end
		end

	process_indexing_tag_text (a_text: STRING_GENERAL)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_indexing_tag_text (a_text)
				end
				l_formatters.forth
			end
		end

	process_local_text (a_text: STRING_GENERAL)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_local_text (a_text)
				end
				l_formatters.forth
			end
		end

	process_number_text (a_text: STRING_GENERAL)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_number_text (a_text)
				end
				l_formatters.forth
			end
		end

	process_quoted_text (a_text: STRING_GENERAL)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_quoted_text (a_text)
				end
				l_formatters.forth
			end
		end

	process_assertion_tag_text (a_text: STRING_GENERAL)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_assertion_tag_text (a_text)
				end
				l_formatters.forth
			end
		end

	process_string_text (a_text: STRING_GENERAL; a_link: STRING_GENERAL)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_string_text (a_text, a_link)
				end
				l_formatters.forth
			end
		end

	process_reserved_word_text (a_text: STRING_GENERAL)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_reserved_word_text (a_text)
				end
				l_formatters.forth
			end
		end

	process_comment_text (a_text: STRING_GENERAL; a_url: STRING_GENERAL)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_comment_text (a_text, a_url)
				end
				l_formatters.forth
			end
		end

	process_difference_text_item (a_text: STRING_GENERAL)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_difference_text_item (a_text)
				end
				l_formatters.forth
			end
		end

	process_class_name_text (a_text: STRING_GENERAL; a_class: CLASS_I; a_quote: BOOLEAN)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_class_name_text (a_text, a_class, a_quote)
				end
				l_formatters.forth
			end
		end

	process_cluster_name_text (a_text: STRING_GENERAL; a_cluster: CONF_GROUP; a_quote: BOOLEAN)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_cluster_name_text (a_text, a_cluster, a_quote)
				end
				l_formatters.forth
			end
		end

	process_target_name_text (a_text: STRING_GENERAL; a_target: CONF_TARGET)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_target_name_text (a_text, a_target)
				end
				l_formatters.forth
			end
		end

	process_feature_name_text (a_text: STRING_GENERAL; a_class: CLASS_C)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_feature_name_text (a_text, a_class)
				end
				l_formatters.forth
			end
		end

	process_feature_error (a_text: STRING_GENERAL; a_feature: E_FEATURE; a_line: INTEGER)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_feature_error (a_text, a_feature, a_line)
				end
				l_formatters.forth
			end
		end

	process_feature_text (a_text: STRING_GENERAL; a_feature: E_FEATURE; a_quote: BOOLEAN)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_feature_text (a_text, a_feature, a_quote)
				end
				l_formatters.forth
			end
		end

	process_breakpoint (a_feature: E_FEATURE; a_index: INTEGER)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_breakpoint (a_feature, a_index)
				end
				l_formatters.forth
			end
		end

	process_breakpoint_index (a_feature: E_FEATURE; a_index: INTEGER; a_cond: BOOLEAN)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_breakpoint_index (a_feature, a_index, a_cond)
				end
				l_formatters.forth
			end
		end

	process_padded
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_padded
				end
				l_formatters.forth
			end
		end

	process_new_line
			-- <Precursor>
		local
			l_count: like new_line_count
		do
			l_count := new_line_count
			if l_count < {NATURAL_8}.max_value then
				new_line_count := new_line_count + 1
			end
		end

	process_indentation (a_indent_depth: INTEGER)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_indentation (a_indent_depth)
				end
				l_formatters.forth
			end
		end

	process_after_class (a_class: CLASS_C)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_after_class (a_class)
				end
				l_formatters.forth
			end
		end

	process_before_class (a_class: CLASS_C)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_before_class (a_class)
				end
				l_formatters.forth
			end
		end

	process_filter_item (a_text: STRING_GENERAL; a_is_before: BOOLEAN)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_filter_item (a_text, a_is_before)
				end
				l_formatters.forth
			end
		end

	process_tooltip_item (a_tooltip: STRING_GENERAL; a_is_before: BOOLEAN)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_tooltip_item (a_tooltip, a_is_before)
				end
				l_formatters.forth
			end
		end

	process_feature_dec_item (a_feature_name: STRING_GENERAL; a_is_before: BOOLEAN)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_feature_dec_item (a_feature_name, a_is_before)
				end
				l_formatters.forth
			end
		end

	process_symbol_text (a_text: STRING_GENERAL)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_symbol_text (a_text)
				end
				l_formatters.forth
			end
		end

	process_keyword_text (a_text: STRING_GENERAL; a_feature: E_FEATURE)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_keyword_text (a_text, a_feature)
				end
				l_formatters.forth
			end
		end

	process_operator_text (a_text: STRING_GENERAL; a_feature: E_FEATURE)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_operator_text (a_text, a_feature)
				end
				l_formatters.forth
			end
		end

	process_address_text (a_address, a_name: STRING_GENERAL; a_class: CLASS_C)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_address_text (a_address, a_name, a_class)
				end
				l_formatters.forth
			end
		end

	process_error_text (a_text: STRING_GENERAL; a_error: ERROR)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_error_text (a_text, a_error)
				end
				l_formatters.forth
			end
		end

	process_cl_syntax (a_text: STRING_GENERAL; a_syntax_message: ERROR; a_class: CLASS_C)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_cl_syntax (a_text, a_syntax_message, a_class)
				end
				l_formatters.forth
			end
		end

	process_column_text (a_column_number: INTEGER)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_column_text (a_column_number)
				end
				l_formatters.forth
			end
		end

	process_call_stack_item (a_level_number: INTEGER; a_display: BOOLEAN)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_call_stack_item (a_level_number, a_display)
				end
				l_formatters.forth
			end
		end

	process_menu_text (a_text, a_link: STRING_GENERAL)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_menu_text (a_text, a_link)
				end
				l_formatters.forth
			end
		end

	process_class_menu_text (a_text, a_link: STRING_GENERAL)
			-- <Precursor>
		local
			l_formatters: like managed_formatters
		do
			process_new_lines_cache
			l_formatters := managed_formatters
			from l_formatters.start until l_formatters.after loop
				if attached l_formatters.item as l_formatter then
					l_formatter.process_class_menu_text (a_text, a_link)
				end
				l_formatters.forth
			end
		end

feature {NONE} -- Basic operations

	process_new_lines_cache
			-- Processes any number of cached new line characters, cached to prevent unnecessary output of new lines.
		local
			l_formatters: ARRAYED_LIST [TEXT_FORMATTER]
			i, l_new_lines: like new_line_count
		do
			l_new_lines := new_line_count
			if l_new_lines > 0 then
				l_formatters := managed_formatters

					-- Navigate backwards, not forwards! This is to ensure the notifier formatter
					-- ({ES_NOTIFIER_FORMATTER} used to notify clients about changes to the output) is
					-- called after the output has been processes.
				check
					not_l_formatter_is_empty: not l_formatters.is_empty
					l_formatters_first_is_notifier: l_formatters.first = notifier
				end
				from l_formatters.finish until l_formatters.before loop
					if attached l_formatters.item as l_formatter then
						from i := 1 until i > l_new_lines loop
							l_formatter.process_new_line
							i := i + 1
						end
					end
					l_formatters.back
				end
				new_line_count := 0
			end
		ensure
			new_line_count_reset: new_line_count = 0
		end

invariant
	managed_formatters_attached: attached managed_formatters
	new_managed_formatters_attached: attached new_managed_formatters
	notifier_attached: attached notifier
	managed_formatters_has_notifier: managed_formatters.has (notifier)

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
