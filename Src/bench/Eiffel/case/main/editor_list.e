indexing

	description: 
		"List of editor windows. Manages all editors created.";
	date: "$Date$";
	revision: "$Revision $"

class EDITOR_LIST [T->EC_EDITOR_WINDOW [ANY]]

inherit

	LINKED_LIST [T]

creation

	make

feature -- Properties

	freed_window: T is
		do
		--	from
		--		start
		--	until
		--		after or else Result /= Void
		--	loop
		--		if item.is_in_free_list then
		--			Result := item;
		--		end;
		--		forth
		--	end
		end;

feature -- Access

	window (a_data: DATA): T is
			-- The editor window to edit a_data
			-- Void if no window is opened
		require
			has_data: a_data /= void
		do
			from
				start
			until
				after or (Result /= void)
			loop
				if a_data = item.entity then
					Result := item
				end;
				forth
			end;
		end; -- editor_windows

feature -- Update

	update_all_windows is
			-- Update all windows associated with editor.
		do
		--	from
		--		start
		--	until
		--		after
		--	loop
		--		if item.entity /= Void then
		--			item.set_entity (item.entity)	
		--		end;
		--		forth
		--	end
		end;

feature -- Removal

	clear_all_windows is
		do
		--	from
		--		start
		--	until
		--		after
		--	loop
		--		if not item.is_in_free_list then
		--			item.clear;
		--		end;
		--		forth
		--	end
		end;

end -- class EDITOR_LIST [T->EDITOR_WINDOW]
