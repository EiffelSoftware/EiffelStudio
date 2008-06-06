
class TEST
inherit
	THREAD_CONTROL
	MEMORY
	EXCEPTIONS

create
	make

feature
        make (args: ARRAY [STRING]) is
		local
			k, count: INTEGER
			initial_used, curr_used, diff: INTEGER
		do
			count := args.item (1).to_integer
			info := memory_statistics (Total_memory)
			info.update (Total_memory)
			initial_used := info.used
			from
				k := 1
			until
				k > count
			loop
				join
				info.update (Total_memory)
				curr_used := info.used
				diff := curr_used - initial_used
				if diff >= 100_000 then
					print ("Memory leak - used memory increased by " + diff.out + " bytes after " + k.out + " iterations%N")
					k := count + 1
				end
				k := k + 1
			end
                end

	info: MEM_INFO

end
