indexing
	description: "Objects that represent a user defined component."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMPONENT_SELECTOR_ITEM
	
inherit
	
	GB_SHARED_XML_HANDLER
		undefine
			default_create, copy
		end
		
	GB_SHARED_COMPONENT_VIEWER
		undefine
			default_create, copy
		end
	
	GB_XML_OBJECT_BUILDER
		undefine
			default_create, copy
		end
		
	GB_COMMAND_HANDLER
		undefine
			default_create, copy
		end
	
	EV_LIST_ITEM

create
	make_from_object,
	make_with_name

feature {NONE} -- Initialization

	make_from_object (an_object: GB_OBJECT; a_name: STRING) is
			-- Create `Current' from `an_object'.
		do
			xml_handler.add_new_component (an_object, a_name)
			make_with_name (a_name)
		end
		
	make_with_name (a_name: STRING) is
			-- Create a new component representation from `a_name'.
		local
			component: GB_COMPONENT
			pixmaps: GB_SHARED_PIXMAPS
		do
			make_with_text (a_name)
			set_pebble_function (agent generate_pebble)	
			create component.make_with_name (a_name)
			create pixmaps
			set_pixmap (pixmaps.pixmap_by_name (component.root_element_type))
		end

feature {NONE} -- Implementation
		
	generate_pebble: GB_COMPONENT is
			-- `Result' is used for a pick and drop.
		local
			component: GB_COMPONENT
		do
			if application.ctrl_pressed then
				create component.make_with_name (text)
				component_viewer.set_component (component)
					-- We don't call execute on the component viewer command
					-- as this toggles between states, and we do not want the
					-- viewer hidden
				if not component_viewer.is_show_requested then
					show_hide_component_viewer_command.execute
				end
			else
				create Result.make_with_name (text)
			end
		end

end -- class GB_COMPONENT
