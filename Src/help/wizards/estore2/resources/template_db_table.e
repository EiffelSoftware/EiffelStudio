indexing
	description: "Class which allows EiffelStore to retrieve/store%
	      %the content of a table row from database table <CN:U>"
	author: "EiffelStore Wizard"
	date: "$Date$"
	revision: "$Revision$"

class
	<CN:U>

inherit
	DB_TABLE
		undefine
			Tables,
			is_valid_code
		redefine
			out
		end

	DB_SPECIFIC_TABLES_ACCESS_USE	
		redefine
			out
		end

create
	make

feature -- Access

<A:A:A>	<AN:L>: <TN:U>

</A>	table_description: DB_TABLE_DESCRIPTION is
			-- Description associated to the <CN:L>.
		do
			tables.<CN:L>_description.set_<CN:L> (Current)
			Result := tables.<CN:L>_description
		end

feature -- Initialization

	set_default is
		do
<A:A:A>			<AN:L> := <TDV>
</A>		end

feature -- Basic operations

<A:A:A>	set_<AN:L> (a_<AN:L>: <TN:U>) is
		do
			<AN:L> := a_<AN:L>
		end

</A>feature -- Output

	out: STRING is
			-- Printable representation of current object.
		do
			Result := ""
<A:A:A>			if <AN:L> /= Void then
				Result.append ("<AN:I>: " + <AN:L>.out + "%N")
			end
</A>		end

end -- class CODES