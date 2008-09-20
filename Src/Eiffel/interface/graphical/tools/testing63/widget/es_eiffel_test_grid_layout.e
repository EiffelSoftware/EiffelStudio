indexing
	description: "[
		Objects representing a {ES_TAGABLE_GRID} layout for eiffel tests.
		
		See {ES_TAGABLE_GRID_LAYOUT} for more information.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIFFEL_TEST_GRID_LAYOUT

inherit
	ES_EIFFEL_TEST_GRID_LAYOUT_LIGHT
		redefine
			column_width,
			populate_item_row,
			column_count,
			populate_header
		end

create
	make

feature -- Status report

	column_count: INTEGER
			-- <Precursor>
		do
			Result := 3
		end

	column_width (a_index: INTEGER): INTEGER
			-- <Precursor>
		do
			inspect
				a_index
			when last_tested_column then
				Result := 120
			else
				Result := Precursor (a_index)
			end
		end

feature {NONE} -- Basic functionality

	populate_header (a_header: !EV_GRID_HEADER) is
			-- <Precursor>
		do
			a_header.i_th (last_tested_column).set_text ("Last executed")
			Precursor (a_header)
		end

	populate_item_row (a_row: !EV_GRID_ROW; a_item: !EIFFEL_TEST_I) is
			-- <Precursor>
		local
			l_label: EV_GRID_LABEL_ITEM
		do
			Precursor (a_row, a_item)
			if a_item.is_outcome_available then
				a_row.set_item (last_tested_column, date_time_item (a_item.last_outcome.date))
			else
				create l_label
				a_row.set_item (last_tested_column, l_label)
			end
		end

	date_time_item (a_date: !DATE_TIME): !EV_GRID_ITEM is
			-- Item displaying how long a given date is in the past.
			--
			-- `a_date': Date shown on item.
		local
			l_label: EV_GRID_LABEL_ITEM
			l_secs, l_days, l_hours, l_mins: INTEGER_64
			l_date, l_time, l_text, l_tooltip: STRING
		do
			create l_text.make (20)
			l_secs := (create {DATE_TIME}.make_now).definite_duration (a_date).seconds_count
			l_date := a_date.date.out
			l_time := a_date.time.out
			l_days := l_secs // 86400
			if l_days > 10 then
				l_text.append (l_date)
			else
				l_hours := l_secs // 3600
				if l_hours > 23 then
					l_text.append ("> ")
					l_text.append_integer_64 (l_days)
					l_text.append (" day")
					if l_days > 1 then
						l_text.append_character ('s')
					end
				else
					l_mins := (l_secs // 60) + 1
					if l_mins > 59 then
						l_text.append ("> ")
						l_text.append_integer_64 (l_hours)
						l_text.append (" hour")
						if l_hours > 1 then
							l_text.append_character ('s')
						end
					else
						l_text.append_integer_64 (l_mins)
						l_text.append (" min")
					end
				end
				l_text.append (" ago")
			end
			create l_label
			l_label.align_text_right
			l_label.set_text (l_text)
			l_tooltip := a_date.out
			l_label.set_tooltip (l_tooltip)
			Result := l_label
		end

feature {NONE} -- Constants

	last_tested_column: INTEGER = 3

end
