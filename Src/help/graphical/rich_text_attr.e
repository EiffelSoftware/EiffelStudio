indexing
	description: "Objects that represent a rich text attribute."
	author: "Vincent Brendel"
	date: "$Date$"
	revision: "$Revision$"

class
	RICH_TEXT_ATTR

create
	make

feature -- Initialization

	make (startp, endp: INTEGER) is
			-- Create with `startp' and `endp'.
		do
			start_pos := startp
			end_pos := endp
		end

	set_format (cf: EV_CHARACTER_FORMAT) is
			-- Set `format' to `cf'.
		do
			format := cf
		end

	apply (rt: EV_RICH_TEXT) is
			-- Sets the attribute on the specified position to `rt'.
		require
			rt_exists: rt /= Void
		do
			rt.format_region (start_pos, end_pos, format)
		end

feature -- Access

	start_pos, end_pos: INTEGER

	format: EV_CHARACTER_FORMAT

end -- class RICH_TEXT_ATTR
