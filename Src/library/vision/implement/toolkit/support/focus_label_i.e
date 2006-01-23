indexing

	description: "Abstract notion of a focus label."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class FOCUS_LABEL_I

feature -- Initialization

	initialize (a_parent: COMPOSITE) is
			-- Initialization
		deferred
		end;
 
	initialize_widget (a_focusable: FOCUSABLE) is
			-- Platform specific initialization of the focusable widget
		require
			non_void_focusable: a_focusable /= Void
		deferred
		end;

	initialize_focusables (initializer: TOOLTIP_INITIALIZER) is
			-- Initialize the focusables.
			-- Should be called after all focusables for the tooltip_initializer 
			-- were created and tooltip_initializer itself was realized
			
		require
			initializer_not_void: initializer /= Void
		deferred
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




end -- class FOCUS_LABEL_I

