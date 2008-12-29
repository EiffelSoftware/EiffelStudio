note
	description: "Dialog to display text property"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_TEXT_PROPERTY_DIALOG

inherit
	PROPERTY_DIALOG [TUPLE [a_text: STRING_GENERAL; a_case_sensitive: BOOLEAN; a_matcher: INTEGER]]
		redefine
			initialize,
			on_ok,
			on_cancel
		end

	EB_CONSTANTS
		undefine
			default_create,
			copy
		end

feature{NONE} -- Initialization

	initialize
			-- Initialization
		local
			l_ver_box: EV_VERTICAL_BOX
			l_name_lbl: EV_LABEL
			l_frame: EV_FRAME
			l_opt_ver_box: EV_VERTICAL_BOX
			l_cell1: EV_CELL
			l_cell2: EV_CELL
			l_ver: EV_VERTICAL_BOX
		do
			create identical_radio.make_with_text (metric_names.t_identical)
			create substring_radio.make_with_text (metric_names.t_containing)
			create wildcard_radio.make_with_text (metric_names.t_wildcard)
			create regexp_radio.make_with_text (metric_names.t_regexp)
			create case_sensitive_checkbox.make_with_text (metric_names.l_use_case_sensitive)
			create name_text
			Precursor {PROPERTY_DIALOG}
			show_actions.extend (agent on_show)

			set_size (300, 200)
			create ok_actions
			create cancel_actions

			create l_ver
			l_ver.set_padding (8)

			create l_ver_box
			l_ver_box.set_padding (5)

			create l_name_lbl.make_with_text (metric_names.l_name_colon)
			l_name_lbl.align_text_left

			create l_frame
			l_frame.set_style ({EV_FRAME_CONSTANTS}.ev_frame_etched_in)
			l_frame.set_text (metric_names.t_matching_strategy)

			create l_cell1
			l_cell1.set_minimum_height (5)

			create l_cell2
			l_cell2.set_minimum_height (20)

			create l_opt_ver_box
			l_opt_ver_box.set_padding (5)
			l_opt_ver_box.set_border_width (5)
			l_frame.extend (l_opt_ver_box)

			l_opt_ver_box.extend (identical_radio)
			l_opt_ver_box.extend (substring_radio)
			l_opt_ver_box.extend (wildcard_radio)
			l_opt_ver_box.extend (regexp_radio)

			l_opt_ver_box.disable_item_expand (identical_radio)
			l_opt_ver_box.disable_item_expand (substring_radio)
			l_opt_ver_box.disable_item_expand (wildcard_radio)
			l_opt_ver_box.disable_item_expand (regexp_radio)

			l_ver.extend (l_frame)
			l_ver.extend (case_sensitive_checkbox)

			l_ver_box.extend (l_name_lbl)
			l_ver_box.disable_item_expand (l_name_lbl)
			l_ver_box.extend (name_text)
			l_ver_box.disable_item_expand (l_name_lbl)
			l_ver_box.extend (l_cell1)
			l_ver_box.disable_item_expand (l_cell1)
			l_ver_box.extend (l_ver)
			l_ver_box.disable_item_expand (l_ver)
			l_ver_box.extend (l_cell2)
			l_ver_box.disable_item_expand (l_cell2)
			element_container.extend (l_ver_box)
			set_icon_pixmap (pixmaps.icon_pixmaps.tool_metric_icon)
		end

feature -- Access

	ok_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when "OK" button is pressed

	cancel_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when "Cancel" button is pressed

feature{NONE} -- Actions

	on_show
			-- Action to be performed when dialog is displayed
		local
			l_value: like value
		do
			l_value := value
			if l_value = Void then
				name_text.set_text ("")
				case_sensitive_checkbox.disable_select
				identical_radio.enable_select
			else
				name_text.set_text (l_value.a_text)
				if l_value.a_case_sensitive then
					case_sensitive_checkbox.enable_select
				else
					case_sensitive_checkbox.disable_select
				end
				inspect
					l_value.a_matcher
				when {QL_NAME_CRITERION}.identity_matching_strategy then
					identical_radio.enable_select
				when {QL_NAME_CRITERION}.containing_matching_strategy then
					substring_radio.enable_select
				when {QL_NAME_CRITERION}.wildcard_matching_strategy then
					wildcard_radio.enable_select
				when {QL_NAME_CRITERION}.regular_expression_matching_strategy then
					regexp_radio.enable_select
				end
			end
		end

	on_ok
			-- Action to be performed when "OK" button is pressed
		local
			l_value: like value
		do
			l_value := [name_text.text.as_string_8, case_sensitive_checkbox.is_selected, matcher_index]
			l_value.compare_objects
			set_value (l_value)
			Precursor {PROPERTY_DIALOG}
			ok_actions.call (Void)
		end

	on_cancel
			-- Action to be performed when "Cancel" button is pressed
		do
			Precursor
			cancel_actions.call (Void)
		end

feature{NONE} -- Implementation

	case_sensitive_checkbox: EV_CHECK_BUTTON
			-- Check box to indicate if case sensitive string comparison is used

	name_text: EV_TEXT_FIELD
			-- Text field for string input

	matcher_index: INTEGER
			-- Matcher strategy index
		do
			if identical_radio.is_selected then
				Result := {QL_NAME_CRITERION}.identity_matching_strategy
			elseif substring_radio.is_selected then
				Result := {QL_NAME_CRITERION}.containing_matching_strategy
			elseif wildcard_radio.is_selected then
				Result := {QL_NAME_CRITERION}.wildcard_matching_strategy
			elseif regexp_radio.is_selected then
				Result := {QL_NAME_CRITERION}.regular_expression_matching_strategy
			end
		ensure
			good_result: Result > 0
		end

	identical_radio: EV_RADIO_BUTTON
	substring_radio: EV_RADIO_BUTTON
	wildcard_radio: EV_RADIO_BUTTON
	regexp_radio: EV_RADIO_BUTTON

invariant
	ok_actions_attached: ok_actions /= Void
	cancel_actions_attached: cancel_actions /= Void
	case_sensitive_checkbox_attached: case_sensitive_checkbox /= Void
	name_text_attached: name_text /= Void

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

end
