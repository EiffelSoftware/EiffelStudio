class
	RECTANGLE_DEMO_WINDOW

inherit
	DEMO_WIN

creation
	make

feature -- deferred
	
	launch_demo is
		do
			!! rect_demo_cmd.make_in ( px_window)
			rect_demo_cmd.launch
		end

	rect_demo_cmd: RECTANGLE_DEMO_CMD

	fig_demo_cmd: DEMO_CMD is
		do
			Result := rect_demo_cmd
		end


end -- class RECTANGLE_DEMO_WINDOW

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
