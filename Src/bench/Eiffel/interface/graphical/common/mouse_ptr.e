indexing

	description: 
		"Cursor management. To do: Provides features to change %
		%the graphical aspect of the mouse pointer.";
	date: "$Date$";
	revision: "$Revision $"

class MOUSE_PTR  

inherit
	
	GRAPHICS;
	SHARED_CURSORS

creation

	set_watch_cursor, do_nothing

feature -- Setting

	set_watch_cursor is
			-- Display the mouse pointer 
			-- shaped as a watch.
		do
			if not watch_shaped.item then
				set_global_cursor (cur_Watch);
				watch_shaped.set_item (True)
			end
		end;

feature -- Restoring

	restore is
			-- Restore the mouse pointer back to
			-- its arrow shape.
		do
			if watch_shaped.item then
				restore_cursors;
				watch_shaped.set_item (False)
			end
		end

feature {NONE}

	watch_shaped: BOOLEAN_REF is
			-- Is the mouse pointer a watch shape?
		once
			!! Result
		end;
	
end -- class MOUSE_PTR
