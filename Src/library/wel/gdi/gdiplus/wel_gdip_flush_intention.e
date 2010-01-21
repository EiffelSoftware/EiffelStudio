note
	description: "GpFlushIntention enumeration for Gdi+."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_FLUSH_INTENTION

feature -- Enumeration

	Flush: INTEGER = 0
			-- Pending rendering operations are executed as soon as possible.
			-- The Flush method is not synchronized with the completion of the rendering operations
			-- and might return before the rendering operations are completed.

	Sync: INTEGER = 1
			-- Pending rendering operations are executed as soon as possible.
			-- The Flush method is synchronized with the completion of the rendering operations;
			-- that is, it will not return until after the rendering operations are completed.

feature -- Query

	is_valid (a_int: INTEGER): BOOLEAN
			-- If `a_int' valid?
		do
			Result := a_int = Flush
				or a_int = Sync
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
