note
	description: "Container in the middler layer between top level docking conainter (given by client progrmammers) and leaf nodes containers(SD_ZONEs)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_MIDDLE_CONTAINER

inherit
	EV_CONTAINER
		undefine
			put,
			extend,
			item,
			prune_all,
			fill,
			replace,
			cl_put,
			cl_extend
		end

feature -- Docking query

	is_minimized: BOOLEAN
			-- If Current alreay a container used for minimized zones?
		do
			Result := not attached {EV_SPLIT_AREA} Current
		end

feature -- Access

	first: detachable EV_WIDGET
			-- First child
		deferred
		end

	second: detachable EV_WIDGET
			-- Second child
		deferred
		end

	maximum_split_position: INTEGER
			-- Maximum split position
		deferred
		end

	minimum_split_position: INTEGER
			-- Minimum split position
		deferred
		end

	split_position: INTEGER
			-- Spliter position
		deferred
		end

	is_empty: BOOLEAN
			-- If no child?
		deferred
		end

	count: INTEGER
			-- How many child current have?
		deferred
		end

	is_horizontal: BOOLEAN
			-- If current is horizontal split area?
		do
			Result := attached {SD_HORIZONTAL_BOX} Current or attached {SD_HORIZONTAL_SPLIT_AREA} Current
		end

feature -- Setting

	disable_item_expand (a_item: EV_WIDGET)
			-- Diable `a_item' size auto expand
		deferred
		end

	enable_item_expand (a_item: EV_WIDGET)
			-- Enable `a_item' size auto expand
		deferred
		end

	set_split_position (a_pos: INTEGER)
			-- Set `split_position` with `a_pos'
		deferred
		end

	prune (a_widget: EV_WIDGET)
			-- Prune `a_widget'
		deferred
		end

	wipe_out
			-- Wipe out all childs
		deferred
		end

	set_splitter_visible (a_visible: BOOLEAN)
			-- Set splitter bar visible base on chidren visibilities
		do
		end

feature -- Split area resizing

	set_proportion_recursive
			-- Set proportion recursive in idle actions
		require
			not_void: top_resize_split_area.item /= Void
		do
			if attached top_resize_split_area.item as l_item then
				set_proportion_recursive_imp (l_item)
			else
				check
					from_preconditon_not_void: False
				end
			end
			top_resize_split_area.put (Void)
		ensure
			cleared: top_resize_split_area.item = Void
		end

	set_proportion_recursive_imp (a_container: SD_MIDDLE_CONTAINER)
			-- Set proportion recursively
			-- from outside to inside to avoid generating resize events during resizing
		require
			not_void: a_container /= Void
		do
			if
				attached {EV_SPLIT_AREA} a_container as l_ev_split and then
				not l_ev_split.is_destroyed and then l_ev_split.full
			then
				l_ev_split.set_proportion_with_remembered
			end

			if attached {SD_MIDDLE_CONTAINER} a_container.first as l_first then
				set_proportion_recursive_imp (l_first)
			end

			if attached {SD_MIDDLE_CONTAINER} a_container.second as l_second then
				set_proportion_recursive_imp (l_second)
			end
		end

	remember_top_resize_split_area (a_split_area: SD_MIDDLE_CONTAINER)
			-- Record `a_split_area' to `top_resize_split_area' if `a_split_area' is outmost split area
			-- If `top_resize_split_area' is void, one idle action will be generated
		local
			l_item: detachable SD_MIDDLE_CONTAINER
			l_env: EV_ENVIRONMENT
		do
			l_item := top_resize_split_area.item
			if l_item /= Void then
				if l_item /= a_split_area and then a_split_area.full and then a_split_area.has_recursive (l_item) then
					top_resize_split_area.put (a_split_area)
				end
			else
				if a_split_area.full then
					top_resize_split_area.put (a_split_area)

					create l_env
					if attached l_env.application as l_app then
						l_app.do_once_on_idle (agent set_proportion_recursive)
					end
				end
			end
		ensure
			set: a_split_area.full implies top_resize_split_area.item /= Void
		end

	top_resize_split_area: CELL [detachable SD_MIDDLE_CONTAINER]
			-- Top resize split area recorded
			-- Set by `remember_top_resize_split_area'
			-- Cleaned by `set_proportion_recursive'
		once
			create Result.put (Void)
		ensure
			not_void: Result /= Void
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"






end
