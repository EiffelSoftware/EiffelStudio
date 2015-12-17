note
	description: "[
			Arbitrary sized dictionaries that hold keys. Each key has an associated value,
			e.g. a dictionary could hold people's names as the keys and
			people's email address as the associated values. 
			Keys are searched for or compared using object equality, i.e. `equal'.
			Values are returned as references.
						]"
	date: "Jan 4, 2006"
	modified_by: "Faraz A. Torshizi"

class DICTIONARY_ [ VALUE , KEY ]
create
	make

feature -- A: Creation

	make
			-- Create an empty dictionary
		require
			true
		do
			create container.make(0)	-- create a dictionary with zero elements
										-- creates an arrayed_list container with zero capacity
		ensure
			container_not_void: container /= void
			dictionary_is_empty: is_empty
			count_zero: count = 0
			comment("HI")
		end


feature -- B: Queries
	count: INTEGER
			-- Returns the number of items in the dictionary
		require
			true
		do
			Result := container.count

		ensure
			correct_result: Result = container.count
			no_change_in_container: equal (old container, container)
			no_change_in_count: old count = count
		end


	is_empty: BOOLEAN
			-- Is dictionary empty
		require
			true
		do
			Result := count = 0

		ensure
			correct_result: Result = (count = 0)
			no_change_in_container: equal (old container, container)
			no_change_in_count: old count = count
		end

	at alias "@" ( k : KEY ) : VALUE
			-- The value associated with key 'k'
		require
			key_non_void: k /= void
			key_exists_in_dictionary: has(k)
			dictionary_not_empty: is_empty = false
		local
			done: BOOLEAN
		do
			from
				container.start	-- start from the first element of the container
			until
				container.after or done	-- until found or finished
			loop
				if
					equal(container.item.get_key , k) -- found the key (object equlity) 	
				then
					done := true
					Result := container.item.get_value
				else
					container.forth
				end
			end

		ensure
			correct_result: exists (agent same_key_and_value_as(?, ?, Result, k))
			no_change_in_container: equal (old container, container)
			no_change_in_count: old count = count
		end

	has( k : KEY ) : BOOLEAN
			-- Does the dictionary contain key 'k'?
		require
			key_non_void: k /= void
--			dictionary_not_empty: is_empty = false
		do
			from
				container.start	-- start from the first element of the container
			until
				container.after or Result	-- until found or finished
			loop
				if
					equal(container.item.get_key, k) -- found the key 	
				then
					Result := true
				else
					container.forth
				end
			end

		ensure
			correct_result: Result = exists (agent same_key_as(?, ?, k))
			no_change_in_container: equal (old container, container)
			no_change_in_count: old count = count
		end

	has_defensive( k : KEY ) : BOOLEAN
			-- Does the dictionary contain key 'k'?
			-- No precondition
			-- k = void returns false
		require
			true
		do
			if	-- if key not void
				k /= void
			then
				Result := has (k)
			else	-- key void
				Result := false
			end

		ensure
			correct_result: Result = exists (agent same_key_as(?, ?, k))
			void_check: k = void implies Result = false
			no_change_in_container: equal (old container, container)
			no_change_in_count: old count = count
		end


feature -- C: Commands
	put( v : VALUE; k : KEY)
			-- Put key 'k' into the dictionary with associated value 'v'
			-- provided not already in
		require
			key_non_void: k /= void
			not_already_in: has_defensive(k) = false
		local
			dictionary_item: DIC_ITEM_ [VALUE, KEY]
		do
			create dictionary_item.make(v, k)  -- create a new dictionary item with key 'k' and value 'v'
			container.extend (dictionary_item) -- put it into the container

		ensure
			count_increased: count = old count + 1
			not_empty_anymore: is_empty = false
			dictionary_has_it: has(k)
			correct_value: equal (at(k), v)
			key_and_value_exist: exists (agent same_key_and_value_as(?, ?, v, k))
		end


	put_defensive( v : VALUE; k : KEY)
			-- Put key 'k' into the dictionary with associated value 'v'
			-- If k = Void then do nothing
			-- If has(k) is already in, replace with new tuple [v, k]
			-- There should be no precondition
		require
			true
		local
			dictionary_item: DIC_ITEM_ [VALUE, KEY]
			done: BOOLEAN
		do
			if	-- key non void and not already in the dictionary
				k /= void and has_defensive (k) = false
			then
				create dictionary_item.make(v, k)  -- create a new dictionary item with key 'k' and value 'v'
				container.extend (dictionary_item) -- put it into the container
			elseif -- already in
				k /= void
			then
				create dictionary_item.make(v, k)  -- create a new dictionary item with key 'k' and value 'v'
				from
					container.start	-- start from the first element of the container
				until
					container.after or done	-- until found or finished
				loop
					if
						equal(container.item.get_key, k) -- found the key 	
					then
						done := true
						container.replace (dictionary_item) -- replace current item with dictionary_item
					else
						container.forth
					end
				end -- loop		
			end -- elseif

		ensure
			count_increased: old has_defensive(k) = false and k /= void implies count = old count + 1
			dictionary_has_it: old has_defensive(k) = false and k /= void implies has(k)
			correct_value: old has_defensive(k) = false and k /= void implies equal (at(k), v)
			key_and_value_exist: k /= void implies exists (agent same_key_and_value_as(?, ?, v, k))
		end

	remove( k : KEY )
			-- Remove key 'k' from the dictionary
		require
			not_empty: is_empty = false
			has_the_key: has(k)
			key_non_void: k /= void
		local
			done: BOOLEAN
		do
			from
				container.start	-- start from the first element of the container
			until
				container.after or done	-- until found or finished
			loop
				if
					equal(container.item.get_key, k) -- found the key 	
				then
					done := true
					container.remove -- remove the current item
				else
					container.forth
				end
			end

		ensure
			count_decreased: count = old count - 1
			does_not_exist_anymore: has (k) = false -- could become empty
			count_non_negative: count >= 0
			does_not_exist_anymore: not exists (agent same_key_as (?,?, k))
		end

feature -- D: Quantifiers

	for_all (test: FUNCTION[VALUE,KEY, BOOLEAN]): BOOLEAN
			-- does `test' hold for all key value pairs?
		do
			Result := true
			from
				container.start
			until
				container.after or Result = false
			loop
				if  -- if alteast one item did not satisfy the test
					not test.item ([container.item.get_value, container.item.get_key])
				then
					Result := false
				else
					container.forth
				end
			end

		ensure
			no_change_in_container: equal (old container, container)
			no_change_in_count: old count = count
		end

	exists (test: FUNCTION[VALUE,KEY, BOOLEAN]): BOOLEAN
			-- does `test' hold for at least one of the key value pairs?
		do
			Result := false
			from
				container.start
			until
				container.after or Result = true
			loop
				if  -- if alteast one item satisfied the test
					test.item ([container.item.get_value, container.item.get_key])
				then
					Result := true
				else
					container.forth
				end
			end

		ensure
			no_change_in_container: equal (old container, container)
			no_change_in_count: old count = count
		end

feature -- E: Comment Support	
	comment( s : STRING ) : BOOLEAN
		-- Return true (because this feature is intended just to
		-- provide a place to write comments in contracts that
		-- the ISE compiler will not lose).
	do
		Result := true
	end


feature{NONE} -- F-Implementation
	container: ARRAYED_LIST [DIC_ITEM_[VALUE, KEY]]
		-- This container stores all the dictionary items

	same_key_and_value_as (v1: VALUE ; k1: KEY; v2: VALUE; k2: KEY): BOOLEAN
			-- if k1 is equal to k2 then v1 is equal to v2
	do
		Result := equal (k1, k2) implies equal (v1, v2)
	end

	same_key_as (v: VALUE; k1: KEY; k2: KEY): BOOLEAN
			-- is k1 equal to k2?
	do
		Result := equal (k1, k2)
	end





invariant
	container_not_void: container /= Void
	counter_non_negative: count >= 0
	count_zero_then_empty: (count = 0) = is_empty

end -- class DICTIONARY
