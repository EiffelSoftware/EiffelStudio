
class EDITOR_MGR 
	
feature {NONE}

	editor_type: EB_TOP_SHELL;

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

	editor: like editor_type is
			-- Creates a new editor or retrieves a previously destroyed
			-- (i.e. hidden) editor. 
		local
			mp: MOUSE_PTR;
			new_x, new_y: INTEGER
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
				new_x := screen.x;
				new_y := screen.y;
				if new_x + Result.width > screen.width then
					new_x := screen.width - Result.width
				end;
				if new_x < 0 then
					new_x := 0
				end;
				if new_y + Result.height > screen.height then
					new_y := screen.height - Result.height
				end;
				if new_y < 0 then
					new_y := 0
				end;
				Result.set_x_y (new_x, new_y);
				mp.restore;
			end;
			active_editors.extend (Result);
		end;

	has (ed: EB_TOP_SHELL): BOOLEAN is
		do
			Result := active_editors.has (ed)
		end;

feature {NONE}

	clear_editor (ed: like editor_type) is
		do
		end;

feature 

	remove (ed: like editor_type) is
		do
			active_editors.start;
			active_editors.search (ed);
			if not active_editors.after then
				active_editors.remove;
				ed.hide;
				if free_list.count >= free_list_max then
					ed.destroy
				else
					ed.set_geometry;
					free_list.extend (ed)
				end
			end
		end;

	clear_editors is
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				clear_editor (active_editors.item);
				active_editors.forth
			end;
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
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.show;
				active_editors.forth
			end
		end;

end 
