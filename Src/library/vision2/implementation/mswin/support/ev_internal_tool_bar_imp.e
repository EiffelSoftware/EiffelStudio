indexing
	description: "A WEL control holding the EiffelVision Tool Bar."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INTERNAL_TOOL_BAR_IMP

inherit
	WEL_CONTROL_WINDOW
		redefine
			default_style,
			on_control_id_command,
			on_erase_background,
			class_name,
			on_notify,
			on_size
		end

	WEL_TTN_CONSTANTS
		export
			{NONE} all
		end

	WEL_TB_CONSTANTS
		export
			{NONE} all
		end

create
	make_with_toolbar

feature {NONE} -- Initialization

	make_with_toolbar
		(a_parent: WEL_COMPOSITE_WINDOW; a_toolbar_imp: EV_TOOL_BAR_IMP) is
			-- Create the internal toolbar for toolbar `a_toolbar_imp'.
		do
			make (a_parent, "EV_INTERNAL_TOOL_BAR_IMP")
			toolbar := a_toolbar_imp
		end

feature {NONE} -- WEL Implementation

	toolbar: EV_TOOL_BAR_IMP
			-- Child toolbar of `Current'.

	on_control_id_command (control_id: INTEGER) is
			-- A command has been received from `control_id'.
		do
			toolbar.on_button_clicked (control_id)
		end

	on_notify (a_control_id: INTEGER; info: WEL_NMHDR) is
		local
			tt1: WEL_TOOLTIP_TEXT
			id_from: INTEGER
			tooltip_text: STRING
			tooltip: WEL_TOOLTIP
			int: INTEGER
			env: EV_ENVIRONMENT
			app: EV_APPLICATION
		do
			if info.code = Ttn_needtext then
					-- Set resource string id.
				create tt1.make_by_nmhdr (info)
				id_from := info.id_from
					-- We retrieve a pointer to the tooltip for `toolbar'
				int := cwin_send_message_result (
					toolbar.wel_item, tb_gettooltips, 0, 0)
					-- We create `tooltip' from retrieved pointer.	
				create tooltip.make_by_pointer (cwel_integer_to_pointer (int))
				create env
				app := env.application
					-- If there is a tooltip delay and it has changed then
					-- assign the delay to `tooltip'.
					--| The first time this tooltip is shown after setting
					--| the tooltip delay, it will use the previous value.
					--| This was considered a reasonable trade off as otherwise
					--| we would need to reference all these widgets from	
					--| EV_APPLICATION_IMP.
				if app.tooltip_delay >= 0 and
					tooltip.initial_delay_time /= app.tooltip_delay then
					tooltip.set_initial_delay_time (app.tooltip_delay)
				end
					-- Retrieve tooltip text.
				tooltip_text := toolbar.button_tooltip_text (a_control_id)
				if tooltip_text /= Void then
					tt1.set_text (tooltip_text)
				end
			end
		end
		
	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erasebkgnd message.
			-- No need to erase the background because this
			-- containers has always the same size than the
			-- tool-bar.
		do
			disable_default_processing
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Wm_size message
			-- See class WEL_SIZE_CONSTANTS for `size_type' value
		do
			toolbar.on_size (size_type, a_width, a_height)
		end

	class_name: STRING is
			-- Window class name to create
		once
			Result := generator
		end

	default_style: INTEGER is
			-- We redefine the default style.
		do
			Result := Ws_child + Ws_clipsiblings
		end

end -- class EV_INTERNAL_TOOL_BAR_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.12  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.11  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.10  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.6.8.13  2000/11/09 20:11:35  rogers
--| Modified on_notify so that the tooltip for `tool_bar' will take into
--| account the tooltip_delay in EV_APPLICATION.
--|
--| Revision 1.6.8.12  2000/11/07 17:56:54  rogers
--| Changed !! to create.
--|
--| Revision 1.6.8.11  2000/11/07 00:31:41  rogers
--| Exported WEL_TTN_CONSTANTS to {NONE}.
--|
--| Revision 1.6.8.10  2000/08/11 19:05:49  rogers
--| Fixed copyright clause. Now use ! instead of |. Formatting.
--|
--| Revision 1.6.8.9  2000/08/08 16:47:12  manus
--| We should not return `1' in `on_erase_background' because it makes the
--| button of tool bar to be white.
--|
--| Revision 1.6.8.8  2000/08/08 01:41:52  manus
--| Redefinition of `on_erase_background' to do nothing since it will be done
--| by EV_TOOL_BAR_IMP.
--| Redefinition of `on_size' so that it correctly resizes the EV_TOOL_BAR_IMP.
--|
--| Revision 1.6.8.7  2000/07/21 00:06:27  rogers
--| Fixed on notify so the correct tooltip text is now used. Updated FIXME
--| accordingly.
--|
--| Revision 1.6.8.6  2000/07/07 17:44:16  rogers
--| On_notify now brings up a tooltip if required.
--| The text is still not set correctly.
--|
--| Revision 1.6.8.5  2000/06/28 20:09:59  rogers
--| Added inheritance from WEL_TTN_CONSTANTS. Redefined on_notify ready
--| to handle the tooltip notification.
--|
--| Revision 1.6.8.4  2000/06/16 07:16:38  pichery
--| Speed optimizations
--|
--| Revision 1.6.8.3  2000/06/12 22:35:05  rogers
--| Removed FIXME NOT_REVIEWED. Comments, formatting.
--|
--| Revision 1.6.8.2  2000/06/09 20:54:52  manus
--| Added redefinition of `on_control_id_command' so that we can call the
--| `select_actions' sequence when we click on a certain button of the toolbar.
--|
--| Revision 1.6.8.1  2000/05/03 19:09:17  oconnor
--| mergred from HEAD
--|
--| Revision 1.9  2000/04/07 00:02:36  rogers
--| Removed on_control_id_command as it does nothing.
--|
--| Revision 1.8  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.7  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.10.3  2000/01/27 19:30:15  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.10.2  2000/01/24 21:26:34  rogers
--| on_control_id_command has been re-implemented as the hash table of children
--| has been removed.
--|
--| Revision 1.6.10.1  1999/11/24 17:30:21  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
