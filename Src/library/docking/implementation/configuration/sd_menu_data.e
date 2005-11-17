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

feature -- Properites

--	set_direction (a_direction: INTEGER) is
--			--
--		require
--			a_direction_valid: direction_valid (a_direction)
--		do
--			direction := a_direction
--		end
--
--	direction: INTEGER
--			-- One value from {SD_SHARED} dock direction.


	rows: ARRAYED_LIST [like menu_data]
			-- All row datas in `Current'.

feature -- Basic operation

--	extend (a_title: STRING; a_position: INTEGER) is
--			--
--		require
--			a_title_not_void: a_title /= Void
--		local
--			l_menu: like menu_data
--		do
--			create l_menu.make (n: INTEGER)
--			l_menu.force (a_title, a_position)
--			rows.extend (l_menu)
--		end

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

--			if Result = Void then
--				create Result.make (1)
--				rows.extend (Result)
----				Result.extend ([a_title, 0])
--			end
		ensure
--			not_void: Result /= Void
		end


feature  {NONE}

	menu_data: ARRAYED_LIST [TUPLE [STRING, INTEGER]]
			-- 1st is menu content's title, 2nd is this menu position in menu row.

feature -- States report

--	direction_valid (a_direction: INTEGER): BOOLEAN is
--			--
--		do
--			Result := a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom or
--				a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
--		end

invariant


end
