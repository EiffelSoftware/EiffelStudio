indexing
	description: 
		"Abstract class for container that hold tree nodes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "container"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_TREE_NODE_CONTAINER

obsolete
	"This is no longer applicable. Use EV_TREE_ITEM_LIST instead."

inherit
	EV_ANY

	LINEAR [EV_TREE_NODE]
		undefine
			default_create, copy
		end

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




end -- class EV_TREE_NODE_CONTAINER

