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

class
	DB_ACCESS_CLASS_GENERATOR

inherit
	DB_CLASS_GENERATOR

feature -- Status report

	description_set: BOOLEAN
			-- Are table names set?
		do
			Result := table_name_list /= Void
		end

feature -- Basic operations

	set_table_names (table_names: ARRAYED_LIST [DB_REPOSITORY])
			-- Set table names to map template to the database tables.
		require
			not_void: table_names /= Void
		do
			table_name_list := table_names
		ensure
			table_name_list_set: description_set
		end

feature {NONE} -- Implementation

	append_block (template_block: STRING; column_number: INTEGER)
			-- Replace tags in `attribute_block' with values of attribute in
			-- `column' (which is at `column_number').
			-- Append result to `result_block'.
		local
			mapped_item: STRING
			table_name: STRING
			l_table_name_list: like table_name_list
			l_result_block: like result_block
		do
			l_table_name_list := table_name_list
			check l_table_name_list /= Void end -- FIXME: implied by nothing... bug?
			table_name := l_table_name_list.i_th (column_number).repository_name.as_lower
			mapped_item := template_block.twin
			mapped_item.replace_substring_all (tags.Lower_class_name, table_name)
			to_initcap (table_name)
			mapped_item.replace_substring_all (tags.Initcap_class_name, table_name)
			table_name.to_upper
			mapped_item.replace_substring_all (tags.Upper_class_name, table_name)
			mapped_item.replace_substring_all (tags.Iterator, column_number.out)
			l_result_block := result_block
			check l_result_block /= Void end -- FIXME: implied by ... bug?
			l_result_block.append (mapped_item)
		end

	description_count: INTEGER
			-- Count of database entities (table or attribute) in description.
		local
			l_table_name_list: like table_name_list
		do
			l_table_name_list := table_name_list
			check l_table_name_list /= Void end -- FIXME: bug?
			Result := l_table_name_list.count
		end

	table_name_list: detachable ARRAYED_LIST [DB_REPOSITORY];
			-- Database table name list.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DB_ACCESS_CLASS_GENERATOR


