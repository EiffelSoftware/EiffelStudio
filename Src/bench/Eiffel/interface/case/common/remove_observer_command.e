indexing
	description: "Command that removes an Observer"
	author: "Kolli Reda"
	date: "$Date$"
	revision: "$Revision$"

class
	REMOVE_OBSERVER_COMMAND

inherit
	EV_COMMAND

	ONCES

creation
	make

feature -- Initialization

	make (o: like observers) is
			-- Initialize
		do
			observers := o
		end

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		require else
			observers_exist: observers /= Void 
		do
			if observers /= Void then
				from
					observers.start
				until 
					observers.after
				loop
					observer_management.clear_observer (observers.item)
				
					observers.forth
				end
			end
		end

feature -- Properties

	observers: LINKED_LIST [GRAPHICAL_COMPONENT [ANY]]

end -- class REMOVE_OBSERVER_COMMAND
