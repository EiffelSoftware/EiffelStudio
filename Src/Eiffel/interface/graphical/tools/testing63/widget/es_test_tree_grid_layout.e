indexing
	description: "[
		Objects representing a {ES_TAGABLE_GRID} layout for eiffel tests.
		
		See {ES_TAGABLE_GRID_LAYOUT} for more information.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_TREE_GRID_LAYOUT

inherit
	ES_TEST_LIST_GRID_LAYOUT
		redefine
			column_width,
			populate_item_row,
			column_count,
			populate_header,
			exception_text,
			append_class_name
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
			when status_column then
				Result := 70
			else
				Result := Precursor (a_index)
			end
		end

feature {NONE} -- Query

	exception_text (a_exception: !EQA_TEST_INVOCATION_EXCEPTION): !STRING_32
			-- Text describing for given expception
		do
			create Result.make_empty
		end

feature -- Basic functionality

	populate_header (a_header: !EV_GRID_HEADER) is
			-- <Precursor>
		do
			a_header.i_th (last_tested_column).set_text (local_formatter.translation (t_last_executed))
			Precursor (a_header)
		end

	populate_item_row (a_row: !EV_GRID_ROW; a_item: !TEST_I) is
			-- <Precursor>
		local
			l_label: EV_GRID_LABEL_ITEM
		do
			a_row.set_item (tests_column, test_item (a_item))
			a_row.set_item (status_column, status_item (a_item))
			if a_item.is_outcome_available then
				a_row.set_item (last_tested_column, date_time_item (a_item.last_outcome.date))
			else
				create l_label
				a_row.set_item (last_tested_column, l_label)
			end
		end

feature {NONE} -- Basic functionality

	date_time_item (a_date: !DATE_TIME): !EV_GRID_ITEM is
			-- Item displaying how long a given date is in the past.
			--
			-- `a_date': Date shown on item.
		local
			l_label: EV_GRID_LABEL_ITEM
			l_now: DATE_TIME
			l_secs, l_days, l_hours, l_mins: INTEGER_64
			l_text, l_tooltip: STRING
		do
			create l_text.make (20)
			create l_now.make_now
			l_secs := l_now.definite_duration (a_date).seconds_count
			l_days := l_secs // 86400
			if l_days > 10 then
				l_text.append (date_format.create_string (a_date))
			else
				l_hours := l_secs // 3600
				if l_hours > 23 then
					l_text.append_integer_64 (l_days)
					l_text.append (" day")
					if l_days > 1 then
						l_text.append_character ('s')
					end
				else
					l_mins := (l_secs // 60) + 1
					if l_mins > 59 then
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
				l_text.append (" ago ")
			end
			if l_days > 365 or l_now.year /= a_date.year then
				l_tooltip := date_format.create_string (a_date)
			elseif l_now.month /= a_date.month or l_now.day /= a_date.day then
				l_tooltip := date_format_show.create_string (a_date)
			else
				l_tooltip := time_format.create_string (a_date)
			end
			create l_label
			l_label.set_text (l_text)
			l_label.set_tooltip (l_tooltip)
			Result := l_label
		end

	append_class_name (a_test: !TEST_I)
			-- <Precursor>
		do
		end

feature {NONE} -- Constants

	last_tested_column: INTEGER = 3

	t_last_executed: STRING = "Last executed"

	time_format: DATE_TIME_CODE_STRING
		once
			create Result.make ("hh12:[0]mi AM")
		end

	date_format: DATE_TIME_CODE_STRING
		once
			create Result.make ("mmm dd yyyy")
		end

	date_format_show: DATE_TIME_CODE_STRING
		once
			create Result.make ("mm dd")
		end

	utc_format: DATE_TIME_CODE_STRING
		once
			create Result.make ("yyyy-[0]mm-[0]dd [0]hh-[0]mi-[0]ss")
		end

end
