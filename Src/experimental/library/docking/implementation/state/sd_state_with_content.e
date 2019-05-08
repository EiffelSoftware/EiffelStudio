note
	description: "{SD_STATE} that has associated content."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_STATE_WITH_CONTENT

inherit
	SD_STATE

feature -- Properties

	content: SD_CONTENT
			-- Content managed by `Current'.
		do
			Result := internal_content
		end

feature {SD_OPEN_CONFIG_MEDIATOR, SD_CONTENT}  -- Restore

	restore (a_data: SD_INNER_CONTAINER_DATA; a_container: EV_CONTAINER)
			-- `titles' is content name
			--
			-- `a_container' is zone parent
		require
			more_than_one_title: attached a_data.titles as lr_titles and then content_count_valid (lr_titles)
			a_container_not_void: a_container /= Void
			a_container_not_full: not a_container.full
			a_direction_valid: a_data.direction = {SD_ENUMERATION}.top or a_data.direction = {SD_ENUMERATION}.bottom
				or a_data.direction = {SD_ENUMERATION}.left or a_data.direction = {SD_ENUMERATION}.right
		do
			content.set_visible (True)
		end

feature -- Commands

	set_focus (a_content: SD_CONTENT)
			-- Set focus
		require
			has_content: has (a_content)
		do
			if attached zone as z then
				z.on_focus_in (a_content)
				docking_manager.property.set_last_focus_content (content)
				if attached {EV_WIDGET} z as lt_widget then
					if not lt_widget.is_displayed then
							-- Maybe current is hidden, we restore zones normal state in that dock area.
						docking_manager.command.recover_normal_state_in_dock_area_of (z)
					end
				else
					check not_possible: False end
				end
			end
		end

	close
			-- Handle close zone
		local
			l_state: SD_STATE_VOID
		do
			if attached zone as z then
				if attached {EV_WIDGET} z as lt_widget then
					docking_manager.command.lock_update (lt_widget, False)
				else
					check not_possible: False end
				end
				docking_manager.command.recover_normal_state_in_dock_area_of (z)
			else
				docking_manager.command.lock_update (Void, True)
			end

			if content /= docking_manager.zones.place_holder_content then
				add_place_holder
			end

			if attached zone as l_zone then
				l_zone.close
			end
			if docking_manager.zones.has_content (content) then
				docking_manager.zones.prune_zone_by_content (content)
			end
			docking_manager.command.remove_empty_split_area
			docking_manager.command.update_title_bar
			docking_manager.command.unlock_update
			create l_state.make (content, docking_manager)
			l_state.set_content (content)
			change_state (l_state)
		end

	auto_hide_tab_with (a_target_content: SD_CONTENT)
			-- When `a_tartget_content' is auto hide state, `content''s auto hide tab dock at side of
			-- `a_target_content' auto hide tab
		require
			a_target_content_not_void: a_target_content /= Void
		local
			l_auto_hide_state: SD_AUTO_HIDE_STATE
		do
			content.set_visible (True)
			docking_manager.command.lock_update (Void, True)
			create l_auto_hide_state.make_with_friend (content, a_target_content)
			content.change_state (l_auto_hide_state)
			docking_manager.command.unlock_update
		end

feature {SD_AUTO_HIDE_STATE} -- Internal calls

	change_state (a_state: SD_STATE_WITH_CONTENT)
			-- Changed `content' state to `a_state'
		require
			a_state_not_void: a_state /= Void
		do
			content.change_state (a_state)
			a_state.set_last_floating_height (last_floating_height)
			a_state.set_last_floating_width (last_floating_width)
		ensure
			changed: content.state = a_state
		end

feature  -- Status report

	has (a_content: SD_CONTENT): BOOLEAN
			-- If Current has `a_content'?
		require
			a_content_not_void: a_content /= Void
		do
			Result := internal_content = a_content
		end

	content_void: BOOLEAN
			-- If current a_content void?
		do
			Result := internal_content = Void
		end

feature {NONE} -- Implementation

	restore_minimize
			-- Restore minimize state
		do
			if attached {SD_UPPER_ZONE} content.state.zone as l_upper_zone then
				l_upper_zone.minimize_for_restore
			end
		end

	call_show_actions
			-- Call content's show actions if possible
		require
			exists: content.state.zone /= Void
			displayed: attached {EV_WIDGET} content.state.zone as lt_widget implies lt_widget.is_displayed
		do
			if not docking_manager.property.is_opening_config then
				content.show_actions.call (Void)
			end
		end

	internal_content: SD_CONTENT
			-- Content managed by `Current'.

;note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
