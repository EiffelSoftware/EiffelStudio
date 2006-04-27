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
			hide,
			set_focus,
			record_state
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
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		do
			create internal_shared
			internal_content := a_content
			internal_docking_manager := a_content.docking_manager
			direction := a_direction
			if a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right then
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
			auto_hide_panel.tab_stubs.extend (tab_stub)

			create internal_animation.make (Current, internal_docking_manager)
			last_floating_height := a_content.state.last_floating_height
			last_floating_width := a_content.state.last_floating_width
		ensure
			set: internal_content = a_content
			set: direction = a_direction
		end

	make_with_size (a_content: SD_CONTENT; a_direction: INTEGER; a_width_height: INTEGER) is
			-- Creation with a size.
		require
			a_content_not_void: a_content /= Void
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
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
			Precursor {SD_STATE} (a_content)
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
			-- Redefine. `a_direction' is useless, it's only used for SD_DOCKING_STATE.
		do
			internal_docking_manager.command.lock_update (Void, True)
			internal_docking_manager.command.remove_auto_hide_zones (False)
			internal_docking_manager.command.recover_normal_state

			stick_zones (a_direction)

			internal_docking_manager.command.remove_empty_split_area
			internal_docking_manager.command.unlock_update
		ensure then
			tab_stubs_pruned: auto_hide_panel.tab_stubs.count < old auto_hide_panel.tab_stubs.count
		end

 	change_title (a_title: STRING; a_content: SD_CONTENT) is
			-- Redefine
		do
			tab_stub.set_text (a_title)
		ensure then
			set: tab_stub.text = a_title
		end

	restore (titles: ARRAYED_LIST [STRING]; a_container: EV_CONTAINER; a_direction: INTEGER) is
			-- Redefine.
		do
			-- This class can created by make (not like SD_DOCKING_STATE, created by INTERNAL), so this routine do less work.
			change_state (Current)
			direction := a_direction
		end

	record_state is
			-- Redefine.
		do
			if direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right then
				width_height := zone.width
			else
				width_height := zone.height
			end
			internal_animation.remove_moving_timer (False)
			internal_animation.remove_close_timer

		ensure then
			width_height_set: direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right
				implies width_height = zone.width
			width_height_set: direction = {SD_DOCKING_MANAGER}.dock_top or direction = {SD_DOCKING_MANAGER}.dock_bottom
				implies width_height = zone.height
		end

	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- Redefine.
		do
		end

	show is
			-- Redefine.
		do
			internal_docking_manager.command.lock_update (Void, True)
			if is_hide then
				auto_hide_panel.tab_stubs.extend (tab_stub)
			end
			internal_animation.show (True)
			internal_docking_manager.command.unlock_update
		ensure then
			show: internal_docking_manager.zones.has_zone_by_content (internal_content)
		end

	hide is
			-- Redefine.
		local
			l_state: SD_STATE_VOID
			l_tab_group: ARRAYED_LIST [SD_TAB_STUB]
		do
			if not is_hide then
				internal_docking_manager.command.remove_auto_hide_zones (False)
				-- Change to SD_STATE_VOID.... wait for user call show.... then back to speciall state.
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

feature -- Command

	close_animation is
			-- Close with animation
		do
			internal_animation.close_animation
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
			if direction  = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right then
				Result := a_width_height <= (internal_docking_manager.fixed_area.width * 0.8).ceiling
			else
				Result := a_width_height <= (internal_docking_manager.fixed_area.height * 0.8).ceiling
			end
		end

feature {NONE} -- Implementation functions.

	stick_zones (a_direction: INTEGER) is
			-- Stick zones which should together with current zone.
		require
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
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
 			internal_animation.remove_close_timer

			-- Remove tab stub from the SD_AUTO_HIDE_PANEL
			auto_hide_panel.tab_stubs.start
			auto_hide_panel.tab_stubs.prune (tab_stub)
		end

feature {SD_AUTO_HIDE_ANIMATION} -- Internal issues.

	max_size_by_zone (a_width_height: INTEGER): INTEGER is
			-- Caculate max size
		require
			valid: a_width_height >= 0
		do
			if direction  = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right then
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

feature {NONE} -- Implemation

	internal_animation: SD_AUTO_HIDE_ANIMATION
			-- Animation helper.

invariant

	not_void: internal_content /= Void
	not_void: internal_shared /= Void
	not_void: tab_stub /= Void
	not_void: auto_hide_panel /= Void
	not_void: internal_animation /= Void
	direction_valid: direction = {SD_DOCKING_MANAGER}.dock_top or direction = {SD_DOCKING_MANAGER}.dock_bottom
		or direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right

indexing
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
