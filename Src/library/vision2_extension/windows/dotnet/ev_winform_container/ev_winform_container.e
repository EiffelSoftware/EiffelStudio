indexing
	description: "Objects that allow positioning of Winforms control in a Vision2 system."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WINFORM_CONTAINER
	
inherit
	EV_WEL_CONTAINER
		rename
			item as wel_item,
			has as wel_has,
			put as wel_put,
			replace as wel_replace,
			extend as wel_extend,
			prune as wel_prune,
			linear_representation as wel_linear_representation
		export
			{NONE} wel_item, wel_has,
			wel_put, wel_replace, wel_extend, wel_prune,
			wel_linear_representation
		end

feature -- Access

	item: WINFORMS_CONTROL is
			-- `Result' is WINFORMS_CONTROL contained in `Current'.
		require
			not_destroyed: not is_destroyed
		local
			l_wel_winform_container: WEL_WINFORM_CONTAINER
		do
			l_wel_winform_container ?= wel_item
			if l_wel_winform_container /= Void then
				Result := l_wel_winform_container.winform
			end
		end
	
	has (v: like item): BOOLEAN is
			-- Is `v' contained in `Current'?
		require
			not_destroyed: not is_destroyed
		do
			Result := (v /= Void and then item = v)
		end
		
	linear_representation: LINEAR [CLI_CELL [like item]] is
			-- Representation as a linear structure
		local
			l: LINKED_LIST [CLI_CELL [like item]]
			l_cell: CLI_CELL [like item]
			l_item: like item
		do
			create l.make
			l_item := item
			if l_item /= Void then
				create l_cell.put (l_item)
				l.extend (l_cell)
			end
			Result := l
		end

feature -- Status setting
		
	put, replace  (a_window: like item) is
			-- Replace `child_item' with `a_window'.
		require
			not_destroyed: not is_destroyed
			writeable: writable
			a_window_not_void: a_window /= Void
		local
			l_wel_winform_container: WEL_WINFORM_CONTAINER
		do
			create l_wel_winform_container.make (implementation_window, a_window)
			wel_replace (l_wel_winform_container)
		end
		
	extend (an_item: like item) is
			-- Ensure that structure includes `an_item'.
		do	
			replace (an_item)
		end
		
	prune (v: like item) is
			-- Remove `v' if contained.
		require
			not_destroyed: not is_destroyed
		do
			if item = v then
				wipe_out
			end
		ensure
			v_not_contained: not has (v)
		end

end -- class EV_WINFORM_CONTAINER

--|----------------------------------------------------------------
--| EiffelVision2 Extension: library of reusable components for ISE Eiffel.
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

