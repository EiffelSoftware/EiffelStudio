indexing
	description: "Objects that contain datas about menu in the docking library"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MENU_DATA

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method.
		do
			create rows.make (1)
		end

feature -- Floating datas

	is_floating: BOOLEAN
		-- If `Current' data about a floating zone?

	set_floating (a_is_floating: BOOLEAN) is
			-- Set `is_floating'.
		do
			is_floating := a_is_floating
		ensure
			set: a_is_floating = is_floating
		end

	title: STRING
			-- Title of floating zone.

	set_title (a_title: STRING) is
			-- Set `a_title'.
		require
			a_title_not_void: a_title /= Void
		do
			title := a_title
		ensure
			set: a_title = title
		end

	screen_x, screen_y: INTEGER
			-- Floating menu zone's position.

	set_screen_x_y (a_screen_x, a_screen_y: INTEGER) is
			-- Set `a_screen_x' and `a_screen_y'.
		do
			screen_x := a_screen_x
			screen_y := a_screen_y
		ensure
			set: screen_x = a_screen_x and screen_y = a_screen_y
		end

feature -- Docking datas

	rows: ARRAYED_LIST [like menu_data]
			-- All row datas in `Current'.

	row (a_title: STRING): like menu_data is
			-- Row data contain a_title. If not found, create a new one.
		require
			a_title_not_void: a_title /= Void
		local
			l_row_data: like menu_data
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
					if (l_row_data.item @ 1).is_equal (a_title) then
						Result := l_row_data
					end

					l_row_data.forth
				end
				rows.forth
			end
		ensure
--			not_void: Result /= Void
		end


feature  {NONE}

	menu_data: ARRAYED_LIST [TUPLE [STRING, INTEGER]]
			-- 1st is menu content's title, 2nd is this menu position in menu row.

feature -- States report

invariant


end
