note
	description: "Objects that represent a tab associated with a notebook item."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_NOTEBOOK_TAB_IMP

inherit
	EV_NOTEBOOK_TAB_I
		redefine
			interface,
			set_widgets
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text
		end

	EV_PIXMAPABLE_I
		redefine
			interface,
			remove_pixmap,
			set_pixmap,
			pixmap
		end

	EV_ANY_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create tab_view_item.make
			initialize_textable
			set_is_initialized (True)
		end

	pixmap: EV_PIXMAP
			-- Image displayed on `Current' or Void if none.
		do
			-- FIXME Currently not implemented on Mac OS X
			create Result
		end

feature -- Element change

	set_widgets (a_notebook: EV_NOTEBOOK; a_widget: EV_WIDGET)
		do
			Precursor {EV_NOTEBOOK_TAB_I} (a_notebook, a_widget)
			if attached {EV_WIDGET_IMP} a_widget.implementation as v_imp then
				tab_view_item.set_view (v_imp.attached_view)
			end
		end

	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to `text'.
		do
			Precursor {EV_TEXTABLE_IMP} (a_text)
			tab_view_item.set_label (a_text)
		end

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Assign `a_pixmap' to `pixmap'.
		do
			-- FIXME Currently not implemented on Mac OS X
		end

	remove_pixmap
			-- Make `pixmap' `Void'.
		do
			-- FIXME Currently not implemented on Mac OS X
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

feature {EV_ANY_I} -- Implementation

	tab_view_item: NS_TAB_VIEW_ITEM

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_NOTEBOOK_TAB note option: stable attribute end;

end -- class EV_NOTEBOOK_TAB_IMP
