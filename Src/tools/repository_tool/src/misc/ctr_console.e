note
	description: "Summary description for {CTR_CONSOLE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_CONSOLE

create
	make

feature {NONE} -- Initialization

	make
		do
			create observers.make (3)
			create mutex.make
		end

feature -- Access

	mutex: MUTEX

	log_custom (m: STRING_GENERAL; t: INTEGER)
		do
			mutex.lock
			observers.do_all (agent {CTR_CONSOLE_OBSERVER}.log_custom (m, t))
			mutex.unlock
		end

	log (m: STRING_GENERAL)
		do
			mutex.lock
			observers.do_all (agent {CTR_CONSOLE_OBSERVER}.log (m))
			mutex.unlock
		end

	log_warning (m: STRING_GENERAL)
		do
			mutex.lock
			observers.do_all (agent {CTR_CONSOLE_OBSERVER}.log_warning (m))
			mutex.unlock
		end

	log_error (m: STRING_GENERAL)
		do
			mutex.lock
			observers.do_all (agent {CTR_CONSOLE_OBSERVER}.log_error (m))
			mutex.unlock
		end

	register_observer (o: CTR_CONSOLE_OBSERVER)
		do
			observers.extend (o)
		end

feature -- Observer

	observers: ARRAYED_LIST [CTR_CONSOLE_OBSERVER]

feature -- Constant

	log_normal_type: INTEGER = 0

	log_warning_type: INTEGER = 1

	log_error_type: INTEGER = 2

end
