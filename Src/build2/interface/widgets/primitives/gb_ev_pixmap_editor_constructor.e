indexing
	description: "Builds an attribute editor for modification of objects of type EV_PIXMAP."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_PIXMAP_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_COMMON_PIXMAP_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
	GB_EV_PIXMAP_HANDLER
		undefine
			default_create
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		end
		
	GB_SHARED_PIXMAPS
		export
			{NONE} all
		end
		
	GB_SHARED_CONSTANTS
		export
			{NONE} all
		end
		
feature -- Access

	ev_type: EV_PIXMAP
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_PIXMAP"
			-- String representation of object_type modifyable by `Current'.
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			pixmap_input_field.update_constant_display (first.twin)
		end
		
feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			execution_agents.put (agent execute, pixmap_path_string)
			validate_agents.put (agent validate, pixmap_path_string)
		end
		
	execute (a_pixmap: EV_PIXMAP; pixmap_path: STRING) is
			-- Asssign `a_pixmap' located at `pixmap_path' to all representations of `Current'.
			-- If `a_pixmap' is Void, remove pixmap and path.
		do
			if a_pixmap /= Void then
				for_all_objects (agent {EV_PIXMAP}.copy (a_pixmap))
				for_all_objects (agent {EV_PIXMAP}.set_pixmap_path (pixmap_path))
				for_all_objects (agent {EV_PIXMAP}.enable_pixmap_exists)
			else
				for_all_objects (agent {EV_PIXMAP}.clear)
				for_all_objects (agent {EV_PIXMAP}.set_pixmap_path (Void))
				for_all_objects (agent {EV_PIXMAP}.disable_pixmap_exists)
			end
		end
		
	validate (a_pixmap: EV_PIXMAP; pixmap_path: STRING): BOOLEAN is
			-- Validate pixmap `a_pixmap' with path `pixmap_path'.
		do
				--| No validation is currently performed on pixmaps, so return True
			Result := True
		end
		
	return_pixmap: EV_PIXMAP is
			-- `Result' is pixmap used for `Current'.
		do
				-- Only return a pixmap if one is set, otherwise
				-- `pixmap_input_field' believes that one is set and the
				-- entry fields are put into the wrong states.
			if first.pixmap_exists then
				Result := objects.first.twin
			end
		end
		
	return_pixmap_path: STRING is
			-- `Result' is path used to retrieve pixmap.
		do
			Result := objects.first.pixmap_path
		end

end -- class GB_EV_PIXMAP_EDITOR_CONSTRUCTOR
