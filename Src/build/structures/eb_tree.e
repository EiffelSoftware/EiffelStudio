indexing
	description: "EiffelBuild Tree."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class EB_TREE [T]

creation

	make

feature {NONE} -- Initialization

	make (i: T) is 
		do 
			item := i
		end

feature -- Absraction

	item: T

	is_root: BOOLEAN is
			-- Is current item the root of the tree ?
		do 
			Result := parent = Void
		end
	
	parent: EB_TREE [T]

	arity: INTEGER
		-- Arity of current item

	child: like parent

	child_start is 
		do 
			if arity > 0 then
				child := first_child
				child_position := 1
			end
		end

	child_back is 
		do 
			child_move (-1)
		end

	child_finish is 
		do 
			child_move (arity - child_position)
		end

	child_forth is 
		do 
			child_position := child_position + 1
			if child = Void then
				child := first_child
			else
				child := child.right_sibling
			end
		end

	child_offright: BOOLEAN is 
		do 
			Result := (arity = 0) or else (child_position = arity + 1)
		end

	search_same_child (sought: like parent) is 
		do 
			from
			until
				child_offright
				or else (sought = child)
			loop
				child_forth
			end
		end

	remove_child is 
		do 
			child_back
			remove_child_right
			if arity > 0 then
				child_forth
			end
		end

	first_child: like parent

	put_child_right (n: like parent) is 
		do 
			n.forget_right
			if (arity = 0) then
				first_child := n
			elseif
				child_position = 0
			then
				n.set_right_sibling (first_child)
				first_child := n
			elseif
				child_position < arity
			then
				n.set_right_sibling (child.right_sibling)
				child.set_right_sibling (n)
			elseif
				child_position = arity
			then
				child.set_right_sibling (n)
			end
			n.attach_to_parent (Current)
			arity := arity + 1
		end
	
	right_sibling: like parent

	left_sibling: like parent is
		local
			old_position: INTEGER
		do
         	if
            	parent /= Void
         	then
				if parent.arity > 1 then
            		from
               			old_position := parent.child_position
               			parent.child_start
            		until
						parent.child = Void or else
               			parent.child.right_sibling = Current
            		loop
               			parent.child_forth
            		end
					if parent.child /= Void then
						Result := parent.child
					end
            		parent.child_move (old_position - parent.child_position)
				end
         	end
		end

feature -- Implementation

	child_position: INTEGER

	child_move (i: INTEGER) is
		local
			new_pos: INTEGER
		do
			new_pos := child_position + i
			from
				if (new_pos > child_position) then
					if child_position = 0 then
						child := first_child
						child_position := 1
					end
				elseif new_pos = 0 then
					child := Void
					child_position := 0
				elseif new_pos < child_position then
					child_start
				end
			until
				child_position = new_pos
			loop
				child := child.right_sibling
				child_position := child_position + 1
			end
		end

	remove_child_right is
		do
			if (child_position = 0) then
				first_child := first_child.right_sibling
				arity := arity - 1
			elseif not child_islast then
				child.set_right_sibling (child.right_sibling.right_sibling)
				arity := arity - 1
			end
		end

	forget_right is
		do
			right_sibling := Void
		end

	set_right_sibling (s: like parent) is
		do
			right_sibling := s
		end

   child_islast: BOOLEAN is
         -- Is cursor at last position in the list?
		do
			Result := not (arity = 0) and then (child_position = arity)
		end

	attach_to_parent (p: like parent) is
		do
			parent := p
		end

end -- class EB_TREE

