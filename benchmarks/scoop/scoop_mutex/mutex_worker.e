class
	MUTEX_WORKER

create
	make

feature {NONE}

	make (sh: separate VAR; max: INTEGER)
		do
			shared := sh
			max_iterations := max
		end

feature

	max_iterations: INTEGER

	done: BOOLEAN

	shared: separate VAR

	live
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > max_iterations
			loop
				run (shared)
				i := i + 1
			end
			done := True
		end

	is_done: BOOLEAN
		do
			Result := done
		end

	run (a_shared: separate VAR)
		do
			a_shared.update_var
		end

end
