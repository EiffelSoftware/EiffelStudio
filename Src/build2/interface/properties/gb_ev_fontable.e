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
		undefine
			attribute_editor
		end
		
	GB_EV_FONTABLE_EDITOR_CONSTRUCTOR


feature {GB_XML_STORE} -- Output

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			font: EV_FONT
			fontable: EV_FONTABLE
		do
			font := first.font
			
			fontable ?= default_object_by_type (class_name (first))
			if not fontable.font.is_equal (font) or uses_constant (font_string) then
				add_font_element (element, font_string, objects.first.font)
			end
		end

	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			element_info: ELEMENT_INFORMATION
			font: EV_FONT
			font_constant: GB_FONT_CONSTANT
			constant_context: GB_CONSTANT_CONTEXT
		do
			full_information := get_unique_full_info (element)
				-- Must only set the font if a font was really contained.
			if full_information @ font_family_string /= Void then
				create font
				element_info := full_information @ (font_family_string)
				if element_info /= Void then
					font.set_family (element_info.data.to_integer)
				end
				element_info := full_information @ (font_weight_string)
				if element_info /= Void then
					font.set_weight (element_info.data.to_integer)
				end
				element_info := full_information @ (font_shape_string)
				if element_info /= Void then
					font.set_shape (element_info.data.to_integer)
				end
				element_info := full_information @ (font_height_string)
				if element_info /= Void then
					font.set_height (element_info.data.to_integer)
				end
					-- We have code for both the old and the new font height
					-- to maintain backwards compatibility for older projects which
					-- did not use points.
				element_info := full_information @ (font_height_points_string)
				if element_info /= Void then
					font.set_height_in_points (element_info.data.to_integer)
				end
				element_info := full_information @ (font_preferred_family_string)
				if element_info /= Void then
					font.preferred_families.extend (element_info.data)
				end
				for_all_objects (agent {EV_FONTABLE}.set_font (font))
			else
				element_info := full_information @ font_string
				if element_info /= Void then
					font_constant ?= constants.all_constants.item (element_info.data)
					create constant_context.make_with_context (font_constant, object, type, font_string)
					font_constant.add_referer (constant_context)
					object.add_constant_context (constant_context)
					for_all_objects (agent {EV_FONTABLE}.set_font (font_constant.value))
				end
			end
		end

feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): ARRAYED_LIST [STRING] is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
		do
			create Result.make (5)
			full_information := get_unique_full_info (element)
			element_info := full_information @ (font_family_string)
				-- As we are maining backwards compatibility, we check both entries.
			if element_info = Void then
				element_info := full_information @ (font_string)
			end
			if element_info /= Void then
				if element_info.is_constant then
					Result.extend (info.name + ".set_font (" + element_info.data + ")")
				else
					info.enable_fonts_set
					Result.extend ("create internal_font")
					Result.extend ("internal_font.set_family (" + element_info.data + ")")
	
					element_info := full_information @ (font_weight_string)
					if element_info /= Void then
						Result.extend ("internal_font.set_weight (" + element_info.data + ")")
					end
					element_info := full_information @ (font_shape_string)
					if element_info /= Void then
						Result.extend ("internal_font.set_shape (" + element_info.data + ")")
					end
					element_info := full_information @ (font_height_points_string)
					if element_info /= Void then
						Result.extend ("internal_font.set_height_in_points (" + element_info.data + ")")
					end
					element_info := full_information @ (font_preferred_family_string)
					if element_info /= Void then
						Result.extend ("internal_font.preferred_families.extend (%"" + element_info.data + "%")")
					end
					Result.extend (info.name + ".set_font (internal_font)")
				end
			end
		end

end -- class GB_EV_DESELECTABLE
