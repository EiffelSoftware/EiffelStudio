indexing
	description: "[

		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_STONABLE_WIDGET [G -> EV_WIDGET]

inherit
	ES_WIDGET [G]

	ES_STONABLE

convert
	widget: {EV_WIDGET, !EV_WIDGET, G, !G}

feature {NONE} -- Basic operations

	propagate_drop_actions (a_excluded: ARRAY [EV_WIDGET])
			-- Propagates the stone drop actions to all widgets, to force the stone to be set on the panel.
			--
			-- `a_exclude': An array of widgets to exluding the the propagation of actions, or Void to include all widgets.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized or is_initializing
        do
        		-- Set drop actions on all widgets
        	propagate_register_action (widget, agent {EV_WIDGET}.drop_actions, agent (ia_pebble: ANY)
        			-- Propagate the stone drop actions	
        		do
        			if is_interface_usable and is_initialized then
        				if {l_stone: !STONE} ia_pebble and then is_stone_usable (l_stone) then
        					set_stone_with_query (l_stone)
        				end
					end
        		end, a_excluded)

        	propagate_drop_veto_actions (a_excluded)
        end

	propagate_drop_veto_actions (a_excluded: ARRAY [EV_WIDGET])
			-- Propagates the stone drop actions to all widgets, to force the stone to be set on the panel.
			--
			-- `a_exclude': An array of widgets to exluding the the propagation of actions, or Void to include all widgets.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized or is_initializing
        do
        		-- Set drop actions on all widgets
			propagate_action (widget, agent (a_widget: EV_WIDGET)
					-- Propagating the action to set the veto pebble function.
				do
					a_widget.drop_actions.set_veto_pebble_function (agent (ia_pebble: ANY): BOOLEAN
							-- Query if a pebble should be vetoed.
						do
							Result := ia_pebble = Void
							if not Result and then {l_stone: STONE} ia_pebble then
								Result := is_stone_usable (l_stone)
							end
						end)
				end, Void)
        end

;indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
