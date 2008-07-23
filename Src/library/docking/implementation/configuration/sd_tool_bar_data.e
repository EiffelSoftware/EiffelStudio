indexing
	description: "Objects that contain data about tool bars in docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_DATA

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method.
		do
			create rows.make (1)
		end

feature -- Visible

	is_visible: BOOLEAN
		-- If visible?

	set_visible (a_bool: BOOLEAN) is
			-- Set `is_visible'
		do
			is_visible := a_bool
		ensure
			set: is_visible = a_bool
		end

feature -- Floating data

	is_floating: BOOLEAN
		-- If `Current' data about a floating zone?

	set_floating (a_is_floating: BOOLEAN) is
			-- Set `is_floating'.
		do
			is_floating := a_is_floating
		ensure
			set: a_is_floating = is_floating
		end

	title: STRING_32
			-- Title of floating zone.

	set_title (a_title: STRING_GENERAL) is
			-- Set `a_title'.
		require
			a_title_not_void: a_title /= Void
		do
			title := a_title
		ensure
			set: a_title.as_string_32.is_equal (title)
		end

	screen_x, screen_y: INTEGER
			-- Floating tool bar zone's position.

	set_screen_x_y (a_screen_x, a_screen_y: INTEGER) is
			-- Set `a_screen_x' and `a_screen_y'.
		do
			screen_x := a_screen_x
			screen_y := a_screen_y
		ensure
			set: screen_x = a_screen_x and screen_y = a_screen_y
		end

feature -- Docking data

	rows: ARRAYED_LIST [like tool_bar_data]
			-- All row data in `Current'.

	row (a_title: STRING_GENERAL): like tool_bar_data is
			-- Row data contain a_title. If not found, create a new one.
		require
			a_title_not_void: a_title /= Void
		local
			l_row_data: like tool_bar_data
			l_item: TUPLE [title: STRING_GENERAL]
		do
			from
				rows.start
			until
				rows.after or Result /= Void
			loop
				l_row_data := rows.item
				from
					l_row_data.start
				until
					l_row_data.after or Result /= Void
				loop
					l_item := l_row_data.item
					if l_item.title.is_equal (a_title) then
						Result := l_row_data
					end

					l_row_data.forth
				end
				rows.forth
			end
		end

feature -- SD_TOOL_BAR_ZONE last state

	last_state: SD_TOOL_BAR_ZONE_STATE
			-- Last tool bar state information

	set_last_state (a_last_state: SD_TOOL_BAR_ZONE_STATE) is
			-- Set `last_state' with `a_last_state'
		require
			not_void: a_last_state /= Void
		do
			last_state := a_last_state
		ensure
			set: last_state = a_last_state
		end

feature  {NONE} -- Implementation

	tool_bar_data: ARRAYED_LIST [TUPLE [STRING_GENERAL, INTEGER, SD_TOOL_BAR_ZONE_STATE]]
			-- When `Current' is docking tool bar data, 1st is tool bar content's title, 2nd is this tool bar position in tool bar row.

invariant

	rows_not_void: rows /= Void

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
