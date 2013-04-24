note
	description: "RedrawWindow() flags."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RDW_CONSTANTS
	
feature -- Access

	Rdw_invalidate: INTEGER =           1
			-- invalidation
			-- Invalidates lprcUpdate or hrgnUpdate 
			-- (only one may be non-NULL). If both are NULL, 
			-- the entire window is invalidated.
	
	Rdw_internalpaint: INTEGER =        2
			-- invalidation
			-- Causes a WM_PAINT message to be posted to 
			-- the window regardless of whether any portion 
			-- of the window is invalid.
	
	Rdw_erase: INTEGER =                4
			-- invalidation
			-- Causes the window to receive a WM_ERASEBKGND 
			-- message when the window is repainted. 
			-- The RDW_INVALIDATE flag must also be specified; 
			-- otherwise, RDW_ERASE has no effect.

	Rdw_validate: INTEGER =             8
			-- validation
			-- Validates lprcUpdate or hrgnUpdate 
			-- (only one may be non-NULL). 
			-- If both are NULL, the entire window is 
			-- validated. This flag does not affect 
			-- internal WM_PAINT messages.
	
	Rdw_nointernalpaint: INTEGER =      16
			-- validation
			-- Suppresses any pending internal WM_PAINT 
			-- messages. This flag does not affect WM_PAINT 
			-- messages resulting from a non-NULL update area.
	
	Rdw_noerase: INTEGER =              32
			-- validation
			-- Suppresses any pending WM_ERASEBKGND messages.

	Rdw_nochildren: INTEGER =           64
			-- Controls which windows are affected by the RedrawWindow function. 
			-- Excludes child windows, if any, from the repainting operation. 
	
	Rdw_allchildren: INTEGER =          128
			-- Controls which windows are affected by the RedrawWindow function. 
			-- Includes child windows, if any, in the repainting operation.

	Rdw_updatenow: INTEGER =            256
			-- Controls when repainting occurs.
			-- Causes the affected windows 
			-- (as specified by the RDW_ALLCHILDREN 
			-- and RDW_NOCHILDREN flags) to receive 
			-- WM_NCPAINT, WM_ERASEBKGND, and WM_PAINT messages, 
			-- if necessary, before the function returns.
	
	Rdw_erasenow: INTEGER =             512
			-- Controls when repainting occurs. 
			-- Causes the affected windows (as specified 
			-- by the RDW_ALLCHILDREN and RDW_NOCHILDREN flags) 
			-- to receive WM_NCPAINT and WM_ERASEBKGND messages, 
			-- if necessary, before the function returns. 
			-- WM_PAINT messages are received at the ordinary time.

	Rdw_frame: INTEGER =                1024
			-- invalidation
			-- Causes any part of the nonclient area of 
			-- the window that intersects the update region 
			-- to receive a WM_NCPAINT message. 
			-- The RDW_INVALIDATE flag must also be specified; 
			-- otherwise, RDW_FRAME has no effect. 
			-- The WM_NCPAINT message is typically not sent 
			-- during the execution of RedrawWindow unless 
			-- either RDW_UPDATENOW or RDW_ERASENOW is specified.
	
	Rdw_noframe: INTEGER =              2048;
			-- validation
			-- Suppresses any pending WM_NCPAINT messages. 
			-- This flag must be used with RDW_VALIDATE and 
			-- is typically used with RDW_NOCHILDREN. 
			-- RDW_NOFRAME should be used with care, as it 
			-- could cause parts of a window to be painted 
			-- improperly.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_RDW_CONSTANTS

