note
	description	: "Manager for all output tools. Can be instanciated on the fly."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "$Author$"

class
	EB_GRAPHICAL_OUTPUT_MANAGER

inherit
	EB_OUTPUT_MANAGER
		redefine
			process_basic_text,
			process_quoted_text,
			process_comment_text,
			process_class_name_text,
			process_cluster_name_text,
			process_target_name_text,
			process_feature_name_text,
			process_feature_text,
			process_breakpoint_index,
			process_breakpoint,
			process_padded,
			process_new_line,
			process_indentation,
			process_after_class,
			process_before_class,
			process_filter_item,
			process_symbol_text,
			process_keyword_text,
			process_operator_text,
			process_address_text,
			process_error_text,
			process_cl_syntax,
			start_processing,
			end_processing,
			add,
			add_string,
			add_new_line,
			set_context_group,
			clear_general
		end

	EB_SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	OUTPUT_ROUTINES
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_TEXT_OUTPUT_FACTORY
		export
			{NONE} all
		end

feature -- Basic Operations / Generic purpose

	force_display
			-- Make the output tools visible (to ensure the user sees what we print).
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.force_display
				end
				managed_output_tools.forth
			end
		end

	scroll_to_end
			-- Make all output tools scroll to the bottom.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				managed_output_tools.item.scroll_to_end
				managed_output_tools.forth
			end
		end

	clear
			-- Clear the window.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				managed_output_tools.item.clear
				managed_output_tools.forth
			end
		end

	clear_general
			-- Clear the window.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.clear
				end
				managed_output_tools.forth
			end
		end

feature -- Basic Operations / Information message

	display_system_info
			-- Print information about the current project.
		local
			l_error: BOOLEAN
		do
			force_display
			clear_general
			start_processing (true)
			if Workbench.is_already_compiled then
				l_error := structured_system_info (Current)
			else
				add ("No compiled project")
				add_new_line
				l_error := structured_system_info (Current)
			end
			end_processing

			if l_error then
				clear_general
			end
		end

	display_application_status
			-- Display the status of the application, or "Not running" if
			-- the application is not running.
		local
			l_error: BOOLEAN
		do
				-- Build the text
			start_processing (true)
			if Debugger_manager.application_is_executing then
				Eb_debugger_manager.text_formatter_visitor.append_status (Debugger_manager.application_status, Current)
			else
				add ("System not launched")
				add_new_line
				l_error := structured_system_info (Current)
				if l_error then
					clear_general
					add ("System not launched")
					add_new_line
				end
			end
			end_processing
		end

feature -- Basic Operations / Compiler messages

	start_processing (append: BOOLEAN)
			-- Start processing.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				managed_output_tools.item.text_area.handle_before_processing (append)
				managed_output_tools.forth
			end
		end

	end_processing
			-- End processing.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				managed_output_tools.item.text_area.handle_after_processing
				managed_output_tools.forth
			end
		end

	trace (handler: ERROR_HANDLER)
			-- <Precursor>
		do
			--| See {ES_ERROR_DISPLAYER}
		end

	trace_warnings (handler: ERROR_HANDLER)
			-- <Precursor>
		do
			--| See {ES_ERROR_DISPLAYER}
		end

	trace_errors (handler: ERROR_HANDLER)
			-- <Precursor>
		do
			--| See {ES_ERROR_DISPLAYER}
		end

