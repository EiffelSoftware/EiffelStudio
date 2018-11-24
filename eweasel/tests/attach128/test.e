class TEST

create
	make,
	make_with,
	make_arguments_with,
	make_arguments_bracket_with,
	make_safe_this,
	make_arguments_safe_this,
	make_arguments_bracket_safe_this,
	make_safe_with,
	make_arguments_safe_with,
	make_arguments_bracket_safe_with

feature {NONE} -- Creation

	make
			-- Run test.
		do
				-- Initialize Current.
			item := Current
				-- Pass Current to update it with a new reference.
			;(create {TEST}.make_with (Current)).do_nothing
			;(create {TEST}.make_arguments_with (Current)).do_nothing
			;(create {TEST}.make_arguments_bracket_with (Current)).do_nothing
			;(create {TEST}.make_safe_this).do_nothing
			;(create {TEST}.make_arguments_safe_this).do_nothing
			;(create {TEST}.make_arguments_bracket_safe_this).do_nothing
			;(create {TEST}.make_safe_with (Current)).do_nothing
			;(create {TEST}.make_arguments_safe_with (Current)).do_nothing
			;(create {TEST}.make_arguments_bracket_safe_with (Current)).do_nothing
		end

	make_with (other: TEST)
			-- Record Current object in other and then complete the initialization.
		do
				-- Call an assigner command passing an incompletely initialized Current.
			other.item := Current -- Error: VEVI
				-- Complete initialization.
			item := Current
		end

	make_arguments_with (other: TEST)
			-- Record Current object in other and then complete the initialization.
		do
				-- Call an assigner command passing an incompletely initialized Current.
			other.data (Current) := Current -- Error: VEVI
		end

	make_arguments_bracket_with (other: TEST)
			-- Record Current object in other and then complete the initialization.
		do
				-- Call an assigner command passing an incompletely initialized Current.
			other [Current] := Current -- Error: VEVI
		end

	make_safe_this
			-- Indirectly complete initialization.
		do
				-- Call an assigner command on a query that initializes Current.
			this.item := Current
		end

	make_arguments_safe_this
			-- Indirectly complete initialization.
		do
				-- Call an assigner command on a query that initializes Current.
			this.data (Current) := Current
		end

	make_arguments_bracket_safe_this
			-- Indirectly complete initialization.
		do
				-- Call an assigner command on a query that initializes Current.
			this [Current] := Current
		end

	make_safe_with (other: TEST)
			-- Record Current object in other indirectly completing the initialization earlier.
		do
				-- Call an assigner command with an expression that initializes Current.
			other.item := this
		end

	make_arguments_safe_with (other: TEST)
			-- Record Current object in other indirectly completing the initialization earlier.
		do
				-- Call an assigner command with an expression that initializes Current.
			other.data (Current) := this
		end

	make_arguments_bracket_safe_with (other: TEST)
			-- Record Current object in other indirectly completing the initialization earlier.
		do
				-- Call an assigner command with an expression that initializes Current.
			other [Current] := this
		end

feature -- Access

	item: TEST assign put
			-- An attribute to be initialized at creation.

	this: TEST
			-- Initialized Current object.
		do
			item := Current
			Result := Current
		end

	put (value: TEST)
			-- Set `item` to `value`.
		do
			item := value
		end

	data alias "[]" (value: TEST): TEST assign set
			-- `value`.
		do
			Result := value
		end

	set (source: TEST; value: TEST)
			-- An assigner for `data`.
		do
		end

end
