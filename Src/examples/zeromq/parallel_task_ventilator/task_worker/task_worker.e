note
	description : "[
				 Task worker
				 Connects PULL socket to tcp://localhost:5557
				 Collects workloads from ventilator via that socket
				 Connects PUSH socket to tcp://localhost:5558
				 Sends results to sink via that socket
				]"
	date        : "$Date$"
	revision    : "$Revision$"
	EIS: "name=Task worker", "src=https://github.com/imatix/zguide/blob/master/examples/C/taskwork.c","protocol=uri"
class
	TASK_WORKER

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		local
			l_context: ZMQ_CONTEXT
			l_receiver: ZMQ_SOCKET
			l_sender: ZMQ_SOCKET
			l_env: EXECUTION_ENVIRONMENT
		do
				-- Initialize 0MQ context
			create l_context.make

				-- Socket to receive messages on
			l_receiver := l_context.new_pull_socket
			l_receiver.connect ("tcp://127.0.0.1:5557")

				-- Socket to send messages to
			l_sender := l_context.new_push_socket
			l_sender.connect ("tcp://127.0.0.1:5558")

			create l_env

				--Process tasks forever
			from
			until
				False
			loop
				l_receiver.read_string
					-- Simple progress indicator for the viewer
				io.output.flush
				print (l_receiver.last_string + ".%N")

					-- Do the work
				l_env.sleep (l_receiver.last_string.to_integer)

					-- Send result to sink
				l_sender.put_string ("")
			end
			l_receiver.close
			l_sender.close
		end

end
