note
	description: "Summary description for {CTR_DATE_TIME_GRID_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_DATE_TIME_GRID_ITEM

inherit
	EV_GRID_LABEL_ITEM
		redefine
			data
		end

	CTR_DATE_TIME_UTILITY
		undefine
			default_create, copy
		end

create
	make_with_text_and_date

feature {NONE} -- Initialization

	make_with_text_and_date (a_text: STRING_GENERAL; a_date: detachable DATE_TIME; a_smart_date_kind: INTEGER; a_date_time_format: detachable STRING; a_gmt_offset: INTEGER; a_gmt_offset_minute: INTEGER)
		do
			date_time := a_date
			date_time_format := a_date_time_format
			smart_date_kind := a_smart_date_kind
			gmt_offset := a_gmt_offset
			gmt_offset_minute := a_gmt_offset_minute
			data := a_text
			make_with_text (text_for_date (a_text, a_date, a_smart_date_kind, a_date_time_format, a_gmt_offset, a_gmt_offset_minute))
			pointer_enter_actions.extend (agent refresh)
		end

feature -- Access

	data: STRING_GENERAL
		-- Arbitrary user data may be stored here.

	date_time: detachable DATE_TIME
			-- Associated date time

	smart_date_kind: INTEGER
			-- Smart date output enabled

	date_time_format: detachable STRING
			-- Date time format

	gmt_offset: INTEGER
			-- GMT offset

	gmt_offset_minute: INTEGER
			-- GMT offset for minutes

feature -- Basic operation

	refresh
		do
			set_text (text_for_date (data, date_time, smart_date_kind, date_time_format, gmt_offset, gmt_offset_minute))
		end

invariant
	smart_date_kind_valid: smart_date_kind > 0 implies valid_smart_date_kind (smart_date_kind)

end
