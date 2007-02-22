indexing
	description: "Dialog to display text property"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_TEXT_PROPERTY_DIALOG

inherit
	PROPERTY_DIALOG [TUPLE [STRING_GENERAL, BOOLEAN, BOOLEAN]]
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

	initialize is
			-- Initialization
		local
			l_ver_box: EV_VERTICAL_BOX
			l_name_lbl: EV_LABEL
			l_frame: EV_FRAME
			l_opt_ver_box: EV_VERTICAL_BOX
			l_cell1: EV_CELL
			l_cell2: EV_CELL
		do
			create case_sensitive_checkbox.make_with_text (metric_names.l_use_case_sensitive)
			create regular_expression_checkbox.make_with_text (metric_names.l_use_regular_expression)
			create name_text
			Precursor {PROPERTY_DIALOG}
			show_actions.extend (agent on_show)

			set_size (300, 200)
			create ok_actions
			create cancel_actions

			create l_ver_box
			l_ver_box.set_padding (5)

			create l_name_lbl.make_with_text (metric_names.l_name_colon)
			l_name_lbl.align_text_left

			create l_frame
			l_frame.set_style ({EV_FRAME_CONSTANTS}.ev_frame_etched_in)

			create l_cell1
			l_cell1.set_minimum_height (5)

			create l_cell2
			l_cell2.set_minimum_height (20)

			create l_opt_ver_box
			l_opt_ver_box.set_padding (5)
			l_opt_ver_box.set_border_width (5)
			l_frame.extend (l_opt_ver_box)

			l_opt_ver_box.extend (case_sensitive_checkbox)
			l_opt_ver_box.extend (regular_expression_checkbox)
			l_opt_ver_box.disable_item_expand (case_sensitive_checkbox)
			l_opt_ver_box.disable_item_expand (regular_expression_checkbox)

			l_ver_box.extend (l_name_lbl)
			l_ver_box.disable_item_expand (l_name_lbl)
			l_ver_box.extend (name_text)
			l_ver_box.disable_item_expand (l_name_lbl)
			l_ver_box.extend (l_cell1)
			l_ver_box.disable_item_expand (l_cell1)
			l_ver_box.extend (l_frame)
			l_ver_box.disable_item_expand (l_frame)
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

	on_show is
			-- Action to be performed when dialog is displayed
		local
			l_text: STRING_GENERAL
			l_case_sensitive: BOOLEAN_REF
			l_regular: BOOLEAN_REF
		do
			if value = Void then
				name_text.set_text ("")
				case_sensitive_checkbox.disable_select
				regular_expression_checkbox.enable_select
			else
				l_text ?= value.item (1)
				l_case_sensitive ?= value.item (2)
				l_regular ?= value.item (3)
				name_text.set_text (l_text)
				if l_case_sensitive.item then
					case_sensitive_checkbox.enable_select
				else
					case_sensitive_checkbox.disable_select
				end
				if l_regular.item then
					regular_expression_checkbox.enable_select
				else
					regular_expression_checkbox.disable_select
				end
			end
		end

	on_ok is
			-- Action to be performed when "OK" button is pressed
		do
			set_value ([name_text.text, case_sensitive_checkbox.is_selected, regular_expression_checkbox.is_selected])
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

	regular_expression_checkbox: EV_CHECK_BUTTON
			-- Check box to indicate if regular_expression_checkbox is used

	name_text: EV_TEXT_FIELD
			-- Text field for string input

invariant
	ok_actions_attached: ok_actions /= Void
	cancel_actions_attached: cancel_actions /= Void
	case_sensitive_checkbox_attached: case_sensitive_checkbox /= Void
	regular_expression_checkbox_attached: regular_expression_checkbox /= Void
	name_text_attached: name_text /= Void

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
