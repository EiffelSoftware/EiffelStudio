note
	description: "Example application that shows how to use a worker pool for database logging."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_LOGGER_APPLICATION

create
	make

feature -- Constants

	Initial_worker_count: INTEGER = 2
			-- The initial number of workers in the pool.

	Buffer_size: INTEGER = 100
			-- The size of the work item queue.

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		local
			l_factory: separate DATABASE_LOGGER_FACTORY
		do
			print ("Starting database logger example...%N")

				-- To properly initialize the worker pool, a factory for worker objects is needed.
			create l_factory.make ("root", "1234", "localhost", "log_db", 4406)

				-- Now we can initialize the separate worker pool.
			create logger_pool.make_with_factory (Buffer_size, Initial_worker_count, l_factory)

				-- It is a lot more convenient to use a processor-local proxy.
			create logger_pool_proxy.make (logger_pool)

				-- Add some work items to the pool
			logger_pool_proxy.put ("INSERT INTO log VALUES ('OK', 'Served client: johndoe')")
			logger_pool_proxy.put ("INSERT INTO log VALUES ('OK', 'Served client: johndoe')")
			logger_pool_proxy.put ("INSERT INTO log VALUES ('OK', 'Served client: johndoe')")
			logger_pool_proxy.put ("INSERT INTO log VALUES ('OK', 'Served client: johndoe')")
			logger_pool_proxy.put ("INSERT INTO log VALUES ('Error', 'Too many requests: johndoe')")

				-- It is possible to increase the number of worker processors on the fly.
			print ("Adding two new workers to the pool:%N")
			logger_pool_proxy.set_worker_count (4)

			check logger_pool_proxy.actual_worker_count = 4 end

				-- Scaling down is also possible.
			print ("Tearing down three workers:%N")
			logger_pool_proxy.set_worker_count (1)

				-- However, it takes some time for these workers to shut down.
			(create {EXECUTION_ENVIRONMENT}).sleep (1_000_000_000)
			check logger_pool_proxy.actual_worker_count = 1 end

				-- It is necessary to stop the worker pool at the end, otherwise the application can't terminate.
			print ("Stopping worker pool:%N")
			logger_pool_proxy.stop
		end

feature {NONE} -- Implementation

	logger_pool: separate CP_WORKER_POOL [STRING, CP_STRING_IMPORTER]
			-- The separate database logger pool.

	logger_pool_proxy: CP_WORKER_POOL_PROXY [STRING]
			-- Processor-local access to the `logger_pool'.

end
