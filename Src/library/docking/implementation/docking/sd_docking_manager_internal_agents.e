indexing
	description: "Objects help SD_DOCKING_MANAGER with agents issues."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_MANAGER_AGENTS

create
	make

feature {NONE}  -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			internal_docking_manager := a_docking_manager
			internal_docking_manager.main_window.focus_out_actions.extend (agent on_main_window_focus_out)
			internal_docking_manager.main_window.focus_in_actions.extend (agent on_main_window_focus_in)
		ensure
			set: internal_docking_manager = a_docking_manager
		end

feature  -- Agents

--	on_widget_pointer_press (a_widget: EV_WIDGET) is
	on_widget_pointer_press (a_widget: EV_WIDGET; a_button, a_x, a_y: INTEGER) is
			-- Handle EV_APPLICATION's pointer button press actions.
		local
			l_auto_hide_zone: SD_AUTO_HIDE_ZONE
			l_zones: ARRAYED_LIST [SD_ZONE]
		do

			l_zones := internal_docking_manager.zones.zones.twin
			from
				l_zones.start
			until
				l_zones.after
			loop
				if l_zones.item.has_recursive (a_widget) then
					if internal_docking_manager.property.last_focus_content /= l_zones.item.content then
						internal_docking_manager.property.set_last_focus_content (l_zones.item.content)
						l_zones.item.on_focus_in (Void)
						if l_zones.item.content.focus_in_actions /= Void then
							l_zones.item.content.focus_in_actions.call ([])
						end
					else
						l_auto_hide_zone ?= internal_docking_manager.property.last_focus_content.state.zone
						if l_auto_hide_zone = Void then
							internal_docking_manager.command.remove_auto_hide_zones (True)
						else
							l_auto_hide_zone.set_title_bar_selection_color (True)
						end
					end
				end
				l_zones.forth
			end
		end

	on_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle resize zone event. Resize all the widgets in fixed_area (EV_FIXED).
		do
			debug ("docking")
				io.put_string ("%N SD_DOCKING_MANAGER on_resize ~~~~~~~~~~~~~~~~~~~~")
			end
			internal_docking_manager.command.remove_auto_hide_zones (False)
			internal_docking_manager.menu_container.set_minimum_size (0, 0)
			internal_docking_manager.fixed_area.set_minimum_size (0, 0)
			internal_docking_manager.query.inner_container_main.set_minimum_size (0, 0)
			if a_width > 0 then
				internal_docking_manager.internal_viewport.set_item_width (a_width)
				internal_docking_manager.fixed_area.set_item_width (internal_docking_manager.query.inner_container_main , internal_docking_manager.fixed_area.width)
			end
			if a_height > 0 then
				internal_docking_manager.internal_viewport.set_item_height (a_height)
				internal_docking_manager.fixed_area.set_item_height (internal_docking_manager.query.inner_container_main, internal_docking_manager.fixed_area.height)
			end
		end

	on_added_zone (a_zone: SD_ZONE) is
			-- Handle inserted a zone event.
		do
		end

	on_pruned_zone (a_zone: SD_ZONE) is
			-- Handle pruned a zone event.
		require
			a_zone_not_void: a_zone /= Void
		local
			l_floating_zone: SD_FLOATING_ZONE
		do
			l_floating_zone ?= a_zone
			if l_floating_zone /= Void then
				l_floating_zone.destroy
			end
		end

	on_added_content (a_content: SD_CONTENT) is
			--  Handle added a content to contents.
		require
			a_content_widget_valid: user_widget_valid (a_content)
			title_unique: title_unique (a_content)
		do
			a_content.set_docking_manager (internal_docking_manager)
		ensure
			set: a_content.docking_manager = internal_docking_manager
		end

	on_main_window_focus_out is
			-- Handle window lost focus event.
		local
			l_content: SD_CONTENT
			l_zone: SD_ZONE
		do
			l_content := internal_docking_manager.property.last_focus_content
			l_zone := internal_docking_manager.zones.zone_by_content (l_content)
			if internal_docking_manager.main_container.has_recursive (l_zone) then
				l_zone.set_non_focus_selection_color
			end
			debug ("docking")
				print ("%NSD_DOCKING_MANAGER_AGENTS on_main_window_focus_out ")
			end
		end

	on_main_window_focus_in is
			-- Handle window get focus event.
		local
			l_content: SD_CONTENT
			l_zone: SD_ZONE
		do
			l_content := internal_docking_manager.property.last_focus_content
			l_zone := internal_docking_manager.zones.zone_by_content (l_content)
			if internal_docking_manager.main_container.has_recursive (l_zone) then
				l_zone.set_title_bar_selection_color (True)
			end
			debug ("docking")
				print ("%NSD_DOCKING_MANAGER_AGENTS on_main_window_focus_in ")
			end
		end

feature -- Contract support

	user_widget_valid (a_content: SD_CONTENT): BOOLEAN is
			-- Dose a_widget alreay in docking library?
		local
			l_container: EV_CONTAINER
			l_found: BOOLEAN
			l_contents: ARRAYED_LIST [SD_CONTENT]
		do
			l_contents := internal_docking_manager.contents.twin
			l_contents.start
			l_contents.prune (a_content)

			from
				l_contents.start
			until
				l_contents.after or l_found
			loop
				l_container ?= l_contents.item.user_widget
				if l_container /= Void then
					if l_container.has_recursive (a_content.user_widget) then
						l_found := True
					end
				end

				if a_content.user_widget = l_contents.item.user_widget then
					l_found := True
				end

				l_contents.forth
			end
			Result := not l_found
		end

	title_unique (a_content: SD_CONTENT): BOOLEAN is
			-- If `a_unique_title' really unique?
		require
			a_content_not_void: a_content /= Void
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
		do
			l_contents := internal_docking_manager.contents.twin
			l_contents.start
			l_contents.prune (a_content)
			Result := True

			from
				l_contents.start
			until
				l_contents.after or not Result
			loop
				Result := not l_contents.item.unique_title.is_equal (a_content.unique_title)
				l_contents.forth
			end
		end

feature {SD_DEBUG_WINDOW} -- For debug.

	show_inner_container_structure is
			-- For debug.
		do
			io.put_string ("%N --------------------- SD_DOCKING_MANAGER inner container -------------------")
			internal_docking_manager.inner_containers.start
			show_inner_container_structure_imp (internal_docking_manager.inner_containers.item.item, " ")
		end

	show_inner_container_structure_imp (a_container: EV_WIDGET; a_indent: STRING) is
			-- For debug.
		local
			l_split_area: EV_SPLIT_AREA
			l_docking_zone: SD_DOCKING_ZONE
		do
			l_docking_zone ?= a_container
			if l_docking_zone /= Void then
				io.put_string ("%N " + a_indent + a_container.generating_type + " " + l_docking_zone.content.unique_title)
			else
				if a_container /= Void then
					io.put_string ("%N " + a_indent + a_container.generating_type)
				else
					io.put_string ("%N " + a_indent + "Void")
				end
			end
			l_split_area ?= a_container
			if l_split_area /= Void then
				show_inner_container_structure_imp (l_split_area.first, a_indent + " ")
				show_inner_container_structure_imp (l_split_area.second, a_indent + " ")
			end
		end

feature {NONE}  -- Implementation

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current associate with.

invariant
	invariant_clause: True -- Your invariant here

end
