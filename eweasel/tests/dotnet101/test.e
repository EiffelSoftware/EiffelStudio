class
	TEST

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize test
		do
			types.do_all (agent (a_item: TUPLE [obj: ANY; sealed: BOOLEAN])
				local
					so: SYSTEM_OBJECT
				do
					so ?= a_item.obj
					print (a_item.sealed = so.get_type.is_sealed)
					print ("%N")
				end)
		end

	types: ARRAYED_LIST [TUPLE [ANY, BOOLEAN]]
		do
			create Result.make (9)
			Result.extend ([create {A}, False])
			Result.extend ([create {B}, True])
			Result.extend ([create {C}, True])
			Result.extend ([create {D}, True])
			Result.extend ([create {E}, False])
			Result.extend ([create {F}, True])
			Result.extend ([create {G}, True])
			Result.extend ([create {H}, False])
			Result.extend ([create {I}, False])
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

end