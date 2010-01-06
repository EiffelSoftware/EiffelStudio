
class TEST
inherit
	THREAD_CONTROL
create
	make

feature

	make (args: ARRAY [STRING]) is
		local
			k, count, iterations, length: INTEGER
			worker: WORKER
		do
			from
				k := 1
				count := args.item (1).to_integer
				iterations := args.item (2).to_integer
				length := args.item (3).to_integer
			until
				k > count
			loop
				create worker.make (iterations, length, '0' + k, "input" + k.out, "output" + k.out)
				worker.launch
				k := k + 1
			end
			join_all
		end

end
