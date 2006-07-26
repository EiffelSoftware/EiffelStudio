indexing
	description: "Expression generator for metrics"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_EXPRESSION_GENERATOR

inherit
	EB_SHARED_PREFERENCES

feature{NONE} -- Initialization

	make is
			-- Initialize.
		do
			create {LINKED_LIST [STRING_GENERAL]} text_list.make
			create {LINKED_LIST [EV_CHARACTER_FORMAT]} format_list.make
		ensure
			text_list_attached: text_list /= Void
			format_list_attached: format_list /= Void
		end

feature -- Access

	text_list: LIST [STRING_GENERAL]
			-- List of text

	format_list: LIST [EV_CHARACTER_FORMAT]
			-- Format list.
			-- Format are appliable in {EV_RICH_TEXT}.

	string_representation: STRING_GENERAL is
			-- String representation of current expression
		local
			l_text: STRING
			l_list: LIST [STRING_GENERAL]
		do
			create {STRING} Result.make (100)
			l_list := text_list
			from
				l_list.start
			until
				l_list.after
			loop
				Result.append (l_list.item.out)
				l_list.forth
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Basic operation

	generate_expression is
			-- Generate expression in `text_list' and `format_list'.
		deferred
		end

	load_expression (a_text: EV_RICH_TEXT) is
			-- Load `text_list' and `format_list' in `a_text'.
		local
			l_text_list: LIST [STRING_GENERAL]
			l_format_list: LIST [EV_CHARACTER_FORMAT]
			l_pos: INTEGER
			l_text: STRING_GENERAL
		do
			a_text.set_text ("")
			l_text_list := text_list
			l_format_list := format_list
			from
				l_text_list.start
				l_format_list.start
				l_pos := 1
			until
				l_text_list.after or l_format_list.after
			loop
				l_text := l_text_list.item
				if not l_text.is_empty then
					a_text.append_text (l_text)
					a_text.format_region (l_pos, l_pos + l_text.count, l_format_list.item)
				end
				l_pos := l_pos + l_text.count
				l_text_list.forth
				l_format_list.forth
			end
		end

	reset is
			-- Reset `text_list' and `format_list' for new expression generation.
		do
			text_list.wipe_out
			format_list.wipe_out
		ensure
			text_list_reset: text_list.is_empty
			format_list_reset: format_list.is_empty
		end

feature{NONE} -- Implemenation/Colors

	normal_color: EV_COLOR is
			-- Normal color
		do
			Result := preferences.editor_data.normal_text_color
		ensure
			result_attached: Result /= Void
		end

	string_color: EV_COLOR
			-- String color
		do
			Result := preferences.editor_data.string_text_color
		ensure
			result_attached: Result /= Void
		end

	group_color: EV_COLOR
			-- Group color
		do
			Result := preferences.editor_data.cluster_text_color
		ensure
			result_attached: Result /= Void
		end

	class_color: EV_COLOR
			-- Class color
		do
			Result := preferences.editor_data.class_text_color
		ensure
			result_attached: Result /= Void
		end

	feature_color: EV_COLOR
			-- Feature color
		do
			Result := preferences.editor_data.feature_text_color
		ensure
			result_attached: Result /= Void
		end

	keyword_color: EV_COLOR
			-- Keyword color
		do
			Result := preferences.editor_data.keyword_text_color
		ensure
			result_attached: Result /= Void
		end

	error_color: EV_COLOR
			-- Background color
		do
			Result := preferences.editor_data.error_text_color
		ensure
			result_attached: Result /= Void
		end

	background_color: EV_COLOR
			-- Background color
		do
			Result := (create {EV_STOCK_COLORS}).white
		ensure
			result_attached: Result /= Void
		end

	number_color: EV_COLOR
			-- Number color
		do
			Result := preferences.editor_data.number_text_color
		ensure
			result_attached: Result /= Void
		end

	operator_color: EV_COLOR
			-- operator color
		do
			Result := preferences.editor_data.operator_text_color
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation/Fonts

	normal_font: EV_FONT is
			-- Normal font
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	keyword_font: EV_FONT is
			-- Keyword font
		once
			create Result
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation/Formats

	normal_format: EV_CHARACTER_FORMAT is
			-- Normal format
		do
			create Result.make_with_font_and_color (normal_font, normal_color, background_color)
		ensure
			result_attached: Result /= Void
		end

	string_format: EV_CHARACTER_FORMAT is
			-- String format
		do
			create Result.make_with_font_and_color (normal_font, string_color, background_color)
		ensure
			result_attached: Result /= Void
		end

	keyword_format: EV_CHARACTER_FORMAT is
			-- Keyword format
		do
			create Result.make_with_font_and_color (keyword_font, keyword_color, background_color)
		ensure
			result_attached: Result /= Void
		end

	error_format: EV_CHARACTER_FORMAT is
			-- Error format
		do
			create Result.make_with_font_and_color (normal_font, error_color, background_color)
		ensure
			result_attached: Result /= Void
		end

	group_format: EV_CHARACTER_FORMAT is
			-- Group format
		do
			create Result.make_with_font_and_color (normal_font, group_color, background_color)
		ensure
			result_attached: Result /= Void
		end

	class_format: EV_CHARACTER_FORMAT is
			-- Class format
		do
			create Result.make_with_font_and_color (normal_font, class_color, background_color)
		ensure
			result_attached: Result /= Void
		end

	feature_format: EV_CHARACTER_FORMAT is
			-- Feature format
		do
			create Result.make_with_font_and_color (normal_font, feature_color, background_color)
		ensure
			result_attached: Result /= Void
		end

	operator_format: EV_CHARACTER_FORMAT is
			-- Operator format
		do
			create Result.make_with_font_and_color (normal_font, operator_color, background_color)
		ensure
			result_attached: Result /= Void
		end

	number_format: EV_CHARACTER_FORMAT is
			-- Number format
		do
			create Result.make_with_font_and_color (normal_font, number_color, background_color)
		ensure
			result_attached: Result /= Void
		end

invariant
	text_list_attached: text_list /= Void
	format_list_attached: format_list /= Void

indexing
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

end
