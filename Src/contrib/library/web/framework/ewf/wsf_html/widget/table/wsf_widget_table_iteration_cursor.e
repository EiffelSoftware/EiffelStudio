note
	description: "Summary description for {WSF_WIDGET_TABLE_ITERATION_CURSOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_WIDGET_TABLE_ITERATION_CURSOR

inherit
	ITERATION_CURSOR [WSF_WIDGET_TABLE_ITEM]

create
	make

feature {NONE} -- Initialization

	make (a_table: WSF_WIDGET_TABLE)
		do
			table := a_table
			start
		end

	table: WSF_WIDGET_TABLE

	row_index: INTEGER
	column_index: INTEGER

feature -- Access

	start
		do
			row_index := 1
			column_index := 0
			forth
		end

	item: WSF_WIDGET_TABLE_ITEM
			-- Item at current cursor position.
		do
			if attached table.row (row_index) as r then
				if attached r.item (column_index) as w then
					Result := w
				else
					create Result.make_with_text ("")
				end
			else
				create Result.make_with_text ("")
			end
		end

feature -- Status report

	after: BOOLEAN
			-- Are there no more items to iterate over?
		do
			if row_index > table.row_count then
				Result := True
			elseif row_index = table.row_count then
				if attached table.row (row_index) as l_row then
					if column_index > l_row.count then
						Result := True
					else
						Result := False
					end
				else
					Result := True
				end
			end
		end

feature -- Cursor movement

	forth
			-- Move to next position.
		do
			if row_index <= table.row_count then
				if attached table.row (row_index) as l_row then
					if column_index < l_row.count then
						column_index := column_index + 1
					else
						from
							row_index := row_index + 1
							column_index := 1
						until
							row_index > table.row_count or
							attached table.row (row_index) as r and then r.count > 0
						loop
							row_index := row_index + 1
						end
					end
				end
			end
		end

end
