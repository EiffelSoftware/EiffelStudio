indexing
	description: "[
		Objects that represent commonly requested utility functions for EiffelVision2.
		Inherit this class to use these features in your system.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_UTILITIES

feature -- Access

	parent_window (a_widget: EV_WIDGET): EV_WINDOW is
			-- Returns top level window containing `a_widget', or
			-- Void if none.
		require
			a_widget_not_void: a_widget /= Void
		local
			window: EV_WINDOW
		do
			window ?= a_widget.parent
			if window = Void then
				if a_widget.parent /= Void then
					Result := parent_window (a_widget.parent)
				end	
			else
				Result := window
			end	
		end
		
	parent_dialog (a_widget: EV_WIDGET): EV_DIALOG is
			-- `Result' is top level dialog containing `a_widget' or
			-- `Void' if none.
		require
			a_widget_not_void: a_widget /= Void
		local
			dialog: EV_DIALOG
		do
			dialog ?= a_widget.parent
			if dialog = Void then
				if a_widget.parent /= Void then
					Result := parent_dialog (a_widget.parent)
				end	
			else
				Result := dialog
			end	
		end

end -- class EV_UTILITIES

