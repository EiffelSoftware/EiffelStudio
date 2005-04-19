indexing

	description: "Abstract description of a renaming pair. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class RENAME_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (o: like old_name; n: like new_name) is
			-- Create a new RENAME_PAIR AST node.
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

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_rename_as (Current)
		end

feature -- Attributes

	old_name: FEATURE_NAME
			-- Name of the renamed feature

	new_name: FEATURE_NAME
			-- New name

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := old_name.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := new_name.end_location
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (old_name, other.old_name) and
				equivalent (new_name, other.new_name)
		end

invariant
	old_name_not_void: old_name /= Void
	new_name_not_void: new_name /= Void

end -- class RENAME_AS
