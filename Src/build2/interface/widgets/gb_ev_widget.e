indexing
	description: "Objects that manipulate objects of type EV_WIDGET"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_WIDGET
	
	-- The following properties from EV_WIDGET are manipulated by `Current'.
	-- Minimum_width - Performed on the real object only. Not the display object
	-- Minimum_height - Performed on the real object only. Not the display_object

inherit
	GB_EV_ANY
		undefine
			attribute_editor
		redefine
			ev_type
		end


	GB_XML_UTILITIES
		export
			{NONE} all
		undefine
			default_create
		end
		
	GB_EV_WIDGET_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
	
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		undefine
			default_create
		end

feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): ARRAYED_LIST [STRING] is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		do
			create Result.make (2)
			full_information := get_unique_full_info (element)
			if attribute_set (Minimum_width_string) then
				Result.extend (info.name + ".set_minimum_width (" + retrieve_integer_setting (Minimum_width_string) + ")")
			end
			if attribute_set (Minimum_height_string) then
				Result.extend (info.name + ".set_minimum_height (" + retrieve_integer_setting (Minimum_height_string) + ")")
			end
		end

feature {GB_XML_STORE} -- Output
	
	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		do
			if object.name.is_equal ("template_dialog") then
				do_nothing
			end
			if objects.first.minimum_width_set_by_user or uses_constant (Minimum_width_string) then
				add_integer_element (element, Minimum_width_string, objects.first.minimum_width)	
			end
			if objects.first.minimum_height_set_by_user or uses_constant (Minimum_height_string) then
				add_integer_element (element, Minimum_height_string, objects.first.minimum_height)
			end
		end
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		do
			full_information := get_unique_full_info (element)
			if full_information @ (Minimum_width_string) /= Void then
				for_first_object (agent {EV_WIDGET}.set_minimum_width (retrieve_and_set_integer_value (Minimum_width_string)))
			end
			
			if full_information @ (Minimum_height_string) /= Void then
				for_first_object (agent {EV_WIDGET}.set_minimum_height (retrieve_and_set_integer_value (Minimum_height_string)))
			end
		end

end -- class GB_EV_WINDOW