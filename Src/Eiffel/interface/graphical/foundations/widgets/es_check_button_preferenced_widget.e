indexing
	description: "[
			A preference bound check button ESF widget.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CHECK_BUTTON_PREFERENCED_WIDGET

inherit
	ES_PREFERENCED_WIDGET [EV_CHECK_BUTTON, BOOLEAN_PREFERENCE, BOOLEAN]

create
	make

convert
	widget: {EV_WIDGET, EV_CHECK_BUTTON}

feature {NONE} -- Access

	preference_value: BOOLEAN
			-- <Precursor>
		do
			Result := preference.value
		end

	widget_value: BOOLEAN
			-- <Precursor>
		do
			Result := widget.is_selected
		end

	widget_change_actions: !ACTION_SEQUENCE [TUPLE]
			-- <Precursor>
		local
			l_actions: ACTION_SEQUENCE [TUPLE]
		do
			l_actions := widget.select_actions
			check l_actions_attached: l_actions /= Void end
			Result := l_actions
		end

feature {NONE} -- Basic operations

	update_widget_from_preference_value
			-- <Precursor>
		do
			if preference_value then
				widget.enable_select
			else
				widget.disable_select
			end
		end

	update_preference_value_from_widget
			-- <Precursor>
		do
			preference.set_value (widget.is_selected)
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
