indexing
	description: "Use this squeleton to modify the generated class tables%
				  %Set the anchor to True and the code between the tags will%
				  %be inserted in the class tables%
				  %You should write the tags with no space."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MY_TABLE

inherit
	ANY
		redefine
			out
		end

<FL_ANCHOR_BEGIN=NO>
	MY_INHERITANCE
		redefine
			my_feature
		end
</FL_ANCHOR_BEGIN>

create
	make

feature -- Access

	myid: STRING
			-- Auto-generated.
	
feature -- Initialization

	make is
		do
			myid:= ""
		end

feature -- Settings

	set_myid (a_myid: ANY) is
			--Set the value of myid
		require
			value_exists: a_myid /= Void
		do
			myid := a_myid
		ensure
			myid_set: a_myid = myid
		end

feature -- Output

	out: STRING is
		do
			Result := ""
			Result.append (myid.out + "%N")
		end

<FL_ANCHOR_END=NO>
feature -- my_feature

	my_action is
		do
			action
		end
</FL_ANCHOR_END>

end -- class DB_ACTION
