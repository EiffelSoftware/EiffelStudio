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
	EB_METRIC_GRID_DOMAIN_ITEM_DIALOG [TUPLE [STRING, EB_METRIC_VALUE_TESTER]]
		redefine
			initialize,
			on_ok,
			on_cancel
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

	make (a_value_tester_area_shown: BOOLEAN) is
			-- Initialize.
		do
			is_value_tester_area_shown := a_value_tester_area_shown
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
			Precursor

			create l_ver
			create l_hor
			create l_split_area
			create l_lbl.make_with_text (interface_names.first_character_to_upper_case (metric_names.t_metric).as_string_32 + ":")
			l_lbl.align_text_left

			l_hor.extend (l_lbl)
			l_hor.disable_item_expand (l_lbl)
			l_hor.extend (metric_setter)
			l_hor.disable_item_expand (metric_setter)


			create l_domain_selector_area
			create l_input_domain_lbl.make_with_text (metric_names.l_select_input_domain)
			create l_domain_cell
			if is_value_tester_area_shown then
				l_domain_cell.set_minimum_height (25)
			else
				l_domain_cell.set_minimum_height (5)
			end
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
			l_split_area.extend (l_domain_selector_area)
			if is_value_tester_area_shown then
				l_split_area.extend (l_tester_selector_area)
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

feature -- Status report

	is_value_tester_area_shown: BOOLEAN
			-- Is value tester area shown?

feature{NONE} -- Actions

	on_show is
			-- Action to be performed when dialog is displayed
		local
			l_value: like value
			l_metric_name: STRING
			l_tester: EB_METRIC_VALUE_TESTER
		do
			l_value := value
			if l_value = Void then
				l_value := ["", create {EB_METRIC_VALUE_TESTER}.make]
			end
			l_metric_name ?= l_value.item (1)
			if l_metric_name = Void then
				l_metric_name := ""
			end
			l_tester ?= l_value.item (2)
			if l_tester = Void then
				create l_tester.make
			end
			metric_setter.load_metric_data (l_metric_name, uuid_gen.generate_uuid)
			value_tester.set_criterion (l_tester)
		end

	on_ok is
			-- Ok was pressed.
		do
			Precursor
			set_value ([metric_setter.metric_name, value_tester.criterion])
			ok_actions.call ([])
		end

	on_cancel is
			-- Cancel was pressed.
		do
			Precursor
			cancel_actions.call ([])
		end

invariant
	value_tester_attached: value_tester /= Void
	metric_setter_attached: metric_setter /= Void

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
