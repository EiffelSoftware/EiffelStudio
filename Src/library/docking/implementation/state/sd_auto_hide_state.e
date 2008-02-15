indexing
	description: "SD_STATE for  SD_AUTO_HIDE_ZONE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_AUTO_HIDE_STATE

inherit
	SD_STATE
		redefine
			show,
			close,
			stick,
			change_title,
			change_pixmap,
			hide,
			set_focus,
			record_state,
			restore,
			move_to_docking_zone,
			move_to_tab_zone,
			change_zone_split_area
		end

create
	make,
	make_with_size,
	make_with_friend

feature {NONE} -- Initlization

	make (a_content: SD_CONTENT; a_direction: INTEGER) is
			-- Creation method.
		require
			a_content_not_void: a_content /= Void
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		do
			create internal_shared
			internal_content := a_content
			internal_docking_manager := a_content.docking_manager
			direction := a_direction
			if a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right then
				width_height := (internal_docking_manager.fixed_area.width * internal_shared.default_docking_width_rate).ceiling
			else
				width_height := (internal_docking_manager.fixed_area.height * internal_shared.default_docking_height_rate).ceiling
			end
			auto_hide_panel := internal_docking_manager.query.auto_hide_panel (a_direction)

			create tab_stub.make (internal_content, a_direction)

			debug ("docking")
				io.put_string ("%N ************************** SD_AUTO_HIDE_STATE: insert tab stubs.")
			end
			tab_stub.pointer_enter_actions.extend (agent show)
			tab_stub.pointer_press_actions.extend (agent show)
			auto_hide_panel.tab_stubs.extend (tab_stub)

			create animation.make (Current, internal_docking_manager)
			last_floating_height := a_content.state.last_floating_height
			last_floating_width := a_content.state.last_floating_width

			initialized := True
		ensure
			set: internal_content = a_content
			set: direction = a_direction
		end

	make_with_size (a_content: SD_CONTENT; a_direction: INTEGER; a_width_height: INTEGER) is
			-- Creation with a size.
		require
			a_content_not_void: a_content /= Void
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		do
			make (a_content, a_direction)
			width_height := max_size_by_zone (a_width_height)
		ensure
			set: width_height = max_size_by_zone (a_width_height)
		end

	make_with_friend (a_content:SD_CONTENT; a_friend: SD_CONTENT) is
			-- Make with `a_friend', so tab together.
		do
			make (a_content, a_friend.state.direction)
			auto_hide_panel.set_tab_with_friend (tab_stub, a_friend)
		end

feature -- Redefine.

	set_focus (a_content: SD_CONTENT) is
			-- Redefine
		do
			show
			if zone /= Void then
				zone.on_focus_in (a_content)
			end
			docking_manager.property.set_last_focus_content (content)
		end

	close is
			-- Redefine
		do
			Precursor {SD_STATE}
			internal_close
		ensure then
			tab_group_pruned: not auto_hide_panel.has (tab_stub)
		end

	stick (a_direction: INTEGER) is
			-- Redefine. `a_direction' is useless. This feature used by SD_DOCKING_STATE and SD_CONTENT.set_auto_hide.
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				internal_docking_manager.command.lock_update (Void, True)
				internal_docking_manager.command.remove_auto_hide_zones (False)
				internal_docking_manager.command.recover_normal_state

				-- Hanlde the case that first call SD_AUTO_HIDE_STATE.hide, then SD_AUTO_HIDE_STATE.stick.
				-- So we should insert the `tab_stub' which removed by `hide'.
				if is_hide then
					auto_hide_panel.tab_stubs.extend (tab_stub)
				end

				stick_zones (a_direction)

				internal_docking_manager.command.remove_empty_split_area
				internal_docking_manager.command.unlock_update
			end
		ensure then
			tab_stubs_pruned: old not is_hide implies auto_hide_panel.tab_stubs.count < old auto_hide_panel.tab_stubs.count
		rescue
			internal_docking_manager.command.unlock_update
			l_retried := True
			retry
		end

 	change_title (a_title: STRING_GENERAL; a_content: SD_CONTENT) is
			-- Redefine
		do
			tab_stub.set_text (a_title)
		ensure then
			set: tab_stub.text = a_title
		end

	change_pixmap (a_pixmap: EV_PIXMAP; a_content: SD_CONTENT) is
			-- Redefine
		do
			tab_stub.on_expose (0, 0, tab_stub.width, tab_stub.height)
		end

	restore (a_data: SD_INNER_CONTAINER_DATA; a_container: EV_CONTAINER) is
			-- Redefine.
		do
			-- This class can created by make (not like SD_DOCKING_STATE, created by INTERNAL), so this routine do less work.
			change_state (Current)
			direction := a_data.direction
			Precursor {SD_STATE} (a_data, a_container)
			initialized := True
		end

	record_state is
			-- Redefine.
		do
			if direction = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right then
				width_height := zone.width
			else
				width_height := zone.height
			end
			animation.remove_moving_timer (False)
			animation.remove_close_timer

		ensure then
			-- This contract cannot write on GTK.
			-- Because the width/height is changed immediately
