indexing
	description	: " Multi column list tooltipable (on windows for now)"
	author		: "$Author$"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_MULTI_COLUMN_LIST_ROW

inherit
	EV_MULTI_COLUMN_LIST_ROW

create
	default_create

create {EB_MULTI_COLUMN_LIST_ROW}
	make_filled

feature -- Element access

	tooltip: STRING is
			-- Tooltip displayed on `Current'.
		do
			Result := implementation.tooltip
		end

feature -- Element change

	set_tooltip (a_tooltip: STRING) is
			-- Assign `a_tooltip' to `tooltip'.
		do
			implementation.set_tooltip (a_tooltip)
		end
		
	remove_tooltip is
			-- Make `tooltip' empty.
		do
			implementation.remove_tooltip
		end 

end -- class EB_MULTI_COLUMN_LIST_ROW
