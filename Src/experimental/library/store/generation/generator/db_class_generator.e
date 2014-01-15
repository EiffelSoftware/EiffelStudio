note
	Description: "Objects that enable to create a class related%
			%to a specific database table from a template and%
			%a class description (class DB_REPOSITORY)."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

deferred class
	DB_CLASS_GENERATOR

feature -- Access

	generated_file_content: detachable STRING
			-- Content of file mapped to database table associated to table description.
		do
			Result := gfc
		end

feature -- Status report

	is_ok: BOOLEAN
			-- Is file properly generated?

	error_message: detachable STRING
			-- Error message.

	template_content_set: BOOLEAN
			-- Is template file content set?
		do
			Result := template_content /= Void
		end

	description_set: BOOLEAN
			-- Is description for mapping set?
		deferred
		end

feature -- Basic operations

	set_template_content (a_template_content: STRING)
			-- Set template file content for the class generation.
		require
			content_exists: a_template_content /= Void and then not a_template_content.is_empty
		do
			template_content := a_template_content
		ensure
			content_set: template_content_set
		end

	generate_file
			-- Generate file with table description and
			-- template file content.
		require
			description_set: description_set
			content_set: template_content_set
		local
			attr_tag: STRING
			attr_tag_index, attr_tag_end_index, tag_close_index: INTEGER
			template_block: STRING
			l_gfc: like gfc
			l_result_block: STRING
		do
				-- Per precondition
			check attached template_content as l_template_content then
				l_gfc := l_template_content.twin
				gfc := l_gfc
				l_gfc.replace_substring_all (tags.Attribute_count, description_count.out)
				from
					attr_tag_index := l_gfc.substring_index (tags.attribute_block, 1)
				until
					attr_tag_index = 0
				loop
					tag_close_index := l_gfc.index_of (tags.tag_close, attr_tag_index + 1)
					if tag_close_index /= 0 then
						attr_tag := l_gfc.substring (attr_tag_index, tag_close_index)
						tags.parse_tag (attr_tag)
						if tags.is_valid_attribute_tag then
							attr_tag_end_index := l_gfc.substring_index (tags.Attribute_block_end, attr_tag_index + attr_tag.count)
							if attr_tag_end_index /= 0 then
								template_block := l_gfc.substring (attr_tag_index + attr_tag.count, attr_tag_end_index - 1)
								l_result_block := create_result_block (template_block)
								l_gfc.replace_substring (l_result_block, attr_tag_index, attr_tag_end_index + tags.Attribute_block_end.count - 1)
								attr_tag_index := l_gfc.substring_index (tags.attribute_block, attr_tag_index)
							else
								attr_tag_index := l_gfc.substring_index (tags.attribute_block, attr_tag_index + attr_tag.count)
							end
						else
							attr_tag_index := l_gfc.substring_index (tags.attribute_block, attr_tag_index + 1)
						end
					else
							-- Search is finished.
						attr_tag_index := 0
					end
				end
				is_ok := True
			end
		ensure
			set: gfc /= Void
		end

feature {NONE} -- Implementation

	create_result_block (template_block: STRING): STRING_32
			-- Replace tags in `attribute_block' and iterate for table/table attributes
			-- matching conditions given by `tags' to create the
			-- concatenation of blocks corresponding to the mapping of
			-- a block (defined with tags) to a database entity (table or attribute).
		require
			attribute_block_not_void: template_block /= Void
		local
			i, count: INTEGER
		do
			create Result.make (template_block.count)
			if tags.has_first_attribute_option then
				append_block (Result, template_block, 1)
			end
			if tags.has_intermediate_attribute_option then
				from
					i := 2
					count := description_count - 1
				until
					i > count
				loop
					append_block (Result, template_block, i)
					i := i + 1
				end
			end
			if tags.has_last_attribute_option and then count > 0 then
				append_block (Result, template_block, count + 1)
			end
		ensure
			result_block_not_void: Result /= Void
		end

	append_block (a_result_block, template_block: STRING; index: INTEGER)
			-- Replace tags in `template_block' with values of description item in
			-- at `index'. Append result to `a_result_block'.
		deferred
		end

	description_count: INTEGER
			-- Count of database entities (table or attribute) in description.
		deferred
		end

	gfc: detachable STRING
			-- `generated_file_content' implementation.

	template_content: detachable STRING
			-- Template file content for class to generate.

	tags: DB_TEMPLATE_TAGS
			-- Management of tags used in template file content.
		once
			create Result
		end

	to_initcap (string: STRING)
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

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class DB_CLASS_GENERATOR


