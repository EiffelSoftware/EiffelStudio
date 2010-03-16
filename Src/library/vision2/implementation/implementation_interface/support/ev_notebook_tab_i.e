note
	description: "Objects that represent a tab associated with a notebook item."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_NOTEBOOK_TAB_I

inherit
	EV_ANY_I
		redefine
			interface
		end

	EV_TEXTABLE_I
		redefine
			interface
		end

	EV_PIXMAPABLE_I
		redefine
			interface
		end

	EV_SELECTABLE_I
		redefine
			interface
		end

feature -- Access

	notebook: detachable EV_NOTEBOOK
			-- Notebook in which `Current' is displayed.

	widget: detachable EV_WIDGET
			-- Widget to which `Current' is associated.

feature {EV_NOTEBOOK_TAB} -- Status Setting

	set_widgets (a_notebook: EV_NOTEBOOK; a_widget: EV_WIDGET)
			-- Assign `a_notebook' to `notebook' and `a_widget' to `widget'.
		require
			notebook_not_void: a_notebook /= Void
			a_widget_not_void: a_widget /= Void
			notebook_has_widget: a_notebook.has (a_widget)
		do
			notebook := a_notebook
			widget := a_widget
		ensure
			notebook_set: notebook = a_notebook
			widget_set: widget = a_widget
		end

	is_selected: BOOLEAN
			-- Is objects state set to selected.
		do
			if attached notebook as l_notebook then
				Result := l_notebook.selected_item = widget
			end
		end

	enable_select
			-- Select the object.
		do
			if attached notebook as l_notebook and then attached widget as l_widget then
				l_notebook.select_item (l_widget)
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_NOTEBOOK_TAB note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

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




end -- class EV_NOTEBOOK_TAB_I











