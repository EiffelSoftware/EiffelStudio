class
	MAIN_WINDOW

inherit
	PRECOMP_MAIN_WINDOW
		redefine
			class_icon
		end
creation
	make


feature {NONE} -- Implementation


	class_icon: WEL_ICON is
			-- Window's icon
		once
			create Result.make_by_id (1)
		end

end -- class MAIN_WINDOW

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
