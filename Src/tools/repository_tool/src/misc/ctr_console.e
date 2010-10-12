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

	log (m: STRING_GENERAL)
		do
			mutex.lock
			observers.do_all (agent {CTR_CONSOLE_OBSERVER}.log (m))
			mutex.unlock
		end

	register_observer (o: CTR_CONSOLE_OBSERVER)
		do
			observers.extend (o)
		end

feature -- Observer

	observers: ARRAYED_LIST [CTR_CONSOLE_OBSERVER]

end
