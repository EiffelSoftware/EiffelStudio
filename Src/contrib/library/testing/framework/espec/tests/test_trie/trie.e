note
	description: "Objects that represent tries, i.e. a ceratin kind of retrieval tree"
	author: "JSO"
	date: "Januray 28, 04"

class
	TRIE[G]

create
	make

feature {NONE} -- Initialization

	make
			-- create an empty TRIE
		do
			create ll.make
			height := 1
		ensure
			is_empty
			height = 1
		end

feature -- Status report


	contains (seq: LINKED_LIST[G]): BOOLEAN
		-- Returns true if the trie contains the particular sequence
		local
			seq_clone: LINKED_LIST[G]
		do
			if seq.is_empty then
				Result := terminal
			else
				seq_clone := seq.twin
				from
					seq_clone.start
					ll.start
				until
--					ll.after or ll.item.element.is_equal(seq_clone.item)
					ll.after or equal(ll.item.element, seq_clone.item)
				loop
					ll.forth
				end
				seq_clone.remove
				if ll.after then
					Result := false
				elseif seq_clone.is_empty  and ll.item.terminal then
					Result := true
				else
					Result := ll.item.contains(seq_clone)
				end
				restore_ll_cursor
			end
		ensure
			count_unchanged: count = old count
			unique_containment: Result implies exists1 (agent same_list (seq,?))
			same_terminal: terminal = old terminal
--			same_element: equal(element, old clone(element))
--			-- perhaps these are unncessary
			seq_unchanged: seq.is_equal(old seq.twin)
			values_in_seq_unchanged: deep_equal (seq, old seq.deep_twin)
			trie_unchanged: deep_equal (Current, old Current.deep_twin)
		end

	count: INTEGER
			-- The number of sequences in the trie
		local
			list: LINKED_LIST[TRIE[G]]
			t : TRIE[G]
		do
			list := ll.twin
			create t.make
			if terminal  then
				Result := 1
			end
			from
				list.start
			until
				list.after
			loop
				t := list.item
				-- recursive call
				Result := Result + t.count
				list.forth
			end
		ensure
			same_height: height = old height
			same_terminal: terminal = old terminal
--			same_element: equal(element, old clone(element))
--			-- perhaps unnecesary
--			same_element: equal(element, old clone(element))
			trie_unchanged: deep_equal (Current, old Current.deep_twin)
		end

	is_empty: BOOLEAN
			-- is the trie empty?
		do
			Result := count = 0
		ensure
			Result = (count = 0)
			trie_unchanged: deep_equal (Current, old current.deep_twin)
			count = old count
			height = old height
		end

	height: INTEGER
			-- The length of the longest path from the root of the trie to any leaf node
			-- The height of an empty trie is 1
			-- space inefficient; better to implement as a routine


