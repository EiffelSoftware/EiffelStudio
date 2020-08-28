class TEST
create
	make

feature

	make
		local
			list: ARRAYED_LIST [detachable STRING]
			a: ARRAY [detachable STRING]
		do
			create list.make_from_array (<<"hello", "world", Void, Void>>)
				-- Pruning Void elements is equivalent to reducing the count of the list by 2.
			list.prune_all (Void)
			check
				valid_count: list.count = 2
			end

			a := list.to_array

			a.do_all(agent detect_void (?, 1))
			a.do_if(agent detect_void (?, 1), agent is_void_string (? , 1))
			if a.there_exists (agent is_void_string (? , 1)) then
				print ("Void string!")
			end
			if not a.for_all (agent is_not_void_string (?, 1)) then
				print ("Void string!")
			end
			a.do_all_with_index (agent detect_void)
			a.do_if_with_index (agent detect_void, agent is_void_string)
		end

	is_void_string (s: STRING; i: INTEGER): BOOLEAN
		do
			Result := s = Void
		end

	is_not_void_string (s: STRING; i: INTEGER): BOOLEAN
		do
			Result := s /= Void
		end

	detect_void (s: STRING; i: INTEGER)
		do
			if s = Void then
				print ("Void string!")
			end
		end

end
