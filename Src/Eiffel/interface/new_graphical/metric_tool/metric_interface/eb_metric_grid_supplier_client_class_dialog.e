indexing
	description: "[
					Object that represents a dialog to setup a metric domain as class client/supplier
					Three items (in order) are used as value:
					(1) A boolean indicating if indirect client/supplier classes will be retrieved
					(2) A boolean indicating if normal referenced client/supplier classes will be retrieved
					(3) A boolean indicating if only syntactically referenced client/supplier classes will be retrieved
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_GRID_SUPPLIER_CLIENT_CLASS_DIALOG

inherit
	EB_METRIC_GRID_DOMAIN_ITEM_DIALOG [TUPLE [indirect: BOOLEAN; referenced: BOOLEAN; syntactical: BOOLEAN]]
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

	SHARED_BENCH_NAMES
		undefine
			copy,
			default_create
		end

feature{NONE} -- Initialization

	initialize is
			-- Initialize.
		local
			l_vertical_box: EV_VERTICAL_BOX
			l_ver_box: EV_VERTICAL_BOX
			l_ver_box2: EV_VERTICAL_BOX
			l_label: EV_LABEL
			l_frame: EV_FRAME
		do
			create direct_radio
			create indirect_radio
			create normal_referenced_checkbox
			create syntactical_referenced_checkbox
			create l_frame
			l_frame.set_style ({EV_FRAME_CONSTANTS}.ev_frame_etched_in)
			Precursor
			create l_vertical_box
			l_vertical_box.set_padding (5)
			create l_ver_box2
			l_ver_box2.set_padding (2)
			l_ver_box2.set_border_width (3)
			l_ver_box2.extend (direct_radio)
			l_ver_box2.disable_item_expand (direct_radio)
			l_ver_box2.extend (indirect_radio)
			l_ver_box2.disable_item_expand (indirect_radio)
			l_frame.extend (l_ver_box2)
			l_vertical_box.extend (l_frame)
			l_vertical_box.extend (normal_referenced_checkbox)
			l_vertical_box.extend (syntactical_referenced_checkbox)
			l_vertical_box.disable_item_expand (l_frame)
			l_vertical_box.disable_item_expand (normal_referenced_checkbox)
			l_vertical_box.disable_item_expand (syntactical_referenced_checkbox)

			create l_ver_box
			l_ver_box.set_padding (2)
			create l_label.make_with_text (metric_names.l_select_input_domain)
			l_label.align_text_left
			l_ver_box.extend (l_label)
			l_ver_box.extend (domain_selector)
			l_ver_box.disable_item_expand (l_label)

			l_vertical_box.extend (l_ver_box)
			element_container.extend (l_vertical_box)
			set_icon_pixmap (pixmaps.icon_pixmaps.tool_metric_icon)
			update_ui
		end

feature -- Status report

	is_for_supplier_class: BOOLEAN
			-- Is Current dialog to setup client class?

	is_for_client_class: BOOLEAN is
			-- Is Current dialog to setup supplier class?
		do
			Result := not is_for_supplier_class
		end

feature -- Setting

	enable_for_supplier_class is
			-- Switch Current dialog to setup supplier class.
		do
			is_for_supplier_class := True
			update_ui
		ensure
			for_supplier_class: is_for_supplier_class
		end

	enable_for_client_class is
			-- Switch Current dialog to setup client class.
		do
			is_for_supplier_class := False
			update_ui
		ensure
			for_client_class: is_for_client_class
		end

feature{NONE} -- Actions

	on_show is
			-- Action to be performed when dialog is displayed
		local
			l_value: like value
			l_indirect: BOOLEAN
			l_referenced: BOOLEAN
			l_syntactical: BOOLEAN
		do
			l_value := value
			if l_value /= Void then
				l_indirect := l_value.indirect
				l_referenced := l_value.referenced
				l_syntactical := l_value.syntactical
			end
			if l_indirect then
				indirect_radio.enable_select
			else
				direct_radio.enable_select
			end
			if l_referenced then
				normal_referenced_checkbox.enable_select
			else
				normal_referenced_checkbox.disable_select
			end
			if l_syntactical then
				syntactical_referenced_checkbox.enable_select
			else
				syntactical_referenced_checkbox.disable_select
			end
		end

	on_ok is
			-- Ok was pressed.
		do
			Precursor
			set_value ([indirect_radio.is_selected,
						normal_referenced_checkbox.is_selected,
						syntactical_referenced_checkbox.is_selected]
			)
			ok_actions.call (Void)
		end

	on_cancel is
			-- Cancel was pressed.
		do
			Precursor
			cancel_actions.call (Void)
		end

feature{NONE} -- Implementation

	indirect_radio: EV_RADIO_BUTTON
			-- Radio button to indicate if indirect supplier/client classes are retrieved

	direct_radio: EV_RADIO_BUTTON
			-- Radio button to indicate if supplier/client classes are retrieved

	normal_referenced_checkbox: EV_CHECK_BUTTON
			-- Check box to indicate if normal referenced classes are retrieved

	syntactical_referenced_checkbox: EV_CHECK_BUTTON
			-- Check box to indicate if only syntactically referenced classa are retireved

	update_ui is
			-- Update interface.
		do
			set_title (metric_names.l_setup_referenced_class_dialog (is_for_supplier_class))
			direct_radio.set_text (metric_names.l_retrieve_referenced_class (is_for_supplier_class))
			indirect_radio.set_text (metric_names.l_retrieve_indirect_referenced_class (is_for_supplier_class))
			normal_referenced_checkbox.set_text (metric_names.l_retrieve_normally_referenced_class (is_for_supplier_class))
			syntactical_referenced_checkbox.set_text (metric_names.l_retrieve_only_syntacticall_referenced_class (is_for_supplier_class))
		end

invariant
	direct_radio_attached: direct_radio /= Void
	indirect_checkbox_attached: indirect_radio /= Void
	normal_referenced_checkbox_attached: normal_referenced_checkbox /= Void
	syntactical_referenced_checkbox_attached: syntactical_referenced_checkbox /= Void

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
