indexing
	description: "Eiffel Vision menu item. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_MENU_ITEM_IMP

inherit
	EV_MENU_ITEM_I
		redefine
			interface,
			parent
		end
		
	EV_ITEM_IMP
		undefine
			parent
		redefine
			interface,
			set_capture,
			release_capture,	
			set_heavy_capture,
			release_heavy_capture,
			remove_pixmap,
			set_pixmap
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text,
			text
		end

	EV_ID_IMP

	EV_MENU_ITEM_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the menu item.
		do
			base_make (an_interface)
			make_id
		end

	initialize is
			-- Initialize `is_sensitive' True.
		do
			is_sensitive := True
			is_initialized := True
		end

feature -- Access

	text: STRING is
			-- Text displayed in label.
		do
			Result := wel_text
		end 

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		do
			wel_set_text (a_text)
		end

feature -- Status report

	is_sensitive: BOOLEAN
			-- Can this item be clicked on?
			--| is not a function because we do not want to block the
			-- user from setting the sensitive state while unparented.

feature -- Status setting

	enable_sensitive is
   			-- Set current item sensitive.
		do
			is_sensitive := True
			if has_parent then
				parent_imp.enable_item (id)
			end
   		end

	disable_sensitive is
   			-- Set current item insensitive.
		do
			is_sensitive := False
			if has_parent then
				parent_imp.disable_item (id)
			end
   		end

feature -- Element change

	set_parent_imp (a_parent_imp: like parent_imp) is
			-- Make `a_parent_imp' the parent of `Current'.
		do
			if a_parent_imp /= Void then
				parent_imp := a_parent_imp
			else
				parent_imp := Void
			end
		end

feature {NONE} -- Implementation

	wel_text: STRING is
			-- Caption of the menu item.
			--| For the specification given in the note of EV_MENU_ITEM,
			--| we do not have to take any special action.
			--| Does not return internal toolkit string because it is possible
			--| to set the string without parent.
		do
			if real_text /= Void then
				Result := clone (real_text)
			else
				Result := ""
			end
		end

	real_text: STRING

	wel_set_text (a_text: STRING) is
			-- Set `text' to `a_txt'. See `wel_text'.
		do
			real_text := clone (a_text)
			if has_parent then
				parent_imp.modify_string (a_text, id)
			end
		end

	text_length: INTEGER is
			-- Length of text'.
		do
			if real_text /= Void then
				Result := real_text.count
			end
		end

	parent_imp: EV_MENU_ITEM_LIST_IMP
			-- The menu or menu-bar this item is in.

	parent: EV_MENU_ITEM_LIST is
			-- Item list containing `Current'.
		do
			if parent_imp /= Void then
				Result ?= parent_imp.interface
			end
		end

	has_parent: BOOLEAN is
			-- Is this menu item in a menu?
		do
			Result := parent_imp /= Void and then
				parent_imp.item_exists (id)
		end

	remove_pixmap is
			-- Remove pixmap from `Current'.
		do
			if private_pixmap /= Void then
				private_pixmap := Void
				if parent_imp /= Void then
					parent_imp.internal_replace (
						Current, parent_imp.index_of (interface, 1))
				end
			end
		end

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		local
			pos: INTEGER
		do
			--|FIXME Currently, either the text or the pixmap can be displayed.
			--| We need to be able to display both.
			--| Also, when loading a pixmap directly from an icon, the
			--| transparent color is displayed visibly.
			Precursor (a_pixmap)
			if parent_imp /= Void then
				pos := parent_imp.index_of (interface, 1)
				parent_imp.internal_replace (Current, pos)

			end
		end

feature {EV_ANY_I} -- Pick and Drop

	set_capture is
			-- Grab user input.
			-- Works only on current windows thread.
		do
			--| To be implemented.
			--| This may work without redefinition.
			--| These have been left as re-defined to make sure it is not
			--| overlooked in the future.
			check
				To_be_implemented: False
			end
		end

	release_capture is
			-- Release user input.
			-- Works only on current windows thread.
		do
			--| To be implemented.
			--| This may work without redefinition.
			--| These have been left as re-defined to make sure it is not
			--| overlooked in the future.
			check
				To_be_implemented: False
			end
		end

	set_heavy_capture is
			-- Grab user input.
			-- Works on all windows threads.
		do
			--| To be implemented.
			--| This may work without redefinition.
			--| These have been left as re-defined to make sure it is not
			--| overlooked in the future.
			check
				To_be_implemented: False
			end
		end

	release_heavy_capture is
			-- Release user input
			-- Works on all windows threads.
		do
			--| To be implemented.
			--| This may work without redefinition.
			--| These have been left as re-defined to make sure it is not
			--| overlooked in the future.
			check
				To_be_implemented: False
			end
		end

feature {NONE} -- Contract Support

	parent_is_sensitive: BOOLEAN is
			-- is parent of `Current' sensitive?
		do
			if parent_imp /= Void then
				Result := parent_imp.is_sensitive
			end
		end


feature {EV_ANY_I} -- Implementation

	on_activate is
			-- `Current' has been clicked on.
		do
			if select_actions_internal /= Void then
				select_actions_internal.call ([])
			end
		end

	interface: EV_MENU_ITEM

end -- class EV_MENU_ITEM_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

