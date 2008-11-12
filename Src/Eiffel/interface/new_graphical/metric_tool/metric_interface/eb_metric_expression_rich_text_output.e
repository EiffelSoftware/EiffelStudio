indexing
	description: "Object that represents a generated metric expression in rich text format"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_EXPRESSION_RICH_TEXT_OUTPUT

inherit
	EB_METRIC_EXPRESSION_OUTPUT

	EB_METRIC_SHARED

	EB_SHARED_PREFERENCES

	SHARED_TEXT_ITEMS

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize.
		do
			create {LINKED_LIST [STRING_GENERAL]} text_list.make
			create {LINKED_LIST [EV_CHARACTER_FORMAT]} format_list.make
			regenerate_formats
		end

feature -- Access

	string_representation: STRING_GENERAL is
			-- String representation of generated output
		local
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
		end

feature -- Operations

	load_expression (a_text: EV_RICH_TEXT) is
			-- Load `text_list' and `format_list' in `a_text'.
		local
			l_text_list: like text_list
			l_format_list: like format_list
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
				a_text.append_text (l_text)
				a_text.format_region (l_pos, l_pos + l_text.count, l_format_list.item)
				l_pos := l_pos + l_text.count
				l_text_list.forth
				l_format_list.forth
			end
		end

feature -- Result operations

	wipe_out is
			-- Wipe out all generated output.
		do
			text_list.wipe_out
			format_list.wipe_out
		ensure then
			text_list_reset: text_list.is_empty
			format_list_reset: format_list.is_empty
		end

feature{EB_METRIC_EXPRESSION_GENERATOR}

	prepare_output is
			-- Prepare output.
		do
		end

feature -- Metric element output

	put_metric_name (a_metric_name: STRING) is
			-- Display metric name of `a_metric_name'.
		do
			if metric_manager.is_metric_calculatable (a_metric_name) then
				safe_put (a_metric_name.as_string_32, metric_name_format)
			else
				if a_metric_name.is_empty then
					safe_put (metric_names.te_no_metric.as_string_32, err_metric_name_format)
				else
					safe_put (a_metric_name.as_string_32, err_metric_name_format)
				end

			end
		end

	put_criterion_name (a_criterion: EB_METRIC_CRITERION) is
			-- Display name of `a_criterion'.
		do
			if a_criterion.is_name_valid then
				if a_criterion.is_and_criterion or a_criterion.is_or_criterion then
					safe_put (a_criterion.name, keyword_format)
				else
					safe_put (a_criterion.name, normal_format)
				end
			else
				if a_criterion.name.is_empty then
					safe_put (metric_names.te_no_metric, error_format)
				else
					safe_put (a_criterion.name, error_format)
				end
			end
		end

	put_string (a_string: STRING_GENERAL) is
			-- Display `a_string'.
		local
			l_str: STRING_32
		do
			l_str := ti_double_quote.as_string_32
			l_str.append (a_string.as_string_32)
			l_str.append (ti_double_quote.as_string_32)
			safe_put (l_str, string_format)
		end

	put_operator (a_operator: STRING_GENERAL) is
			-- Display `a_operator', such as "+", "-".
		do
			safe_put (a_operator, operator_format)
		end

	put_double (a_double: DOUBLE) is
			-- Display `a_double'.
		do
			safe_put (a_double.out.as_string_32, number_format)
		end

	put_integer (a_integer: INTEGER) is
			-- Display `a_integer'.
		do
			safe_put (a_integer.out.as_string_32, number_format)
		end

	put_keyword (a_keyword: STRING_GENERAL) is
			-- Display `a_keyword'.
		do
			safe_put (a_keyword, keyword_format)
		end

	put_error (a_error_msg: STRING_GENERAL) is
			-- Display error message `a_error_msg'.
		do
			safe_put (a_error_msg, error_format)
		end

	put_normal_text (a_text: STRING_GENERAL) is
			-- Display normal text `a_text'.
		do
			safe_put (a_text, normal_format)
		end

	put_domain_item (a_domain_item: EB_METRIC_DOMAIN_ITEM; a_format: EV_CHARACTER_FORMAT) is
			-- Display `a_domain_item' in `a_format' f `a_domain_item' is valid,
			-- otherwise display `a_domain_item' in `error_format'.
		require
			a_domain_item_attached: a_domain_item /= Void
		do
			if a_domain_item.is_valid then
				safe_put (a_domain_item.string_representation, a_format)
			else
				safe_put (a_domain_item.string_representation, error_format)
			end
		end

	put_target_domain_item (a_target_item: EB_METRIC_TARGET_DOMAIN_ITEM) is
			-- Display `a_target_item'.
		do
			put_domain_item (a_target_item, target_format)
		end

	put_group_domain_item (a_group_item: EB_METRIC_GROUP_DOMAIN_ITEM) is
			-- Display `a_group_item'.
		do
			put_domain_item (a_group_item, group_format)
		end

	put_folder_domain_item (a_folder_item: EB_METRIC_FOLDER_DOMAIN_ITEM) is
			-- Display `a_folder_item'.
		do
			put_domain_item (a_folder_item, folder_format)
		end

	put_class_domain_item (a_class_item: EB_METRIC_CLASS_DOMAIN_ITEM) is
			-- Display `a_class_item'.
		do
			put_domain_item (a_class_item, class_format)
		end

	put_feature_domain_item (a_feature_item: EB_METRIC_FEATURE_DOMAIN_ITEM) is
			-- Display `a_feature_item'.
		do
			if a_feature_item.is_valid then
				safe_put (ti_l_curly.as_string_32, operator_format)
				put_class_domain_item (a_feature_item.associated_class_domain_item)
				safe_put (ti_r_curly.as_string_32, operator_format)
				safe_put (ti_dot, operator_format)
				safe_put (a_feature_item.ql_feature.name, feature_format)
			else
				safe_put (a_feature_item.string_representation, error_format)
			end
		end

	put_delayed_domain_item (a_delayed_item: EB_METRIC_DELAYED_DOMAIN_ITEM) is
			-- Display `a_delayed_item'.
		do
			put_domain_item (a_delayed_item, delayed_format)
		end

	put_modifier (a_modifier: STRING_GENERAL) is
			-- Display modifier `a_modifier'.
		do
			safe_put (a_modifier, modifier_format)
		end

	put_warning (a_warning_msg: STRING_GENERAL) is
			-- Display warning message `a_warning_msg'.
		do
			safe_put (a_warning_msg, warning_format)
		end

