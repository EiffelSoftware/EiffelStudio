indexing
	description: "Renaming clause in Ace file";
	date: "$Date$";
	revision: "$Revision$"

class
	TWO_NAME_SD

inherit
	AST_LACE

feature {TWO_NAME_SD, LACE_AST_FACTORY} -- Initialization

	initialize (o: like old_name; n: like new_name) is
			-- Create a new TWO_NAME AST node.
		require
			o_not_void: o /= Void
			n_not_void: n /= Void
		do
			old_name := o
			new_name := n
		ensure
			old_name_set: old_name = o
			new_name_set: new_name = n
		end

feature -- Properties

	old_name: ID_SD
			-- Old name

	new_name: ID_SD
			-- New name

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object.
		do
			create Result
			Result.initialize (clone (old_name), clone (new_name))
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then old_name.same_as (other.old_name) and then
						new_name.same_as (other.new_name)
		end

feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		do
			old_name.save (st)
			st.putstring (" as ")
			new_name.save (st)
		end

end -- class TWO_NAME_SD
