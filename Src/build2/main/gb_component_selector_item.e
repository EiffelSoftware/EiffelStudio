indexing
	description: "Objects that represent a user defined component."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMPONENT_SELECTOR_ITEM
	
inherit
	
	GB_ACCESSIBLE_XML_HANDLER
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
	
	EV_LIST_ITEM

create
	make_from_object,
	make_with_name

feature {NONE} -- Initialization

	make_from_object (an_object: GB_OBJECT; a_name: STRING) is
			-- Create `Current' from `an_object'.
		do
			xml_handler.add_new_component (an_object, a_name)
			make_with_text (a_name)
			set_pebble_function (agent generate_pebble)
		end
		
	make_with_name (a_name: STRING) is
			-- Create a new component representation from `a_name'.
		do
			make_with_text (a_name)
			set_pebble_function (agent generate_pebble)
		end

feature {NONE} -- Implementation

	generate_pebble: GB_COMPONENT is
			-- `Result' is used for a pick and drop.
		local
			environment: EV_ENVIRONMENT
			an_object: GB_OBJECT
			widget: EV_WIDGET
			component: GB_COMPONENT
		do
			an_object ?= new_object (xml_handler.xml_element_representing_named_component (text))
			create environment
			if environment.application.ctrl_pressed then				
				widget ?= an_object.display_object
				check
					widget_not_void: widget /= Void
				end
				create component.make_with_name (text)
				component_viewer.set_component (component)
				component_viewer.show
			else
				create Result.make_with_name (text)
				object_handler.for_all_objects_build_drop_actions_for_new_object
			end
		end

end -- class GB_COMPONENT
