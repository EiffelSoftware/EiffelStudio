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
			on_ok
		end

feature{NONE} -- Initialization

	initialize is
			-- Initialization
		do
			Precursor {PROPERTY_DIALOG}
			create property_area
			element_container.extend (property_area)
			show_actions.extend (agent on_show)
			set_size (300, 200)
			create ok_actions
		ensure then
			property_area_attached: property_area /= Void
			ok_actions_attached: ok_actions /= Void
		end

feature -- Access

	ok_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when "OK" button is pressed

feature{NONE} -- Actions

	on_show is
			-- Action to be performed when dialog is displayed
		local
			l_text: STRING_GENERAL
			l_case_sensitive: BOOLEAN_REF
			l_regular: BOOLEAN_REF
		do
			if value = Void then
				property_area.name_text.set_text ("")
				property_area.case_sensitive_checkbox.disable_select
				property_area.regular_expr_checkbox.enable_select
			else
				l_text ?= value.item (1)
				l_case_sensitive ?= value.item (2)
				l_regular ?= value.item (3)
				property_area.name_text.set_text (l_text)
				if l_case_sensitive.item then
					property_area.case_sensitive_checkbox.enable_select
				else
					property_area.case_sensitive_checkbox.disable_select
				end
				if l_regular.item then
					property_area.regular_expr_checkbox.enable_select
				else
					property_area.regular_expr_checkbox.disable_select
				end
			end
		end

	on_ok is
			-- Action to be performed when "OK" button is pressed
		do
			set_value ([property_area.name_text.text, property_area.case_sensitive_checkbox.is_selected, property_area.regular_expr_checkbox.is_selected])
			Precursor {PROPERTY_DIALOG}
			ok_actions.call ([])
		end

feature{NONE} -- Implementation

	property_area: EB_NAME_PROPERTY_AREA
			-- Property area

invariant
	property_area_attached: property_area /= Void
	ok_actions_attached: ok_actions /= Void

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
