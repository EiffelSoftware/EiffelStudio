class
	CHAIN_IMP [G]

inherit
	CHAIN [G]
		undefine
			is_equal,
			copy,
			is_inserted,
			prune,
			prune_all,
			readable,
			first,
			last,
			new_cursor,
			start,
			finish,
			go_i_th,
			isfirst,
			islast,
			off,
			remove
		end

	LINKED_LIST [G]
		undefine
			move
		end

create
	make

end
