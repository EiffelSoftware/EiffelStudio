
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
			click_list: ARRAY [CLICK_STONE];
			root_stone, obj_stone: OBJECT_STONE;
			i: INTEGER
		do
			from
				!! Result.make;
				active_editors.start
			until
				active_editors.after
			loop
				root_stone ?= active_editors.item.text_window.root_stone;
				if root_stone /= Void then
					click_list := root_stone.click_list;
					if click_list /= Void then
						from
							i := click_list.lower
						until
							i > click_list.upper
						loop
							obj_stone ?= click_list.item (i).node;
							if obj_stone /= Void then
								Result.add (obj_stone.object_address)
							end;
							i := i + 1
						end
					end;
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
