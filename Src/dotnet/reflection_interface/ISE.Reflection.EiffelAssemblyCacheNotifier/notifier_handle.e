indexing
	description: "Reflection notifier"
	external_name: "ISE.Reflection.NotifierHandle"

class
	NOTIFIER_HANDLE

create 
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Creation routine"
			external_name: "Make"
		do
		end
		
feature -- Access

	current_notifier: NOTIFIER is
		indexing
			description: "Current notifier"
			external_name: "CurrentNotifier"
		once
			create Result.make
		end

end -- class NOTIFIER_HANDLE