note
	description: "Object that represents a dialog used in metric grid domain item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_GRID_DOMAIN_ITEM_DIALOG [G]

inherit
	PROPERTY_DIALOG [G]
		redefine
			initialize
		end

feature{NONE} -- Initialization

	initialize
			-- Initialize.
		do
			create ok_actions
			create cancel_actions
			create domain_selector
			Precursor {PROPERTY_DIALOG}
			show_actions.extend (agent on_show)
		end

feature -- Access

	ok_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when OK button is pressed

	cancel_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when Cancel button is pressed

	domain_selector: EB_METRIC_DOMAIN_SELECTOR
			-- Domain selector

	domain: EB_METRIC_DOMAIN
			-- Domain from `domain_selector'
		do
			Result := domain_selector.domain
		ensure
			result_attached: Result /= Void
		end

feature -- Setting

	set_domain (a_domain: EB_METRIC_DOMAIN)
			-- Set domain in `domain_selector' with `a_domain'.
		require
			a_domain_attached: a_domain /= Void
		do
			domain_selector.set_domain (a_domain)
		end

	set_context_menu_factory (a_factory: EB_CONTEXT_MENU_FACTORY)
			-- Set context menu factory.
		do
			domain_selector.set_context_menu_factory (a_factory)
		end

feature{NONE} -- Actions

	on_show
			-- Action to be performed when dialog is displayed
		deferred
		end

invariant
	ok_actions_attached: ok_actions /= Void
	cancel_actions_attached: cancel_actions /= Void
	domain_selector_attached: domain_selector /= Void

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
