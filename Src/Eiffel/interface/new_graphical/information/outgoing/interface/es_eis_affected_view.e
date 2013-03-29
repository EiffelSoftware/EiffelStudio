note
	description: "View for affected items"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_AFFECTED_VIEW

inherit
	ES_EIS_COMPONENT_VIEW [INTEGER]

create
	make

feature {NONE} -- Initialization

	make (a_for_target: BOOLEAN; a_eis_grid: ES_EIS_ENTRY_GRID)
			-- Initialized with `a_conf_notable' and `a_eis_grid'.
		require
			a_eis_grid_not_void: a_eis_grid /= Void
			a_eis_grid_not_destroyed: not a_eis_grid.is_destroyed
		do
			for_target := a_for_target
				-- Make component different so that `same_view' return false.
			if a_for_target then
				component := 1
			else
				component := 2
			end
			eis_grid := a_eis_grid
		end

feature -- Element Change

	acknowledge_selected_items
			-- Acknowledge selected items
		local
			l_selected_rows: ARRAYED_LIST [EV_GRID_ROW]
			l_request: ES_DISCARDABLE_QUESTION_PROMPT
			l_cancelled, l_removed: BOOLEAN
		do
			create l_request.make_standard_with_cancel (interface_names.l_confirm_acknowledge_selected_items,
				interface_names.l_always_acknowledge_without_asking,
				create {ES_BOOLEAN_PREFERENCE_SETTING}.make (preferences.dialog_data.confirm_acknowledge_eis_affected_items_preference, True))
			l_request.set_title (interface_names.t_eiffelstudio_question)
			l_request.show_on_active_window
			if
				l_request.dialog_result = dialog_buttons.cancel_button or else
				l_request.dialog_result = dialog_buttons.no_button
			then
				l_cancelled := True
			end

			if not l_cancelled then
				l_selected_rows := eis_grid.selected_rows
				from
					l_selected_rows.start
				until
					l_selected_rows.after
				loop
					if attached {EIS_ENTRY} l_selected_rows.item_for_iteration.data as lt_entry then
						storage.acknowledge_entry (lt_entry)
						l_removed := True
					end
					l_selected_rows.forth
				end
				if l_removed then
					rebuild_and_refresh_grid
				end
			end
		end

feature {NONE} -- Implementation

	for_target: BOOLEAN
			-- For target? Otherwise for resources

	new_extractor: ES_EIS_AFFECTED_ITEM_EXTRACTOR
			-- Create extractor
		do
			create Result.make (for_target)
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
