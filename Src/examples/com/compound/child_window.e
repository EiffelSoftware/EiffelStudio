indexing
	description: "Child window of frame window containing an OLE compound file"
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
			on_window_pos_changed,
			on_notify
		end

	EXCEPTIONS
		rename
			class_name as exception_class_name
		export
			{NONE} all
		end

	ECOM_STORAGE_ROUTINES
		export
			{NONE} all
		end

	WEL_SIZE_CONSTANTS
		export
			{NONE} all
		end

	WEL_SM_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVIF_CONSTANTS
		export
			{NONE} all
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	ECOM_STGTY
		export
			{NONE} all
		end

	ECOM_STGM
		export
			{NONE} all
		end

	ECOM_EXCEPTION_CODES
		export
			{NONE} all
		end

creation
	make

feature -- Initialization

	make (p: WEL_MDI_FRAME_WINDOW; name: STRING) is
			-- Create MDI child window with parent `p' and
			-- title `name', then build associated tree view.
		local
			mess_box: WEL_MSG_BOX
			tvitem: WEL_TREE_VIEW_ITEM
			tvinss: WEL_TREE_VIEW_INSERT_STRUCT
			retried: BOOLEAN
			file_name: FILE_NAME
		do
			if not retried then
				create tvitem_table.make (5)
				if is_compound_file (name) then
					create file_name.make_from_string (name)
					create storage.make_open_file (file_name, Stgm_share_deny_write)
					mdi_child_window_make (p, name)
					create tree_view.make (Current, 0, 0, width, height, Tree_view_id)
					create tvitem.make
					create tvinss.make
					tvitem.set_text (Root_item_title)
					tvinss.set_parent (tree_view.last_item)
					tvinss.set_last
					tvinss.set_tree_view_item (tvitem)
					tree_view.insert_item (tvinss)
					create_tree_view (tree_view.last_item, storage)
				else
					create mess_box.make
					mess_box.error_message_box (p, "Sorry, not a compound file.", "Read error")
				end
			end
		rescue
			if exception =  Stg_e_shareviolation then
				create mess_box.make
				mess_box.error_message_box (p, "Sharing Violation", "Read error")
				retried := True
				retry
			else					
				create mess_box.make
				mess_box.error_message_box (p, "Can not open file", "Open error")
				retried := True
				retry
			end
		end
	
	new_tvitem (stor: ECOM_STORAGE; stream_name: STRING): WEL_TREE_VIEW_ITEM is
			-- New tree view item referencing stream `stream_name' in storage `stor'
		do
			tvitem_table.put ([stor, stream_name], tvitem_table_count)
			create Result.make
			Result.set_mask (Result.mask + Tvif_param)
			Result.set_lparam (tvitem_table_count)
			tvitem_table_count := tvitem_table_count + 1
		end

	create_tree_view (p: POINTER; stor: ECOM_STORAGE) is
			-- Recursively create tree view with parent `p'
			-- and associated compound file `stor'
			-- `elements' is used for efficiency.
		local
			substorage: ECOM_STORAGE
			tex: STRING
			elements: ECOM_ENUM_STATSTG
			statstg: ECOM_STATSTG
			tvitem: WEL_TREE_VIEW_ITEM
			tvinss: WEL_TREE_VIEW_INSERT_STRUCT
		do
			from
				elements := stor.elements
				elements.reset
				statstg := elements.next_item
				create tex.make (0)
			until
				statstg = Void
			loop
				tvitem := new_tvitem (stor, clone (statstg.name))
				create tvinss.make
				tex := stgty_string (statstg.type)
				tex.append (statstg.name)
				tvitem.set_text (tex)
				tvinss.set_parent (p)
				tvinss.set_last
				tvinss.set_tree_view_item (tvitem)
				tree_view.insert_item (tvinss)
				if statstg.type = Stgty_storage then
					substorage := stor.retrieved_substorage (statstg.name, Stgm_share_exclusive)
					create_tree_view (tree_view.last_item, substorage)
				end
				statstg := elements.next_item
             end
		end

feature -- Access

	tree_view: WEL_TREE_VIEW
			-- Associated tree view

	storage: ECOM_STORAGE
			-- Associated root file

feature -- Message Processing

	on_size (size_type, w, h: INTEGER) is
			-- Resize tree view to width `w'and height `h'.
			-- `size_type' indicates form of resizing.
		do
			if tree_view /= Void and then tree_view.exists then
				if size_type = Size_minimized then
					tree_view.minimize
				elseif size_type = Size_restored then
					tree_view.restore
				else
					tree_view.move_and_resize (0, 0, w, h, true)
				end
			end
		end

	 on_window_pos_changed (window_pos: WEL_WINDOW_POS) is
			-- Move tree view to `window_pos'and resize accordingly.
		do
			if tree_view /= Void and then tree_view.exists then
				tree_view.move_and_resize (0, 0, window_pos.width,
				window_pos.height, true)
			end
		end

	on_notify (control_id: INTEGER; info: WEL_NMHDR) is
			-- Notifications processing
		local
			stor: ECOM_STORAGE
			name: STRING
			stream: ECOM_STREAM
			stream_display: STREAM_DISPLAY_WINDOW
			retried: BOOLEAN
			mess_box: WEL_MSG_BOX
   		do
			if not retried then
				if control_id = Tree_view_id and then info.code = -3 and not tree_view.selected_item.text.is_equal (Root_item_title) then
					stor ?= tvitem_table.item (tree_view.selected_item.lparam).item (1)
					check
						non_void_storage: stor /= Void
					end
					name ?= tvitem_table.item (tree_view.selected_item.lparam).item (2)
					check
						non_void_name: name /= Void
					end
					stream := stor.retrieved_stream (name, Stgm_share_exclusive)
					create stream_display.make (stream)
				end
			end
		rescue
			create mess_box.make
			mess_box.error_message_box (Current, "Can not open stream", "Open error")
			retried := True
			retry
 		end

feature {NONE} -- Implementation

	tvitem_table: HASH_TABLE [TUPLE [ECOM_STORAGE, STRING], INTEGER]
			-- Table of streams identified by their contening storage and name
			-- Index kept in tree view item for later retrieval in `on_notify'

	stgty_string (stgty_constant: INTEGER): STRING is
			-- String value of ECOM_STGTY constants
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

	Tree_view_id: INTEGER is 0
			-- Tree view control id

	tvitem_table_count: INTEGER
			-- Next free index in `tvitem_table'

	Root_item_title: STRING is "Root"
			-- Root storage displayed name

end -- class CHILD_WINDOW

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Tree_view_bottom_margin0 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
