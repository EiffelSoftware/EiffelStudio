
note
	description: "Objects that makes Carbon's DataBrowser control easily accessible"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CARBON_DATABROWSER-- [G]-- -> EV_CARBON_DATABROWSER_ITEM]

inherit
	EV_ANY_IMP

	DATA_BROWSER_ITEM_DATA_PROC_PTR_CALLBACK
		rename
			on_callback as get_set_item_data_callback
		end

	DATA_BROWSER_ITEM_NOTIFICATION_PROC_PTR_CALLBACK
		rename
			on_callback as item_notification_callback
		end

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

--create
--	make

feature -- Creation

		make (an_interface: like interface)
				--
		local
			ptr: POINTER
			rect: RECT_STRUCT
			ret: INTEGER
		do
			base_make (an_interface)

			create rect.make_new_unshared
			rect.set_right (300)
			rect.set_bottom (100)
			ret := create_data_browser_control_external (null, rect.item, {CONTROLDEFINITIONS_ANON_ENUMS}.kDataBrowserListView, $ptr)
			set_c_object (ptr)

			ret := set_data_browser_has_scroll_bars_external (ptr, 0, 1) -- set a vertical scrollbar only

			if get_set_item_data_dispatcher = Void then
				create get_set_item_data_dispatcher.make (current)
			end
			if item_notification_dispatcher = Void then
				create item_notification_dispatcher.make (current)
			end


			do_ugly_things (c_object, get_set_item_data_dispatcher.c_dispatcher, item_notification_dispatcher.c_dispatcher)
			create_list (1)
			tree_list.extend ([current, c_object])

			id_count := 1
			create free_ids.make
			create item_list.make ( 1, 20 )
		end

	initialize
			--
		do

		end


	insert_i_th (v: EV_ANY; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			item: like db_item
			ret: INTEGER
			id: INTEGER
		do
			item ?= v.implementation
			--item.set_parent_imp (Current)

			-- carbon specifics:
			item.add_item_and_children_to_parent_tree (Current, Void, i);
			id := item.item_id
			ret := add_data_browser_items_external (c_object, 0, 1, $id, {CONTROLDEFINITIONS_ANON_ENUMS}.kDataBrowserItemNoProperty);
			-- 2nd argument should be: {CONTROLDEFINITIONS_ANON_ENUMS}.kDataBrowserNoItem
		end

	remove_id (a_id: INTEGER)
			-- Remove item at `a_position'
		local
			ret: INTEGER
		do
			-- TODO: remove the id (and those of children) from the 'item_list'
			ret := remove_data_browser_items_external (c_object, 0, 1, $a_id, {CONTROLDEFINITIONS_ANON_ENUMS}.kDataBrowserItemNoProperty);
			-- 2nd argument should be: {CONTROLDEFINITIONS_ANON_ENUMS}.kDataBrowserNoItem
		end

	selected_item_imp: like db_item

	set_selected_item_imp (an_item: like db_item)
			--
		do
			selected_item_imp := an_item
		end


feature -- settings

	show_title_row
			-- Show the row of the titles.
		local
			ret: INTEGER
		do
			ret := set_data_browser_list_view_header_btn_height_external (c_object, 15)
		end

	hide_title_row
			-- Hide the row of the titles.
		local
			ret: INTEGER
		do
			ret := set_data_browser_list_view_header_btn_height_external (c_object, 0)
		end

	set_disclosure_column
			--
		local
			ret: INTEGER
		do
			-- Make the column (ID 1) have the disclosure triangles.
			ret := set_data_browser_list_view_disclosure_column_external ( c_object, 1, 0 );
		end


feature -- internals

	add_list_view_column (an_identity: INTEGER; a_type: INTEGER; a_minwidth: INTEGER; a_maxwidth: INTEGER; a_title_string: STRING): INTEGER
			-- Add a column to the list view of the data browser
		local
			ret: INTEGER
			listviewcolumndesc: DATA_BROWSER_LIST_VIEW_COLUMN_DESC_STRUCT
			listviewheaderdesc: DATA_BROWSER_LIST_VIEW_HEADER_DESC_STRUCT
			tableviewcolumndesc: DATA_BROWSER_PROPERTY_DESC_STRUCT
			cfstring: EV_CARBON_CF_STRING
			fontstyle: CONTROL_FONT_STYLE_REC_STRUCT
			fontinfo: CONTROL_BUTTON_CONTENT_INFO_STRUCT


		do

			create listviewcolumndesc.make_new_unshared

			create tableviewcolumndesc.make_new_unshared
			tableviewcolumndesc.set_propertyid (an_identity)
			tableviewcolumndesc.set_propertytype (a_type)


			listviewcolumndesc.set_propertydesc (tableviewcolumndesc.item)

			create cfstring.make_unshared_with_eiffel_string (a_title_string)

			create listviewheaderdesc.make_new_unshared
			listviewheaderdesc.set_version ({CONTROLDEFINITIONS_ANON_ENUMS}.kdatabrowserlistviewlatestheaderdesc)
			listviewheaderdesc.set_minimumwidth (a_minwidth)
			listviewheaderdesc.set_maximumwidth (a_maxwidth)
			listviewheaderdesc.set_titleoffset (0)
			listviewheaderdesc.set_titlestring (cfstring.item)
			listviewheaderdesc.set_initialorder (0)

			create fontstyle.make_new_unshared
			fontstyle.set_flags (64)
			fontstyle.set_just (0)

			listviewheaderdesc.set_btnfontstyle (fontstyle.item)


			create fontinfo.make_new_unshared
			fontinfo.set_contenttype (0)

			listviewheaderdesc.set_btncontentinfo (fontinfo.item)

			listviewcolumndesc.set_headerbtndesc (listviewheaderdesc.item)

			ret := add_data_browser_list_view_column_external (c_object, listviewcolumndesc.item, {CONTROLDEFINITIONS_ANON_ENUMS}.kdatabrowserlistviewappendcolumn)
			ret := set_data_browser_property_flags_external (c_object, an_identity , {CONTROLDEFINITIONS_ANON_ENUMS}.kdatabrowserlistviewdefaultcolumnflags)
		end

	create_list (a_columns: INTEGER)
			-- Create the clist with `a_columns' columns.
		require
			a_columns_positive: a_columns > 0
		local
			i, ret: INTEGER
		do
			from
				i := column_count + 1
			until
				i > a_columns
			loop
				-- for now: first column is initialized with icon
				if i = 1 then
					ret := add_list_view_column (i, {CONTROLDEFINITIONS_ANON_ENUMS}.kDataBrowserIconAndTextType, 100, 10000, "")
				else
					ret := add_list_view_column (i, {CONTROLDEFINITIONS_ANON_ENUMS}.kdatabrowsertexttype, 100, 10000, "")
				end
				i := i + 1

			end
			ret := auto_size_data_browser_list_view_columns_external (c_object)
		end

		column_count: INTEGER
			-- Number of columns in the list.
		local
			ret, col_list: INTEGER
		do
			ret := get_data_browser_table_view_column_count_external (c_object, $col_list)
			Result := col_list
		end

	do_ugly_things (db_control, a_item_data_dispatcher, a_item_notification_dispatcher: POINTER)
			-- move this to the application class or make it somehow unique

		external
			"C inline"
		alias
			"[
				{
				    // Set control non-focusable
				    Boolean frameAndFocus = false;
					SetControlData($db_control, kControlNoPart, kControlDataBrowserIncludesFrameAndFocusTag, sizeof(frameAndFocus), &frameAndFocus);
				
					// Initialize the callbacks
					DataBrowserCallbacks  dbCallbacks;
					dbCallbacks.version = kDataBrowserLatestCallbacks;
					InitDataBrowserCallbacks (&dbCallbacks);
					dbCallbacks.u.v1.itemDataCallback = NewDataBrowserItemDataUPP ( (DataBrowserItemDataProcPtr) $a_item_data_dispatcher );
				    dbCallbacks.u.v1.itemNotificationCallback = NewDataBrowserItemNotificationUPP ( $a_item_notification_dispatcher );

					SetDataBrowserCallbacks ( $db_control, &dbCallbacks );

				}
			]"
		end

	get_set_item_data_dispatcher: DATA_BROWSER_ITEM_DATA_PROC_PTR_DISPATCHER
			-- The dispatcher is on the one side connected to a C function,
			-- that can be given to the C library as a callback target
			-- and on the other hand to an Eiffel object with a feature
			-- `on_callback'. Whenn its C function gets called, the dispatcher
			-- calls `on_callback' in the connected Eiffel object (`on callback' ~> `get_set_item_data_callback')

	get_set_item_data_callback (a_browser: POINTER; a_item: INTEGER; a_property: INTEGER; a_itemdata: POINTER; a_setvalue: INTEGER): INTEGER
			-- Through this callback the DataBrowser is requesting information about an item
		local
			cfstring: EV_CARBON_CF_STRING
			db: like Current
			node: like db_item
			multinode: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			Result := {CONTROLDEFINITIONS_ANON_ENUMS}.errDataBrowserPropertyNotSupported
			if a_setvalue.to_boolean then
				-- Set Information: Some information has changed: update data structures
				-- Should not happen, since we don't support e.g. inline editing of the items!
			else
				-- Get Information (request from the control)
				db := get_object_from_pointer (a_browser)
				node := db.item_list.item (a_item)
				if a_property = {CONTROLDEFINITIONS_ANON_ENUMS}.kDataBrowserItemIsContainerProperty then
					if node.child_array /= Void and then node.child_array.count /= 0 then
						Result := set_data_browser_item_data_boolean_value_external (a_itemdata, 1)
					else
						Result := set_data_browser_item_data_boolean_value_external (a_itemdata, 0)
					end
				else if a_property = 1 then
					create cfstring.make_unshared_with_eiffel_string (node.text)
					Result := set_data_browser_item_data_text_external (a_itemdata, cfstring.item)
					if node.icon_ref /= Void then
						Result := set_data_browser_item_data_icon_external (a_itemdata, get_icon_ref(node.icon_ref))
					end
				else



					multinode ?= node

					if multinode /= Void then
						create cfstring.make_unshared_with_eiffel_string (multinode.interface.i_th (a_property))
					else
						create cfstring.make_unshared_with_eiffel_string ("blub")
					end
					Result := set_data_browser_item_data_text_external (a_itemdata, cfstring.item)
					if node.icon_ref /= Void then
						Result := set_data_browser_item_data_icon_external (a_itemdata, get_icon_ref(node.icon_ref))
					end
				end
			end
		end
	end

	get_icon_ref (img: POINTER) : POINTER
			--
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"[
				{
					UInt32              dataRGB[128 * 128] = { 0 };
					UInt8               dataA[  128 * 128] = { 0 };
					CGContextRef        cgContextRGB, cgContextA;
					CGColorSpaceRef     cgColourSpace;
					SInt32              theSize;
					IconRef             iconRef;
					IconFamilyHandle    iconHnd;
					Handle              tmpHnd;
					OSStatus            theErr;
					CGImageRef			cgImage = $img;
					
					// Initialise ourselves
					theErr  = noErr;
					iconRef = NULL;
					// Draw the image
					//
					// Since 128x128-sized IconRefs are constructed from two blocks of data,
					// we render the image twice to obtain the image data and the mask data.
					//
					// If we could require 10.4 we could use kIconServices256PixelDataARGB
					// and create a 256x256 icon directly from the ARGB data, but for now we
					// use kCGImageAlphaOnly to support 10.3.
					cgColourSpace = CGColorSpaceCreateDeviceRGB();
					if (cgColourSpace == NULL)
					    return(NULL);
					cgContextRGB  = CGBitmapContextCreate(dataRGB, 128, 128, 8, 128 * 4, cgColourSpace, kCGImageAlphaNoneSkipFirst);
					cgContextA    = CGBitmapContextCreate(dataA,   128, 128, 8, 128 * 1, NULL,          kCGImageAlphaOnly);
					if (cgContextRGB != NULL && cgContextA != NULL)
					    {
					        CGContextDrawImage(cgContextRGB, CGRectMake(0, 0, 128, 128), cgImage);
					        CGContextDrawImage(cgContextA,   CGRectMake(0, 0, 128, 128), cgImage);
					    }
				    //CFSafeRelease(cgColourSpace);
				    //CFSafeRelease(cgContextRGB);
				    //CFSafeRelease(cgContextA);
				    // Create the icon family handle
				    //
				    // An icon family handle is just a fixed (big-endian) header, and tagged data.
				    theSize = sizeof(OSType) + sizeof(OSType);
				    iconHnd = (IconFamilyHandle) NewHandle(theSize);
				    if (iconHnd == NULL)
				        theErr = memFullErr;
				    if (theErr == noErr)
				        {
				            (*iconHnd)->resourceType = EndianU32_NtoB(kIconFamilyType);
				            (*iconHnd)->resourceSize = EndianU32_NtoB(theSize);
				        }
				    if (theErr == noErr)
				        {
				            theErr = PtrToHand(dataRGB, &tmpHnd, sizeof(dataRGB));
				            if (theErr == noErr)
				                {
				                    theErr = SetIconFamilyData(iconHnd, kThumbnail32BitData, tmpHnd);
				                    DisposeHandle(tmpHnd);
				                }
				        }
				        
				   if (theErr == noErr)
				        {
				            theErr = PtrToHand(dataA, &tmpHnd, sizeof(dataA));
				            if (theErr == noErr)
				               {
				                   theErr = SetIconFamilyData(iconHnd, kThumbnail8BitMask, tmpHnd);
				                   DisposeHandle(tmpHnd);
				               }
				        }
				                
				    // Create the IconRef
				    if (theErr == noErr)
				        theErr = GetIconRefFromIconFamilyPtr(*iconHnd, GetHandleSize((Handle) iconHnd), &iconRef);
				    
				    // Clean up
				    if (iconHnd != NULL)
				        DisposeHandle((Handle) iconHnd);
				    
				    return(iconRef);
				}
			]"
		end

	item_notification_dispatcher: DATA_BROWSER_ITEM_NOTIFICATION_PROC_PTR_DISPATCHER
			-- The dispatcher is on the one side connected to a C function,
			-- that can be given to the C library as a callback target
			-- and on the other hand to an Eiffel object with a feature
			-- `on_callback'. Whenn its C function gets called, the dispatcher
			-- calls `on_callback' in the connected Eiffel object (`on callback' ~> `item_notification_callback')

	item_notification_callback (a_browser: POINTER; a_item: INTEGER; a_message: INTEGER)
			-- A item has changed
		local
			id: INTEGER
			ret: INTEGER
			tree: like current
			node, child_node: like db_item
		do
			if a_message = {CONTROLDEFINITIONS_ANON_ENUMS}.kDataBrowserContainerOpened then
				tree := get_object_from_pointer (a_browser)
				node := tree.item_list.item (a_item)
				from
					node.child_array.start
				until
					node.child_array.after
				loop
					child_node ?= node.child_array.item.implementation
					id := child_node.item_id
					ret := add_data_browser_items_external (a_browser, a_item, 1, $id, {CONTROLDEFINITIONS_ANON_ENUMS}.kDataBrowserItemNoProperty);
					node.child_array.forth
				end
				--print ("item_notification: Container-Opened id " + a_item.out + ", " + id.out + "%N")
			elseif a_message = {CONTROLDEFINITIONS_ANON_ENUMS}.kDataBrowserItemSelected then
				tree := get_object_from_pointer (a_browser)
				node := tree.item_list.item (a_item)
				node.select_actions.call ([])
				tree.set_selected_item_imp(node)
				tree.call_selection_action_sequences
