indexing
	description: 
		"Eiffel Vision tooltipable. Mswindows implementation."
	status: "See notice at end of class"
	keywords: "tooltip, popup"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_TOOLTIPABLE_IMP
	
inherit
	
	EV_TOOLTIPABLE_I
		redefine
			interface
		end

	WEL_TTF_CONSTANTS

feature -- Initialization

	tooltip: STRING
			-- Text of tooltip assigned to `Current'.

feature -- Element change

	set_tooltip (a_tooltip: STRING) is
			-- Assign `a_tooltip' to `tooltip'.
	local
			tool_info: WEL_TOOL_INFO
			envir: EV_ENVIRONMENT
			app_imp: EV_APPLICATION_IMP
		do
			create envir
			app_imp ?= envir.application.implementation
		
			--| The tooltip does not seem to work correctly unless we
			--| destroy the old tooltip before creating the new one.
			if internal_tooltip /= Void then
				internal_tooltip.destroy
			end
			create internal_tooltip.make (tooltip_window, 1)
			create tool_info.make
			tool_info.set_text (a_tooltip)
			tool_info.set_flags (Ttf_subclass + Ttf_idishwnd)
			tool_info.set_id_with_window (tooltip_window)
			internal_tooltip.add_tool (tool_info)
			internal_tooltip.activate

				-- Set the inital time delay for the tooltip.
			internal_tooltip.set_initial_delay_time (app_imp.tooltip_delay)
			
			app_imp.all_tooltips.extend (internal_tooltip)

				-- Assign `a_tooltip' to `tooltip'.
			tooltip := clone (a_tooltip)
		end

	remove_tooltip is
			-- Assign Void to `tooltip'.
		local
			envir: EV_ENVIRONMENT
			app_imp: EV_APPLICATION_IMP
		do
				-- We do nothing if there is no tooltip on
				-- `Current'.
			if tooltip /= Void then
					-- If `tooltip' is not `Void' then there should always
					-- be an internal tooltip.
				check
					internal_tooltip_not_void: internal_tooltip /= Void
				end
					-- Assign `Void' to `tooltip'.
				tooltip := Void
	
					-- Remove `internal_tooltip' from `all_tooltips' in
					-- EV_APPLICATION_IMP.
				create envir
				app_imp ?= envir.application.implementation
				app_imp.all_tooltips.prune (internal_tooltip)
			
					-- Destroy `internal_tooltip'.
				internal_tooltip.destroy
			end
		end

feature {NONE} -- Implementation 

	internal_tooltip: WEL_TOOLTIP
		-- WEL_TOOLTIP used internally by current.

	tooltip_window: WEL_WINDOW is
			-- Window of `Current' for use with tooltips.
			--| This is redefined in descendents as necessary.
			--| When redefinition has taken place in all descendents then
			--| This can be removed.
		do
			Result := Void
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOLTIPABLE

end -- EV_TOOLTIPABLE_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
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
--| Revision 1.3  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.12  2001/03/30 02:11:48  rogers
--| Added a check that internal_tooltip is not void in `remove_tooltip'.
--|
--| Revision 1.1.2.11  2001/01/19 00:59:32  rogers
--| Remove_tooltip no longer attempts to do anything when `Current' does not
--| have a tooltip. Previously would crash when calling remove_tooltip without
--| having set a tooltip.
--|
--| Revision 1.1.2.10  2000/11/07 23:00:29  rogers
--| Internal_tooltip is now destroyed before being re-created.
--|
--| Revision 1.1.2.9  2000/11/07 00:13:21  rogers
--| Set_tooltip now prunes an existing tooltip from `all_tooltips' within
--| EV_APPLICATION_IMP.
--|
--| Revision 1.1.2.8  2000/11/07 00:01:40  rogers
--| set_tooltip now deletes the existing tool associated to `Current' before
--| setting a new one. Previously calling set_tooltip twice on `Current'
--| would set two tooltips. Only one tooltip is allowed with this interface.
--|
--| Revision 1.1.2.7  2000/06/28 00:15:11  rogers
--| Added and improved comments.
--|
--| Revision 1.1.2.6  2000/06/27 23:25:13  rogers
--| Implemented remove_tooltip.
--|
--| Revision 1.1.2.5  2000/06/27 22:42:49  rogers
--| Removed unrefernced local variables from set_tooltip.
--|
--| Revision 1.1.2.4  2000/06/27 22:17:21  rogers
--| Now inherits WEL_TTI_CONSTANTS. Implemented tooltip and set_tooltip.
--| Tooltips currently only work for primitives.
--|
--| Revision 1.1.2.3  2000/05/10 23:10:00  king
--| Integrated tooltipable changes
--|
--| Revision 1.1.2.2  2000/05/04 19:14:05  brendel
--| Removed inheritance of non-existent EV_ANY_IMP.
--|
--| Revision 1.1.2.1  2000/05/04 19:00:52  king
--| initial
--|
--| Revision 1.1.2.2  2000/05/04 18:50:31  king
--| Corrected set_tooltip
--|
--| Revision 1.1.2.1  2000/05/03 19:08:41  oconnor
--| mergred from HEAD
--|
--| Revision 1.1  2000/05/02 22:15:40  king
--| Initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
