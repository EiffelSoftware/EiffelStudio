indexing
	description: "Description of class <CN:U>"
	author: "EiffelStore Wizard"
	date: "$Date$"
	revision: "$Revision$"

class
	<CN:U>_DESCRIPTION

inherit
	DB_TABLE_DESCRIPTION
		undefine
			Tables,
			is_valid_code
		end

	DB_SPECIFIC_TABLES_ACCESS_USE

create
	{DB_SPECIFIC_TABLES_ACCESS} make

feature -- Access

	Table_name: STRING is "<CN:U>"

	Table_code: INTEGER is <CI>

	Attribute_number: INTEGER is <ACNT>
			-- Number of attributes in the table.

	Id_code: INTEGER is
			-- Table ID attribute code.
		do
			Result := <IC>
		end

<A:A:A>	<AN:I>: INTEGER is <IT>

</A>	attribute_code_list: ARRAYED_LIST [INTEGER] is
			-- Feature code list
		once
			create Result.make (Attribute_number)
<A:A:A>			Result.extend (<AN:I>)
</A>		end

	description_list: ARRAYED_LIST [STRING] is
			-- Feature name list. Can be interpreted as a list
			-- or a hash-table.
		once
			create Result.make (Attribute_number)
<A:A:A>			Result.extend ("<AN:I>")
</A>		end

	type_list: ARRAYED_LIST [INTEGER] is
			-- Feature type list. Can be interpreted as a list
			-- or a hash-table.
		once
			create Result.make (Attribute_number)
<A:A:A>			Result.extend (<TN:I>_type)
</A>		end

	to_delete_fkey_from_table: HASH_TABLE [INTEGER, INTEGER] is
			-- List of tables depending on this one and their
			-- foreign key for this table.
			-- Deletion on this table may imply deletions on
			-- depending tables. 
		once
			<DH>		end

	to_create_fkey_from_table: HASH_TABLE [INTEGER, INTEGER] is
			-- List of associated necessary tables and the  
			-- linking foreign keys.
			-- Creation on this table may imply creations on
			-- associated necessary tables.
		once
			<CH>		end

	attribute (i: INTEGER): ANY is
			-- Get feature value of feature whose code is 'i'.
		do
			inspect i
<A:A:A>				when <AN:I> then
					Result := <CN:L>.<AN:L>
</A>			end
		end

	set_attribute (i: INTEGER; value: ANY) is
			-- Set feature value of feature whose code is `i' to `value'.
			-- `value' must be of type STRING, INTEGER, BOOLEAN, CHARACTER,
			-- DOUBLE or DATE_TIME. References are made automatically from
			-- expanded types.
		local
			integer_value: INTEGER_REF
			double_value: DOUBLE_REF
			boolean_value: BOOLEAN_REF
			character_value: CHARACTER_REF
			date_time_value: DATE_TIME
			string_value: STRING
		do
			inspect i
<A:S:A>				when <AN:I> then
					string_value ?= value
					<CN:L>.set_<AN:L> (string_value)
</A><A:F:A>				when <AN:I> then
					double_value ?= value
					if double_value /= Void then
						<CN:L>.set_<AN:L> (double_value.item)
					else
						<CN:L>.set_<AN:L> (0.0)
					end
</A><A:I:A>				when <AN:I> then
					integer_value ?= value
					if integer_value /= Void then
						<CN:L>.set_<AN:L> (integer_value.item)
					else
						<CN:L>.set_<AN:L> (0)
					end
</A><A:D:A>				when <AN:I> then
					date_time_value ?= value
					<CN:L>.set_<AN:L> (date_time_value)
</A><A:C:A>				when <AN:I> then
					character_value ?= value
					if character_value /= Void then
						<CN:L>.set_<AN:L> (character_value.item)
					else
						<CN:L>.set_<AN:L> ('%U')
					end
</A><A:B:A>				when <AN:I> then
					boolean_value ?= value
					if boolean_value /= Void then
						<CN:L>.set_<AN:L> (boolean_value.item)
					else
						<CN:L>.set_<AN:L> (False)
					end
</A>			end
		end

feature {<CN:U>} -- Basic operations

	set_<CN:L> (a_<CN:L>: <CN:U>) is
			-- Associate the description to a piece of <CN:L>.
		require
			not_void: a_<CN:L> /= Void
		do
			<CN:L> := a_<CN:L>
		ensure
			<CN:L> = a_<CN:L>
		end

feature {NONE} -- Implementation

	<CN:L>: <CN:U>
			-- Piece of <CN:L> associated with the description	

end -- class CODES_DESCRIPTION