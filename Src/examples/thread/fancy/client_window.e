indexing
	description: "Client window where drawing will be performed"
	date: "$Date$"
	revision: "$Revision$"

class
	CLIENT_WINDOW

inherit
	WEL_CONTROL_WINDOW
		redefine
			on_wm_close,
			class_background,
			class_name,
			default_ex_style
		end

create
	make

feature -- Redefine features

	on_wm_close is
			-- Wm_close message.
			-- If `closeable' is False further processing is halted.
		do
			set_default_processing (closeable)
		end

	class_background: WEL_GRAY_BRUSH is
			-- Standard window background color
		once
			create Result.make
		end

feature {NONE} -- Implementation

	default_ex_style: INTEGER is
			-- Style of Client Window.
		do
			Result := Ws_ex_overlappedwindow
		end

	class_name: STRING is
			-- Name of window class.
		once
			Result := "Client Window"
		end

end -- class CLIENT_WINDOW

--|----------------------------------------------------------------
--| EiffelThread: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

