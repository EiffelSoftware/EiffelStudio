indexing
	description:"A Cell of a DS_LINKED_TREE"
	status:		"See notice at end of class."
	author:		"Andreas Leitner"
class
	DS_LINKED_TREE_CELL [G]

inherit
	DS_BILINKABLE [G]
		rename
			-- left as left_child,
			-- right as right_child,
			-- forget_left as forget_left_child,
			-- forget_right as forget_right_child,
			-- put_left as put_left_child,
			-- put_right as put_right_child,
			-- attach_right as attach_right_child,
			-- attach_left as attach_left_child
		redefine
			make,
			-- attach_left_child,
			-- attach_right_child
			attach_left,
			attach_right
		end

creation
	make
feature

	make (v: G) is
		do
			Precursor (v)
			!! children.make (Current)
		end
	
feature -- Access

	parent: like Current
	children: DS_LINKED_TREE_CHILDREN_LIST [G]
			-- Children


	is_root: BOOLEAN is
			-- Is cursor on root item?
		do
			Result := parent = Void
		end

	is_leaf: BOOLEAN is
		do
			Result := children.count = 0
		end


	depth: INTEGER is
		do
			if
				is_root
			then
				Result := 1
			else
				Result := parent.depth + 1
			end
		end

feature -- Element change

	put_parent (other: like Current) is
			-- Put `other' as parent of cell.
		do
			parent := other
		end

feature {DS_BILINKABLE} -- Implementation


	attach_left (other: like Current) is
		do
			left := other
			synchronize_parents (other)
		end;

	attach_right (other: like Current) is
		do
			right := other
			synchronize_parents (other)
		end;

	synchronize_parents (other: like Current) is
		do
			if
				parent = Void
			then
				put_parent (other.parent)
			else
				check
					other /= Void
				end
				other.put_parent (parent)
			end
		end

invariant
	children_not_void: children /= Void
end -- class DS_LINKED_TREE_CELL
--|-------------------------------------------------------------------------
--| eXML, Eiffel XML Parser Toolkit
--| Copyright (C) 1999  Andreas Leitner and others
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Andreas Leitner
--| Arndtgasse 1/3/5
--| 8010 Graz
--| Austria
--| email: andreas.leitner@chello.at
--| www: http://exml.dhs.org
--|-------------------------------------------------------------------------