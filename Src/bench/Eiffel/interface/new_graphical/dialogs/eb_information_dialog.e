--| FIXME: This class has been commented out because it does not work
--| with the current implementation of Vision2 under Windows.
indexing
	description: "Information dialog for ebench"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_INFORMATION_DIALOG

inherit
	EV_INFORMATION_DIALOG
--		redefine
--			show_modal_to_window, destroy
--		end

create
	make_with_text,	make_with_text_and_actions

feature -- Basic operations

--	show_modal_to_window (window: EV_WINDOW) is
--			-- Show as blocking until left button is pressed.
--		do
--			key_press_actions.force_extend (~destroy)
--			pointer_button_press_actions.extend (~on_mouse_button_down)
--			set_x_position ((window.x_position + ((window.width - width) // 2)).max(0))
--			set_y_position ((window.y_position + ((window.height - height)// 2)).max(0))
--			show_relative_to_window (window)
--			enable_capture
--			block
--		end			

feature {NONE} -- Events

--	on_mouse_button_down (abs_x_pos, y_pos, buttn: INTEGER; unused1,unused2,unused3: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
--			-- A mouse button has been pressed.
--		do
--			if buttn = 1 then
--				destroy
--			end
--		end

feature {NONE} -- Implementation

--	destroy is
--			-- Remove capture and Destroy `Current'.
--		do
--			if has_capture then
--				disable_capture
--			end
--			if not is_destroyed then
--				Precursor
--			end
--		end

end -- class EB_INFORMATION_DIALOG
