--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision fontable, gtk implementation.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"
	
deferred class
	EV_FONTABLE_IMP
	
inherit
	EV_FONTABLE_I
		redefine
			interface
		end

--	EV_ANY_IMP
--		redefine
--			interface
--		end
	
feature -- Access

	font: EV_FONT is
			-- Character appearance for `Current'.
		do
			if private_font = Void then
				create private_font
				Result := private_font
			else
				Result := private_font
			end
		end
		

--		local
--			font_x: FONT_IMP
--		do
-- 			if private_font = Void then
-- 				create private_font.make;
-- 				font_x ?= private_font.implementation;
-- --XX				font_x.set_default_font (font_list)
-- 			end;
-- 			Result := private_font
--			create Result
--		end;

feature -- Status setting

--XX 	set_font_list (a_font_list: MEL_FONT_LIST) is
-- 			-- Set `font_list' to `a_font_list'.
-- 		require
-- 			valid_font_list: a_font_list /= Void and then a_font_list.is_valid
-- 		deferred
-- 		end;

	set_font (a_font: EV_FONT) is
			-- Assign `a_font' to `font'.

		do
			private_font := a_font
		end

--		local
--			font_implementation: FONT_IMP;
--		do
-- 			if private_font /= Void then
-- 				font_implementation ?= private_font.implementation;
-- 				font_implementation.decrement_users
-- 			end;
-- 			private_font := a_font;
-- 			font_implementation ?= a_font.implementation;
-- 			font_implementation.increment_users;
-- 			set_font_from_imp (font_implementation)
--			check
--				to_be_implemented: False
--			end
--		end

-- feature {FONT_IMP} -- Implementation

 	private_font: EV_FONT
			-- Private font

-- 	update_font is
-- 			-- Update the X font after a change inside the Eiffel font.
-- 		local
-- 			font_implementation: FONT_IMP
-- 		do
-- 			font_implementation ?= private_font.implementation;
-- 			set_font_from_imp (font_implementation)
-- 		end	

-- feature {NONE} -- Implementation

-- 	set_font_from_imp (font_implementation: FONT_IMP) is
-- 			-- Set the font from `a_font_imp'.
-- 		require
-- 			valid_font_imp: font_implementation /= Void
-- 		local
-- 			a_font_list: MEL_FONT_LIST
-- 		do
-- 			font_implementation.allocate_font;
-- 			if font_implementation.is_valid then
-- 				a_font_list := font_implementation.font_list;
-- 				if a_font_list.is_valid then
-- --XX					set_font_list (a_font_list);
-- 					a_font_list.destroy
-- 				else
-- 					io.error.putstring ("Warning can not allocate font%N");
-- 				end;
-- 			else
-- 				io.error.putstring ("Warning can not allocate font%N");
-- 			end
-- 		end;	

feature {NONE} -- Implementation

	interface: EV_FONTABLE

end -- class EV_FONTABLE_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2000/02/14 11:40:28  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.6  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.3.6.5  2000/01/27 19:29:31  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.4  1999/12/18 02:15:58  king
--| Implemented font and set_font routines
--|
--| Revision 1.3.6.3  1999/12/15 19:25:00  king
--| Removed inheritence from ev_any_imp
--|
--| Revision 1.3.6.2  1999/12/06 17:56:51  brendel
--| Changed so that it only has `font' and `set_font'.
--|
--| Revision 1.3.6.1  1999/11/24 17:29:47  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
