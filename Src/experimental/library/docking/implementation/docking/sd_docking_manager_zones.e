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
		redefine
			set_docking_manager
		end

create
	make

feature {NONE}  -- Initlization

	make
			-- Creation method
		do
			create zones
			init_place_holder
		end

	init_place_holder
			-- Init `place_holder_content'
		local
			l_shared: SD_SHARED
		do
			create l_shared
			create place_holder_widget
			create place_holder_content.make_with_widget (place_holder_widget, l_shared.Editor_place_holder_content_name)
			place_holder_content.set_type ({SD_ENUMERATION}.place_holder)
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
				if Result.content /= a_content then
					Result := Void
				end
				zones.forth
			end
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
		do
			if attached {EV_WIDGET} a_zone as lt_widget then
				if attached lt_widget.parent as l_parent then
					l_parent.prune (lt_widget)
				end
			else
				check not_possible: False end
			end

			-- FIXIT: call prune_all from ACTIVE_LIST contract broken?
			zones.start
			zones.prune (a_zone)

			if attached {EV_CONTAINER} a_zone.content.user_widget.parent as l_parent then
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
			l_pruned: BOOLEAN
		do
			from
				zones.start
			until
				zones.after or l_pruned
			loop
				if zones.item.content = a_content then
					prune_zone (zones.item)
					l_pruned := True
				end
				if not l_pruned then
					zones.forth
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
				if l_width < l_auto_hide_zone.minimum_width then
					l_width := l_auto_hide_zone.minimum_width
				end
				if l_height < l_auto_hide_zone.minimum_height then
					l_height := l_auto_hide_zone.minimum_height
				end
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

feature -- Command

	set_docking_manager (a_docking_manager: detachable SD_DOCKING_MANAGER)
			-- <Precursor>
		do
			Precursor {SD_DOCKING_MANAGER_HOLDER} (a_docking_manager)
			place_holder_content.set_docking_manager (docking_manager)
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
