indexing
	description: "Child window of frame window containing an OLE compound file"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CHILD_WINDOW

inherit

	WEL_MDI_CHILD_WINDOW
		rename
			make as mdi_child_window_make        
		redefine
			class_icon,
			on_size,
			on_window_pos_changed
		end

	WEL_SIZE_CONSTANTS
		export
			{NONE} all
		end

	WEL_SM_CONSTANTS
		export
			{NONE} all
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	EOLE_STGTY
		export
			{NONE} all
		end

	EOLE_STGM
		export
			{NONE} all
		end

	EOLE_ERROR_CODE
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (p: WEL_MDI_FRAME_WINDOW; name: STRING) is
			-- Create MDI child window with parent `p' and
			-- title `name', then build associated tree view.
		local
			mess_box: WEL_MSG_BOX
			tvitem: WEL_TREE_VIEW_ITEM
			tvinss: WEL_TREE_VIEW_INSERT_STRUCT
		do
			create storage.make
			if storage.is_compound_file (name) then
				storage.open_compound_file (name, Stgm_share_deny_write)
				if storage.status.last_hresult = STG_E_SHAREVIOLATION then
					create mess_box.make
					mess_box.error_message_box (p, "Sharing Violation", "Read error")
				elseif storage.status.last_hresult = S_OK then
					storage.add_ref
					mdi_child_window_make (p, name)
					create tree_view.make (Current, 0, 0, width - 8, height - 27, 0)
					create tvitem.make
					create tvinss.make
					tvitem.set_text ("Root")
					tvinss.set_parent (tree_view.last_item)
					tvinss.set_last
					tvinss.set_tree_view_item (tvitem)
					tree_view.insert_item (tvinss)
					create_tree_view (tree_view.last_item, storage)
				else					
					create mess_box.make
					mess_box.error_message_box (p, "Can not open file", "Open error")
				end
			else
				create mess_box.make
				mess_box.error_message_box (p, "Sorry, not a compound file !!", "Read error")
			end
		end
	
	create_tree_view (p: INTEGER; stor: EOLE_STORAGE) is
			-- Recursively create tree view with parent `p'
			-- and associated compound file `stor'
			-- `elements' is used for efficiency.
		local
			index: INTEGER
			tvitem: WEL_TREE_VIEW_ITEM
			tvinss: WEL_TREE_VIEW_INSERT_STRUCT
			substorage: EOLE_STORAGE
			tex: STRING
			elements: ARRAY [EOLE_STATSTG]
		do
			from
				elements := stor.enum_elements
				index := elements.lower
				create tvitem.make
				create tvinss.make
				create tex.make (0)
			until
				index = elements.upper + 1
			loop
				tex := stgty_string (elements.item (index).element_type)
				tex.append (elements.item (index).element_name)
				tvitem.set_text (clone (tex))
				tvinss.set_parent (p)
				tvinss.set_last
				tvinss.set_tree_view_item (clone (tvitem))
				tree_view.insert_item (tvinss)
				if elements.item (index).element_type = STGTY_STORAGE then
					create substorage.make
					substorage := clone (stor).open_substorage (elements.item (index).element_name, STGM_SHARE_EXCLUSIVE)
					create_tree_view (tree_view.last_item, substorage)
				end
				index := index + 1
             end
			 stor.release
		end

feature -- Access

	tree_view: WEL_TREE_VIEW
			-- Associated tree view

	storage: EOLE_STORAGE
			-- Associated root file

feature -- Basic operations

	on_size (size_type, w, h: INTEGER) is
			-- Resize tree view to width `w'and height `h'.
			-- `size_type' indicates form of resizing.
		do
			if size_type = Size_minimized then
				tree_view.minimize
			elseif size_type = Size_restored then
				tree_view.restore
			else
				tree_view.move_and_resize (0, 0, w - 8, h - 27, true)
			end
		end

	 on_window_pos_changed (window_pos: WEL_WINDOW_POS) is
			-- Move tree view to `window_pos'and resize accordingly.
		do
			tree_view.move_and_resize (0, 0, window_pos.width - 8,
			window_pos.height - 27, true)
		end

feature {NONE} -- Implementation

	stgty_string (stgty_constant: INTEGER): STRING is
			-- String value of EOLE_STGTY constants
		do
			if stgty_constant = STGTY_LOCKBYTES then
				Result := "Lock Bytes: "
			elseif stgty_constant = STGTY_STREAM then
				Result := "Stream: "
			elseif stgty_constant = STGTY_STORAGE	then
				Result := "Storage: "
			end
		end

	class_icon: WEL_ICON is
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_child_window)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CHILD_WINDOW

