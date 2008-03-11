indexing
	description: "Matrix order enumeration used by Gdi+."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_MATRIX_ORDER

feature -- Enumeration

    Prepend: INTEGER is 0
    		-- The new operation is applied before the old operation.

    Append: INTEGER is 1
    		-- The new operation is applied after the old operation.

feature -- Query

	is_valid (a_flag: INTEGER): BOOLEAN
			-- If `a_flag' valid?
		do
			Result := a_flag = Append or
				a_flag = Prepend
		end

indexing
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
