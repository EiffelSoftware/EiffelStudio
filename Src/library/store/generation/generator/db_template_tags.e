indexing
	Description: "Objects that enable to access tags used in template%
			%describing how to generate a class related to a specific%
			%database table."
	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

class
	DB_TEMPLATE_TAGS

feature -- Access

	Upper_class_name: STRING is "<CN:U>"
			-- Tag to replace by the name of the table in upper case.
			
	Initcap_class_name: STRING is "<CN:I>"
			-- Tag to replace by the name of the table in lower case
			-- except for the initial character.
			
	Lower_class_name: STRING is "<CN:L>"
			-- Tag to replace by the name of the table in lower case.

	Upper_attribute_name: STRING is "<AN:U>"
			-- Tag to replace by the name of the attribute in upper case.
			
	Initcap_attribute_name: STRING is "<AN:I>"
			-- Tag to replace by the name of the attribute in lower case
			-- except for the initial character.
			
	Lower_attribute_name: STRING is "<AN:L>"
			-- Tag to replace by the name of the attribute in lower case.

	Iterator: STRING is "<IT>"
			-- Tag to replace by the position of the attribute.
	
	Tag_close: CHARACTER is '>'
			-- Character closing a tag.

	Attribute_block: STRING is "<A:"
			-- Tag to indicate a block to write for every table attribute.

	Attribute_block_end: STRING is "</A>"
			-- Tag to indicate the end of a block for every table attribute.

	Attribute_count: STRING is "<ACNT>"
			-- Tag to replace by the number of attributes.

	Upper_type_name: STRING is "<TN:U>"
			-- Tag to replace by the attribute type name (in uppercase).
			
	Lower_type_name: STRING is "<TN:L>"
			-- Tag to replace by the attribute type name (in lowercase).
			
	Initcap_type_name: STRING is "<TN:I>"
			-- Tag to replace by the attribute type name (in lowercase except
			-- for the initial character).
			
	Type_default_value: STRING is "<TDV>"		
			-- Tag to replace by the attribute type default value.
			
feature -- Status report

	is_valid_attribute_tag: BOOLEAN
			-- Is last parsed tag a valid attribute tag?

	has_all_type_option: BOOLEAN is
			-- Does last parsed tag have the "all types" option?
		do
			Result := has_integer_type_option and then 
					has_string_type_option and then
					has_character_type_option and then
					has_boolean_type_option and then
					has_double_type_option and then
					has_date_type_option
		end
					
	has_integer_type_option: BOOLEAN
			-- Does last parsed tag have the "integer type" option?
			
	has_string_type_option: BOOLEAN
			-- Does last parsed tag have the "string type" option?
			
	has_date_type_option: BOOLEAN
			-- Does last parsed tag have the "date type" option?
			
	has_boolean_type_option: BOOLEAN
			-- Does last parsed tag have the "boolean type" option?
			
	has_character_type_option: BOOLEAN
			-- Does last parsed tag have the "character type" option?
			
	has_double_type_option: BOOLEAN
			-- Does last parsed tag have the "double type" option?
			
	has_all_attribute_option: BOOLEAN is
			-- Does last parsed tag have the "all attributes" option?
		do
			Result := has_first_attribute_option and then
					has_last_attribute_option and then
					has_intermediate_attribute_option
		end

	has_first_attribute_option: BOOLEAN
			-- Does last parsed tag have the "first attribute" option?
			
	has_last_attribute_option: BOOLEAN
			-- Does last parsed tag have the "last attribute" option?
			
	has_intermediate_attribute_option: BOOLEAN
			-- Does last parsed tag have the "intermediate attribute" option?
				
feature -- Status setting

	reset is
			-- Reset status indicators.
		do
			is_valid_attribute_tag := False
			has_string_type_option := False
			has_integer_type_option := False
			has_date_type_option := False
			has_boolean_type_option := False
			has_double_type_option := False
			has_character_type_option := False
			has_first_attribute_option := False
			has_last_attribute_option := False
			has_intermediate_attribute_option := False
		end
		
feature -- Basic operations

	parse_tag (tag: STRING) is
			-- Parse `tag' to have information on it.
		local
			index: INTEGER
			option_char: CHARACTER
			second: BOOLEAN
		do
			reset
			if Attribute_block.is_equal (tag.substring (1, Attribute_block.count)) and then
						tag.item (tag.count) = Tag_close then
				index := Attribute_block.count + 1
				from
					option_char := tag.item (index)
				until
					index = tag.count
				loop
					if second then
						has_first_attribute_option := has_first_attribute_option or else option_char = At_first_attr
						has_last_attribute_option := has_last_attribute_option or else option_char = At_last_attr
						has_intermediate_attribute_option := has_intermediate_attribute_option or else option_char = At_intmd_attr
						if option_char = At_all_attr then
							set_all_attributes
						end
					else
						second := option_char = Separator
						if not second then
							has_integer_type_option := has_integer_type_option or else option_char = At_int_type
							has_string_type_option := has_string_type_option or else option_char = At_str_type
							has_date_type_option := has_date_type_option or else option_char = At_date_type
							has_boolean_type_option := has_boolean_type_option or else option_char = At_boolean_type
							has_character_type_option := has_character_type_option or else option_char = At_character_type
							has_double_type_option := has_double_type_option or else option_char = At_double_type
							if option_char = At_all_type then
								set_all_types
							end
						end
					end
					index := index + 1
					option_char := tag.item (index)
				end
				if second then
					is_valid_attribute_tag := True
				else
					reset
				end
			end
		end
	
feature {NONE} -- Implementation

	At_all_attr: CHARACTER is 'A'
			-- Attribute tag "all attributes" option: tag content is added
			-- for all database table attributes. 
	
	At_intmd_attr: CHARACTER is 'I'
			-- Attribute tag "intermediate attributes" option: tag content is added
			-- for all database table attributes first and last excepted. 
	
	At_first_attr: CHARACTER is 'F'
			-- Attribute tag "first attribute" option: tag content is added
			-- for first database table attribute. 
	
	At_last_attr: CHARACTER is 'L'
			-- Attribute tag "all attributes" option: tag content is added
			-- for last database table attribute. 

	At_all_type: CHARACTER is 'A'
			-- Attribute tag "all types" option: tag content is added for
			-- database table attributes of all types.

	At_int_type: CHARACTER is 'I'
			-- Attribute tag "integer type" option: tag content is added for
			-- database table attributes of integer type.

	At_str_type: CHARACTER is 'S'
			-- Attribute tag "string type" option: tag content is added for
			-- database table attributes of string type.

	At_date_type: CHARACTER is 'D'
			-- Attribute tag "date type" option: tag content is added for
			-- database table attributes of date type.

	At_boolean_type: CHARACTER is 'B'
			-- Attribute tag "boolean type" option: tag content is added for
			-- database table attributes of boolean type.

	At_character_type: CHARACTER is 'C'
			-- Attribute tag "character type" option: tag content is added for
			-- database table attributes of character type.

	At_double_type: CHARACTER is 'F'
			-- Attribute tag "double type" option: tag content is added for
			-- database table attributes of double type.

	Separator: CHARACTER is ':'
			-- Options separator.

	set_all_types is
			-- Set "all types" option.
		do
			has_integer_type_option := True
			has_string_type_option := True
			has_date_type_option := True
			has_boolean_type_option := True
			has_character_type_option := True
			has_double_type_option := True
		end

	set_all_attributes is
			-- Set "all attributes" option.
		do
			has_first_attribute_option := True
			has_last_attribute_option := True
			has_intermediate_attribute_option := True
		end

end -- class DB_TEMPLATE_TAGS


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

