indexing
	description: "MATISSE-Eiffel Binding"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MT_CONTAINER_OBJECT

inherit
	MT_STORABLE
		export 
			{NONE} all
		undefine
			is_equal,
			copy,
			is_persistent,
			check_persistence
		end

feature

	store_updates is
		deferred
		end
				
end -- class MT_CONTAINER_OBJECT
