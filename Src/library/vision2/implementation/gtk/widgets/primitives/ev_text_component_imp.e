indexing

	description: 
		"EiffelVision text component, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXT_COMPONENT_IMP
	
inherit
	EV_TEXT_COMPONENT_I
		redefine
			interface
		end
	
	EV_PRIMITIVE_IMP
		redefine
			interface,
			default_key_processing_blocked,
			on_focus_changed
		end

	EV_TEXT_COMPONENT_ACTION_SEQUENCES_IMP
		export
			{EV_INTERMEDIARY_ROUTINES} change_actions_internal	
		end
		
feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_change_actions is
			-- The text has been changed by the user.
		deferred
		end
		
feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make `nb' characters visible on one line.
		do
			set_minimum_width (nb * maximum_character_width + 10)
				-- 10 = size of handle
		end

	maximum_character_width: INTEGER is
			-- Maximum width of a single character in `Current'.
		do
			Result := font.string_width ("W")
		end
		
	font: EV_FONT is
			-- Current font displayed by widget. (This can be removed if text component is made fontable)
		deferred
		end
		
feature {EV_WINDOW_IMP}
		
	default_key_processing_blocked (a_key: EV_KEY): BOOLEAN is
			-- 
		do
			-- We don't want to lose focus on up or down keys.
			if a_key.code = {EV_KEY_CONSTANTS}.key_down or else a_key.code = {EV_KEY_CONSTANTS}.key_up then
				Result := True
			end
		end
		
feature {NONE} -- Implementation

	on_focus_changed (a_has_focus: BOOLEAN) is
			-- Focus for `Current' has changed'.
		do
			if a_has_focus then
				top_level_window_imp.set_focus_widget (Current)
			else
				top_level_window_imp.set_focus_widget (Void)
			end
			Precursor {EV_PRIMITIVE_IMP} (a_has_focus)
		end

feature {EV_ANY_I} -- Implementation		

	interface: EV_TEXT_COMPONENT

end -- class EV_TEXT_COMPONENT_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

