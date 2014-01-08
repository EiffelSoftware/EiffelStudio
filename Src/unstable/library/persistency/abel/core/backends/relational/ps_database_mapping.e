note
	description: "Summary description for {PS_DATABASE_MAPPING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_DATABASE_MAPPING

create
	make

feature {PS_ABEL_EXPORT} -- Access

	primary_key_column (table_name: READABLE_STRING_GENERAL): detachable STRING
			-- Check if there's a primary key column for `table_name'.
		do
			Result := primary_hash [table_name]
		end

feature {PS_ABEL_EXPORT} -- Element change

	add_primary_key_column (column_name: STRING; table_name: READABLE_STRING_GENERAL)
			-- Register `column_name' in table `table_name' as a primary key.
		do
			primary_hash.extend (column_name, table_name)
		end

feature {NONE}

	primary_hash: STRING_TABLE [STRING]
			-- The primary key table hash.

	make
			-- Initialization for `Current'.
		do
			create primary_hash.make (5)
		end
end
