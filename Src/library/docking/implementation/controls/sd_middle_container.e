indexing
	description: "Container in the middler layer between top level docking conainter (given by client progrmammers) and leaf nodes containers(SD_ZONEs)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_MIDDLE_CONTAINER

inherit
	EV_CONTAINER
		rename
			implementation as implementation_not_use,
			may_contain as may_contain_not_use
		undefine
			extend,
			put,
			item,
			prune_all,
			fill,
			replace,
			cl_extend,
			cl_put
		end

feature -- Docking query

	is_minimized: BOOLEAN is
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

	first: EV_WIDGET is
			-- First child.
		deferred
		end

	second: EV_WIDGET is
			-- Second child.
		deferred
		end

	full: BOOLEAN is
			-- If full?
		deferred
		end

	maximum_split_position: INTEGER is
			-- Maximum split position.
		deferred
		end

	minimum_split_position: INTEGER is
			-- Minimum split position.
		deferred
		end

	split_position: INTEGER is
			-- Spliter position.
		deferred
		end

	is_empty: BOOLEAN is
			-- If no child?
		deferred
		end

	count: INTEGER is
			-- How many child current have?
		deferred
		end

	is_horizontal: BOOLEAN is
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

	disable_item_expand (a_item: EV_WIDGET) is
			-- Diable `a_item' size auto expand.
		deferred
		end

	enable_item_expand (a_item: EV_WIDGET) is
			-- Enable `a_item' size auto expand.
		deferred
		end

	set_split_position (a_pos: INTEGER) is
			-- Set `split_position` with `a_pos'
		deferred
		end

	extend (a_widget: EV_WIDGET) is
			-- Extend `a_widget'
		deferred
		end

	prune (a_widget: EV_WIDGET) is
			-- Prune `a_widget'.
		deferred
		end

	wipe_out is
			-- Wipe out all childs.
		deferred
		end

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
