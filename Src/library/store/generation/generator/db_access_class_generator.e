indexing
	Description: "Objects that enable to create a class related%
			%to a specific database table from a template and%
			%a class description (class DB_REPOSITORY)."
	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

class
	DB_ACCESS_CLASS_GENERATOR

inherit
	DB_CLASS_GENERATOR
	
feature -- Status report

	description_set: BOOLEAN is
			-- Are table names set?
		do
			Result := table_name_list /= Void
		end
	
feature -- Basic operations

	set_table_names (table_names: ARRAYED_LIST [DB_REPOSITORY]) is
			-- Set table names to map template to the database tables.
		require
			not_void: table_names /= Void
		do
			table_name_list := table_names
		ensure
			table_name_list_set: description_set
		end

feature {NONE} -- Implementation

	append_block (template_block: STRING; column_number: INTEGER) is
			-- Replace tags in `attribute_block' with values of attribute in
			-- `column' (which is at `column_number').
			-- Append result to `result_block'.
		local
			mapped_item: STRING
			table_name: STRING
		do
			table_name := clone (table_name_list.i_th (column_number).repository_name)
			mapped_item := clone (template_block)
			table_name.to_lower
			mapped_item.replace_substring_all (tags.Lower_class_name, table_name)
			to_initcap (table_name)
			mapped_item.replace_substring_all (tags.Initcap_class_name, table_name)
			table_name.to_upper
			mapped_item.replace_substring_all (tags.Upper_class_name, table_name)
			mapped_item.replace_substring_all (tags.Iterator, column_number.out)
			result_block.append (mapped_item)
		end
		
	description_count: INTEGER is
			-- Count of database entities (table or attribute) in description.
		do
			Result := table_name_list.count
		end
		
	table_name_list: ARRAYED_LIST [DB_REPOSITORY]
			-- Database table name list.
			
end -- class DB_ACCESS_CLASS_GENERATOR

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
