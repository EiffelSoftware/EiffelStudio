indexing
	description: "[
		Objects that represent a tab associated with a notebook item. These objects may
		not be created directly but instead returned from a notebook via `item_tab'.
		If `widget' is subsequently removed from `notebook', `Current' is automatically
		destroyed and is no longer usuable.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_NOTEBOOK_TAB
	
inherit
	EV_ANY
		redefine
			implementation,
			is_in_default_state,
			is_destroyed
		end
		
	EV_TEXTABLE
		redefine
			implementation,
			is_in_default_state,
			is_destroyed
		end
		
	EV_PIXMAPABLE
		redefine
			implementation,
			is_in_default_state,
			is_destroyed
		end
		
	EV_SELECTABLE
		redefine
			implementation,
			is_in_default_state,
			is_destroyed
		end
		
create {EV_NOTEBOOK_I}

	make_with_widgets
	
feature {EV_NOTEBOOK_I, EV_NOTEBOOK_TAB} -- Initialization

	make_with_widgets (a_notebook: EV_NOTEBOOK; a_widget: EV_WIDGET) is
			-- Create `Current' with `notebook' `a_notebook' and `widget' `a_widget'.
			-- Not exported as you may only query  a notebook tab from a notebook
			-- via `item_tab'.
		require
			notebook_not_void: a_notebook /= Void
			widget_not_void: a_widget /= Void
			notebook_has_widget: a_notebook.has (a_widget)
		do
			default_create
			implementation.set_widgets (a_notebook, a_widget)
		ensure
			notebook_set: notebook = a_notebook
			widget_set: widget = a_widget
		end

feature -- Access

	notebook: EV_NOTEBOOK is
			-- Notebook in which `Current' is displayed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.notebook
		ensure
			result_not_void: Result /= Void
		end
		
	widget: EV_WIDGET is
			-- Widget to which `Current' is associated.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.widget
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	is_destroyed: BOOLEAN is
			-- Is `Current' no longer usable?
		do
			Result := implementation.is_destroyed or else not notebook.has (widget)	
		end

feature {NONE} -- Contract Support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_TEXTABLE} and Precursor {EV_PIXMAPABLE}
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_NOTEBOOK_TAB_I
			-- Responsible for interaction with native graphics toolkit.
			
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_NOTEBOOK_TAB_IMP} implementation.make (Current)
		end

invariant
	notebook_not_void: is_usable implies notebook /= Void
	widget_not_void: is_usable implies widget /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_NOTEBOOK_TAB

