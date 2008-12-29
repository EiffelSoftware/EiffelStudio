note
	description: "Object that represents a dialog to setup metric domain"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_GRID_PLAIN_DOMAIN_DIALOG

inherit
	EB_METRIC_GRID_DOMAIN_ITEM_DIALOG [ANY]
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

	initialize
			-- Initialize.
		local
			l_ver_box: EV_VERTICAL_BOX
			l_label: EV_LABEL
		do
			Precursor {EB_METRIC_GRID_DOMAIN_ITEM_DIALOG}
			create l_ver_box
			l_ver_box.set_padding (2)
			create l_label.make_with_text (metric_names.l_select_input_domain)
			l_label.align_text_left
			l_ver_box.extend (l_label)
			l_ver_box.extend (domain_selector)
			l_ver_box.disable_item_expand (l_label)

			element_container.extend (l_ver_box)
			set_icon_pixmap (pixmaps.icon_pixmaps.tool_metric_icon)
			set_title (metric_names.l_setup_domain_dialog)
		end

feature -- Status report

	is_for_supplier_class: BOOLEAN
			-- Is Current dialog to setup client class?

	is_for_client_class: BOOLEAN
			-- Is Current dialog to setup supplier class?
		do
			Result := not is_for_supplier_class
		end

feature -- Setting

	enable_for_supplier_class
			-- Switch Current dialog to setup supplier class.
		do
			is_for_supplier_class := True
		ensure
			for_supplier_class: is_for_supplier_class
		end

	enable_for_client_class
			-- Switch Current dialog to setup client class.
		do
			is_for_supplier_class := False
		ensure
			for_client_class: is_for_client_class
		end

feature{NONE} -- Actions

	on_show
			-- Action to be performed when dialog is displayed
		do
		end

	on_ok
			-- Ok was pressed.
		do
			Precursor
			ok_actions.call (Void)
		end

	on_cancel
			-- Cancel was pressed.
		do
			Precursor
			cancel_actions.call (Void)
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

end
