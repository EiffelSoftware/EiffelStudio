note
	description: "[
		An EiffelStudio dockable tool window, allowing a context stone to be pushed, base implementation for EiffelStudio tools.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_DOCKABLE_STONABLE_TOOL_PANEL [G -> EV_WIDGET]

inherit
	ES_DOCKABLE_TOOL_PANEL [G]
		redefine
			internal_recycle,
			tool_descriptor,
			on_show
		end

	ES_STONABLE_I
		export
			{ES_STONABLE_I, ES_TOOL} all
		redefine
			set_stone
		end

	ES_STONABLE_SYNCHRONIZED_I
		export
			{ES_STONABLE_I, ES_TOOL} all
		redefine
			set_stone,
			synchronize
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			if content /= Void then
				content.drop_actions.set_veto_pebble_function (Void)
			end
			Precursor
		ensure then
			content_veto_action_removed: (old content.drop_actions).veto_pebble_function = Void
		end

feature {ES_STONABLE_I, ES_TOOL} -- Access

	frozen stone: STONE
			-- <Precursor>
		do
			if attached {attached ES_STONABLE_I} tool_descriptor as l_stonable then
				Result := l_stonable.stone
			end
		end

feature {NONE} -- Access

	tool_descriptor: attached ES_STONABLE_TOOL [ES_DOCKABLE_STONABLE_TOOL_PANEL [EV_WIDGET]]
			-- <Precursor>

