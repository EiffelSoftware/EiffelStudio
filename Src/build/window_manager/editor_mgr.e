indexing
	description: "Editor manager."
	Id: "$Id$" 
	Date: "$Date$"
	Revision: "$Revision$"

class EDITOR_MGR 
	
feature {NONE} -- Initialization

	make (par: EV_WINDOW; i: INTEGER) is
			-- Create a window manager. All editors will be create 
			-- using `nm' as the identifier and `par' as
			-- the parent.
		do
			free_list_max := i
			parent := par
			create active_editors.make
			create free_list.make
		end

	editor_type: EB_WINDOW

feature -- Access

	active_editors: LINKED_LIST [like editor_type]
			-- Editors currently active 

	editor: like editor_type is
			-- Creates a new editor or retrieves a previously destroyed
			-- (i.e. hidden) editor.
--		local
--			mp: MOUSE_PTR
		do
			if
				not free_list.empty
			then
				free_list.start
				Result := free_list.item
				free_list.remove
			else
--				!!mp
--				mp.set_watch_shape
				create Result.make (parent)
--				Result.set_x_y (screen.x, screen.y)
--				mp.restore
			end
			active_editors.extend (Result)
		end

	has (ed: like editor_type): BOOLEAN is
		do
			Result := active_editors.has (ed)
		end

	remove (ed: like editor_type) is
		do
			active_editors.start
			active_editors.search (ed)
			if not active_editors.after then
				active_editors.remove
				ed.hide
				if free_list.count >= free_list_max then
					ed.destroy
				else
					ed.set_geometry
					free_list.extend (ed)
				end
			end
		end

	clear_editors is
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				clear_editor (active_editors.item)
				active_editors.forth
			end
		end

	hide_editors is
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.hide
				active_editors.forth
			end
		end

	show_editors is
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.show
				active_editors.forth
			end
		end

feature {NONE} -- Implementation

	free_list: LINKED_LIST [like editor_type]
			-- Editors that has been requested to be destroyed

	free_list_max: INTEGER

	parent: EV_WINDOW

	clear_editor (ed: like editor_type) is
		do
		end

end -- class EDITOR_MGR

