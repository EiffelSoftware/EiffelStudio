indexing
	description: "Objects that represent a tab associated with a notebook item. MsWindows implementation."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_NOTEBOOK_TAB_IMP
	
inherit
	EV_NOTEBOOK_TAB_I
		redefine
			interface
		end
		
	EV_TEXTABLE_IMP
		redefine
			interface
		end
	
	EV_PIXMAPABLE_IMP
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
			is_initialized := True
		end
		
	pixmap: EV_PIXMAP is
			-- Image displayed on `Current' or Void if none.
		do
			if notebook /= Void then
			--	Result := notebook_imp.item_pixmap (widget)
			end
		end

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		do
			if notebook /= Void then
			--	notebook_imp.set_item_pixmap (widget, a_pixmap)	
			end
		end

	remove_pixmap is
			-- Make `pixmap' `Void'.
		do
			if notebook /= Void then
				--notebook_imp.set_item_pixmap (widget, Void)
			end
		end
		
--	wel_text: STRING is
--			-- Text displayed in label.
--		do
--			if notebook /= Void then
--				Result := notebook_imp.item_text (widget)
--			else
--					-- Although when `notebook' is Void it is not possible to query
--					-- `text' from the interface, this must be set to an empty string as
--					-- otherwise assertions fail during creation.
--				Result := ""
--			end
--		end
		
	text_length: INTEGER is
			-- Number of characters making up `text'.
		do
			Result := 0--wel_text.count
		end

	needs_event_box: BOOLEAN is False

feature -- Element change

--	wel_set_text (a_text: STRING) is
--			-- Assign `a_text' to `text'.
--		do
--			if notebook /= Void then
--				notebook_imp.set_item_text (widget, a_text)
--			end
--		end

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
			is_destroyed := True
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_NOTEBOOK_TAB

end -- class EV_NOTEBOOK_TAB_IMP

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

