indexing
	description: "Objects that represent a common editor constructor for pixmap and pixmapable objects."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_COMMON_PIXMAP_EDITOR_CONSTRUCTOR

inherit
	GB_EV_EDITOR_CONSTRUCTOR
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
		undefine
			Visual_studio_information
		end
		
	GB_SHARED_CONSTANTS
		export
			{NONE} all
		end
		
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end
		
feature -- Access
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			create Result
			initialize_attribute_editor (Result)
			
				-- Tool bar and menu separators do inherit from EV_PIXMAPABLE,
				-- however, the facilities are not exported.
			if not (object.type.is_equal ("EV_TOOL_BAR_SEPARATOR") or object.type.is_equal ("EV_MENU_SEPARATOR")) then
				create pixmap_input_field.make (Current, Result, pixmap_path_string, "Pixmap", "Pixmap", agent execute (?, ?), agent validate (?, ?), agent return_pixmap, agent return_pixmap_path)
				update_attribute_editor
			end
		end
		
	execute (a_pixmap: EV_PIXMAP; pixmap_path: STRING) is
			-- Asssign `a_pixmap' located at `pixmap_path' to all representations of `Current'.
			-- If `a_pixmap' is Void, remove pixmap and path.
		deferred
		end
		
	validate (a_pixmap: EV_PIXMAP; pixmap_path: STRING): BOOLEAN is
			-- Validate pixmap `a_pixmap' with path `pixmap_path'.
		deferred
		end
		
	return_pixmap: EV_PIXMAP is
			-- `Result' is pixmap used for `Current'.
		deferred			
		end
		
	return_pixmap_path: STRING is
			-- `Result' is path used to retrieve pixmap.
		deferred
		end

feature {NONE} -- Implementation

	pixmap_path_string: STRING is "Pixmap_path"
	
	Remove_tooltip: STRING is "Remove pixmap"
		-- Tooltip on `modify_button' when able to remove pixmap.
		
	Select_tooltip: STRING is "Select pixmap"
		-- Tooltip on `modify_button' when able to remove pixmap.

	pixmap_input_field: GB_PIXMAP_INPUT_FIELD
		-- Input field to retrieve pixmap.
		
end -- class GB_EV_COMMON_PIXMAP_EDITOR_CONSTRUCTOR
