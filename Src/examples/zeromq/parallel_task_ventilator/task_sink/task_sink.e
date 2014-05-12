note
	description : "[
				 Task sink
				 Binds PULL socket to tcp://localhost:5558
				 Collects results from workers via that socket
				 ]"
	date        : "$Date$"
	revision    : "$Revision$"
	EIS: "name=Task sink", "src=https://github.com/imatix/zguide/blob/master/examples/C/tasksink.c", "protocol=uri"

class
	TASK_SINK

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		local
			l_context: ZMQ_CONTEXT
			l_receiver: ZMQ_SOCKET
			l_start_time, l_finish_time: TIME
			l_task_number: INTEGER
		do
				-- Initialize 0MQ context and socket receiver
			create l_context.make
			l_receiver := l_context.new_pull_socket
			l_receiver.bind ("tcp://127.0.0.1:5558")

				-- Wait for start of batch
			l_receiver.read_string

				-- Start out clock now
			create l_start_time.make_now

				-- Process 100 confirmations
			from
				l_task_number := 1
			until
				l_task_number > 100
			loop
				l_receiver.read_string
				if (l_task_number / 10 ) * 10 = l_task_number then
					print (":")
				else
					print (".")
				end
				l_task_number := l_task_number + 1
				io.output.flush
			end
				-- Calculate and report duration of batch
			create l_finish_time.make_now
			print ("Total elapsed time:"+(l_finish_time - l_start_time).duration.out + "msec%N")
			l_receiver.close

		end

end
