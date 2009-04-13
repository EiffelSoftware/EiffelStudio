class TEST
inherit
	THREAD_CONTROL
	MEMORY
creation
	make

feature

	make (args: ARRAY [STRING]) is
		local
			k, count: INTEGER
			worker: WORKER
		do
			from
$COMMENT		k := 1;
				count := args.item (1).to_integer
			until
				k > count
			loop
				create worker
				worker.launch
				k := k + 1;
			end
			join_all
		end;

end

