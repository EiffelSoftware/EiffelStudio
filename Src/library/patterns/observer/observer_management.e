indexing
	description: "Class responsible for managing the observers"
	author: "Kolli Reda"
	date: "$Date$"
	revision: "$Revision$"

class
	OBSERVER_MANAGEMENT

creation
	make

feature -- Initialization
	
	make is
		-- Initialize.
		do
			!! data_observer_list.make
		end

feature -- Operations

	add_observer (d: ANY; w: OBSERVER) is
			-- Add an observer w to the list of d.
		require
			data_exists: d /= Void
			observer_exists: w /= Void
		local
			data_observer: DATA_OBSERVER
		do
			data_observer := get_data_observer (d)	
			if data_observer /= Void then
				data_observer.add_observer (w)
			else
				!! data_observer.make (d)
				data_observer.add_observer (w)
				data_observer_list.extend (data_observer)
			end
		end

	remove_observer (d: ANY; w: OBSERVER) is
		-- Remove the observer 'd' from the list of observed data.
		require
			data_exists: d /= Void
			observer_exists: w /= Void
		local
			found: BOOLEAN
			data_observer: DATA_OBSERVER
		do
			from 
				data_observer_list.start
				found := false
			until
				data_observer_list.after or found
			loop
				data_observer := data_observer_list.item
				check
					every_item_not_void: data_observer /= Void
					-- No item of the data observer list should be void.
				end
				if data_observer.data = d then
					found := true
					data_observer.remove_observer (w)
				end 
				data_observer_list.forth
			end
		end

	clear_observer (o: OBSERVER) is
		-- Remove the observer o from the list of all the subjects. 
		require
			observer_exists: o /= Void
		local
			found: BOOLEAN
			data_observer: DATA_OBSERVER
		do
			from 
				data_observer_list.start
			until
				data_observer_list.after or found
			loop
				data_observer := data_observer_list.item
				check
					every_item_not_void: data_observer /= Void
					-- No item of the data observer list should be void.
				end
				data_observer.remove_observer (o)
				data_observer_list.forth
			end
		end


	update_observer (d: ANY) is
			-- Update the observer of data 'd'
		require
			data_exists: d /= Void
		local
			data_observer: DATA_OBSERVER
		do
			data_observer := get_data_observer (d)
			if data_observer /= Void then
				-- The data is observed.
				data_observer.update
			end
		end

feature -- Access

	get_data_observer (d: ANY) : DATA_OBSERVER is
			-- Return the observer of the data 'd', if any.
			-- If none, return Void
		require
			data_exists: d /= Void
		local
			found: BOOLEAN
			data_observer: DATA_OBSERVER
		do
			from 
				data_observer_list.start
				found := false
			until
				data_observer_list.after or found
			loop
				data_observer := data_observer_list.item
				if data_observer /= Void 
				then
					if data_observer.data = d
					then
						found := true
						Result := data_observer	
					end 
				end
				data_observer_list.forth
			end
			if not found
			then
				Result := Void
			end
		end

feature {NONE} -- Implementation

	data_observer_list: LINKED_LIST [DATA_OBSERVER]
		-- List of data observers.

invariant
	OBSERVER_MANAGEMENT_data_observer_list_exists: data_observer_list /= Void

end -- class OBSERVER_MANAGMENT


--|----------------------------------------------------------------
--| EiffelPatterns: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