feature -- Element change

	extend (an_output_tool: ES_OUTPUT_TOOL_PANEL)
			-- Add this output tool to the list of managed output tools.
		do
			managed_output_tools.extend (an_output_tool)
		end

	prune (an_output_tool: ES_OUTPUT_TOOL_PANEL)
			-- Remove this output tool from the list of managed output tools.
		do
			managed_output_tools.start
			managed_output_tools.prune_all (an_output_tool)
		end

	set_context_group (a_group: like context_group)
			-- Set context_group with `a_group'.
		do
			Precursor {EB_OUTPUT_MANAGER}(a_group)
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.set_context_group (a_group)
				end
				managed_output_tools.forth
			end
		end

feature {NONE} -- Text formatter

	add (s: STRING_GENERAL)
			-- Add basic text.
		do
			process_basic_text (s)
		end

	add_string (s: STRING_GENERAL)
			-- Add string text.
		do
			process_string_text (s, Void)
		end

	add_new_line
			-- Add new line.
		do
			process_new_line
		end

	process_basic_text (text: STRING_GENERAL)
			-- Process default basic text `t'.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_basic_text (text)
				end
				managed_output_tools.forth
			end
		end

	process_quoted_text (text: STRING_GENERAL)
			-- Process the quoted `text' within a comment.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_quoted_text (text)
				end
				managed_output_tools.forth
			end
		end

	process_comment_text (text: STRING_GENERAL; url: STRING_GENERAL)
			-- Process comment text.
			-- `url' is possible url, which can be void if none.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_comment_text (text, url)
				end
				managed_output_tools.forth
			end
		end

	process_class_name_text (text: STRING_GENERAL; a_class: CLASS_I; a_quote: BOOLEAN)
			-- Process class name of `a_class'.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_class_name_text (text, a_class, a_quote)
				end
				managed_output_tools.forth
			end
		end

	process_cluster_name_text (text: STRING_GENERAL; a_cluster: CONF_GROUP; a_quote: BOOLEAN)
			-- Process cluster name of `a_cluster'.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_cluster_name_text (text, a_cluster, a_quote)
				end
				managed_output_tools.forth
			end
		end

	process_target_name_text (text: STRING_GENERAL; a_target: CONF_TARGET)
			-- Process target name text `text'.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_target_name_text (text, a_target)
				end
				managed_output_tools.forth
			end
		end

	process_feature_name_text (text: STRING_GENERAL; a_class: CLASS_C)
			-- Process feature name text `text'.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_feature_name_text (text, a_class)
				end
				managed_output_tools.forth
			end
		end

	process_feature_text (text: STRING_GENERAL; a_feature: E_FEATURE; a_quote: BOOLEAN)
			-- Process feature text `text'.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_feature_text (text, a_feature, a_quote)
				end
				managed_output_tools.forth
			end
		end

	process_breakpoint_index (a_feature: E_FEATURE; a_index: INTEGER; a_cond: BOOLEAN)
			-- Process breakpoint index `a_index'.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_breakpoint_index (a_feature, a_index, a_cond)
				end
				managed_output_tools.forth
			end
		end

	process_breakpoint (a_feature: E_FEATURE; a_index: INTEGER)
			-- Process breakpoint.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_breakpoint (a_feature, a_index)
				end
				managed_output_tools.forth
			end
		end

	process_padded
			-- Process padded item at start of non breakpoint line.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_padded
				end
				managed_output_tools.forth
			end
		end

	process_new_line
			-- Process new line.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_new_line
				end
				managed_output_tools.forth
			end
		end

	process_indentation (a_indent_depth: INTEGER)
			-- Process indentation `t'.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_indentation (a_indent_depth)
				end
				managed_output_tools.forth
			end
		end

	process_after_class (a_class: CLASS_C)
			-- Process after class `a_class'.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_after_class (a_class)
				end
				managed_output_tools.forth
			end
		end

	process_before_class (a_class: CLASS_C)
			-- Process before class `a_class'.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_before_class (a_class)
				end
				managed_output_tools.forth
			end
		end

	process_filter_item (text: STRING_GENERAL; is_before: BOOLEAN)
			-- Process filter text `t'.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_filter_item (text, is_before)
				end
				managed_output_tools.forth
			end
		end

	process_symbol_text (text: STRING_GENERAL)
			-- Process symbol text.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_symbol_text (text)
				end
				managed_output_tools.forth
			end
		end

	process_keyword_text (text: STRING_GENERAL; a_feature: E_FEATURE)
			-- Process keyword text.
			-- `a_feature' is possible feature.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_keyword_text (text, a_feature)
				end
				managed_output_tools.forth
			end
		end

	process_operator_text (text: STRING_GENERAL; a_feature: E_FEATURE)
			-- Process operator text.
			-- `a_feature' can be void.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_operator_text (text, a_feature)
				end
				managed_output_tools.forth
			end
		end

	process_address_text (a_address, a_name: STRING_GENERAL; a_class: CLASS_C)
			-- Process address text.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_address_text (a_address, a_name, a_class)
				end
				managed_output_tools.forth
			end
		end

	process_error_text (text: STRING_GENERAL; a_error: ERROR)
			-- Process error text.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_error_text (text, a_error)
				end
				managed_output_tools.forth
			end
		end

	process_cl_syntax (text: STRING_GENERAL; a_syntax_message: ERROR; a_class: CLASS_C)
			-- Process class syntax text.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					managed_output_tools.item.text_area.text_displayed.process_cl_syntax (text, a_syntax_message, a_class)
				end
				managed_output_tools.forth
			end
		end

feature {NONE} -- Implementation / Private attributes

	managed_output_tools: ARRAYED_LIST [ES_OUTPUT_TOOL_PANEL]
			-- Managed output tools
		note
			once_status: global
		once
			create Result.make (10)
		end

	general_output_tools: ARRAYED_LIST [ES_OUTPUT_TOOL_PANEL]
			-- General output tool
		do
			create Result.make (3)
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				if managed_output_tools.item.is_general then
					Result.extend (managed_output_tools.item)
				end
			end
		end

note
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

end -- class EB_OUTPUT_MANAGER
