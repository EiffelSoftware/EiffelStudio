note
	description: "Manager that help docking manager manage all zones."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_MANAGER_ZONES

inherit
	SD_ACCESS

	SD_DOCKING_MANAGER_HOLDER

	EV_BUILDER

create
	make

feature {NONE}  -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER)
			-- Associate new object with `a_docking_manager'.
		do
			docking_manager := a_docking_manager
			create zones
			create place_holder_widget
			create place_holder_content.make_placeholder_with_original_widget
				(place_holder_widget, {SD_SHARED}.Editor_place_holder_content_name, a_docking_manager)
		end

feature -- Zones managements

	zones: ACTIVE_LIST [SD_ZONE]
			-- All SD_ZONE in current system.

	maximized_zones: ARRAYED_LIST [SD_ZONE]
			-- Maximized zone, maybe void if not exists.
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
		do
			from
				create Result.make (1)
				l_zones := docking_manager.zones.zones
				l_zones.start
			until
				l_zones.after
			loop
				if l_zones.item.is_maximized then
					Result.extend (l_zones.item)
				end
				l_zones.forth
			end
		ensure
			not_void: Result /= Void
		end

	maximized_zone_in_main_window: detachable SD_ZONE
			-- Maximized zone in main window
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
			l_main_area: SD_MULTI_DOCK_AREA
		do
			from
				l_main_area := docking_manager.query.inner_container_main
				l_zones := docking_manager.zones.zones
				l_zones.start
			until
				l_zones.after or Result /= Void
			loop
				if l_zones.item.is_maximized then
					if attached {EV_WIDGET} l_zones.item as lt_widget then
						if l_main_area.has_recursive (lt_widget) then
							Result := l_zones.item
						end
					else
						check not_possible: False end
					end
				end
				l_zones.forth
			end
		end

	upper_zones: ARRAYED_LIST [SD_UPPER_ZONE]
			-- ALl upper zones existing.
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
		do
			from
				l_zones := zones
				create Result.make (l_zones.count)
				l_zones.start
			until
				l_zones.after
			loop
				if attached {SD_UPPER_ZONE} l_zones.item as l_upper_zone then
					Result.extend (l_upper_zone)
				end
				l_zones.forth
			end
		ensure
			not_void: Result /= Void
		end

	zone_by_content (a_content: SD_CONTENT): detachable SD_ZONE
			-- If main container has zone with a_content?
		do
			from
				zones.start
			until
				zones.after or
				Result /= Void
			loop
				Result := zones.item
				if not Result.has_content or else Result.content /= a_content then
					Result := Void
				end
				zones.forth
			end
		end

	contents_in_same_zone (a_content: SD_CONTENT): detachable ARRAYED_LIST [SD_CONTENT]
			-- Get all contents in same zone
			-- Result maybe void if not appliable
		require
			not_void: a_content /= Void
		do
			if attached zone_by_content (a_content) as l_zone then
				if attached {SD_MULTI_CONTENT_ZONE} l_zone as l_multi_zone then
					Result := l_multi_zone.contents
				elseif attached {SD_SINGLE_CONTENT_ZONE} l_zone as l_single_zone then
					create Result.make (1)
					Result.extend (l_single_zone.content)
				end
			end
		ensure
			valid: (attached Result as le_result) implies le_result.has (a_content)
		end

	has_zone (a_zone: SD_ZONE): BOOLEAN
			-- If the main container has zone?
		do
			Result := zones.has (a_zone)
		end

	has_zone_by_content (a_content: SD_CONTENT): BOOLEAN
			-- If the main container has zone with a_content?
		do
			from
				zones.start
			until
				zones.after or Result
			loop
				Result := zones.item.has (a_content)
				zones.forth
			end
		end

	zone_parent_void (a_zone: SD_ZONE): BOOLEAN
			-- Contract support
		require
			a_zone_not_void: a_zone /= Void
		do
			if attached {SD_FLOATING_ZONE} a_zone as l_floating_zone then
				-- Allow a SD_FLOATING_ZONE parent void
				Result := False
			else
				if attached {EV_WIDGET} a_zone as l_widget then
					Result := l_widget.parent = Void
				else
					check not_possible: False end -- Implied by basic design of {SD_ZONE}
				end
			end
		end

	add_zone (a_zone: SD_ZONE)
			-- Add a zone to show.
		require
			a_zone_not_void: a_zone /= Void
		do
			docking_manager.command.remove_auto_hide_zones (False)
			zones.extend (a_zone)
		ensure
			extended: zones.has (a_zone)
		end

	prune_zone (a_zone: SD_ZONE)
			-- Prune a zone which was managed by docking manager.
		require
			a_zone_not_void: a_zone /= Void
		local
			l_has_child: BOOLEAN
		do
			if
				attached {EV_CONTAINER} a_zone as l_container and then
					-- Maybe we are moving from {SD_AUTO_HIDE_STATE} to {SD_DOCKING_STATE}
					-- {SD_CONTENT}.user_widget's parent already changed, no need to prune later
				a_zone.has_content
			then
				l_has_child := l_container.has_recursive (a_zone.content.user_widget)
			end

			if attached {EV_WIDGET} a_zone as lt_widget then
				if attached lt_widget.parent as l_parent then
					l_parent.prune (lt_widget)
				end
			else
				check not_possible: False end
			end

				-- FIXME: call prune_all from ACTIVE_LIST contract broken?
			zones.start
			zones.prune (a_zone)

			if
				l_has_child and then
				a_zone.has_content and then
				attached a_zone.content.user_widget.parent as l_parent
			then
				l_parent.prune (a_zone.content.user_widget)
			end
		ensure
			a_zone_pruned: not zones.has (a_zone)
		end

	prune_zone_by_content (a_content: SD_CONTENT)
			-- Prune a zone which contain a_content.
		require
			has_content: has_content (a_content)
		local
			l_zones: like zones
			l_zone: SD_ZONE
			l_pruned: BOOLEAN
		do
			from
				l_zones := zones
				l_zones.start
			until
				l_zones.after or l_pruned
			loop
				l_zone := l_zones.item
				if
					l_zone.has_content and then
					l_zone.content = a_content
				then
						-- `zones` is modified by the next call.
					prune_zone (l_zone)
					l_pruned := True
				else
						-- It is safe to advance only when `zones` is not modified.
					l_zones.forth
				end
			end
		end

	set_zone_size (a_zone: SD_ZONE; a_width, a_height: INTEGER)
			-- Set a zone size.
		require
			has_zone: has_zone (a_zone)
		local
			l_width, l_height: INTEGER
		do
			l_width := a_width
			l_height := a_height
			if attached {SD_AUTO_HIDE_ZONE} a_zone as l_auto_hide_zone then
				if l_auto_hide_zone.minimum_height_set_by_user then
					if l_height < l_auto_hide_zone.minimum_height then
						l_height := l_auto_hide_zone.minimum_height
					end
				else
					l_auto_hide_zone.reset_minimum_height
				end
				if l_auto_hide_zone.minimum_width_set_by_user then
					if l_width < l_auto_hide_zone.minimum_width then
						l_width := l_auto_hide_zone.minimum_width
					end
				else
					l_auto_hide_zone.reset_minimum_width
				end
				l_auto_hide_zone.reset_minimum_size
				docking_manager.fixed_area.set_item_size (l_auto_hide_zone, l_width, l_height)
			end
		ensure
			set: attached {EV_WIDGET} a_zone as lt_widget implies lt_widget.width = a_width and lt_widget.height = a_height
		end

	disable_all_zones_focus_color (a_except: SD_ZONE)
			-- Disable all zones focus color except `a_except'.
		do
			from
				zones.start
			until
				zones.after
			loop
				if a_except /= zones.item then
					zones.item.on_focus_out
				end
				zones.forth
			end
		end

feature -- Query

	place_holder_content: SD_CONTENT
			-- Editor place holder zone content. One instance per docking manager.

	place_holder_widget: EV_CELL
			-- Widget in `place_holder_content'

feature -- Contract support

	has_content (a_content: SD_CONTENT): BOOLEAN
			-- If `docking_manager' has `a_content'?
		do
			Result := docking_manager.has_content (a_content)
		end

invariant
	not_void: zones /= Void
	not_void: place_holder_content /= Void
	not_void: place_holder_widget /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
