indexing
	description: "Objects that represent windows in a GB_WIDGET_SELECTOR"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_WIDGET_SELECTOR_ITEM
	
inherit
	GB_WIDGET_SELECTOR_COMMON_ITEM
		redefine
			destroy
		end
	
	GB_SHARED_OBJECT_EDITORS
		export
			{NONE} all
		end
		
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
		
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		end

create
	make_with_object
	
feature {NONE} -- Initialization

	make_with_object (an_object: GB_OBJECT) is
			-- Create `Current' and associate with `an_object'.
		require
			object_not_void: an_object /= Void
		local
			pixmaps: GB_SHARED_PIXMAPS
		do
			common_make
			object := an_object

				-- Ensure that `Current' graphically reflects `an_object'.
			update_to_reflect_name_change
			
				-- Assign the appropriate pixmap.
			create pixmaps
			tree_item.set_pixmap (pixmaps.pixmap_by_name (an_object.type.as_lower))
			
				-- Set a pebble for transport
			tree_item.set_pebble_function (agent retrieve_pebble)
				
				-- Make `Current' available from `an_object'.
			an_object.set_widget_selector_item (Current)
			tree_item.select_actions.extend (agent widget_selector.selected_window_changed (Current))
			tree_item.drop_actions.extend (agent object.handle_object_drop)
			tree_item.drop_actions.set_veto_pebble_function (agent object.can_add_child)
		ensure
			object_set: object = an_object
		end
		
feature -- Access

	object: GB_OBJECT
			-- Object referenced by `Current'
			-- Note that it is safe to keep a reference to `object' here and not an id reference
			-- as used elsewhere by a system, as `Current' is part of an object and therefore the
			-- object is responsible for ensuring that the references are correct.
			
	is_destroyed: BOOLEAN
		-- Is `Current' destroyed?
		
	file_exists: BOOLEAN is
			-- Does the interface file corresponding to `object' currently exist on disk?
		local
			directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			path: ARRAYED_LIST [STRING]
			file_name: FILE_NAME
			file: RAW_FILE
		do
			directory ?= parent
			if directory /= Void then
				path := directory.path
				create file_name.make_from_string (system_status.current_project_settings.project_location)
				from
					path.start
				until
					path.off
				loop
					file_name.extend (path.item)
					path.forth
				end
				file_name.extend (object.name + ".e")
				create file.make (file_name)
				Result := file.exists
			else
					-- In this case, we are not contained in a sub-directory so simply take the root location.
				create file_name.make_from_string (system_status.current_project_settings.project_location)
				file_name.extend (object.name + ".e")
				create file.make (file_name)
				Result := file.exists
			end			
		end
		
			
feature -- Status setting

	update_to_reflect_name_change is
			-- Update `Current' to reflect a name change of `object'.
		do
			tree_item.set_text (object.name.as_upper)
		end
	
feature --{NONE} -- Implementation

	retrieve_pebble: ANY is
			-- Retrieve pebble for transport.
			-- A convenient was of setting up the drop
			-- actions for GB_OBJECT.
		do			
				-- If the ctrl key is pressed, then we must
				-- start a new object editor for `Current', instead
				-- of beginning the pick and drop.
			if application.ctrl_pressed then
				new_object_editor (object)
			else
				Result := create {GB_STANDARD_OBJECT_STONE}.make_with_object (object)
			end
		end
		
feature {GB_OBJECT} -- Implementation

	set_object (an_object: GB_OBJECT) is
			-- Assign `an_object' to `object'
		require
			an_object_not_void: an_object /= Void
		do
			object := an_object
		ensure
			object_set: object = an_object
		end
		
	destroy is
			-- Destroy `Current'.
		do
			is_destroyed := True
			object := Void
			Precursor {GB_WIDGET_SELECTOR_COMMON_ITEM}
		end

invariant
	object_not_void: not is_destroyed implies object /= Void

end -- class GB_WIFGET_SELECTOR_ITEM
