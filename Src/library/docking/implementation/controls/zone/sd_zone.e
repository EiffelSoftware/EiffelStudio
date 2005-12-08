indexing
	description: "Objects that used to hold SD_CONTENT's user widgets."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_ZONE

inherit
	EV_CONTAINER
		rename
			extend as extend_widget,
			has as has_widget,
			implementation as implementation_container
		undefine
			extend_widget,
			copy,
			is_equal,
			put,
			item,
			prune_all,
			replace,
			is_in_default_state,
			cl_extend,
			cl_put,
			fill
		end

feature -- Command

	on_normal_max_window is
			-- Normal or max `Current'.
		local
			l_split_area: EV_SPLIT_AREA
		do
			internal_docking_manager.lock_update
			main_area := internal_docking_manager.inner_container (Current)
			if not is_maximized then
				main_area_widget := main_area.item
				internal_parent := parent
				l_split_area ?= internal_parent
				if l_split_area /= Void then
					internal_parent_split_position := l_split_area.split_position
				end
				internal_parent.prune (Current)
				main_area.wipe_out
				main_area.extend (Current)
				set_max (True)
			else
				recover_to_normal_state
			end
			internal_docking_manager.unlock_update
		end

	close is
			-- Close window.
		do
			internal_docking_manager.lock_update
			if is_maximized then
				main_area.wipe_out
				main_area.extend (main_area_widget)
				main_area := Void
			end

			internal_docking_manager.unlock_update
		end

	recover_to_normal_state is
			-- If Current maximized, then normal Current.
		local
			l_split_area: EV_SPLIT_AREA
		do
			if is_maximized then
				internal_docking_manager.lock_update
				main_area.wipe_out
				internal_parent.extend (Current)
				main_area.extend (main_area_widget)
				main_area := Void

				l_split_area ?= internal_parent
				if l_split_area /= Void then
					l_split_area.set_split_position (internal_parent_split_position)
				end
				main_area_widget := Void
				internal_parent := Void
				set_max (False)
				internal_docking_manager.unlock_update
			end
		end

	set_max (a_max: BOOLEAN) is
			-- Set if current is maximized.
		do
		end
	
	set_title_bar_focus_color (a_focus: BOOLEAN) is
			-- Set title bar focuse color.
		do	
		end
		
feature -- Query

	state: SD_STATE is
			-- State which `Current' is.
		do
			Result := content.state
		ensure
			not_void: Result /= Void
		end

	content: SD_CONTENT is
			-- Content which `Current' holded.
		deferred
		ensure
			not_void: Result /= Void
		end

	extend (a_content: SD_CONTENT) is
			-- Set `a_content'.
		require
			a_content_not_void: a_content /= Void
		deferred
		end

	type: INTEGER is
			-- type.
		do
			Result := content.type
		end

	has (a_content: SD_CONTENT): BOOLEAN is
			-- `Current' has `a_content'?
		require
			a_content_not_void: a_content /= Void
		deferred
		end

	is_maximized: BOOLEAN is
			-- If current maximized?
		do
			Result := False
		end

feature {SD_CONFIG_MEDIATOR} -- Save config.

	save_content_title (a_config_data: SD_INNER_CONTAINER_DATA) is
			-- save content(s) title(s) to `a_config_data'.
		require
			a_config_data_not_void: a_config_data /= Void
		deferred
		end

feature {SD_DOCKING_MANAGER} -- Focus out

	on_focus_out is
			-- Handle focus out.
		local
			l_multi_dock_area: SD_MULTI_DOCK_AREA
		do
			l_multi_dock_area := internal_docking_manager.inner_container (Current)
			if not internal_docking_manager.is_main_inner_container (l_multi_dock_area) then
				l_multi_dock_area.parent_floating_zone.set_title_focus (False)
			end
			content.focus_out_actions.call ([])
		end

feature {SD_DOCKING_MANAGER, SD_CONTENT}  -- Focus in

	on_focus_in (a_content: SD_CONTENT) is
			-- Handle focus in.
		require
			has: a_content /= Void implies has (a_content)
		local
			l_multi_dock_area: SD_MULTI_DOCK_AREA
		do
			internal_docking_manager.disable_all_zones_focus_color
			l_multi_dock_area := internal_docking_manager.inner_container (Current)
			if not internal_docking_manager.is_main_inner_container (l_multi_dock_area) then
				l_multi_dock_area.parent_floating_zone.set_title_focus (True)
			end
		end

feature {SD_TAB_STATE} -- Maximum issues.

	main_area_widget: EV_WIDGET
			-- Other user widgets when `Current' is maximized.

	main_area: SD_MULTI_DOCK_AREA
			-- SD_MULTI_DOCK_AREA current zone belong to.

	internal_parent_split_position: INTEGER
			-- Parent split position.

	internal_parent: EV_CONTAINER
			-- Parent.

feature {NONE} -- Implementation

	on_close_request is
			-- Handle close request actions.
		do
			content.close_request_actions.call ([])
		end
		
	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.
					
	internal_shared: SD_SHARED
			-- All singletons.

feature {SD_HOT_ZONE} -- Redraw

	invalidate is
			-- Redraw current.
		local

		do

		end

invariant

	internal_shared_not_void: internal_shared /= Void

end
