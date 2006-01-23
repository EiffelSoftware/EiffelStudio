indexing
	description: "This class represents a MS_IMPmanager"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class MANAGER_IMP

inherit

	COMPOSITE_IMP
		redefine
			realize
		end

	MANAGER_I

	COLORED_FOREGROUND_WINDOWS
	
feature --Status setting
	
	realize is
		do
			Precursor {COMPOSITE_IMP}
				-- set initial focus
			if initial_focus /= Void then
				initial_focus.wel_set_focus
			end
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




end -- class MANAGER_IMP

