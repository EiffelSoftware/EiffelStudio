note
	description: "Dialog to setup caller/callee domain"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_GRID_CALLER_CALLEE_DIALOG

inherit
	EB_METRIC_GRID_DOMAIN_ITEM_DIALOG [TUPLE[BOOLEAN]]
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

feature{NONE} -- Initialization

	initialize
			-- Initialize.
		local
			l_ver: EV_VERTICAL_BOX
			l_ver_box: EV_VERTICAL_BOX
			l_label: EV_LABEL
		do
			create only_current_version_radio.make_with_text (metric_names.t_only_current_version)
			create descendant_version_radio.make_with_text (metric_names.t_descendant_version)
			Precursor

			create l_ver_box
			l_ver_box.set_padding (2)
			create l_label.make_with_text (metric_names.l_select_input_domain)
			l_label.align_text_left
			l_ver_box.extend (l_label)
			l_ver_box.extend (domain_selector)
			l_ver_box.disable_item_expand (l_label)

			create l_ver
			l_ver.set_padding (5)
			l_ver.extend (only_current_version_radio)
			l_ver.extend (descendant_version_radio)
			l_ver.extend (l_ver_box)
			l_ver.disable_item_expand (only_current_version_radio)
			l_ver.disable_item_expand (descendant_version_radio)
			element_container.extend (l_ver)
			set_icon_pixmap (pixmaps.icon_pixmaps.tool_metric_icon)
			set_title (metric_names.t_setup_feature_domain)
		end

feature{NONE} -- Action

	on_show
			-- Action to be performed when dialog is displayed
		local
			l_value: TUPLE[only_current: BOOLEAN]
		do
			l_value := value
			if l_value = Void then
				l_value := [True]
			end
			if l_value.only_current then
				only_current_version_radio.enable_select
			else
				descendant_version_radio.enable_select
			end
		end

	on_ok
			-- Ok was pressed.
		do
			Precursor
			set_value ([only_current_version_radio.is_selected])
			ok_actions.call (Void)
		end

	on_cancel
			-- Cancel was pressed.
		do
			Precursor
			cancel_actions.call (Void)
		end

feature{NONE} -- Implementation

	only_current_version_radio: EV_RADIO_BUTTON
			-- Radio button to indicate that only features related with current version of specified features are retrieved

	descendant_version_radio: EV_RADIO_BUTTON
		-- Radio button to indicate that only features related with current version and all their descendant versions of specified features are retrieved

invariant
	only_current_version_radio_attached: only_current_version_radio /= Void
	descendant_version_radio_attached: descendant_version_radio /= Void

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
