
class OBJECT_WIN_MGR 

inherit

	EDITOR_MGR
		redefine
			editor_type
		end

creation

	make

feature

	objects_kept: LINKED_SET [STRING] is
			-- Hector references to objects clickable from object tools
		local
			text_window: TEXT_STRUCT;
			click_list: ARRAY [CLICK_STONE];
			obj_stone: OBJECT_STONE;
			i, clickable_count: INTEGER
		do
			from
				!! Result.make;
				active_editors.start
			until
				active_editors.after
			loop
				text_window := active_editors.item.text_window;
				clickable_count := text_window.clickable_count;
				click_list := text_window;
				from
					i := 1
				until
					i > clickable_count
				loop
					obj_stone ?= click_list.item (i).node;
					if obj_stone /= Void then
						Result.extend (obj_stone.object_address)
					end;
					i := i + 1
				end;
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
				active_editors.item.text_window.synchronize;
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

feature {NONE}

	editor_type: OBJECT_W;
	
end 
