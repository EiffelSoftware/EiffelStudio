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
	--	redefine
	--		out
	--	end
		undefine
			Tables,
			is_valid_code
		end

	DB_SPECIFIC_TABLES_ACCESS_USE	

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

--FIXME: add this	out: STRING is
--		do
--			Result := ""
--			Result.append (myid.out + "%N")
--		end

end -- class CODES