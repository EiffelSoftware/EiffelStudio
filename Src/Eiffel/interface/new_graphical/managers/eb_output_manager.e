note
	description	: "Manager for output and error messages"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

deferred class
	EB_OUTPUT_MANAGER

inherit
	ERROR_DISPLAYER

	TEXT_FORMATTER

feature -- Basic Operations / Generic purpose

	clear
			-- Clear the window.
		deferred
		end

	clear_general
			-- Clear the general window.
		do
			clear
		end

	scroll_to_end
			-- Scroll to end of text.
		deferred
		end

feature {NONE} -- Text formatter

	process_basic_text (text: STRING_GENERAL)
			-- Process default basic text `t'.
		do
		end

	process_quoted_text (text: STRING_GENERAL)
			-- Process the quoted `text' within a comment.
		do
		end

	process_comment_text (text: STRING_GENERAL; url: STRING_GENERAL)
			-- Process comment text.
			-- `url' is possible url, which can be void if none.
		do
		end

	process_class_name_text (text: STRING_GENERAL; a_class: CLASS_I; a_quote: BOOLEAN)
			-- Process class name of `a_class'.
		do
		end

	process_cluster_name_text (text: STRING_GENERAL; a_cluster: CONF_GROUP; a_quote: BOOLEAN)
			-- Process cluster name of `a_cluster'.
		do
		end

	process_target_name_text (text: STRING_GENERAL; a_target: CONF_TARGET)
			-- Process target name text `text'.
		do
		end

	process_feature_name_text (text: STRING_GENERAL; a_class: CLASS_C)
			-- Process feature name text `text'.
		do
		end

	process_feature_text (text: STRING_GENERAL; a_feature: E_FEATURE; a_quote: BOOLEAN)
			-- Process feature text `text'.
		do
		end

	process_breakpoint_index (a_feature: E_FEATURE; a_index: INTEGER; a_cond: BOOLEAN)
			-- Process breakpoint index `a_index'.
		do
		end

	process_breakpoint (a_feature: E_FEATURE; a_index: INTEGER)
			-- Process breakpoint.
		do
		end

	process_padded
			-- Process padded item at start of non breakpoint line.
		do
		end

	process_new_line
			-- Process new line.
		do
		end

	process_indentation (a_indent_depth: INTEGER)
			-- Process indentation `t'.
		do
		end

	process_after_class (a_class: CLASS_C)
			-- Process after class `a_class'.
		do
		end

	process_before_class (a_class: CLASS_C)
			-- Process before class `a_class'.
		do
		end

	process_filter_item (text: STRING_GENERAL; is_before: BOOLEAN)
			-- Process filter text `t'.
		do
		end

	process_symbol_text (text: STRING_GENERAL)
			-- Process symbol text.
		do
		end

	process_keyword_text (text: STRING_GENERAL; a_feature: E_FEATURE)
			-- Process keyword text.
			-- `a_feature' is possible feature.
		do
		end

	process_operator_text (text: STRING_GENERAL; a_feature: E_FEATURE)
			-- Process operator text.
			-- `a_feature' can be void.
		do
		end

	process_address_text (a_address, a_name: STRING_GENERAL; a_class: CLASS_C)
			-- Process address text.
		do
		end

	process_error_text (text: STRING_GENERAL; a_error: ERROR)
			-- Process error text.
		do
		end

	process_cl_syntax (text: STRING_GENERAL; a_syntax_message: ERROR; a_class: CLASS_C)
			-- Process class syntax text.
		do
		end

feature -- Basic Operations / Information message

	display_system_info
			-- Print information about the current project.
		deferred
		end

	display_application_status
			-- Display the application status.
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class EB_OUTPUT_MANAGER
