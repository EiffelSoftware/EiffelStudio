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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

