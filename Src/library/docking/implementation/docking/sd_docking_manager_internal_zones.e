indexing
	description: "Manager that help docking manager manage all zones."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_MANAGER_ZONES

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
		ensure
			set: internal_docking_manager = a_docking_manager
		end

feature -- Zones managements

	zones: ACTIVE_LIST [SD_ZONE]
			-- All SD_ZONE in current system.

	zone_by_content (a_content: SD_CONTENT): SD_ZONE is
			-- If main container has zone with a_content?
		do
			from
				zones.start
			until
				zones.after or
				Result /= Void
			loop
				if zones.item.content = a_content then
					Result := zones.item
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
				zones.after or
				Result
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
			l_container: EV_CONTAINER
		do
			l_container ?= a_zone
			check l_container /= Void end
			if l_container.parent /= Void then
				l_container.parent.prune (l_container)
			end

			zones.start
			zones.prune (a_zone)
			-- FIXIT: call prune_all from ACTIVE_LIST contract broken
--			zones.prune_all (a_zone)
			if a_zone.content.user_widget.parent /= Void then
				a_zone.content.user_widget.parent.prune (a_zone.content.user_widget)
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

	disable_all_zones_focus_color is
			-- Disable all zones focus color.
		do
			from
				zones.start
			until
				zones.after
			loop
				zones.item.on_focus_out
				zones.forth
			end
		end

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

	zones_not_void: zones /= Void
	internal_docking_manager_not_void: internal_docking_manager /= Void

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