--			width_height_set: direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right
--				implies width_height = zone.width
--			width_height_set: direction = {SD_DOCKING_MANAGER}.dock_top or direction = {SD_DOCKING_MANAGER}.dock_bottom
--				implies width_height = zone.height
		end

	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- Redefine.
			-- It's completely same as SD_STATE_VOID, merge?
		local
			l_docking_state: SD_DOCKING_STATE
		do
			internal_docking_manager.command.lock_update (Void, True)
			if direction = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right then
				create l_docking_state.make (internal_content, direction, (internal_docking_manager.query.container_rectangle.width * internal_shared.default_docking_width_rate).ceiling)
			else
				create l_docking_state.make (internal_content, direction, (internal_docking_manager.query.container_rectangle.height * internal_shared.default_docking_height_rate).ceiling)
			end
			l_docking_state.dock_at_top_level (a_multi_dock_area)
			change_state (l_docking_state)

			internal_close
			internal_docking_manager.command.unlock_update
		ensure then
			state_changed: internal_content.state /= Current
		end

	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER) is
			-- Redefine.
		local
			l_docking_state: SD_DOCKING_STATE
		do
			content.set_visible (True)
			internal_docking_manager.command.lock_update (a_target_zone, False)
			create l_docking_state.make (internal_content, a_direction, 0)
			l_docking_state.change_zone_split_area (a_target_zone, a_direction)
			change_state (l_docking_state)

			internal_close
			internal_docking_manager.command.unlock_update
		ensure then
			state_changed: internal_content.state /= Current
		end

	show is
			-- Redefine.
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				internal_docking_manager.command.lock_update (Void, True)
				if is_hide then
					auto_hide_panel.tab_stubs.extend (tab_stub)
				end
				animation.show (True)
				content.show_actions.call (Void)
				internal_docking_manager.command.unlock_update
			end
		ensure then
			show: internal_docking_manager.zones.has_zone_by_content (internal_content)
		rescue
			internal_docking_manager.command.unlock_update
			l_retried := True
			retry
		end

	hide is
			-- Redefine.
		local
			l_state: SD_STATE_VOID
			l_tab_group: ARRAYED_LIST [SD_TAB_STUB]
		do
			if not is_hide then
				internal_docking_manager.command.remove_auto_hide_zones (False)
				-- Change to SD_STATE_VOID.... wait for user call show.... then back to special state.
				create l_state.make (internal_content)
				l_tab_group := auto_hide_panel.tab_group (tab_stub)
				internal_close
				l_tab_group.prune (tab_stub)
				if l_tab_group.count >= 1 then
					l_state.set_relative (auto_hide_panel.content_by_tab (l_tab_group.last))
					change_state (l_state)
				end
			end
		end

	set_user_widget (a_widget: EV_WIDGET) is
			-- Redefine
		do
			if zone /= Void then
				zone.window.set_user_widget (a_widget)
			end
		end

feature -- Command

	close_animation is
			-- Close with animation
		do
			animation.close_animation
		end

feature -- Query

	is_hide: BOOLEAN is
			-- If current Hide?
		do
			Result := not auto_hide_panel.tab_stubs.has (tab_stub)
		end

	is_width_height_valid (a_width_height: INTEGER): BOOLEAN is
			-- If a_width_height valid?
		do
			if direction  = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right then
				Result := a_width_height <= (internal_docking_manager.fixed_area.width * 0.8).ceiling
			else
				Result := a_width_height <= (internal_docking_manager.fixed_area.height * 0.8).ceiling
			end
		end

