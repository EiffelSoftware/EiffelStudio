indexing

	 description:
			"Abstract description of an item in the class indexing list. %
			%Version for Bench."
	 date: "$Date$"
	 revision: "$Revision$"

class INDEX_AS

inherit
	AST_EIFFEL
		redefine
			type_check
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (t: like tag; i: like index_list) is
			-- Create a new INDEX AST node.
		require
			i_not_void: i /= Void
		do
			tag := t
			index_list := i
		ensure
			tag_set: tag = t
			index_list_set: index_list = i
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_index_as (Current)
		end

feature -- Attributes

	tag: ID_AS
			-- Tag of the index list

	index_list: EIFFEL_LIST [ATOMIC_AS]
			-- Indexes

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := tag.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := index_list.end_location
		end
			
feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (tag, other.tag) and
				equivalent (index_list, other.index_list)
		end

	is_equiv (other: like Current): BOOLEAN is
		do
			Result := equivalent (tag, other.tag) and then
						equivalent (index_list, other.index_list)
		end

feature -- Type checking

	type_check is
			-- Type check a unique type
		do
			index_list.type_check
		end

feature {DOCUMENTATION_ROUTINES} -- Access

	content_as_string: STRING is
			-- Merge content into a single string.
		local
			il: like index_list
		do
			create Result.make (20)
			il := index_list
			from
				il.start
			until
				il.after
			loop
				Result.append (il.item.string_value)
				il.forth
				if not il.after then
					Result.append (", ")
				end
			end
		end

invariant
	index_list_not_void: index_list /= Void

end -- class INDEX_AS
