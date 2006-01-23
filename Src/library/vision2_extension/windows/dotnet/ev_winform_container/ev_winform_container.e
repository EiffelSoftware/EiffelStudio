indexing
	description: "Objects that allow positioning of Winforms control in a Vision2 system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		
	linear_representation: LINEAR [like item] is
			-- Representation as a linear structure
		local
			l_res: ARRAYED_LIST [like item]
			l_item: like item
		do
			create l_res.make (1)
			l_item := item
			if l_item /= Void then
				l_res.extend (l_item)
			end
			Result := l_res
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




end -- class EV_WINFORM_CONTAINER

