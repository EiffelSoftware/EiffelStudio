indexing
	description:
		"EiffelVision cursor code, gtk implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CURSOR_CODE_IMP

feature -- Access

	busy: INTEGER is
			-- Standard arrow and small hourglass
		do
			Result := Gdk_watch
		end

	standard: INTEGER is
			-- Standard arrow
		do
			Result := Gdk_arrow
		end

	crosshair: INTEGER is
			-- Crosshair
		do
			Result := Gdk_crosshair
		end

	help: INTEGER is
			-- Arrow and question mark
		do
			Result := Gdk_question_arrow
		end

	ibeam: INTEGER is
			-- I-beam
		do
			Result := Gdk_xterm
		end

	no: INTEGER is
			-- A 8 ends cross.
		do
			Result := Gdk_cross_reverse
		end

	sizeall: INTEGER is
			-- Four-pointed arrow pointing north, south, east and west
		do
			Result := Gdk_fleur
		end

--	sizenesw: INTEGER is
--			-- Double-pointed arrow pointing northeast and southwest
--		do
--			Result := implementation.sizenesw
--		end

	sizens: INTEGER is
			-- Double-pointed arrow pointing north and south
		do
			Result := Gdk_sb_v_double_arrow
		end

--	sizenwse: INTEGER is
--			-- Double-pointed arrow pointing west and east
--		do
--			Result := Gdk_bottom_right_corner
--		end

	sizewe: INTEGER is
			-- Double-pointed arrow pointing west and east
		do
			Result := Gdk_sb_h_double_arrow
		end

	uparrow: INTEGER is
			-- Vertical arrow
		do
			Result := Gdk_sb_up_arrow
		end

	wait: INTEGER is
			-- Hourglass
		do
			Result := Gdk_watch
		end

feature {NONE} -- Externals

	Gdk_num_glyphs: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_NUM_GLYPHS"
		end

	Gdk_x_cursor: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_X_CURSOR"
		end

	Gdk_arrow: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_ARROW"
		end

	Gdk_based_arrow_down: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_BASED_ARROW_DOWN"
		end

	Gdk_based_arrow_up: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_BASED_ARROW_UP"
		end

	Gdk_boat: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_BOAT"
		end

	Gdk_bogosity: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_BOGOSITY"
		end

	Gdk_bottom_left_corner: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_BOTTOM_LEFT_CORNER"
		end

	Gdk_bottom_right_corner: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_BOTTOM_RIGHT_CORNER"
		end

	Gdk_bottom_side: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_BOTTOM_SIDE"
		end

	Gdk_bottom_tee: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_BOTTOM_TEE"
		end

	Gdk_box_spiral: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_BOX_SPIRAL"
		end

	Gdk_center_ptr: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_CENTER_PTR"
		end

	Gdk_circle: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_CIRCLE"
		end

	Gdk_clock: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_CLOCK"
		end

	Gdk_coffee_mug: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_COFFEE_MUG"
		end

	Gdk_cross: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_CROSS"
		end

	Gdk_cross_reverse: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_CROSS_REVERSE"
		end

	Gdk_crosshair: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_CROSSHAIR"
		end

	Gdk_diamond_cross: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_DIAMOND_CROSS"
		end

	Gdk_dot: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_DOT"
		end

	Gdk_dotbox: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_DOTBOX"
		end

	Gdk_double_arrow: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_DOUBLE_ARROW"
		end

	Gdk_draft_large: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_DRAFT_LARGE"
		end

	Gdk_draft_small: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_DRAFT_SMALL"
		end

	Gdk_draped_box: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_DRAPED_BOX"
		end

	Gdk_exchange: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_EXCHANGE"
		end

	Gdk_fleur: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_FLEUR"
		end

	Gdk_gobbler: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_GOBBLER"
		end

	Gdk_gumby: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_GUMBY"
		end

	Gdk_hand1: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_HAND1"
		end

	Gdk_hand2: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_HAND2"
		end

	Gdk_heart: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_HEART"
		end

	Gdk_icon: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_ICON"
		end

	Gdk_iron_cross: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_IRON_CROSS"
		end

	Gdk_left_ptr: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_LEFT_PTR"
		end

	Gdk_left_side: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_LEFT_SIDE"
		end

	Gdk_left_tee: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_LEFT_TEE"
		end

	Gdk_leftbutton: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_LEFTBUTTON"
		end

	Gdk_ll_angle: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_LL_ANGLE"
		end

	Gdk_lr_angle: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_LR_ANGLE"
		end

	Gdk_man: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_MAN"
		end

	Gdk_middlebutton: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_MIDDLEBUTTON"
		end

	Gdk_mouse: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_MOUSE"
		end

	Gdk_pencil: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_PENCIL"
		end

	Gdk_pirate: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_PIRATE"
		end

	Gdk_plus: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_PLUS"
		end

	Gdk_question_arrow: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_QUESTION_ARROW"
		end

	Gdk_right_ptr: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_RIGHT_PTR"
		end

	Gdk_right_side: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_RIGHT_SIDE"
		end

	Gdk_right_tee: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_RIGHT_TEE"
		end

	Gdk_rightbutton: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_RIGHTBUTTON"
		end

	Gdk_rtl_logo: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_RTL_LOGO"
		end

	Gdk_sailboat: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_SAILBOAT"
		end

	Gdk_sb_down_arrow: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_SB_DOWN_ARROW"
		end

	Gdk_sb_h_double_arrow: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_SB_H_DOUBLE_ARROW"
		end

	Gdk_sb_left_arrow: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_SB_LEFT_ARROW"
		end

	Gdk_sb_right_arrow: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_SB_RIGHT_ARROW"
		end

	Gdk_sb_up_arrow: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_SB_UP_ARROW"
		end

	Gdk_sb_v_double_arrow: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_SB_V_DOUBLE_ARROW"
		end

	Gdk_shuttle: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_SHUTTLE"
		end

	Gdk_sizing: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_SIZING"
		end

	Gdk_spider: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_SPIDER"
		end

	Gdk_spraycan: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_SPRAYCAN"
		end

	Gdk_star: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_STAR"
		end

	Gdk_target: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_TARGET"
		end

	Gdk_tcross: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_TCROSS"
		end

	Gdk_top_left_arrow: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_TOP_LEFT_ARROW"
		end

	Gdk_top_left_corner: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_TOP_LEFT_CORNER"
		end

	Gdk_top_right_corner: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_TOP_RIGHT_CORNER"
		end

	Gdk_top_side: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_TOP_SIDE"
		end

	Gdk_top_tee: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_TOP_TEE"
		end

	Gdk_trek: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_TREK"
		end

	Gdk_ul_angle: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_UL_ANGLE"
		end

	Gdk_umbrella: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_UMBRELLA"
		end

	Gdk_ur_angle: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_UR_ANGLE"
		end

	Gdk_watch: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_WATCH"
		end

	Gdk_xterm: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_XTERM"
		end

end -- class EV_CURSOR_CODE_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision Library: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2001/06/07 23:08:03  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.4.2  2000/09/06 23:18:40  king
--| Reviewed
--|
--| Revision 1.2.4.1  2000/05/03 19:08:38  oconnor
--| mergred from HEAD
--|
--| Revision 1.4  2000/02/22 18:39:35  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.3  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.6.3  2000/02/04 05:03:31  oconnor
--| released
--|
--| Revision 1.2.6.2  2000/01/27 19:29:28  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.6.1  1999/11/24 17:29:45  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
