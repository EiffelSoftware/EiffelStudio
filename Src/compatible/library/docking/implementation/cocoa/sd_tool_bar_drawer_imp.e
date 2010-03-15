note
	description: "Cocoa SD_TOOL_BAR_DRAWER implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_DRAWER_IMP

inherit
	SD_TOOL_BAR_DRAWER_I
		rename
			to_sepcial_state as to_cocoa_state
		end

	EV_BUTTON_IMP
		rename
			make as make_not_use
		export
			{NONE} all
		end

create
	make

feature{NONE} -- Initlization

	make
			-- Creation method
		do
			-- Make user not break the invariant from EV_ANY_I
			set_state_flag (base_make_called_flag, True)

			create internal_shared
		end

feature -- Redefine

	start_draw (a_rectangle: EV_RECTANGLE)
			-- <Precursor>
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_item_rect, l_rect: EV_RECTANGLE
		do
			is_start_draw_called := True

			from
				l_items := tool_bar.items
				l_rect := a_rectangle.twin
				l_items.start
			until
				l_items.after
			loop
				l_item_rect := l_items.item.rectangle
				if l_item_rect.intersects (a_rectangle) then
					-- We find the maximum area we should clear.
					l_rect.merge (l_item_rect)
				end
				l_items.forth
			end
			if not tool_bar.is_destroyed then
				internal_shared.setter.clear_background_for_theme (tool_bar, l_rect)
			end
		end

	end_draw
			-- Redefine
		do
			is_start_draw_called := False
		end

	is_start_draw_called: BOOLEAN
			-- Redefine

	draw_item (a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS)
			-- Redefine
		local
			l_tool_bar_imp: EV_DRAWING_AREA_IMP
			l_rect: EV_RECTANGLE
			l_button: SD_TOOL_BAR_BUTTON
			l_popup_button: SD_TOOL_BAR_DUAL_POPUP_BUTTON
		do
			if not tool_bar.is_destroyed and then tool_bar.is_displayed then
				l_tool_bar_imp ?= a_arguments.tool_bar.implementation
				check not_void: l_tool_bar_imp /= Void end
				l_rect := a_arguments.item.rectangle
				l_button ?= a_arguments.item
				l_popup_button ?= a_arguments.item
				if l_button /= Void then

					-- Paint button background
					if a_arguments.item.state /= {SD_TOOL_BAR_ITEM_STATE}.normal then
					end
				else
					if a_arguments.item.is_wrap then
					else
					end
				end
			end
		end

	on_theme_changed
			-- Redefine
		do
		end

	desatuation (a_pixmap: EV_PIXMAP; a_k: REAL)
			-- Redefine
		do
		end

	set_tool_bar (a_tool_bar: SD_TOOL_BAR)
			-- Redefine
		do
			tool_bar := a_tool_bar
		end

feature {NONE} -- Implementation

	to_cocoa_state (a_state: INTEGER): INTEGER
			-- Convert from SD_TOOL_BAR_ITEM_STATE to WEL_THEME_TS_CONSTANTS.
		do
		end

	internal_shared: SD_SHARED;
			-- Shared singleton

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