--				selected := true
			end
		end

	get_object_from_pointer (a_pointer: POINTER): EV_CARBON_DATABROWSER
	-- Doesn't work with 'like Current' since the instance of the class could be of another type,... callback confusion
			-- Takes a c-pointer to the associated c_object of a object of type EV_TREE_IMP and returns a handle to that.
		do
			-- Okay, this is really ugly now: Since there is only one callback function
			--  the "current" object doesn't have to be the one it should. We have to figure
			--  out for which TREE object we should give out the data by looking at the
			--  DataBrowser pointer, going through the list and comparing with all c_objects.
			from
				tree_list.start
			until
				tree_list.after or else a_pointer = tree_list.item.pointer_item (2)
			loop
				tree_list.forth
			end
			check
				tree_imp_found: a_pointer = tree_list.item.pointer_item (2)
			end
			-- We have found the object for a_browser. It is in 'tree_list.item.item (1)'
			Result ?= tree_list.item.item (1)
		end

	call_selection_action_sequences
		deferred
		end

	icon_ref: POINTER

feature {EV_CARBON_DATABROWSER, EV_CARBON_DATABROWSER_ITEM} -- Implementation

	db_item: EV_CARBON_DATABROWSER_ITEM

	id_count: INTEGER  -- the next id for an event.

	free_ids: LINKED_LIST[INTEGER]

	item_list: ARRAY[like db_item]

	get_id (a_node: like db_item) : INTEGER
			-- Get a unique ID so we can associate an event by its ID with a control
		do
			if free_ids.is_empty then
				item_list.force (a_node, id_count)
				Result := id_count
				id_count := id_count + 1
			else
				free_ids.start
				item_list.force (a_node, free_ids.item)
				Result :=  free_ids.item
				free_ids.remove
			end
		end

	dispose_id (a_id: INTEGER)
				-- Give an id back (it will be recycled)
			do
				item_list.force (void, a_id)
				free_ids.put_right (a_id)
			end

	tree_list: LIST [TUPLE]
			-- A shared list of all trees created
		once
			create {LINKED_LIST [TUPLE]} Result.make
		end

note
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end -- class EV_CARBON_DATABROWSER
