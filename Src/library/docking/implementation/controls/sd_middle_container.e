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
		local
			l_spliter: EV_SPLIT_AREA
		do
			l_spliter ?= Current
			if l_spliter /= Void then
				-- Current is split area used for non-minimized widgets.
				Result := False
			else
				-- Current is SD_HORIZONTAL_BOX or SD_VERTICAL_BOX used for minimized widgets.
				Result := True
			end
		end

feature -- Access

	first: EV_WIDGET
			-- First child.
		deferred
		end

	second: EV_WIDGET
			-- Second child.
		deferred
		end

	full: BOOLEAN
			-- If full?
		deferred
		end

	maximum_split_position: INTEGER
			-- Maximum split position.
		deferred
		end

	minimum_split_position: INTEGER
			-- Minimum split position.
		deferred
		end

	split_position: INTEGER
			-- Spliter position.
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
		local
			l_h_split: SD_HORIZONTAL_SPLIT_AREA
			l_h_box: SD_HORIZONTAL_BOX
		do
			l_h_box ?= Current
			l_h_split ?= Current
			if l_h_box /= Void or l_h_split /= Void then
				Result := True
			end
		end

feature -- Setting

	disable_item_expand (a_item: EV_WIDGET)
			-- Diable `a_item' size auto expand.
		deferred
		end

	enable_item_expand (a_item: EV_WIDGET)
			-- Enable `a_item' size auto expand.
		deferred
		end

	set_split_position (a_pos: INTEGER)
			-- Set `split_position` with `a_pos'
		deferred
		end

	prune (a_widget: EV_WIDGET)
			-- Prune `a_widget'.
		deferred
		end

	wipe_out
			-- Wipe out all childs.
		deferred
		end

	set_splitter_visible (a_visible: BOOLEAN)
			-- Set splitter bar visible base on chidren visibilities.
		do
		end

feature -- Split area resizing

	set_proportion_recursive
			-- Set proportion recursive in idle actions
		require
			not_void: top_resize_split_area.item /= Void
		do
			set_proportion_recursive_imp (top_resize_split_area.item)
			top_resize_split_area.put (Void)
		ensure
			cleared: top_resize_split_area.item = Void
		end

	set_proportion_recursive_imp (a_container: SD_MIDDLE_CONTAINER)
			-- Set proportion recursively
			-- from outside to inside to avoid generating resize events during resizing
		require
			not_void: a_container /= Void
		local
			l_first, l_second: SD_MIDDLE_CONTAINER
			l_ev_split: EV_SPLIT_AREA
		do
			l_ev_split ?= a_container
			if l_ev_split /= Void and then not l_ev_split.is_destroyed and then l_ev_split.full then
				l_ev_split.set_proportion_with_remembered
			end

			l_first ?= a_container.first
			if l_first /= Void then
				set_proportion_recursive_imp (l_first)
			end

			l_second ?= a_container.second
			if l_second /= Void then
				set_proportion_recursive_imp (l_second)
			end
		end

	remember_top_resize_split_area (a_split_area: SD_MIDDLE_CONTAINER)
			-- Record `a_split_area' to `top_resize_split_area' if `a_split_area' is outmost split area
			-- If `top_resize_split_area' is void, one idle action will be generated
		local
			l_item: SD_MIDDLE_CONTAINER
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
					l_env.application.do_once_on_idle (agent set_proportion_recursive)
				end
			end
		ensure
			set: a_split_area.full implies top_resize_split_area.item /= Void
		end

	top_resize_split_area: CELL [SD_MIDDLE_CONTAINER]
			-- Top resize split area recorded
			-- Set by `remember_top_resize_split_area'
			-- Cleaned by `set_proportion_recursive'
		once
			create Result
		ensure
			not_void: Result /= Void
		end

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
