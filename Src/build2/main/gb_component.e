indexing
	description: "Objects that represent a component"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMPONENT
	
inherit
	
	GB_XML_OBJECT_BUILDER

create
	
	make_with_name
	
feature {NONE} -- Initialization

	make_with_name (a_name: STRING) is
			-- Create `Current' and assign `a_name' to `name'.
		do
			set_name (a_name)
		end
		

feature -- Access

	name: STRING
		-- Name of `Current'.
		
	object: GB_OBJECT is
			-- `Result' is representation of `Current'
			-- unique each time.
		do
			Result := (new_object ((create {GB_SHARED_XML_HANDLER}).xml_handler.xml_element_representing_named_component (name), True))
		ensure
			result_not_void: Result /= Void
		end
		
	root_element_type: STRING is
			-- `Result' is type of root element.
		do
			Result := ((create {GB_SHARED_XML_HANDLER}).xml_handler.component_root_element_type (name))
		end
		

feature -- Status Setting

	set_name (a_name: STRING) is
			-- Assign `a_name' to `name'.
		require
			name_valid: a_name /= Void and then not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name = a_name
		end
		

end -- class GB_COMPONENT
