note
	description: "EiffelVision font selection dialog, implementation."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_DIALOG_IMP

inherit
	EV_FONT_DIALOG_I
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface,
			make,
			show_modal_to_window
		end

create
	make


feature {NONE} -- Initialization

	make
			-- Initialize the dialog.
		do
			Precursor {EV_STANDARD_DIALOG_IMP}
			create font_panel.shared_font_panel
--			window := font_panel
		end

feature -- Access

	font: EV_FONT
			-- Current selected font.
		do
		end

feature -- Element change

	set_font (a_font: EV_FONT)
			-- Select `a_font'.
		do
		end

feature {NONE} -- Implementation

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show `Current' modal with respect to `a_window'.
		do
			selected_button := Void

			font_panel.make_key_and_order_front (current)

			selected_button := ev_ok
			interface.ok_actions.call (Void)
		end

	font_panel: NS_FONT_PANEL

feature {EV_ANY_I} -- Implementation

	interface: EV_FONT_DIALOG;

end -- class EV_FONT_DIALOG_IMP
