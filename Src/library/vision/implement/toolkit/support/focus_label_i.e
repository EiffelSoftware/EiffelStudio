indexing

	description: "Abstract notion of a focus label."
	status: "See notice at end of class";
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

end -- class FOCUS_LABEL_I


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

