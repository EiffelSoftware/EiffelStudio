indexing
	description	: "Owner-draw Static control"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEL_STATIC_OWNERDRAW

inherit
	WEL_STATIC
		redefine
			text,
			set_text,
			default_style,
			text_length
		end
		
create 
	make,
	make_by_id

feature -- Status report

	text_length: INTEGER is
			-- Text length
		do
			if internal_text /= Void then
				Result := internal_text.count
			else
				Result := 0
			end
		end

feature -- Access

	text: STRING is
			-- Window text
		do
			if internal_text /= Void then
				Result := internal_text.twin
			else
				Result := ""
			end
		end
		
feature -- Element change

	set_text (a_new_text: STRING) is
			-- Set the window text
		do
			if a_new_text /= Void then
				internal_text := a_new_text.twin
			else
				internal_text := Void
			end
		end

feature {NONE} -- Implementation

	internal_text: STRING
			-- Text set to this control. When we use the SS_OWNERDRAW
			-- flag, Windows does not handle the text anymore.
			
	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Precursor + Ss_ownerdraw
		end

end -- class EV_WEL_STATIC_OWNERDRAW

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

