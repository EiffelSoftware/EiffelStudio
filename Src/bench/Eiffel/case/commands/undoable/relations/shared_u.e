indexing

	description: 
		"Abstraction of shared and unshared action of a link.";
	date: "$Date$";
	revision: "$Revision $"

deferred class SHARED_U 

inherit

	UNDOABLE_EFC

feature -- Update

	shared is
			-- Add shared specification to 'link'
		do
			link.add_shared (reverse)
			workareas.add_shared (link, reverse)
			observer_management.update_observer(link)
		end

	unshared is
			-- Remove shared specification of 'link'
		do
			link.remove_shared (reverse)
			workareas.remove_shared (link, reverse)
			observer_management.update_observer(link)
		end

	update is
			-- Update the relation window corresponding to 'link'
		local
			relation_window : EC_RELATION_WINDOW
		do
--			relation_window := windows.relation_window (link);
--			if relation_window /= Void then
--				relation_window.update_shared (reverse)
--			end;
--			workareas.refresh;
--			System.set_is_modified
		end -- update

feature {NONE} -- Implementation

	link: CLI_SUP_DATA;
			-- Link which became shared or unshared

	reverse: BOOLEAN

end -- class SHARED_U
