indexing
	description: "Objects that handle clipboard manipulation in EiffelBuild"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CLIPBOARD
	
inherit
	GB_SHARED_PIXMAPS
		export
			{NONE} all
		undefine
			default_create
		end
		
	GB_COMMAND_ADD_OBJECT
		export
			{NONE} all
		undefine
			default_create
		end
		
	GB_SHARED_TOOLS
		export
			{NONE} all
		undefine
			default_create
		end
		
	GB_XML_OBJECT_BUILDER
		export
			{NONE} all
		undefine
			default_create
		end
		
	GB_SHARED_ID
		export
			{NONE} all
		undefine
			default_create
		end
		
feature {NONE} --Initialization
	
	default_create is
			-- Create `Current'.
		do
			create content_change_actions
		end

feature -- Access
		
	object: GB_OBJECT is
			-- `Result' is a new object representation of the contents.
		local
			a_list: ARRAYED_LIST [GB_OBJECT]
		do
			Result := internal_object
			if Result /= Void then
				create a_list.make (20)
				Result.all_children_recursive (a_list)
				a_list.extend (Result)
				from
					a_list.start
				until
					a_list.off
				loop
						-- Remove all names from the copied XML. There is no easy method
						-- of keeping the original names as we perform a replace for all objects that
						-- are top level instances within the XML. Can be done, but may be tricky. For later.
					a_list.item.set_name ("")
					a_list.item.set_id (new_id)
					object_handler.add_object_to_objects (a_list.item)
					a_list.forth
				end
					-- Perform the connection of the instance referers afterwards as
					-- otherwise, the temporary object instance referers structure may
					-- reference the sane object in a nested chain as all of the new ids have not yet been updated.
				from
					a_list.start
				until
					a_list.off
				loop
					if a_list.item.associated_top_level_object_on_loading > 0 then
						a_list.item.update_object_as_instance_representation
					end
					a_list.forth
				end
			end
		end

	object_type: STRING
			-- Type of `object' or Void if `is_empty'.
		
	is_empty: BOOLEAN is
			-- Is clipboard empty?
		do
			Result := contents_cell.item = Void
		end
		
	content_change_actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Action sequence executed when contents of clipboard change.

feature {GB_CLIPBOARD_COMMAND} -- Implementation

	internal_object: GB_OBJECT is
			-- `Result' is a new object representing clipboard contents.
			-- This is a minimal representation and does not have it's id's updated, referers connected etc etc.
			-- Used when you simply need a copy of the clipboard's contents for viewing.
		do
			if contents_cell.item /= Void then
			
				if system_status.is_in_debug_mode then
					show_element (contents_cell.item, main_window)
				end				
				replace_all_instances_with_up_to_date_xml (contents_cell.item)
				remove_nodes_recursive (contents_cell.item, root_window_string)
				if system_status.is_in_debug_mode then
					show_element (contents_cell.item, main_window)
				end				

				Result := new_object (contents_cell.item, True)
					-- Modify id of `Result' so that it is not the same as that of `Current'.
			end
		end

feature {GB_CUT_OBJECT_COMMAND, GB_COPY_OBJECT_COMMAND, GB_CLIPBOARD_COMMAND, GB_PASTE_OBJECT_COMMAND} -- Implementation

	set_object (an_object: GB_OBJECT) is
			-- Assign a copy of `an_object' to `Current'.
		require
			an_object_not_void: an_object /= Void
		local
			xml_store: GB_XML_STORE
			xm_element: XM_ELEMENT
			element: XM_ELEMENT
		do
			if an_object.object = Void then
				an_object.build_objects
			end
			object_type := an_object.type
			create xml_store
			xml_store.store_individual_object (an_object)
			xm_element := xml_store.last_stored_individual_object
			
			if an_object.is_top_level_object then
				-- We must now parse the XML and set the first object as a reference
				-- object and remove the deeper references.
				element ?= xm_element.first
				convert_element_to_instance (element, an_object.id, 1)
			end
			
			contents_cell.put (xm_element)
			if not content_change_actions.is_empty then
				content_change_actions.call (Void)
			end
		ensure
			contents_cell_not_empty: contents_cell.item /= Void
		end

	contents_cell: CELL [XM_ELEMENT] is
			-- A cell to hold the contents of `Current'.
			-- Whenver the contents are requested, this must be copied.
		once
			create Result	
		end
		
invariant
	content_change_actions_not_void: content_change_actions /= Void

end -- class GB_CLIPBOARD
