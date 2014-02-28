class TEST1 [G -> STRING]

create
	make

feature

	make
		local
			s: G
		do
			create tasks
			s := tasks.i_th (1).task
		end

	tasks: TEST2 [like new_task_data]

	new_task_data (a_task: G): TUPLE [task: G]
		do
			check False then end
		end

end