feature {ES_STONABLE_I, ES_TOOL} -- Element change

	set_stone (a_stone: like stone)
			-- <Precursor>
		do
			if a_stone /= stone then
					-- Client is setting the stone directly, and not through {ES_STONABLE_TOOL}
					-- This is normal because of the transistion of tool development to ESF.
					-- See notes for `stone_change_notified'.
				if attached {attached ES_STONABLE_I} tool_descriptor as l_stonable then
					l_stonable.set_stone (a_stone)
				end
			else
				has_performed_stone_change_notification := False
			end

			if is_initialized and not has_performed_stone_change_notification then
				on_stone_changed_internal (tool_descriptor.previous_stone)
			end
		end

feature {NONE} -- Status report

	has_performed_stone_change_notification: BOOLEAN
			-- Status flag to ensure stone change notifications are performed.
			-- Note: This flag is needed because of the transistion between old tools and ESF.
			--       Idealistically all stones should be set through the tool panel's `tool_descriptor'.
			--       as ESF dictates that no interaction should be perform with the panel (Current) but
			--       the tool descritor (`tool_descriptor').

	is_stone_usable_internal (a_stone: attached like stone): BOOLEAN
			-- <Precursor>
		do
			Result := tool_descriptor.is_stone_usable (a_stone)
		end

feature {NONE} -- Helpers

	stone_sychronizer: ES_STONE_SYNCHRONIZER
			-- A stone synchronizer, using Current as the primary stonable object.
		require
			is_interface_usable: is_interface_usable
		do
			if attached internal_stone_sychronizer as l_result then
				Result := l_result
			else
				create Result.make (Current)
				internal_stone_sychronizer := Result
				auto_recycle (Result)
			end
		ensure
			result_consistent: Result = stone_sychronizer
		end

feature {NONE} -- Basic opertations

	propagate_drop_actions (a_excluded: ARRAY [EV_WIDGET])
			-- Propagates the stone drop actions to all widgets, to force the stone to be set on the panel.
			--
			-- `a_exclude': An array of widgets to exluding the the propagation of actions, or Void to include all widgets.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized or is_initializing
        do
        		-- Set drop actions on all widgets
        	propagate_register_action (user_widget, agent {EV_WIDGET}.drop_actions, agent (ia_pebble: ANY)
        			-- Propagate the stone drop actions	
        		do
        			if is_interface_usable and is_initialized and then tool_descriptor.is_interface_usable then
        				if attached {attached STONE} ia_pebble as l_stone and then tool_descriptor.is_stone_usable (l_stone) then
      							-- Force stone on descriptor, which will optimize the display of the stone on Current.
	        					-- I cannot see any reason why the tool would not be shown when a drop action occurs (unless the action is published programmatically),
	        					-- but going through the descriptor is the safest and most optimized means of setting a stone.
        					tool_descriptor.set_stone_with_query (l_stone)
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
			propagate_action (user_widget, agent (a_widget: EV_WIDGET)
					-- Propagating the action to set the veto pebble function.
				do
					a_widget.drop_actions.set_veto_pebble_function (agent (ia_pebble: ANY): BOOLEAN
							-- Query if a pebble should be vetoed.
						do
							Result := ia_pebble = Void
							if not Result and then attached {STONE} ia_pebble as l_stone then
								Result := is_stone_usable (l_stone)
							end
						end)
				end, Void)
        end

feature -- Actions

	stone_changed_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [sender: ES_STONABLE_I; old_stone: detachable STONE]]
			-- <Precursor>
		do
			if attached internal_stone_changed_actions as l_result then
				Result := l_result
			else
				create Result
				internal_stone_changed_actions := Result
			end
		end

feature {NONE} -- Action handlers

	on_show
			-- Called when the tool is brought into view.
		local
			l_previous_stone: detachable STONE
		do
			Precursor {ES_DOCKABLE_TOOL_PANEL}

        	if not has_performed_stone_change_notification and (stone = Void or else is_stone_usable (stone)) then
        			-- Synchronize stone and by-pass display checks because the UI is shown.
        		l_previous_stone := tool_descriptor.previous_stone
        		if is_stone_usable (l_previous_stone) then
        			on_stone_changed (l_previous_stone)
        		end
				has_performed_stone_change_notification := True
        	end
		end

	on_stone_changed (a_old_stone: detachable like stone)
			-- Called when the set stone changes.
			-- Note: This routine can be called when `stone' is Void, to indicate a stone has been cleared.
			--       Be sure to check `is_in_stone_synchronization' to determine if a stone has change through an explicit
			--       setting or through compile synchronization.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_stone_change_notified: not has_performed_stone_change_notification
			is_shown: is_shown or is_auto_hide
		deferred
		ensure
				-- This change is handled by the callee
			not_stone_change_notified: not has_performed_stone_change_notification
		end

	frozen on_stone_changed_internal (a_old_stone: detachable like stone)
			-- Called when the set stone changes.
			-- Note: This routine can be called when `stone' if Void.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_stone_change_notified: not has_performed_stone_change_notification
		do
			if is_shown then
				on_stone_changed (a_old_stone)
				has_performed_stone_change_notification := True
			end
		ensure
			stone_change_notified: is_shown implies has_performed_stone_change_notification
		rescue
			has_performed_stone_change_notification := True
		end

feature {ES_STONABLE_I} -- Synchronization

	synchronize
			-- <Precursor>
		local
			l_stone: STONE
			l_new_stone: STONE
		do
			if is_initialized then
				l_stone := stone
				if l_stone /= Void then
					l_new_stone := l_stone.synchronized_stone
				end
				if is_stone_sychronization_required (l_stone, l_new_stone) then
						-- Force recomputation.
					has_performed_stone_change_notification := False
					is_in_stone_synchronization := True
					if l_new_stone /= Void and then is_stone_usable (l_new_stone) then
						set_stone (l_new_stone)
					else
						set_stone (Void)
					end
					is_in_stone_synchronization := False
				end
			end
		rescue
			is_in_stone_synchronization := False
		end

feature {NONE} -- Implementation: Internal cache

	internal_stone_changed_actions: like stone_changed_actions
			-- Cache version of `stone_changed_actions'
			-- Note: Do not use directly!

	internal_stone_sychronizer: like stone_sychronizer
			-- Cache version of `stone_sychronizer'
			-- Note: Do not use directly!

invariant
	tool_descriptor_is_stonable: is_interface_usable implies (({ES_STONABLE_I}) #? tool_descriptor) /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
