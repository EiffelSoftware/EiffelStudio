
class EDITOR_MGR 

inherit

	CURSOR_W;
	GRAPHICS;
	
feature {NONE}

	active_editors: LINKED_LIST [like editor_type];
			-- Editors currently active 

	editor_type: BAR_AND_TEXT;
			-- Abstract window type. Redefined in descendants
			-- for specific window creation

	free_list: LINKED_LIST [like editor_type];
			-- Editors that has been requested to be destroyed 

	free_list_max: INTEGER;

	screen: SCREEN;
			-- Screen used for window creation

	make (a_screen: SCREEN; i: INTEGER) is
			-- Create a window manager. All editors will be create 
			-- with `a_screen' as the parent.
		do
			free_list_max := i;
			screen := a_screen;
			!!active_editors.make;
			!!free_list.make
		end;

feature {WINDOW_MGR}

	count: INTEGER is
		do
			Result := active_editors.count
		end;

	empty_editor: like editor_type is
			-- Retrieve an empty editor. If not found
			-- then create one.
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.forth
			end;
			if not active_editors.after then
				Result := active_editors.item
			else
				Result := editor
			end
		end;

	editor: like editor_type is
			-- Creates new editor. (Either creates one or
			-- retrieves one from the free_list).
		do
			if
				not free_list.empty
			then
				free_list.start;
				Result := free_list.item;
				free_list.remove;
			else
				set_global_cursor (watch_cursor);
				!!Result.make (screen);
				restore_cursors;
			end;
			active_editors.add (Result);
		end;

	has (ed: like editor_type): BOOLEAN is
			-- Is editor `ed' displayed?
		do
			Result := active_editors.has (ed)
		end;

	hide_editors is
			-- Hide all active editors.
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.hide;
				active_editors.item.close_windows;
				active_editors.forth
			end;
		end;

	show_editors is
			-- Show all active editors.
		local
			ed: like editor_type
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				ed := active_editors.item;
				ed.show;
				ed.set_x_y (ed.x, ed.y);
				active_editors.forth
			end
		end;

	remove (ed: like editor_type) is
			-- Remove an editor `ed'.
		do
			active_editors.start;
			active_editors.search (ed);
			if
				not active_editors.after
			then
				ed.hide;
				ed.reset;
				active_editors.remove;
				if free_list.count >= free_list_max then
					ed.destroy
				else
					free_list.add (ed)
				end;
			else
					--| Should never happen but this is ultra
					--| safe programming.
				ed.hide;
				ed.reset;
				ed.destroy;
			end;
		end;

	raise_editors is
			-- Raise all active editors.
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.raise;
				active_editors.forth
			end
		end;

end 
