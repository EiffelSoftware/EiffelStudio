
class EDITOR_MGR 
	
feature {NONE}

	editor_type: TOP_SHELL;

feature 

	active_editors: LINKED_LIST [like editor_type];
			-- Editors currently active 

feature {NONE}

	free_list: LINKED_LIST [like editor_type];
			-- Editors that has been requested to be destroyed 

	free_list_max: INTEGER;

	identifier: STRING;

	screen: SCREEN;

	make (a_name: STRING; a_screen: SCREEN; i: INTEGER) is
			-- Create a window manager. All editors will be create 
			-- using `a_name' as the identifier and `a_screen' as
			-- the parent.
		do
			free_list_max := i;
			identifier := a_name;
			screen := a_screen;
			!!active_editors.make;
			!!free_list.make
		end;

feature 

	empty_editor: like editor_type is
			-- Retrieve an empty editor. If not found
			-- then create one.
		do
			from
				active_editors.start
			until
				active_editors.after
				or is_empty (active_editors.item)
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
			-- Creates a new editor or retrieves a previously destroyed
			-- (i.e. hidden) editor. 
		local
			mp: MOUSE_PTR
		do
			if
				not free_list.empty
			then
				free_list.start;
				Result := free_list.item;
				free_list.remove;
			else
				!!mp;
				mp.set_watch_shape;
				!!Result.make (identifier, screen);
				mp.restore;
			end;
			active_editors.extend (Result);
		end;

	has (ed: TOP_SHELL): BOOLEAN is
		do
			Result := active_editors.has (ed)
		end;

	
feature {NONE}

	is_empty (ed: like editor_type): BOOLEAN is
		do
		end;

	
feature 

	remove (ed: like editor_type) is
		do
			active_editors.start;
			active_editors.search (ed);
			if not active_editors.after then
				ed.hide;
				active_editors.remove;
				if free_list.count >= free_list_max then
					ed.destroy
				else
					free_list.extend (ed)
				end
			end
		end;

	hide_editors is
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.hide;
				active_editors.forth
			end;
		end;

	show_editors is
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

end 
