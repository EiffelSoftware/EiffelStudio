note
	AutoProof: ownership, ownership_defaults, overflow

class B_MESSAGES

feature -- Successful verification

	verification_successful (a, b, c: INTEGER)
		require
			tag1: a > 0
			b > 0
			tag2: c > 0
		do
		end

feature -- Check violation

	check_fails (a: INTEGER)
		do
			check a > 0 end
		end

	tagged_check_fails (a: INTEGER)
		do
			check tag1: a > 0 end
		end

	multi_check_fails (a, b, c: INTEGER)
		do
			check
				tag1: a > 0
				b > 0
				tag2: c > 0
			end
		end

feature -- Postcondition violation

	postcondition_fails: INTEGER
		do
		ensure
			Result > 0
		end

	tagged_postcondition_fails: INTEGER
		do
		ensure
			tag1: Result > 0
		end

	multi_postcondition_fails (a: INTEGER): INTEGER
		do
			Result := a
		ensure
			tag1: Result > 0
			Result < 0
		end

feature -- Precondition violation

	precondition_fails: INTEGER
		do
			verification_successful (1, 0, 1)
		end

	tagged_precondition_fails: INTEGER
		do
			verification_successful (0, 1, 1)
		end

	multi_precondition_fails (a: INTEGER): INTEGER
		do
				-- ONLY ONE ERROR REPORTED
			verification_successful (0, 0, 0)
		end

feature -- Loop invariant violation

	loop_invariant_fails_on_entry
		local
			a: INTEGER
		do
			from
			invariant
				a < 0
			until
				a > 10
			loop
				a := a + 1
			end
		end

	tagged_loop_invariant_fails_on_entry
		local
			a: INTEGER
		do
			from
			invariant
				tag1: a < 0
			until
				a > 10
			loop
				a := a + 1
			end
		end

	multi_loop_invariant_fails_on_entry
		local
			a, b, c: INTEGER
		do
			from
			invariant
					-- ONLY ONE ERROR REPORTED
				tag1: a < 0
				b < 0
				tag2: c < 0
			until
				a > 10
			loop
				a := a + 1
			end
		end

	loop_invariant_not_maintained
		local
			a: INTEGER
		do
			from
			invariant
				a <= 0
			until
				a > 10
			loop
				a := a + 1
			end
		end

	tagged_loop_invariant_not_maintained
		local
			a: INTEGER
		do
			from
			invariant
				tag1: a <= 0
			until
				a > 10
			loop
				a := a + 1
			end
		end

	multi_loop_invariant_not_maintained
		local
			a, b, c: INTEGER
		do
			from
			invariant
					-- ONLY ONE ERROR REPORTED
				tag1: a <= 0
				b <= 0
				tag2: c <= 0
			until
				a > 10
			loop
				a := a + 1
				b := b + 1
				c := c + 1
			end
		end

feature -- Loop variant violation

	loop_variant_negative
		local
			a: INTEGER
		do
			from
			until
				a > 10
			loop
				a := a + 1
			variant
				a - 1
			end
		end

	tagged_loop_variant_negative
		local
			a: INTEGER
		do
			from
			until
				a > 10
			loop
				a := a + 1
			variant
				tag1: a - 1
			end
		end

	loop_variant_not_reduced
		local
			a: INTEGER
		do
			from
			until
				a > 10
			loop
			variant
				10 - a
			end
		end

	tagged_loop_variant_not_reduced
		local
			a: INTEGER
		do
			from
			until
				a > 10
			loop
			variant
				tag1: 10 - a
			end
		end

feature -- Void-call

	void_call_on_local: ANY
		local
			x: ANY
		do
			x.do_nothing
		end

	void_call_in_check: ANY
		local
			x: B_MESSAGES
		do
			check x.any_attribute = Void or True end
		end

	void_call_in_pre_helper (a: B_MESSAGES)
		note
			status: skip
		require
			a.any_attribute = Void
		do
		end

	void_call_in_pre: ANY
		do
			void_call_in_pre_helper (Void)
		end

	void_call_in_loop_inv
		do
			-- TODO
		end

	void_call_in_loop_var
		do
			-- TODO
		end

	any_attribute: ANY

	void_call_on_attribute: ANY
		do
			any_attribute.do_nothing
		end

	void_call_on_function
		do
			void_call_on_local.do_nothing
		end

feature {NONE} -- Overflow

	overflow_in_body (a, b: INTEGER): INTEGER
		do
			Result := a + b
		end

	overflow_in_check (a, b: INTEGER): INTEGER
		require
			a > 0 and b > 0
		do
			check a + b > 0 end
		end

	overflow_in_post (a, b: INTEGER): INTEGER
		require
			a > 0 and b > 0
		do
		ensure
			a + b > 0
		end

	overflow_in_pre_helper (a, b, c, d: INTEGER)
		note
			status: skip
		require
			tag1: a + b > 0
			c + d > 0
		do
		end

	overflow_in_pre (a, b: INTEGER)
		require
			a > 0 and b > 0
		do
			overflow_in_pre_helper (1, 1, a, b)
		end

	overflow_in_pre_tagged (a, b: INTEGER)
		require
			a > 0 and b > 0
		do
			overflow_in_pre_helper (a, b, 1, 1)
		end

feature -- Ownership

	ownership_assignment_current_not_open
		note
			explicit: "all"
		require
			observers = []
			modify (Current)
		do
			any_attribute := Void
		end

	ownership_assignment_heap_not_writable
		note
			explicit: "all"
		require
			observers = []
			is_open
			modify ([])
		do
			any_attribute := Void
		end

	ownership_assignment_observers_open_or_preserved
		note
			explicit: "all"
		require
			is_open
			modify (Current)
		do
			any_attribute := Void
		end

	ownership_default_wrap_fails
		do
			wrap
		end

	ownership_default_is_wrapped_violated
		note
			explicit: wrapping
		do
			unwrap
		end

feature -- Frame violation
feature -- Class invariant

feature -- Validity errors

	not_functional1
		note
			status: functional
		do
		end

	not_functional2: INTEGER
		note
			status: functional
		local
			a: INTEGER
		do
			a := 1
			Result := a
		end

	call_not_functional
		local
			a: INTEGER
		do
			not_functional1
			a := not_functional2
		end

	partial_invariant_invalid
		require
			inv_only ("abc")
			inv_without ("abc")
		do
		end

	modify_field_invalid
		require
			modify_field (1, Current)
			modify_field (["abc", 1], Current)
		do
		end

end
