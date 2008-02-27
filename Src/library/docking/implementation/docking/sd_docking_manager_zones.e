indexing
	description: "Manager that help docking manager manage all zones."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_MANAGER_ZONES

inherit
	SD_ACCESS
	
create
	make

feature {NONE}  -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			internal_docking_manager := a_docking_manager
			create zones
			init_place_holder
		ensure
			set: internal_docking_manager = a_docking_manager
		end

	init_place_holder is
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

	maximized_zones: ARRAYED_LIST [SD_ZONE] is
			-- Maximized zone, maybe void if not exists.
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
		do
			from
				create Result.make (1)
				l_zones := internal_docking_manager.zones.zones
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

	maximized_zone_in_main_window: SD_ZONE is
			-- Maximized zone in main window.
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
			l_main_area: SD_MULTI_DOCK_AREA
		do
			from
				l_main_area := internal_docking_manager.query.inner_container_main
				l_zones := internal_docking_manager.zones.zones
				l_zones.start
			until
				l_zones.after or Result /= Void
			loop
				if l_zones.item.is_maximized then
					if l_main_area.has_recursive (l_zones.item) then
						Result := l_zones.item
					end
				end
				l_zones.forth
			end
		end

	upper_zones: ARRAYED_LIST [SD_UPPER_ZONE] is
			-- ALl upper zones existing.
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
			l_upper_zone: SD_UPPER_ZONE
		do
			from
				l_zones := zones
				create Result.make (l_zones.count)
				l_zones.start
			until
				l_zones.after
			loop
				l_upper_zone ?= l_zones.item
				if l_upper_zone /= Void then
					Result.extend (l_upper_zone)
				end
				l_zones.forth
			end
		ensure
			not_void: Result /= Void
		end

	zone_by_content (a_content: SD_CONTENT): SD_ZONE is
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

	has_zone (a_zone: SD_ZONE): BOOLEAN is
			-- If the main container has zone?
		do
			Result := zones.has (a_zone)
		end

	has_zone_by_content (a_content: SD_CONTENT): BOOLEAN is
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

	zone_parent_void (a_zone: SD_ZONE): BOOLEAN is
			-- Contract support
		require
			a_zone_not_void: a_zone /= Void
		local
			l_widget: EV_WIDGET
			l_floating_zone: SD_FLOATING_ZONE
		do
			l_floating_zone ?= a_zone
			if l_floating_zone /= Void then
				-- Allow a SD_FLOATING_ZONE parent void
				Result := False
			else
				l_widget ?= a_zone
				check l_widget /= Void end
				Result := l_widget.parent = Void
			end
		end

	add_zone (a_zone: SD_ZONE) is
			-- Add a zone to show.
		require
			a_zone_not_void: a_zone /= Void
		do
			internal_docking_manager.command.remove_auto_hide_zones (False)
			zones.extend (a_zone)
		ensure
			extended: zones.has (a_zone)
		end

	prune_zone (a_zone: SD_ZONE) is
			-- Prune a zone which was managed by docking manager.
		require
			a_zone_not_void: a_zone /= Void
		local
			l_parent: EV_CONTAINER
		do
			if a_zone.parent /= Void then
				a_zone.parent.prune (a_zone)
			end
			-- FIXIT: call prune_all from ACTIVE_LIST contract broken?
			zones.start
			zones.prune (a_zone)

			l_parent := a_zone.content.user_widget.parent
			if l_parent /= Void then
				l_parent.prune (a_zone.content.user_widget)
			end
		ensure
			a_zone_pruned: not zones.has (a_zone)
		end

	prune_zone_by_content (a_content: SD_CONTENT) is
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

	set_zone_size (a_zone: SD_ZONE; a_width, a_height: INTEGER) is
			-- Set a zone size.
		require
			has_zone: has_zone (a_zone)
		local
			l_auto_hide_zone: SD_AUTO_HIDE_ZONE
			l_width, l_height: INTEGER
		do
			l_width := a_width
			l_height := a_height
			l_auto_hide_zone ?= a_zone
			if l_auto_hide_zone /= Void then
				if l_width < a_zone.minimum_width then
					l_width := a_zone.minimum_width
				end
				if l_height < a_zone.minimum_height then
					l_height := a_zone.minimum_height
				end
				internal_docking_manager.fixed_area.set_item_size (l_auto_hide_zone, l_width, l_height)
			end
		ensure
			set: a_zone.width = a_width and a_zone.height =  a_height
		end

	disable_all_zones_focus_color (a_except: SD_ZONE) is
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

	has_content (a_content: SD_CONTENT): BOOLEAN is
			-- If `internal_docking_manager' has `a_content'?
		do
			Result := internal_docking_manager.has_content (a_content)
		end

feature {NONE}  -- Implementation

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.	

invariant

	not_void: zones /= Void
	not_void: internal_docking_manager /= Void
	not_void: place_holder_content /= Void

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
