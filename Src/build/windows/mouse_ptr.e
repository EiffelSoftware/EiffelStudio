
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
	
	WINDOWS
		export
			{NONE} all
		end



	
feature {NONE}

	Watch_cursor: SCREEN_CURSOR is
			-- Watch cursor
		once
			!!Result.make;
			Result.set_type (Result.Watch)
		end; 

	watch_shaped: BOOLEAN;
			-- Has the mouse pointer a watch shape?

	
feature 

	set_watch_shape is
			-- Display the mouse pointer 
			-- shaped as a watch.
		do
			if not watch_shaped then
				check (global_cursor = Void) end;
				set_global_cursor (Watch_cursor);
				watch_shaped := True
			end
		end;

	restore is
			-- Restore the mouse pointer back to
			-- its arrow shape.
		do
			if watch_shaped then
				check not (global_cursor = Void) end;
				restore_cursors;
				watch_shaped := False
			end
		end

end -- class MOUSE_PTR
