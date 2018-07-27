
class TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
	local
		w: WORKER [TASK]
		t1, t2: TASK
	do
		create w
		t1 := w.new_task
		t2 := w.new_task
		check
			same_value: t1 = t2
		end
	end
end
