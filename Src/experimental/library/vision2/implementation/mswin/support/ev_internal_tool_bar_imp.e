note
	description: "A WEL control holding the EiffelVision Tool Bar."
	legal: "See notice at end of class."
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
		(a_parent: WEL_COMPOSITE_WINDOW; a_toolbar_imp: EV_TOOL_BAR_IMP)
			-- Create the internal toolbar for toolbar `a_toolbar_imp'.
		do
			toolbar := a_toolbar_imp
			make (a_parent, "EV_INTERNAL_TOOL_BAR_IMP")
		end

feature {NONE} -- WEL Implementation

	toolbar: EV_TOOL_BAR_IMP
			-- Child toolbar of `Current'.

	on_control_id_command (control_id: INTEGER)
			-- A command has been received from `control_id'.
		do
			toolbar.on_button_clicked (control_id)
		end

	on_notify (a_control_id: INTEGER; info: WEL_NMHDR)
		local
			tt1: WEL_TOOLTIP_TEXT
			tooltip_text: STRING_32
			tooltip: WEL_TOOLTIP
			int: POINTER
			app: EV_APPLICATION
		do
			if info.code = Ttn_needtext then
					-- Set resource string id.
				create tt1.make_by_nmhdr (info)
					-- We retrieve a pointer to the tooltip for `toolbar'
				int := {WEL_API}.send_message_result (
					toolbar.wel_item, tb_gettooltips, to_wparam (0), to_lparam (0))
					-- We create `tooltip' from retrieved pointer.	
				create tooltip.make_by_pointer (int)
				app := toolbar.application_imp.attached_interface
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

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Wm_erasebkgnd message.
		local
			bk_brush: detachable WEL_BRUSH
			current_height: INTEGER
			theme_drawer: EV_THEME_DRAWER_IMP
		do
				-- Retrieve the internal `height' of `tool_bar'
				-- computed from `get_max_size'. This is the height that the
				-- bar is actually displayed as.
			current_height := toolbar.get_max_size.height
			if current_height < height then
						-- In this situation, `tool_bar' has a `height' greater than its minimum.
						-- This does not actually change the height of `tool_bar', but instead,
						-- `Current' in which it is parented. Therefore we must clear the background
						-- of `Current' that is not occupied by `tool_bar'.
				bk_brush := toolbar.background_brush
				invalid_rect.set_top (invalid_rect.top + current_height)
				theme_drawer := toolbar.application_imp.theme_drawer
				if bk_brush /= Void then
					theme_drawer.draw_widget_background (toolbar, paint_dc, invalid_rect, bk_brush)
					bk_brush.delete
				end
			end
				--| Disable the default windows processing and return correct
				--| value to Windows, i.e. nonzero value.
			disable_default_processing
			set_message_return_value (to_lresult (1))
		end

	on_size (size_type, a_width, a_height: INTEGER)
			-- Wm_size message
			-- See class WEL_SIZE_CONSTANTS for `size_type' value
		do
			toolbar.on_size (size_type, a_width, a_height)
		end

	default_style: INTEGER
			-- We redefine the default style.
		do
			Result := Ws_child | Ws_clipsiblings
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_INTERNAL_TOOL_BAR_IMP
