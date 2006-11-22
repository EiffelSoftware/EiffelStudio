indexing
	description: "Text property"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_TEXT_PROPERTY

inherit
	DIALOG_PROPERTY [TUPLE [STRING_GENERAL, BOOLEAN, BOOLEAN]]
		redefine
			update_text_on_deactivation,
			deactivate,
			make_with_dialog,
			dialog
		end

create
	make_with_dialog

feature{NONE} -- Initialization

	make_with_dialog (a_name: like name; a_dialog: like dialog) is
			-- Create with `a_name' and `a_dialog'.
		do
			Precursor (a_name, a_dialog)
			a_dialog.ok_actions.extend (agent on_dialog_close)
		end

feature{NONE} -- Implementation

	update_text_on_deactivation is
			-- Update text on deactivation.
		do
			update_value
		end

	deactivate is
			-- Cleanup from previous call to `activate'.
		do
			Precursor
			update_value
		end

	update_value is
			-- Update `value'.
		local
			l_value: like value
			l_case: BOOLEAN_REF
			l_regx: BOOLEAN_REF
			l_text: like text
		do
			check value /= Void end
			l_value := value
			l_case ?= l_value.item (2)
			l_regx ?= l_value.item (3)
			check
				l_case /= Void
				l_regx /= Void
			end
			if text_field /= Void then
				l_text := text_field.text
			else
				l_text := text
			end
			dialog.set_value ([l_text, l_case.item, l_regx.item])
			set_value ([l_text, l_case.item, l_regx.item])
		end

	on_dialog_close is
			-- Action to be performed when `dialog' closes.
		do
			set_value (dialog.value)
		end

feature {NONE} -- Implementation

	dialog: EB_METRIC_TEXT_PROPERTY_DIALOG;
			-- Dialog to show to change the value.

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
