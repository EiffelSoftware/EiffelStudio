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

