indexing
	description: "Objects that manipulate objects of type EV_PROGRESS_BAR."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_PROGRESS_BAR
	
	-- The following properties from EV_PROGRESS_BAR are manipulated by `Current'.
	-- Is_segmented - Performed on the real object and the display object.

inherit
	GB_EV_ANY
		undefine
			attribute_editor
		end
		
	GB_EV_PROGRESS_BAR_EDITOR_CONSTRUCTOR

feature {GB_XML_STORE} -- Output

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		do
			if not first.is_segmented then
				add_element_containing_boolean (element, is_segmented_string, objects.first.is_segmented)
			end
		end

	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (is_segmented_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					for_first_object (agent {EV_PROGRESS_BAR}.enable_segmentation)
				else
					for_first_object (agent {EV_PROGRESS_BAR}.disable_segmentation)
				end
			end
		end
		
	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO):ARRAYED_LIST [STRING] is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
		do
			create Result.make (1)
			full_information := get_unique_full_info (element)
			element_info := full_information @ (is_segmented_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					Result.extend (info.name + ".enable_segmentation")
				else
					Result.extend (info.name + ".disable_segmentation")
				end
			end
		end

end -- class GB_EV_SENSITIVE
