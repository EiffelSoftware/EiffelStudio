indexing
	description: "Words occurences implemented as a linked set."
	author: "Parker Abercrombie"
	date: "$Date$"

class
	LINKED_WORD_SET

inherit
	LINKED_SET [INTEGER]
		redefine
			intersect
		end

create
	make

feature -- Basic operations

	intersect (other: like Current) is
			-- Remove all items not in `other'.
			-- Remove all items if `other' is `empty'.
		do
				from
					start;
					other.start
				until
					off
				loop
					if other.has (item) then
						forth
					else
						remove
					end
				end
		end;

end -- class LINKED_WORD_SET
