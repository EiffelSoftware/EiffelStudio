indexing
	description: "Builds an attribute editor for modification of objects of type EV_PIXMAPABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_PIXMAPABLE_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_COMMON_PIXMAP_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
	CONSTANTS
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_PIXMAPABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_PIXMAPABLE"
		-- String representation of object_type modifyable by `Current'.
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			pixmap_input_field.update_constant_display (first.pixmap)
		end
		
feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			execution_agents.put (agent execute, pixmap_path_string)
		end
		
	execute (a_pixmap: EV_PIXMAP;  pixmap_path: STRING) is
			-- Asssign `a_pixmap' located at `pixmap_path' to all representations of `Current'.
			-- If `a_pixmap' is Void, remove pixmap and path.
		do
			if a_pixmap /= Void then
				for_all_objects (agent {EV_PIXMAPABLE}.set_pixmap (a_pixmap))
				for_all_objects (agent {EV_PIXMAPABLE}.set_pixmap_path (pixmap_path))
			else
				for_all_objects (agent {EV_PIXMAPABLE}.remove_pixmap)
				for_all_objects (agent {EV_PIXMAPABLE}.set_pixmap_path (Void))
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
			Result := objects.first.pixmap
		end
		
	return_pixmap_path: STRING is
			-- `Result' is path used to retrieve pixmap.
		do
			Result := objects.first.pixmap_path
		end

end -- class GB_EV_PIXMAPABLE_EDITOR_CONSTRUCTOR
