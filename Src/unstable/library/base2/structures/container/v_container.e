note
	description: "[
		Containers for a finite number of values.
		Immutable interface.
		]"
	author: "Nadia Polikarpova"
	model: bag

deferred class
	V_CONTAINER [G]

inherit
	ITERABLE [G]
		redefine
			out
		end

feature -- Measurement

	count: INTEGER
			-- Number of elements.
		deferred
		ensure
			definition: Result = bag.count
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is container empty?
		do
			Result := count = 0
		ensure
			definition: Result = bag.is_empty
		end

feature -- Search

	has (v: G): BOOLEAN
			-- Is value `v' contained?
			-- (Uses reference equality.)
		local
			it: V_ITERATOR [G]
		do
			it := new_cursor
			it.search_forth (v)
			Result := not it.after
		ensure
			definition: Result = bag.domain [v]
		end

	occurrences (v: G): INTEGER
			-- How many times is value `v' contained?
			-- (Uses reference equality.)
		do
			across
				Current as it
			loop
				if it.item = v then
					Result := Result + 1
				end
			end
		ensure
			definition: Result = bag [v]
		end

	count_satisfying (pred: PREDICATE [G]): INTEGER
			-- How many elements satisfy `pred'?
		require
			pred_has_one_arg: pred.open_count = 1
			precondition_satisfied: bag.domain.for_all (agent (x: G; p: PREDICATE [G]): BOOLEAN
				do
					Result := p.precondition ([x])
				end (?, pred))
		do
			across
				Current as it
			loop
				if pred.item ([it.item]) then
					Result := Result + 1
				end
			end
		ensure
			definition: Result = (bag | (bag.domain | pred)).count
		end

	exists (pred: PREDICATE [G]): BOOLEAN
			-- Is there an element that satisfies `pred'?
		require
			pred_has_one_arg: pred.open_count = 1
			precondition_satisfied: bag.domain.for_all (agent (x: G; p: PREDICATE [G]): BOOLEAN
				do
					Result := p.precondition ([x])
				end (?, pred))
		do
			Result := across Current as it some pred.item ([it.item]) end
		ensure
			definition: Result = bag.domain.exists (pred)
		end

	for_all (pred: PREDICATE [G]): BOOLEAN
			-- Do all elements satisfy `pred'?
		require
			pred_has_one_arg: pred.open_count = 1
			precondition_satisfied: bag.domain.for_all (agent (x: G; p: PREDICATE [G]): BOOLEAN
				do
					Result := p.precondition ([x])
				end (?, pred))
		do
			Result := across Current as it all pred.item ([it.item]) end
		ensure
			definition: Result = bag.domain.for_all (pred)
		end

feature -- Iteration

	new_cursor: V_ITERATOR [G]
			-- New iterator pointing to a position in the container, from which it can traverse all elements by going `forth'.
		deferred
		ensure then
			target_definition: Result.target = Current
			index_definition: Result.index = 1
		end

feature -- Output

	out: STRING
			-- String representation of the content.
		local
			stream: V_STRING_OUTPUT
		do
			create Result.make_empty
			create stream.make (Result)
			stream.pipe (new_cursor)
			Result.remove_tail (stream.separator.count)
		end

feature -- Specification

	bag: MML_BAG [G]
			-- Bag of elements.
		note
			status: specification
		do
			create Result
			across Current as i loop
				Result := Result & i.item
			end
		end

end
