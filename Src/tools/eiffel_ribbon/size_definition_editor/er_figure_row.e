note
	description: "Summary description for {ER_FIGURE_ROW}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_FIGURE_ROW

inherit
	COMPARABLE
		undefine
			is_equal,
			copy
		end

	ARRAYED_LIST [ER_FIGURE]
		redefine
			is_equal
		end
create
	make

feature -- Compare

	is_less alias "<" (a_other: ER_FIGURE_ROW): BOOLEAN
			-- <Precursor>
			-- Only compare position, used by {SD_TOOL_BAR_ROW}.zones
		local
			l_first_item: ER_FIGURE
		do
			if attached first_item as l_item then
				if a_other.count >= 1 then
					l_first_item := a_other.first
					Result := (l_item.x < l_first_item.x)
					if l_item.x = l_first_item.x then
						Result := (l_item.y < l_first_item.y)
					end
				end
			end
		end

	is_equal (a_other: ER_FIGURE_ROW): BOOLEAN
			-- <Precursor>
			-- Only compare position, used by {SD_TOOL_BAR_ROW}.zones
		local
			l_first_item: ER_FIGURE
		do
			if attached first_item as l_item then
				if a_other.count >= 1 then
					l_first_item := a_other.first
					Result := (l_first_item.x = l_item.x) and (l_first_item.y = l_item.y)
				end
			end
		end

	first_item: detachable ER_FIGURE
			--
		do
			if count >= 1 then
				Result := first
			end
		end
end
