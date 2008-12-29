note
	description:
		"Shared access to GUI object"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_SPECIAL_COMMANDS

feature -- Access

	window: WINDOW_COMMANDS
			-- Window related commands
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

	menu: MENU_COMMANDS
			-- Menu related commands
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

	list: LIST_COMMANDS
			-- List related commands
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

--	tree: TREE is
--			-- Tree related commands
--		once
--			create Result.make
--		ensure
--			result_not_void: Result /= Void
--		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
