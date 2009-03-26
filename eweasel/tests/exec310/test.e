
class TEST
inherit
	THREAD_CONTROL
create
	make

feature

	make (args: ARRAY [STRING]) is
		local
			k, count, iterations: INTEGER
			worker: WORKER
		do
			from
				k := 1
				count := args.item (1).to_integer
				iterations := args.item (2).to_integer
			until
				k > count
			loop
				create worker.make (iterations)
				worker.launch
				k := k + 1
			end
			join_all
		end

end
