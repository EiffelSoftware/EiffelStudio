indexing

	description: "General bulletin implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	BULLETIN_I 

inherit

	MANAGER_I

feature -- Status setting
	
	set_default_position (flag: BOOLEAN) is
			-- Set default position.
		deferred
		end;

	allow_recompute_size is
			-- Allow Current bulletin to recompute its size
			-- according to its children.
		deferred
		end;

	forbid_recompute_size is
			-- Forbid Current bulletin to recompute its size
			-- according to its children.
		deferred
		end;

	circulate_up is
			-- Circulate the children of the bulletin up
		deferred
		end;

	circulate_down is
			--circulate the children of the bulletin down
		deferred
		end;

	restack_children (a_stackable_array: ARRAY [STACKABLE]) is
			-- Stack the children of the bulletin in the 
			-- order that they are in the array.
			-- Each item in the argument array must have the same
			--parent
		deferred
		end;

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




end -- class BULLETIN_I