feature{NONE} -- Implementation

	safe_put (a_text: STRING_GENERAL; a_format: EV_CHARACTER_FORMAT) is
			-- Put `a_text' whose format is `a_format' into `text_list' and `format_list'
			-- only if `a_text' is not empty.
		require
			a_text_attached: a_text /= Void
			a_format_attached: a_format /= Void
		do
			if not a_text.is_empty then
				text_list.extend (a_text)
				format_list.extend (a_format)
			end
		end

	text_list: LIST [STRING_GENERAL]
			-- List of text

	format_list: LIST [EV_CHARACTER_FORMAT]
			-- Format list.
			-- Format are appliable in {EV_RICH_TEXT}.

feature{NONE} -- Formats

	normal_format: EV_CHARACTER_FORMAT
			-- Format for normal text

	string_format: EV_CHARACTER_FORMAT
			-- Format for string text

	keyword_format: EV_CHARACTER_FORMAT
			-- Format for keyword text

	number_format: EV_CHARACTER_FORMAT
			-- Format for number text

	operator_format: EV_CHARACTER_FORMAT
			-- Format for operator text

	target_format: EV_CHARACTER_FORMAT
			-- Format for target domain item text

	group_format: EV_CHARACTER_FORMAT
			-- Format for group domain item text

	folder_format: EV_CHARACTER_FORMAT
			-- Format for folder domain item text

	class_format: EV_CHARACTER_FORMAT
			-- Format for class domain item text

	feature_format: EV_CHARACTER_FORMAT
			-- Format for feature domain item text

	delayed_format: EV_CHARACTER_FORMAT
			-- Format for delayed domain item text

	error_format: EV_CHARACTER_FORMAT
			-- Format for error text

	modifier_format: EV_CHARACTER_FORMAT
			-- Format for modifiers

	metric_name_format: EV_CHARACTER_FORMAT
			-- Format for metric name

	err_metric_name_format: EV_CHARACTER_FORMAT
			-- Format for error metric name

	warning_format: EV_CHARACTER_FORMAT
			-- Format for warning message

	regenerate_formats is
			-- Regenerate formats for different kinds of display elements.
		local
			l_background_color: EV_COLOR
			l_normal_font: EV_FONT
			l_keyword_font: EV_FONT
			l_preferences: EB_EDITOR_DATA
		do
			l_preferences := preferences.editor_data
			l_background_color := l_preferences.normal_background_color

			create l_normal_font
			create l_keyword_font
			l_keyword_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)

			create normal_format.make_with_font_and_color   (l_normal_font,  l_preferences.normal_text_color,   l_background_color)
			create string_format.make_with_font_and_color   (l_normal_font,  l_preferences.string_text_color,   l_background_color)
			create keyword_format.make_with_font_and_color  (l_keyword_font, l_preferences.keyword_text_color,  l_background_color)
			create number_format.make_with_font_and_color   (l_normal_font,  l_preferences.number_text_color,   l_background_color)
			create operator_format.make_with_font_and_color (l_normal_font,  l_preferences.operator_text_color, l_background_color)
			create target_format.make_with_font_and_color   (l_normal_font,  l_preferences.target_text_color,   l_background_color)
			create group_format.make_with_font_and_color    (l_normal_font,  l_preferences.cluster_text_color,  l_background_color)
			create folder_format.make_with_font_and_color   (l_normal_font,  l_preferences.cluster_text_color,  l_background_color)
			create class_format.make_with_font_and_color    (l_normal_font,  l_preferences.class_text_color,    l_background_color)
			create feature_format.make_with_font_and_color  (l_normal_font,  l_preferences.feature_text_color,  l_background_color)
			create delayed_format.make_with_font_and_color  (l_normal_font,  l_preferences.normal_text_color,   l_background_color)
			create error_format.make_with_font_and_color    (l_normal_font,  l_preferences.error_text_color,    l_background_color)
			create modifier_format.make_with_font_and_color (l_normal_font,  l_preferences.comments_text_color, l_background_color)
			create metric_name_format.make_with_font_and_color    	(l_keyword_font, l_preferences.normal_text_color,  l_background_color)
			create err_metric_name_format.make_with_font_and_color  (l_keyword_font, l_preferences.error_text_color,   l_background_color)
			create warning_format.make_with_font_and_color    (l_normal_font, l_preferences.warning_text_color,    l_background_color)
		end

invariant
	text_list_attached: text_list /= Void
	format_list_attached: format_list /= Void
	text_format_list_valid: text_list.count = format_list.count
	normal_format_attached: normal_format /= Void
	string_format_attached: string_format /= Void
	keyword_format_attached: keyword_format /= Void
	number_format_attached: number_format /= Void
	operator_format_attached: operator_format /= Void
	target_format_attached: target_format /= Void
	group_format_attached: group_format /= Void
	folder_format_attached: folder_format /= Void
	class_format_attached: class_format /= Void
	feature_format_attached: feature_format /= Void
	delayed_format_attached: delayed_format /= Void
	error_format_attached: error_format /= Void

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
