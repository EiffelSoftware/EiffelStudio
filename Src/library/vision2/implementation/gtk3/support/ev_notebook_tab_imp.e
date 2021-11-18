note
	description: "Objects that represent a tab associated with a notebook item."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_NOTEBOOK_TAB_IMP

inherit
	EV_NOTEBOOK_TAB_I
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

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			set_is_initialized (True)
		end

	pixmap: detachable EV_PIXMAP
			-- Image displayed on `Current' or Void if none.
		do
			if attached notebook_imp as l_notebook_imp and then attached widget as l_widget then
				Result := l_notebook_imp.item_pixmap (l_widget)
			end
		end

	text: STRING_32
			-- Text displayed on `Current'
		do
			if attached notebook_imp as l_notebook_imp and then attached widget as l_widget then
				Result := l_notebook_imp.item_text (l_widget)
			else
				create Result.make (0)
			end
		end

feature -- Element change

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to `text'.
		do
			if attached notebook_imp as l_notebook_imp and then attached widget as l_widget then
				l_notebook_imp.set_item_text (l_widget, a_text)
			end
		end

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Assign `a_pixmap' to `pixmap'.
		do
			if attached notebook_imp as l_notebook_imp and then attached widget as l_widget then
				l_notebook_imp.set_item_pixmap (l_widget, a_pixmap)
			end
		end

	remove_pixmap
			-- Make `pixmap' `Void'.
		do
			if attached notebook_imp as l_notebook_imp and then attached widget as l_widget then
				l_notebook_imp.set_item_pixmap (l_widget, Void)
			end
		end

feature {NONE} -- Implementation

	notebook_imp: detachable EV_NOTEBOOK_IMP
			-- Access to implementation of `notebook'.
			-- Note that `Result' may be `Void' if `notebook' is.
		do
			if attached notebook as l_notebook then
				Result ?= l_notebook.implementation
			end
		ensure
			not_void_if_notebook_not_void: notebook /= Void implies result /= Void
		end

	destroy
			-- Destroy underlying native toolkit objects.
			-- Render `Current' unusable.
			-- Any feature calls after a call to destroy are
			-- invalid.
		do
			set_is_destroyed (True)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_NOTEBOOK_TAB note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_NOTEBOOK_TAB_IMP
