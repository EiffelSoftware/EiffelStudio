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

	parent_window (a_widget: detachable EV_WIDGET): detachable EV_WINDOW
			-- Returns top level window containing `a_widget', or
			-- Void if none.
		do
			if a_widget /= Void then
				if attached {EV_WINDOW} a_widget.parent as l_window then
					Result := l_window
				else
					Result := parent_window (a_widget.parent)
				end
			end
		ensure
			shown_implies_result_not_void: (a_widget /= Void and then a_widget.is_displayed) implies Result /= Void
		end

	parent_dialog (a_widget: detachable EV_WIDGET): detachable EV_DIALOG
			-- `Result' is top level dialog containing `a_widget' or
			-- `Void' if none.
		do
			if a_widget /= Void then
				if attached {EV_DIALOG} a_widget.parent as l_dialog then
					Result := l_dialog
				else
					Result := parent_dialog (a_widget.parent)
				end
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

end
