class
	TEST

inherit
	ARGUMENTS

	THREAD_CONTROL

create
	make

feature

	make is
		local
			d: WORKER_THREAD
			i, j: INTEGER
			c: CHARACTER
		do
			if argument_count > 1 and then argument (1).is_integer then
				i := argument (1).to_integer
			else
				i := 50000
			end
			create queue.make

				-- Creating protected objects in a different thread.
			create d.make (agent protect_objects (i))
			d.launch
			d.join
				-- Free all of them in main thread. This used to be a source of
				-- corruption, because now the current thread refers to memory which
				-- has been freed when the thread died.
			execute_free

				-- Allocating again objects, but this time in current thread. This is
				-- the place where things start to misbehave.
			protect_objects (i)

				-- And then we trye to wean them in many threads.
			from
				j := 1
				c := '1'
			until
				j > 10
			loop
				create d.make (agent execute_free)
				d.launch
				c := c + 1
				j := j + 1
			end
			join_all

				-- Now we protect and weans randomly.
			from
				j := 1
				c := '1'
			until
				j > 10
			loop
				create d.make (agent execute (i, c))
				d.launch
				c := c + 1
				j := j + 1
			end
			join_all

				-- Freezing object objects in a different thread.
			create d.make (agent freeze_objects (i))
			d.launch
			d.join

			execute_unfreeze

			freeze_objects (i)

				-- And unfreeze randomly.
			from
				j := 1
				c := '1'
			until
				j > 10
			loop
				create d.make (agent execute_unfreeze)
				d.launch
				c := c + 1
				j := j + 1
			end
			join_all
		end

	queue: OBJECT_QUEUE

	protect_objects (n: INTEGER) is
			-- Protect a lot of objects
		local
			s: STRING
			i: INTEGER
		do
			from
				i := 1
			until
				i >= n
			loop
				create s.make (10)
				s.append_integer (i)
				queue.push_protected (eif_adopt (s))
				i := i + 1
			end
		end

	freeze_objects (n: INTEGER) is
			-- Protect a lot of objects
		local
			s: STRING
			i: INTEGER
			a: ANY
			l_storage: SPECIAL [STRING]
		do
			from
				i := 1
				create l_storage.make (n + 1)
			until
				i > n
			loop
				create s.make (10)
				s.append_integer (i)
				l_storage.put (s, i)
				i := i + 1
			end
			from
				i := 1
			until
				i >= n
			loop
				a := eif_freeze (l_storage.item (i))
					-- It is part of the implementation of `eif_freeze' that it may not work.
				if a /= Void then
					queue.push_frozen (a)
				end
				i := i + 1
			end
		end

	execute_free is
			-- Pop all elements of `queue' and free them
		local
			s: STRING
			p, l_null: POINTER
			a: ANY
		do
			from
				p := queue.pop_protected
			until
				p = l_null
			loop
				a := eif_wean (p)
				s ?= a
				if s = Void then
					io.put_string ("ERROR%N")
				end
				p := queue.pop_protected
			end
		end

	execute_unfreeze is
			-- Unfreeze until no more.
		local
			a: ANY
		do
			from
				a := queue.pop_frozen
			until
				a = Void
			loop
				eif_unfreeze ($a)
				a := queue.pop_frozen
			end
		end

	execute (n: INTEGER; identifier: CHARACTER) is
			-- Repeat `n'-th times
		local
			s: STRING
			i: INTEGER
			p: POINTER
		do
			from
				i := 1
			until
				i >= n
			loop
				create s.make (10)
				s.append_character (identifier)
				queue.push_protected (eif_adopt (s))
					-- Render control to another thread so that the likelyhood to
					-- pop an element pushed by another thread.
				yield
				p := queue.pop_protected
				if p /= default_pointer then
					s ?= eif_wean (p)
					if s = Void or else s.count /= 1 or else not s.generating_type.is_equal ("STRING_8") then
						io.put_string ("ERROR%N")
					end
				end
				i := i + 1
			end
		end

feature {NONE} -- C externals

	eif_freeze (a: ANY): ANY is
			-- Wrapper for `eif_freeze'.
			-- We currently not use `inline' because inlining does not do the automatic protection
			-- this is another bug and it will have its own eweasel test.
		external
			"C use %"eif_hector.h%""
		alias
			"eif_freeze"
		end

	eif_unfreeze (p: POINTER) is
			-- Wrapper for `eif_unfreeze'.
		external
			"C inline use %"eif_hector.h%""
		alias
			"eif_unfreeze ($p);"
		end


	eif_adopt (a: ANY): POINTER is
			-- Wrapper for `eif_adopt'.
			-- We currently not use `inline' because inlining does not do the automatic protection
			-- this is another bug and it will have its own eweasel test.
		external
			"C use %"eif_hector.h%""
		alias
			"eif_adopt"
		end

	eif_wean (p: POINTER): ANY is
			-- Wrapper for `eif_wean'.
		external
			"C inline use %"eif_hector.h%""
		alias
			"return eif_wean ($p);"
		end


	allocate_memory is
			--
		local
			s: STRING
		do
			create s.make (10000)
			s.fill_character ('9')
		end

end
