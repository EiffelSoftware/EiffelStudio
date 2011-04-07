note
	description: "Constants for UI_VIEWVERB."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VIEW_VERB

feature -- Enumeration

	create_: INTEGER = 0
			-- UI_VIEWVERB_CREATE

	destroy: INTEGER = 1
			-- UI_VIEWVERB_DESTROY

	size: INTEGER = 2
			-- UI_VIEWVERB_SIZE

	error: INTEGER = 3
			-- UI_VIEWVERB_ERROR

feature -- Query

	is_valid (a_int: INTEGER): BOOLEAN
			-- If `a_int' valid ?
		do
			Result := a_int = create_ or a_int = destroy or a_int = size or a_int = error
		end

end
