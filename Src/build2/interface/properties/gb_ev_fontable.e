indexing
	description: "Objects that manipulate objects of type EV_FONTABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_FONTABLE
	
	-- The following properties from EV_FONTABLE are manipulated by `Current'.
	-- Font - Performed on the real object and the display_object.

inherit
	GB_EV_ANY
		redefine
			attribute_editor,
			ev_type
		end
		
	GB_XML_UTILITIES
		undefine
			default_create
		end
		
	EV_ANY_HANDLER
		undefine
			default_create
		end

feature -- Access


	ev_type: EV_FONTABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_FONTABLE"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			font_button: EV_BUTTON
		do
			Result := Precursor {GB_EV_ANY}
			create font_button.make_with_text ("Select font...")
			font_button.select_actions.extend (agent show_dialog)
			Result.extend (font_button)
			update_attribute_editor
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			-- Nothing to do, as there is no display of the
			-- current font at the moment.
		end
		
feature {GB_XML_STORE} -- Output

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			deselectable: EV_DESELECTABLE
			font: EV_FONT
			fontable: EV_FONTABLE
		do
			font := first.font
			
			fontable ?= new_instance_of (dynamic_type_from_string (class_name (first)))
			fontable.default_create
			if not fontable.font.is_equal (font) then
				add_element_containing_integer (element, family_string, font.family)
				add_element_containing_integer (element, weight_string, font.weight)
				add_element_containing_integer (element, shape_string, font.shape)
				add_element_containing_integer (element, height_string, font.height)
				if not font.preferred_families.is_empty then
					add_element_containing_string (element, preferred_family_string, font.preferred_families @ 1)	
				end
			end
		end

	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			font: EV_FONT
		do
			full_information := get_unique_full_info (element)
			create font
			element_info := full_information @ (family_string)
			if element_info /= Void then
				font.set_family (element_info.data.to_integer)
			end
			element_info := full_information @ (weight_string)
			if element_info /= Void then
				font.set_weight (element_info.data.to_integer)
			end
			element_info := full_information @ (shape_string)
			if element_info /= Void then
				font.set_shape (element_info.data.to_integer)
			end
			element_info := full_information @ (height_string)
			if element_info /= Void then
				font.set_height (element_info.data.to_integer)
			end
			element_info := full_information @ (preferred_family_string)
			if element_info /= Void then
				font.preferred_families.extend (element_info.data)
			end
			for_all_objects (agent {EV_FONTABLE}.set_font (font))
		end

feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XML_ELEMENT; info: GB_GENERATED_INFO): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (family_string)
			if element_info /= Void then
				info.enable_fonts_set
				Result := "internal_font.set_family (" + element_info.data + ")"

				element_info := full_information @ (weight_string)
				if element_info /= Void then
					Result := Result + indent + "internal_font.set_weight (" + element_info.data + ")"
				end
				element_info := full_information @ (shape_string)
				if element_info /= Void then
					Result := Result + indent + "internal_font.set_shape (" + element_info.data + ")"
				end
				element_info := full_information @ (height_string)
				if element_info /= Void then
					Result := Result + indent + "internal_font.set_height (" + element_info.data + ")"
				end
				element_info := full_information @ (preferred_family_string)
				if element_info /= Void then
					Result := Result + indent + "internal_font.preferred_families.extend (" + element_info.data + ")"
				end
				Result := Result + indent + info.name + ".set_font (internal_font)"
				Result := strip_leading_indent (Result)
			end
		end

feature {NONE} -- Implementation

	show_dialog is
			-- Display font dialog for user input, and
			-- set font of `objects' to match result.
		do
			create font_dialog
			font_dialog.set_font (first.font)
			font_dialog.show_modal_to_window (parent_window (parent_editor))
			for_all_objects (agent {EV_FONTABLE}.set_font (font_dialog.font))
		end
		
	font_dialog: EV_FONT_DIALOG
		-- Dialog for user font choices.

-- Constants for XML

	family_string: STRING is "Family"
	weight_string: STRING is "Weight"
	shape_string: STRING is "Shape"
	height_string: STRING is "Height"
	preferred_family_string: STRING is "Preferred_family"
	

end -- class GB_EV_DESELECTABLE
