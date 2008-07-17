class
	TEST

create
	make

feature -- Initialization

	make is
			-- Run application.
		local
			l_string: STRING
			l_spec: SPECIAL [STRING]
			l_list: ARRAYED_LIST [SPECIAL [STRING]]
			l_mem: MEMORY
			i, j: INTEGER
		do
			create l_mem
			l_mem.collection_off
			create l_list.make (10000)
			from
				j := 1
			until
				i > 10000
			loop
				create l_string.make (10)
				l_string.append_integer (j)
				create l_spec.make (10)
				l_spec.put (l_string, 2)
				l_list.extend (l_spec)
				if i /= 0 or else is_done (l_spec) then
						-- Now objects are created outside the scavenge zone,
						-- we need to iterate about 10000 times to exhaust our `moved_set'
						-- stack to exibit the problem when resizing.
					i := i + 1
				end
				j := j + 1
			end
			l_spec := l_list.i_th ((100).min (l_list.count)).aliased_resized_area  (30)
			l_mem.collection_on
			l_mem.full_collect
			io.put_string (l_spec.item (2))
			io.put_new_line
		end


	is_done (obj: ANY): BOOLEAN is
		require
			obj_not_void: obj /= Void
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"[
#ifdef EIF_IL_DLL
	return EIF_TRUE
#else
		/* Because we do not have access to `struct sc_zone' I fake it by assuming
		   it is an array of 5 pointers (which corresponds to the fields of `sc_zone'.
		 */
	extern char* sc_from[5];

	if
		((eif_access($obj) > sc_from [3]) ||
		(eif_access($obj) < sc_from [0]))
	{
		return EIF_TRUE;
	} else {
		return EIF_FALSE;
	}
#endif
			]"
		end
end
