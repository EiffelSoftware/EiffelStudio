indexing
	description: 
		"GtkTreeIter Struct helper class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_TREE_ITER_STRUCT

inherit
	MEMORY_STRUCTURE
	
create
	make

feature -- Externals

	frozen structure_size: INTEGER is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"sizeof(GtkTreeIter)"
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




end -- EV_GTK_TREE_ITER_STRUCT

