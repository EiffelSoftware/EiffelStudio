indexing
	description: "A list of observers is associated to a data."
	author: "Kolli Reda & Pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	DATA_OBSERVER

creation
	make

feature -- Initialization

	make (d: like data) is
			-- Initialize
		require
			data_exists: d /= Void
		do
			data := d
			!! observer_list.make
		end

feature -- Properties

	data: ANY
		-- Data observed by Current.

	observer_list: LINKED_LIST [OBSERVER]
		-- List of objects which observes the data 'data'.

feature -- Managment

	add_observer (w: OBSERVER) is
			-- Add an observer to the list.
		require
			observer_exists: w /= Void
		do
			observer_list.extend (w)
		end

	remove_observer (w: OBSERVER) is
			-- remove observer 'w' from the list.
			-- Do nothing if it does not belong to the list.
		require
			observer_exists: w /= Void
		local
			removed: BOOLEAN
		do
			from 
				observer_list.start
				removed := false
			until 
				observer_list.after or removed
			loop
				if observer_list.item=w then
						observer_list.remove
						removed := true
				end		
				if not removed then
					observer_list.forth
				end
			end
		end

	update is
			-- Update every oberver of data 'data'.
		local
			window: OBSERVER
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				window := observer_list.item
				check
					every_item_not_void: window /= Void
					-- No item of the observer list should be void.
				end
				window.update
				observer_list.forth
			end
		end

invariant

	DATA_OBSERVER_observer_list_exists: observer_list /= Void
	DATA_OBSERVER_data_exists: data /= Void

end -- class DATA_OBSERVER
