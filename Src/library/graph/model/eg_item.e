indexing
	description: "The model for a graph item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EG_ITEM
	
inherit
	HASHABLE
		rename
			hash_code as id
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create an EG_ITEM.
		do
			create name_change_actions
			name_change_actions.compare_objects
		end

feature -- Access

	graph: EG_GRAPH
			-- The graph model `Current' is part of (if not Void).
			
	id: INTEGER is
			-- Unique id.
		do
			if internal_hash_id = 0  then
				counter.set_item (counter.item + 1)
				internal_hash_id := counter.item
			end
			Result := internal_hash_id
		end
		
	name: STRING
			-- Name of `Current'.
			
	set_name (a_name: STRING) is
			-- Set `name' to `a_name'.
		do
			if a_name /= name then
				name := a_name
				name_change_actions.call (Void)
			end
		ensure
			set: name = a_name
		end
		
	name_change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Called when `name' was changed.
		
feature {EG_GRAPH} -- Element change.

	set_graph (a_graph: like graph) is
			-- Set `graph' to `a_graph'.
--		require
--			a_graph_not_void: a_graph /= Void
--			graph_void: graph = Void
		do
			graph := a_graph
		ensure
			set: graph = a_graph
		end

feature {NONE} -- Implementation

	internal_hash_id: like id
			-- internal id for the hash code.
			
	counter: INTEGER_REF is
			-- Id counter.
		once
			create Result
		end
		
invariant
	name_change_actions_not_void: name_change_actions /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EG_ITEM

