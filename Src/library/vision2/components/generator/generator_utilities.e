indexing
	description: "Objects that provide useful functions for APPLICATION_GENERATOR"
	author: "Julian Rogers"
	date: "$Date$"
	revision: "$Revision$"

class
	GENERATOR_UTILITIES

feature -- Basic operations

	get_single_level_elements (element: XML_ELEMENT): HASH_TABLE [XML_ELEMENT, STRING] is
			-- `Result' is all child elements of `element' referenced by their unique names.
		local
			current_element: XML_ELEMENT
		do
		create Result.make (50)
		from	
			element.start
		until
			element.off
		loop
			current_element ?= element.item_for_iteration
			if current_element /= Void then
				if not current_element.name.to_utf8.is_equal ("item") and
					not current_element.name.to_utf8.is_equal ("item_text") then
					Result.extend (current_element, current_element.name.to_utf8)
				end
			end
			element.forth
		end
		end

	get_single_level_attributes (element: XML_ELEMENT): HASH_TABLE [STRING, STRING] is
			-- `Result' is all XML character data values of `element' referenced by their unique names.
		local
			current_element: XML_ELEMENT
			current_data_element: XML_CHARACTER_DATA 
			char_data: STRING
			widget: EV_WIDGET
		do
			create Result.make (50)
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					from
						current_element.start
					until
						current_element.off
					loop
						current_data_element ?= current_element.item_for_iteration
						if current_data_element /= Void then
							char_data := current_data_element.content.to_utf8
							char_data.replace_substring_all ("%T","")
							if data_valid (char_data) then
								Result.extend (char_data, current_element.name.to_utf8)
							end
						end
						current_element.forth
					end
				end
				element.forth
			end
		end

	get_unique_full_info (element: XML_ELEMENT): HASH_TABLE [ELEMENT_INFORMATION, STRING] is
			-- `Result' provides access to all child_elements and XML character
			-- data of `Current' referenced by their unique names.
			-- Ignores `item'.
		local
			current_element: XML_ELEMENT
			current_data_element: XML_CHARACTER_DATA
			char_data: STRING
			info: ELEMENT_INFORMATION
		do
			create Result.make (50)
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					if not current_element.name.to_utf8.is_equal ("item") and
						not current_element.name.to_utf8.is_equal ("item_text") then
						create info
						info.set_name (current_element.name.to_utf8)
						info.set_element (current_element)
						from
							current_element.start
						until
							current_element.off
						loop
							current_data_element ?= current_element.item_for_iteration
							if current_data_element /= Void then
								char_data := current_data_element.content.to_utf8
								char_data.replace_substring_all ("%T","")
								if data_valid (char_data) then
									info.set_data (char_data)
								end
							end
							current_element.forth
						end
					Result.extend (info, info.name)
					end
				end
				element.forth
			end
		end

	data_valid (current_data: STRING):BOOLEAN is
			-- Is `current_data' not empty and valid?
		do
			if current_data.count > 0 and current_data.item (1).code /= 10 then	
				Result := True
			end
		end

end -- class GENERATOR_UTILITIES
