indexing
	description: "Objects that provide once access to the clipboard."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_CLIPBOAD

feature -- Access

	clipboard: GB_CLIPBOARD is
			-- Once access to instance of clipboard.
		once
			create Result
		end

invariant
	clipboard_not_void: clipboard /= Void

end -- class GB_SHARED_CLIPBOARD
