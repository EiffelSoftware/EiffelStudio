indexing
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
			interface,
			remove_pixmap,
			set_pixmap,
			pixmap
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
		end

	initialize is
			-- Initialize `Current'.
		do
			set_is_initialized (True)
		end

	pixmap: EV_PIXMAP is
			-- Image displayed on `Current' or Void if none.
		do
			if notebook /= Void then
				Result := notebook_imp.item_pixmap (widget)
			end
		end

	text: STRING_32 is
			-- Text displayed on `Current'
		do
			if notebook /= Void then
				Result := notebook_imp.item_text (widget)
			else
				create Result.make (0)
			end
		end

feature -- Element change

	set_text (a_text: STRING_GENERAL) is
			-- Assign `a_text' to `text'.
		do
			if notebook /= Void then
				notebook_imp.set_item_text (widget, a_text)
			end
		end

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		do
			if notebook /= Void then
				notebook_imp.set_item_pixmap (widget, a_pixmap)
			end
		end

	remove_pixmap is
			-- Make `pixmap' `Void'.
		do
			if notebook /= Void then
				notebook_imp.set_item_pixmap (widget, Void)
			end
		end

feature {NONE} -- Implementation

	notebook_imp: EV_NOTEBOOK_IMP is
			-- Access to implementation of `notebook'.
			-- Note that `Result' may be `Void' if `notebook' is.
		do
			Result ?= notebook.implementation
		ensure
			not_void_if_notebook_not_void: notebook /= Void implies result /= Void
		end

	destroy is
			-- Destroy underlying native toolkit objects.
			-- Render `Current' unusable.
			-- Any feature calls after a call to destroy are
			-- invalid.
		do
			set_is_destroyed (True)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_NOTEBOOK_TAB;

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




end -- class EV_NOTEBOOK_TAB_IMP

