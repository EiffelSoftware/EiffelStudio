indexing
	Description: "Objects that enable to create a class related%
			%to a specific database table from a template and%
			%a class description (class DB_REPOSITORY)."
	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

deferred class
	DB_CLASS_GENERATOR

feature -- Access

	generated_file_content: STRING is
			-- Content of file mapped to database table associated to table description.
		require
			is_ok: is_ok
		do
			Result := gfc
		end

feature -- Status report

	is_ok: BOOLEAN
			-- Is file properly generated?

	error_message: STRING
			-- Error message.

	template_content_set: BOOLEAN is
			-- Is template file content set?
		do
			Result := template_content /= Void
		end
	
	description_set: BOOLEAN is
			-- Is description for mapping set?
		deferred
		end
		
feature -- Basic operations

	set_template_content (a_template_content: STRING) is
			-- Set template file content for the class generation.
		require
			content_exists: a_template_content /= Void and then not a_template_content.is_empty
		do
			template_content := a_template_content
		ensure
			content_set: template_content_set
		end

	generate_file is
			-- Generate file with table description and
			-- template file content.
		require
			description_set: description_set
			content_set: template_content_set
		local
			attr_tag: STRING
			attr_tag_index, attr_tag_end_index, tag_close_index: INTEGER
			template_block: STRING
		do
			gfc := clone (template_content)
			gfc.replace_substring_all (tags.Attribute_count, description_count.out)
			from
				attr_tag_index := gfc.substring_index (tags.attribute_block, 1)
			until
				attr_tag_index = 0
			loop
				tag_close_index := gfc.index_of (tags.tag_close, attr_tag_index + 1)
				if tag_close_index /= 0 then
					attr_tag := gfc.substring (attr_tag_index, tag_close_index)
					tags.parse_tag (attr_tag)
					if tags.is_valid_attribute_tag then
						attr_tag_end_index := gfc.substring_index (tags.Attribute_block_end, attr_tag_index + attr_tag.count)
						if attr_tag_end_index /= 0 then
							template_block := gfc.substring (attr_tag_index + attr_tag.count, attr_tag_end_index - 1)
							create_result_block (template_block)
							gfc.replace_substring (result_block, attr_tag_index, attr_tag_end_index + tags.Attribute_block_end.count - 1)
							attr_tag_index := gfc.substring_index (tags.attribute_block, attr_tag_index)
						else
							attr_tag_index := gfc.substring_index (tags.attribute_block, attr_tag_index + attr_tag.count)
						end
					else
						attr_tag_index := gfc.substring_index (tags.attribute_block, attr_tag_index + 1)
					end
				else
						-- Search is finished.
					attr_tag_index := 0
				end
			end
			is_ok := True
		end

feature {NONE} -- Implementation

	create_result_block (template_block: STRING) is
			-- Replace tags in `attribute_block' and iterate for table/table attributes
			-- matching conditions given by `tags'.
		require
			attribute_block_not_void: template_block /= Void
		local
			i, count: INTEGER
		do
			create result_block.make (template_block.count)
			if tags.has_first_attribute_option then
				append_block (template_block, 1)
			end
			if tags.has_intermediate_attribute_option then
				from
					i := 2
					count := description_count - 1
				until
					i > count
				loop
					append_block (template_block, i)
					i := i + 1
				end
			end
			if tags.has_last_attribute_option and then count > 0 then
				append_block (template_block, count + 1)
			end
		ensure
			result_block_not_void: result_block /= Void
		end

	append_block (template_block: STRING; index: INTEGER) is
			-- Replace tags in `template_block' with values of description item in
			-- at `index'. Append result to `result_block'.
		deferred
		end
	
	description_count: INTEGER is
			-- Count of database entities (table or attribute) in description.
		deferred
		end
		
	result_block: STRING
			-- Concatenation of blocks corresponding to the mapping of
			-- a block (defined with tags) to a database entity (table or attribute).
	
	gfc: STRING
			-- `generated_file_content' implementation.

	template_content: STRING
			-- Template file content for class to generate.

	tags: DB_TEMPLATE_TAGS is
			-- Management of tags used in template file content.
		once
			create Result
		end
		
	to_initcap (string: STRING) is
			-- Change lower case `string' to `string' with initial capital character.
		require
			not_void: string /= Void
--			lower_case: string.is_lower
		local
			initial: CHARACTER
		do
			initial := string.item (1)
			initial := initial.upper
			string.put (initial, 1)
		end
	
end -- class DB_CLASS_GENERATOR

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
--| Contact: http://contact.eiffel.com
--| Customer support: http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
