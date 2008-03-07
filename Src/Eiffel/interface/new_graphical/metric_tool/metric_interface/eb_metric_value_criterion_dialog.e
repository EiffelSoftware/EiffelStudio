indexing
	description: "Dialog to setup value criterion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_VALUE_CRITERION_DIALOG

inherit
	EB_METRIC_GRID_DOMAIN_ITEM_DIALOG [TUPLE [a_metric_name: STRING; a_parent_used: BOOLEAN; a_tester: EB_METRIC_VALUE_TESTER]]
		redefine
			initialize,
			on_ok,
			on_cancel,
			set_context_menu_factory
		end

	EB_CONSTANTS
		undefine
			copy,
			default_create
		end

	EB_METRIC_INTERFACE_PROVIDER
		undefine
			copy,
			default_create
		end

create
	make

feature{NONE} -- Initialization

	make (a_value_tester_area_shown: BOOLEAN; a_metric_selector_area_shown: BOOLEAN; a_use_external_shown: BOOLEAN) is
			-- Initialize.
		do
			is_value_tester_area_shown := a_value_tester_area_shown
			is_metric_area_shown := a_metric_selector_area_shown
			is_use_external_shown := a_use_external_shown
			default_create
		end

	initialize is
			-- Initialize.
		local
			l_ver: EV_VERTICAL_BOX
			l_hor: EV_HORIZONTAL_BOX
			l_tester_area: EV_VERTICAL_BOX
			l_tester_cell: EV_CELL
			l_split_area: EV_HORIZONTAL_SPLIT_AREA
			l_lbl: EV_LABEL
			l_domain_selector_area: EV_VERTICAL_BOX
			l_tester_selector_area: EV_HORIZONTAL_BOX
			l_input_domain_lbl: EV_LABEL
			l_tester_lbl: EV_LABEL
			l_bottom_cell: EV_CELL
			l_domain_cell: EV_CELL
		do
			create value_tester
			create metric_setter
			create use_external_delayed_domain_checkbox.make_with_text (metric_names.t_use_external_delayed)
			Precursor

			create l_ver
			create l_hor
			create l_split_area
			create l_lbl.make_with_text (interface_names.first_character_as_upper (metric_names.t_metric).as_string_32 + ":")
			l_lbl.align_text_left

			l_hor.extend (l_lbl)
			l_hor.disable_item_expand (l_lbl)
			l_hor.extend (metric_setter)
			l_hor.disable_item_expand (metric_setter)

			if not is_metric_area_shown then
				l_hor.hide
			end
			create l_domain_selector_area
			create l_input_domain_lbl.make_with_text (metric_names.l_select_input_domain)
			create l_domain_cell
			l_domain_cell.extend (use_external_delayed_domain_checkbox)
			if is_value_tester_area_shown then
				l_domain_cell.set_minimum_height (25)
			end
			domain_selector.set_minimum_width (203)
			l_input_domain_lbl.align_text_left
			l_domain_selector_area.set_padding (3)
			l_domain_selector_area.extend (l_domain_cell)
			l_domain_selector_area.disable_item_expand (l_domain_cell)
			l_domain_selector_area.extend (l_input_domain_lbl)
			l_domain_selector_area.disable_item_expand (l_input_domain_lbl)
			l_domain_selector_area.extend (domain_selector)

			create l_tester_selector_area
			create l_tester_cell
			create l_tester_area
			create l_tester_lbl.make_with_text (metric_names.t_select_tester)
			l_tester_lbl.align_text_left
			l_tester_cell.set_minimum_width (10)
			l_tester_selector_area.extend (l_tester_cell)
			l_tester_selector_area.disable_item_expand (l_tester_cell)
			l_tester_area.set_padding (3)
			l_tester_area.extend (l_tester_lbl)
			l_tester_area.disable_item_expand (l_tester_lbl)
			l_tester_area.extend (value_tester)
			l_tester_selector_area.extend (l_tester_area)

			l_ver.set_padding (15)
			l_hor.set_padding (5)
			if is_metric_area_shown then
				l_split_area.extend (l_domain_selector_area)
			end
			if is_value_tester_area_shown then
				l_split_area.extend (l_tester_selector_area)
			end
			if is_use_external_shown then
				use_external_delayed_domain_checkbox.show
			else
				use_external_delayed_domain_checkbox.hide
			end
			l_ver.extend (l_hor)
			l_ver.disable_item_expand (l_hor)
			l_ver.extend (l_split_area)

			set_icon_pixmap (pixmaps.icon_pixmaps.tool_metric_icon)
			set_title (metric_names.t_setup_value_criterion)

			create l_bottom_cell
			l_bottom_cell.set_minimum_height (5)
			element_container.extend (l_ver)
			element_container.extend (l_bottom_cell)
			element_container.disable_item_expand (l_bottom_cell)
		end

feature -- Access

	value_tester: EB_METRIC_VALUE_CRITERION_SELECTOR
			-- Value tester selector

	metric_setter: EB_METRIC_SETTER
			-- Metric setter

	use_external_delayed_domain_checkbox: EV_CHECK_BUTTON
			-- Check box to setup if external delayed domain is used

feature -- Status setting

	set_context_menu_factory (a_factory: EB_CONTEXT_MENU_FACTORY) is
			-- Set context menu factory.
		do
			Precursor {EB_METRIC_GRID_DOMAIN_ITEM_DIALOG}(a_factory)
			value_tester.set_context_menu_factory (a_factory)
		end

feature -- Status report

	is_value_tester_area_shown: BOOLEAN
			-- Is value tester area shown?

	is_metric_area_shown: BOOLEAN
			-- Is metric area shown?

	is_use_external_shown: BOOLEAN
			--

feature{NONE} -- Actions

	on_show is
			-- Action to be performed when dialog is displayed
		local
			l_value: like value
			l_metric_name: STRING
			l_tester: EB_METRIC_VALUE_TESTER
			l_use_external_delayed: BOOLEAN
		do
			l_value := value
			if l_value = Void then
				l_value := ["", False, create {EB_METRIC_VALUE_TESTER}.make]
			end
			l_metric_name := l_value.a_metric_name
			if l_metric_name = Void then
				l_metric_name := ""
			end
			l_use_external_delayed := l_value.a_parent_used
			if l_use_external_delayed then
				use_external_delayed_domain_checkbox.enable_select
			else
				use_external_delayed_domain_checkbox.disable_select
			end
			l_tester := l_value.a_tester
			if l_tester = Void then
				create l_tester.make
			end
			metric_setter.load_metric_data (l_metric_name)
			value_tester.set_criterion (l_tester)
		end

	on_ok is
			-- Ok was pressed.
		do
			Precursor
			set_value ([metric_setter.metric_name, use_external_delayed_domain_checkbox.is_selected, value_tester.criterion])
			ok_actions.call (Void)
		end

	on_cancel is
			-- Cancel was pressed.
		do
			Precursor
			cancel_actions.call (Void)
		end

invariant
	value_tester_attached: value_tester /= Void
	metric_setter_attached: metric_setter /= Void
	use_external_delayed_domain_checkbox_attached: use_external_delayed_domain_checkbox /= Void

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
