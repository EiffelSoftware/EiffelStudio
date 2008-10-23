indexing
	description: "[
			An ESF widget tied to a environment preferences.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_PREFERENCED_WIDGET [G -> EV_WIDGET, P -> PREFERENCE, V -> ANY]

inherit
	ES_WIDGET [G]
		rename
			make as make_widget
		redefine
			on_after_initialized
		end

convert
	widget: {EV_WIDGET, !G}

feature {NONE} -- Initialization

	frozen make (a_widget: !G; a_preference: !P)
			-- Initialize a widget based on a preference.
			--
			-- `a_widget'    : The widget to bind to the ESF widget.
			-- `a_preference': The preference object a widget is bound to.
		require
			not_a_widget_is_parented: not a_widget.has_parent
			not_a_widget_is_destroyed: not a_widget.is_destroyed
		do
			preference := a_preference
			internal_widget := a_widget
			make_widget
		ensure
			preference_set: a_preference = preference
			is_initialized: is_initialized
			is_initializing_unchanged: old is_initializing = is_initializing
		end

feature {NONE} -- User interface initialization

	build_widget_interface (a_widget: !G)
			-- <Precursor>
		do
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor
			update_widget_from_preference_value

				-- Reigster change actions.
			register_action (widget_change_actions, agent on_widget_updated)
			register_action (preference.change_actions, agent
				do
					if is_interface_usable and then is_self_updating then
						on_preference_updated
					end
				end)
		end

feature {NONE} -- Access

	preference: !P
			-- The preference the widget is bound to.

	preference_value: ?V
			-- Preference value.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		deferred
		end

	widget_value: ?V
			-- Widget value.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		deferred
		end

feature -- Status report

	is_self_updating: BOOLEAN assign set_is_self_updating
			-- Indicates if the widget updates itself when the preference is changed.

feature {NONE} -- Status report

	is_value_equal (a_new: ?V; a_old: ?V): BOOLEAN
			-- Determines if a changing value is equal.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			Result := a_new ~ a_old
		end

	is_synchronizing_values: BOOLEAN
			-- Indicates if the values are being synchronized between the widget and preference.

feature -- Status setting

	set_is_self_updating (a_update: BOOLEAN)
			-- Sets self-updating attribute of the widget.
			--
			-- `a_update': True to automatically update the widget; False otherwise.
		do
			is_self_updating := a_update
		ensure
			is_self_updating_set: is_self_updating = a_update
		end

feature {NONE} -- Basic operations

	update_widget_from_preference_value
			-- Updates the widget from the set preference value.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		deferred
		ensure
			is_value_equal: is_value_equal (preference_value, widget_value)
		end

	update_preference_value_from_widget
			-- Updates the preference from a change in the widget.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		deferred
		ensure
			is_value_equal: is_value_equal (widget_value, preference_value)
		end

feature {NONE} -- Actions

	widget_change_actions: !ACTION_SEQUENCE [TUPLE]
			-- The actions used to notify current of a change in value.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		deferred
		end

feature {NONE} -- Action handler

	frozen on_preference_updated
			-- Called when the preference is update.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_syncing: BOOLEAN
			l_new: ?V
			l_old: ?V
		do
			l_syncing := is_synchronizing_values
			if not l_syncing then
				l_new := preference_value
				l_old := widget_value

				if not is_value_equal (l_new, l_old) then
					is_synchronizing_values := True

						-- Perform update
					update_widget_from_preference_value

					is_synchronizing_values := False
				end
			end
		ensure
			is_synchronizing_values_unchanged: is_synchronizing_values = old is_synchronizing_values
		rescue
			is_synchronizing_values := l_syncing
		end

	frozen on_widget_updated
			-- Called when the widget is update.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_syncing: BOOLEAN
			l_new: ?V
			l_old: ?V
		do
			l_syncing := is_synchronizing_values
			if not l_syncing then
				l_new := widget_value
				l_old := preference_value

				if not is_value_equal (l_new, l_old) then
					is_synchronizing_values := True

						-- Perform update
					update_preference_value_from_widget

					is_synchronizing_values := False
				end
			end
		ensure
			is_synchronizing_values_unchanged: is_synchronizing_values = old is_synchronizing_values
		rescue
			is_synchronizing_values := l_syncing
		end

feature {NONE} -- Factory

	frozen create_widget: !G
			-- <Precursor>
		do
			Result := internal_widget
		end

feature {NONE} -- Implementation: Internal cache

	internal_widget: !G
			-- Cached version of `widget'

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
