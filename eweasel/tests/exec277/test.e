class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
			display_lst (new_lst)
			display_ht (new_ht)
			io.put_new_line
		end

feature {NONE} -- Test

	new_lst: LINKED_LIST [INTEGER] is
		do
			create Result.make
			Result.extend (1)
			Result.extend (3)
			Result.extend (9)
		end

	display_lst (obj: ANY) is
		local
			lst: LIST [ANY]
		do
			lst ?= obj
			if lst /= Void then
				from
					lst.start
				until
					lst.after
				loop
					print (lst.item.out)
					lst.forth
				end
			end
		end

	new_ht: HASH_TABLE [STRING, INTEGER] is
		do
			create Result.make (3)
			Result.put ("a", 3)
			Result.put ("b", 2)
			Result.put ("c", 1)
		end

	display_ht (obj: ANY) is
		local
			dic: HASH_TABLE [ANY, HASHABLE]
			k: HASHABLE
			v: ANY
			a: ARRAY [ANY]
		do
			dic ?= obj
			if dic /= Void then
				create a.make (1, 3)
				from
					dic.start
				until
					dic.after
				loop
					v := dic.item_for_iteration
					k := dic.key_for_iteration
					if k.out.is_equal ("1") then
						a [1] := v
					elseif k.out.is_equal ("2") then
						a [2] := v
					elseif k.out.is_equal ("3") then
						a [3] := v
					end
					dic.forth
				end
				print (a [1])
				print (a [2])
				print (a [3])
			end
		end

end
