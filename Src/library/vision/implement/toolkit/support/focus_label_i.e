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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

