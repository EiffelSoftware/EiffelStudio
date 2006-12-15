indexing
	description: "Dialog allowing user to setup criterion domain"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_DOMAIN_PROPERTY_DIALOG

inherit
	PROPERTY_DIALOG [TUPLE [EB_METRIC_DOMAIN, BOOLEAN]]
		redefine
			initialize,
			on_ok,
			on_cancel,
			hide
		end

	EB_METRIC_INTERFACE_PROVIDER
		undefine
			copy,
			is_equal,
			default_create
		end

	EB_SHARED_MANAGERS
		undefine
			copy,
			is_equal,
			default_create
		end

feature{NONE} -- Initialization

	initialize is
			-- Initialization
		do
			create property_area
			Precursor {PROPERTY_DIALOG}
			element_container.extend (property_area)
			show_actions.extend (agent on_show)
			set_size (350, 350)
			create ok_actions
			create cancel_actions
			create hide_actions
			set_title (metric_names.f_setup_criterion_domain)
		ensure then
			property_area_attached: property_area /= Void
			ok_actions_attached: ok_actions /= Void
			cancel_actions_attached: cancel_actions /= Void
			hide_actions_attached: hide_actions /= Void
		end

feature{NONE} -- Actions

	on_show is
			-- Action to be performed when dialog is displayed
		local
			l_domain: EB_METRIC_DOMAIN
			l_version: BOOLEAN_REF
		do
			if value /= Void then
				l_domain ?= value.item (1)
				l_version ?= value.item (2)
				check
					l_domain /= Void
					l_version /= Void
				end
				property_area.domain_selector.set_domain (l_domain)
				if l_version.item then
					property_area.only_current_version_checkbox.enable_select
				else
					property_area.descendant_version_checkbox.enable_select
				end
			end
		end

	on_ok is
			-- Action to be performed when "OK" button is pressed
		do
			set_value ([property_area.domain_selector.domain, property_area.only_current_version_checkbox.is_selected])
			Precursor
			ok_actions.call ([])
		end

	on_cancel is
			-- Cancel was pressed.
		do
			Precursor
			cancel_actions.call ([])
		end

feature -- Access

	ok_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when OK button is pressed

	cancel_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when Cancel button is pressed

	hide_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when Current is hiden

	property_area: EB_CALLER_PROPERTY_AREA
			-- Property area

	grid: ES_GRID
			-- Grid which should retrieve focus after Current is hidden

feature -- Status setting

	hide is
			-- Request that `Current' not be displayed even when its parent is.
			-- If successful, make `is_show_requested' `False'.
		local
			l_grid: like grid
		do
			Precursor
			l_grid := grid
			if l_grid /= Void and then not l_grid.is_destroyed and then l_grid.is_displayed and then l_grid.is_sensitive then
				l_grid.set_focus
			end
			window_manager.last_focused_development_window.window.set_focus
			hide_actions.call ([])
		end

	set_grid (a_grid: like grid) is
			-- Set `grid' with `a_grid'.
		require
			a_grid_attached: a_grid /= Void
		do
			grid := a_grid
		ensure
			grid_set: grid = a_grid
		end

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
