indexing
	description: "A list of observers is associated to data"
	author: "Kolli Reda"
	date: "$Date$"
	revision: "$Revision$"

class
	DATA_OBSERVER

creation
	make

feature -- Initialization

	make (d: like data) is
			-- Initialize
		do
			data := d
			!! observer_list.make
		end

feature -- Properties

	data: ANY

	observer_list: LINKED_LIST [OBSERVER]

feature -- Managment

	add_observer (w: OBSERVER) is
		do
			if observer_list = Void 
			then
				!! observer_list.make
			end

			observer_list.extend (w)
		end

	remove_observer (w: OBSERVER) is
		local
			removed: BOOLEAN
		do
			if observer_list /= Void 
			then
				from 
					observer_list.start
					removed := false
				until 
					observer_list.after or removed
				loop
					if observer_list.item = w
					then
						observer_list.remove
						removed := true
					end		

					if not removed 
					then
						observer_list.forth
					end
				end
			end
		end

	update is
		local
			window: OBSERVER
		do
			if observer_list /= Void
			then
				from
					observer_list.start
				until
					observer_list.after
				loop
					window := observer_list.item

					if window /= Void 
					then
						window.update
					end
					
					observer_list.forth
				end
			end
		end

end -- class DATA_OBSERVER
