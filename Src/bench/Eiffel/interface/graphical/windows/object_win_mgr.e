
class OBJECT_WIN_MGR 

inherit

	EDITOR_MGR
		redefine
			editor_type, synchronize, editor
		end

creation

	make

feature

	objects_kept: LINKED_SET [STRING] is
			-- Hector references to objects clickable from object tools
		do
			!! Result.make;
			from
				active_editors.start
			until
				active_editors.after
			loop
				Result.merge (active_editors.item.text_window.kept_objects);
				active_editors.forth
			end
		end;

	synchronize is
			-- Synchronize object tools (after the application stopped).
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.synchronize;
				active_editors.forth
			end
		end;

	hang_on is
			-- Make object addresses unclickable (during application execution).
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.text_window.hang_on;
				active_editors.forth
			end
		end;

	reset is
			-- Reset each object tool.
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.reset;
				active_editors.forth
			end
		end;

feature {WINDOW_MGR}

	editor: like editor_type is
			-- Creates new editor. (Either creates one or
			-- retrieves one from the free_list).
		do
			if	not free_list.empty	then
				free_list.start;
				Result := free_list.item;
				Result.set_default_position;
				Result.text_window.set_tab_length_to_default;
				Result.text_window.set_font_to_default;
				Result.text_window.set_default_sp_bounds;
				free_list.remove
			else
				set_global_cursor (watch_cursor);
				!!Result.make (screen);
				restore_cursors
			end;
			active_editors.extend (Result)
		end;


feature {NONE}

	editor_type: OBJECT_W;
	
end 
