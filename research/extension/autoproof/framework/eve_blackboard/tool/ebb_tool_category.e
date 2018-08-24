note
	description: "Enumeration for tool categories."
	date: "$Date$"
	revision: "$Revision$"

class
	EBB_TOOL_CATEGORY

feature -- Access

	static_verification: INTEGER = 3
			-- Category of static verification tools.

	dynamic_verification: INTEGER = 4
			-- Category of dynamic verification tools.

	code_inference: INTEGER = 6
			-- Category of code inference tools.

	contract_inference: INTEGER = 5
			-- Category of contract inference tools.

	analysis: INTEGER = 2
			-- Category of analysis tools.

feature -- Status report

	is_valid_category (a_category: INTEGER): BOOLEAN
			-- Is `a_category' a valid category?
		do
			Result := 2 <= a_category and a_category <= 6
		end

end
