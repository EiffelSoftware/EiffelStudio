indexing
	description: "Observed (Subject on Observer pattern, (Design Patterns, 293, Gamma et.al))"
	date: "$Date$"
	revision: "$Revision$"

class
	OBSERVED

feature -- Access

	observers: ARRAYED_LIST [OBSERVER]
			-- Observers of Current

feature -- Commands

	attach (o: OBSERVER) is
			-- Attach observer `o'
		require
			observer_not_void: o /= Void
		do
			if not has (o) then
				observers.extend (o)
			end			
		end
		
	detach 	(o: OBSERVER) is
			-- Detach observer `o'
		require
			has_observer: has (o)
		do
			observers.prune (o)
		end
		
feature -- Query

	has (o: OBSERVER): BOOLEAN is
			-- Is `o' an observer?
		require
			observer_not_void: o /= Void
		do
			Result := observers.has (o)
		end		

feature {NONE} -- Implementation

	notify_observers is
			-- Notify observers of change
		do
			from
				observers.start
			until
				observers.after
			loop
				if observers.item.should_update then
					observers.item.update	
				end
				observers.forth
			end
		end

end -- class OBSERVED