feature {NONE} -- Implementation functions.

	stick_zones (a_direction: INTEGER) is
			-- Stick zones which should together with current zone.
		require
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		local
			l_docking_state: SD_DOCKING_STATE
			l_tab_state: SD_TAB_STATE
			l_tab_group: ARRAYED_LIST [SD_TAB_STUB]
			l_tab_stub: SD_TAB_STUB
			l_content: SD_CONTENT

			l_last_tab_zone: SD_TAB_ZONE
		do
			l_tab_group := auto_hide_panel.tab_group (tab_stub)
			from
				l_tab_group.start
			until
				l_tab_group.after
			loop
				l_tab_stub := l_tab_group.item
				auto_hide_panel.tab_stubs.start
				auto_hide_panel.tab_stubs.prune (l_tab_stub)

				l_content := l_tab_stub.content
				if l_tab_group.index = 1 then
					create l_docking_state.make (l_content, direction, width_height)
					l_docking_state.dock_at_top_level (internal_docking_manager.query.inner_container_main)
					l_content.state.change_state (l_docking_state)
				else
					if l_content.user_widget.parent /= Void then
						l_content.user_widget.parent.prune (l_content.user_widget)
					end
					if l_last_tab_zone = Void then
						create l_tab_state.make (l_content, l_docking_state.zone, direction)
						l_tab_state.set_width_height (width_height)
						l_tab_state.set_direction (l_docking_state.direction)
					else
						create l_tab_state.make_with_tab_zone (l_content, l_last_tab_zone, direction)
						l_tab_state.set_width_height (width_height)
						l_tab_state.set_direction (l_last_tab_zone.state.direction)
					end

					l_last_tab_zone := l_tab_state.zone
					l_content.change_state (l_tab_state)
				end

				l_tab_group.forth
			end
			if l_tab_group.count > 1 then
				l_tab_state.select_tab (internal_content, True)
			end
			auto_hide_panel.tab_groups.start
			auto_hide_panel.tab_groups.prune (l_tab_group)
		ensure
			state_changed: content.state /= Current
		end

	internal_close is
			-- Prune internal widgets.
		do
 			animation.remove_close_timer

			-- Remove tab stub from the SD_AUTO_HIDE_PANEL
			auto_hide_panel.tab_stubs.start
			auto_hide_panel.tab_stubs.prune (tab_stub)
		end

	move_to_docking_zone (a_target_zone: SD_DOCKING_ZONE; a_first: BOOLEAN) is
			-- Redefine
			-- FIXIT: It's similiar to SD_DOCKING_STATE move_to_docking_zone, merge?
		do
			move_to_zone_internal (a_target_zone, a_first)
		end

	move_to_tab_zone (a_target_zone: SD_TAB_ZONE; a_index: INTEGER_32) is
			-- Redefine
			-- FIXIT: It's similiar to SD_DOCKING_STATE move_to_tab_zone, merge?
		do
			if a_index = 1 then
				move_to_zone_internal (a_target_zone, True)
			else
				move_to_zone_internal (a_target_zone, False)
			end

			if a_index > 0 and a_index <= a_target_zone.contents.count then
				a_target_zone.set_content_position (content, a_index)
			end
		end

	move_to_zone_internal (a_target_zone: SD_ZONE; a_first: BOOLEAN) is
			-- Move to `a_target_zone'
		local
			l_tab_state: SD_TAB_STATE
			l_orignal_direction: INTEGER
			l_docking_zone: SD_DOCKING_ZONE
			l_tab_zone: SD_TAB_ZONE
		do
			if zone /= Void and then not zone.is_destroyed then
				internal_docking_manager.command.lock_update (zone, False)
			else
				internal_docking_manager.command.lock_update (void, True)
			end

			internal_close
			internal_docking_manager.zones.prune_zone_by_content (internal_content)

			l_orignal_direction := a_target_zone.state.direction
			l_docking_zone ?= a_target_zone
			l_tab_zone ?= a_target_zone
			if l_docking_zone /= Void then
				create l_tab_state.make (internal_content, l_docking_zone, l_orignal_direction)
			else
				check only_allow_two_type_zone: l_tab_zone /= Void end
				create l_tab_state.make_with_tab_zone (internal_content, l_tab_zone, l_orignal_direction)
			end
			if a_first then
				l_tab_state.zone.set_content_position (internal_content, 1)
			end
			l_tab_state.set_direction (l_orignal_direction)
			internal_docking_manager.command.remove_empty_split_area
			change_state (l_tab_state)
			internal_docking_manager.command.update_title_bar
			internal_docking_manager.command.unlock_update
		end

feature {SD_AUTO_HIDE_ANIMATION} -- Internal issues.

	max_size_by_zone (a_width_height: INTEGER): INTEGER is
			-- Caculate max size
		require
			valid: a_width_height >= 0
		do
			if direction  = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right then
				if (a_width_height <= (internal_docking_manager.fixed_area.width * 0.8).ceiling) then
					Result := a_width_height
				else
					Result := (internal_docking_manager.fixed_area.width * 0.8).ceiling
				end
			else
				if (a_width_height <= (internal_docking_manager.fixed_area.height * 0.8).ceiling) then
					Result := a_width_height
				else
					Result := (internal_docking_manager.fixed_area.height * 0.8).ceiling
				end
			end
		ensure
			valid: is_width_height_valid (Result)
		end

	set_zone (a_zone: SD_AUTO_HIDE_ZONE) is
			-- Set `zone'
		require
			not_void: a_zone /= Void
		do
			zone := a_zone
		ensure
			set: zone = a_zone
		end

	zone: SD_AUTO_HIDE_ZONE
			-- Zone which current is in.

	auto_hide_panel: SD_AUTO_HIDE_PANEL
			-- Auto hide panel which current is in.

	tab_stub: SD_TAB_STUB
			-- Tab stub related to `internal_content'.	

feature {SD_DOCKING_MANAGER_AGENTS} -- Implemation

	animation: SD_AUTO_HIDE_ANIMATION
			-- Animation helper.

invariant

	internal_content_not_void: initialized implies internal_content /= Void
	internal_shared_not_void: initialized implies internal_shared /= Void
	tab_stub_not_void: initialized implies tab_stub /= Void
	auto_hide_panel_not_void: initialized implies auto_hide_panel /= Void
	animation_not_void: initialized implies animation /= Void
	direction_valid: initialized implies direction = {SD_ENUMERATION}.top or direction = {SD_ENUMERATION}.bottom
		or direction = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end
