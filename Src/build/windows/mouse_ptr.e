
--====================== class MOUSE_PTR ============================
--
-- Author: Deramat
-- Last revision: 11/22/91
-- Bugs:
-- TODO:
--
-- Provides features to change the graphical aspect of the mouse pointer
--
--===================================================================

class MOUSE_PTR  

inherit
	
	GRAPHICS;
	CONSTANTS

feature {NONE}

	Watch_cursor: EV_CURSOR is
			-- Watch cursor
		do
			Result := Cursors.watch_cursor
		end; 

	watch_shaped: BOOLEAN_REF is
			-- Has the mouse pointer a watch shape?
		once
			!! Result
		end;
	
feature 

	set_watch_shape is
			-- Display the mouse pointer 
			-- shaped as a watch.
		do
			if not watch_shaped.item then
				set_global_cursor (Watch_cursor);
				watch_shaped.set_item (True)
			end
		end;

	restore is
			-- Restore the mouse pointer back to
			-- its arrow shape.
		do
			if watch_shaped.item then
				restore_cursors;
				watch_shaped.set_item (False)
			end
		end

end -- class MOUSE_PTR
