note
	description: "[
		Objects that represent commonly requested utility functions for EiffelVision2.
		Inherit this class to use these features in your system.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_UTILITIES

feature -- Access

	parent_window (a_widget: EV_WIDGET): detachable EV_WINDOW
			-- Returns top level window containing `a_widget', or
			-- Void if none.
		require
			a_widget_not_void: a_widget /= Void
		local
			window: detachable EV_WINDOW
		do
			window ?= a_widget.parent
			if window = Void then
				if attached a_widget.parent as l_widget_parent then
					Result := parent_window (l_widget_parent)
				end
			else
				Result := window
			end
		ensure
			shown_implies_result_not_void: a_widget.is_displayed implies Result /= Void
		end

	parent_dialog (a_widget: EV_WIDGET): detachable EV_DIALOG
			-- `Result' is top level dialog containing `a_widget' or
			-- `Void' if none.
		require
			a_widget_not_void: a_widget /= Void
		local
			dialog: detachable EV_DIALOG
		do
			dialog ?= a_widget.parent
			if dialog = Void then
				if attached a_widget.parent as l_widget_parent then
					Result := parent_dialog (l_widget_parent)
				end
			else
				Result := dialog
			end
		end

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




end -- class EV_UTILITIES