feature -- Element change

	insert (seq: LINKED_LIST[G])
			-- Insert `seq' in the  trie
			-- Assumes that the sequence is not already in the trie
		require
			not contains (seq)
		do
			insert_recursive(seq)
		ensure
			contains (seq)
			exists1 (agent same_list(seq, ?))
			count_increased: count = old count + 1
			not_empty: not is_empty
			height_updated: height = ((seq.count +1).max (height))
			-- next two unnecessary?
			height_updated1: (seq.count >= old height) implies (height = seq.count + 1)
			height_same: (seq.count < old height) = (height = old height)
			each_sequence_is_unique: for_all(agent unique_entry(?))
		end

feature {TRIE} -- Implementation element change
	set_element (el: G)
			-- Change the element represented by this trie
			do
				element := el
			end

	set_terminal
			-- This trie is the valid end of a sequence
			do
				terminal := True
			end

	set_non_terminal
			-- This trie is not the valid end of a sequence
			do
				terminal := False
			end

feature -- Quantifiers

	for_all (test: FUNCTION[LINKED_LIST[G], BOOLEAN]): BOOLEAN
			-- does `test' hold for all sequences in the trie?
		require
			test_not_void: test /= Void
		do
			Result := hold_count (test) = count
		ensure
				Result = ( hold_count (test) = count)
		end

	hold_count (test:
					FUNCTION [LINKED_LIST[G], BOOLEAN]):
				INTEGER
				-- Number of  times `test' holds in the TRIE
			require
				test_not_void: test /= Void
			local
				seq: LINKED_LIST[G]
			do
--				debug print("Enter hold_count: " + "%N") end
				create seq.make
				Result :=  hold_count_recursive(test, seq)
			ensure
				Result >= 0
			end

	exists (test: FUNCTION[LINKED_LIST[G], BOOLEAN]): BOOLEAN
			-- Does `test' hold for at least one of the sequences in the trie?
		require
			test_not_void: test /= Void
		do
			Result := hold_count (test) >= 1
		ensure
				Result =( hold_count (test) >= 1)
		end

	exists1 (test: FUNCTION[LINKED_LIST[G], BOOLEAN]): BOOLEAN
			-- Does `test' hold for at least one of the sequences in the trie?
		require
			test_not_void: test /= Void
		do
			Result := hold_count (test) = 1
		ensure
				Result = ( hold_count (test) = 1)
		end

feature {TRIE, ES_TEST} -- Implementation

	element: G
	terminal: BOOLEAN
	ll: LINKED_LIST[TRIE[G]]
			-- Hidden implementation (a trie is a linked list of sub-tries)

feature {TRIE} -- Implementation

	restore_ll_cursor
			-- restore cursor to what it originally was
			-- so that `Current' is unchanged
		do
				if ll.is_empty then
					ll.finish
				else
					ll.start
				end
		end


	insert_recursive(seq: LINKED_LIST[G])
		-- Traverses the tree structure. If a common prefix is found, it follows the
		-- corresponding link; otherwise it adds a new path
		require
--			not seq.is_empty
			not contains (seq)
		local
			t: TRIE[G]
			seq_clone: LINKED_LIST[G]
		do
			if seq.is_empty then
				set_terminal
			else
				height := ((seq.count +1).max (height))
				create t.make
				seq_clone := seq.twin
				-- Find next insertion position
				from
					ll.start
				until
					ll.after or ll.item.element.is_equal(seq_clone.first)
				loop
					ll.forth
				end
				if ll.after then
					-- Not a substring; create a new branch
					t.set_element (seq_clone.first)
					ll.extend (t)
					ll.back -- set index to point at new item
				end
				--- Remove first element of `seq'
				seq_clone.start
				seq_clone.remove
				if seq_clone.is_empty then
					ll.item.set_terminal
				else
					ll.item.insert_recursive(seq_clone)
				end
			end
		ensure
			height = ((seq.count +1).max (height))
			terminal implies  count = old count + 1
		end

hold_count_recursive(test:
					FUNCTION [LINKED_LIST[G], BOOLEAN];
					seq: LINKED_LIST[G]):
				INTEGER
			-- apply `test' to `seq' if `terminal' holds
	local
		ll_clone: like ll
	do
		if terminal  and  seq.is_empty and test.item([seq]) then
			-- null or Void TRIE
			Result := 1
		end
				ll_clone := ll.twin
				from
					ll_clone.start
				until
					ll_clone.after
				loop
					seq.extend ( ll_clone.item.element)
					if ll_clone.item.terminal  and then test.item([seq]) then
							Result := Result + 1
					end
					if not ll_clone.item.is_empty then
							Result := Result + ll_clone.item.hold_count_recursive (test, seq)
					end
					seq.finish
					seq.remove
					ll_clone.forth
			end
		end

feature -- Agent tests

	unique_entry (l: LINKED_LIST[G]): BOOLEAN
			do
				Result := exists1 (agent same_list(l,?))
			end

	same_list (l1,l2: LINKED_LIST[G]): BOOLEAN
			do
				Result := equal(l1,l2)
			end


invariant
	count_non_negative: count >= 0
	empty_if_no_element: is_empty = (count = 0)
	height >= 1
--	each_sequence_is_unique: for_all(agent unique_entry(?))

end -- class TRIE
