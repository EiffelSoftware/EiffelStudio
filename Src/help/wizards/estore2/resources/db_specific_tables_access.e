indexing
	description: "Description of database tables.%
		%Use this class through DB_SPECIFIC_TABLES_ACCESS_USE."
	author: "EiffelStore Wizard"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_SPECIFIC_TABLES_ACCESS

inherit
	DB_TABLES_ACCESS

creation
	make

feature -- Access

<A:A:A>	<CN:I>: INTEGER is <IT>

</A>	Table_number: INTEGER is <ACNT>

	code_list: ARRAYED_LIST [INTEGER] is
			-- Table code list.
		once
			create Result.make (Table_number)
<A:A:A>			Result.extend (<CN:I>)
</A>		end

	name_list: ARRAYED_LIST [STRING] is
			-- Table name list. Can be interpreted as a list
			-- or a hash-table.
		once
			create Result.make (Table_number)
<A:A:A>			Result.extend ("<CN:I>")
</A>		end

	obj (i: INTEGER): DB_TABLE is
			-- Return instance of table with code `i'.
		do
			inspect i
<A:A:A>				when <CN:I> then
					create {<CN:U>} Result.make
</A>			end
		end

	description (i: INTEGER): DB_TABLE_DESCRIPTION is
			-- Return description of table with code `i'.
		do
			inspect i
<A:A:A>				when <CN:I> then
					Result := <CN:L>_description
</A>			end
		end

<A:A:A>	<CN:L>_description: <CN:U>_DESCRIPTION is
			-- Unique description of table `<CN:U>'.
		once
			create Result.make
		end

</A>
end -- class DB_SPECIFIC_TABLES_ACCESS
