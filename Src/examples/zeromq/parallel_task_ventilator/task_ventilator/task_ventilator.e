note
	description : "[
					Task ventilator
					Binds PUSH socket to tcp://localhost:5557
					Sends batch of tasks to workers via that socket
					]"
	date        : "$Date$"
	revision    : "$Revision$"
	EIS: "name=Task ventilator", "src=https://github.com/imatix/zguide/blob/master/examples/C/taskvent.c", "protocol=uri"
class
	TASK_VENTILATOR

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		local
			l_context: ZMQ_CONTEXT
			l_sender, l_sink: ZMQ_SOCKET
			l_task_number: INTEGER
			l_total_msec: INTEGER
			l_workload: INTEGER
			l_environment: EXECUTION_ENVIRONMENT
		do
				-- Initialize 0MQ context
			create l_context.make
				-- Socket to send messages
			l_sender := l_context.new_push_socket
			l_sender.bind ("tcp://127.0.0.1:5557")

				--Socket to send start of batch message on
			l_sink := l_context.new_push_socket
			l_sink.connect ("tcp://127.0.0.1:5558")

			print ("Press Enter when the workers are ready: %N");
			io.read_line

			print ("Sending tasks to workers...%N")

				--The first message is "0" and signals start of batch
			l_sink.put_string ("0")

				-- Initialize Random number generator
			create random_sequence.set_seed (10000)

				-- Send 100 tasks
			from
				l_task_number := 1
			until
				l_task_number > 100
			loop
                l_workload := new_random \\ 100 + 1
                	-- Random workload from 1 to 100 msec
				l_total_msec := l_total_msec + l_workload
				l_sender.put_string (l_workload.out)
				l_task_number := l_task_number + 1
			end

			print ("Total expected cost:" + l_total_msec.out + " msec%N")
			create l_environment
			l_environment.sleep (10000)
				-- Give 0MQ time to deliver
			l_sink.close
			l_sender.close
		end

feature {NONE} -- RANDOM

	new_random: INTEGER
			-- Random integer
			-- Each call returns another random number.
		do
			random_sequence.forth
			Result := random_sequence.item
		end

	random_sequence: RANDOM
end
