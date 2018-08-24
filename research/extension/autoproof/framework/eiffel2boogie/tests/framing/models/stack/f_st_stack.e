note
	model: sequence

class
	F_ST_STACK [G]

inherit
	F_ST_CONTAINER [G]

create
	make

feature {NONE} -- Initialization

	make
			-- Create an empty list.
		note
			status: creator
		do
			create list.make
		ensure
			sequence_effect: sequence.is_empty
		end

feature	-- Access

	item: G
			-- Top element.
		require
			not_empty: not is_empty
		do
			Result := list.item (count)
		ensure
			Result = sequence.last
		end

	count: INTEGER
			-- Number of elements.
		do
			Result := list.count
		end

feature -- Element change

	push (v: G)
		do
			list.extend_back (v)
		ensure
			sequence_effect: sequence = old sequence & v
		end

	pop
		require
			not_empty: not is_empty
		do
			list.remove_back
		ensure
			sequence_effect: sequence = old sequence.but_last
		end

	wipe_out
			-- Empty container.
		do
			from
			invariant
				list.is_wrapped
				modify_model ("sequence", list)
			until
				list.is_empty
			loop
				list.remove_back
			variant
				list.count
			end
		end

feature {NONE} -- Implementation

	list: F_ST_LIST [G]
			-- Storage for stack elements.

feature -- Specification

	sequence: MML_SEQUENCE [G]
			-- Sequence of list's elements.
		note
			status: ghost
			replaces: bag
		attribute
		end

invariant
	list_attached: list /= Void
	owns_definition: owns = [list]
	bag_definition: bag = sequence.to_bag
	sequence_definition: sequence = list.sequence
end
