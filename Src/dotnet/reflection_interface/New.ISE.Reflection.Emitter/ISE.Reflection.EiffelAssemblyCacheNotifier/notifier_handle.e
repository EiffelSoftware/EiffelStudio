indexing
	description: "Reflection notifier"

class
	NOTIFIER_HANDLE

create 
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Creation routine"
		do
		end
		
feature -- Access

	current_notifier: NOTIFIER is
		indexing
			description: "Current notifier"
		once
			create Result.make
		end

end -- class NOTIFIER_HANDLE