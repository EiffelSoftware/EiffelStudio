indexing

	description: 
		"Abstract notion of a Motif callback structure. %
		%Associated C `handle' is XmAnyCallbackStruct.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_ANY_CALLBACK_STRUCT

inherit

	SHARED_MEL_WIDGET_MANAGER;

	MEL_CALLBACK_STRUCT
		rename
			make as make_with_event
		redefine	
			reason
		end

creation
	make

feature {NONE} -- Initialization

	make (a_widget: MEL_OBJECT; a_callback_struct_ptr: POINTER) is
			-- Make the MEL_CALLBACK_STRUCT associated with the widget
			-- that triggered the callback and the callback_structure
			-- associated with this callback.
		require
			a_widget_exists: a_widget /= Void and then not a_widget.is_destroyed;
			valid_a_callback_struct_ptr: a_callback_struct_ptr /= default_pointer;
			valid_reason: reasons_list.has (reason_from (a_callback_struct_ptr));
		local
			an_event_ptr: POINTER
		do
			widget := a_widget;
			handle := a_callback_struct_ptr;
			an_event_ptr := c_event (a_callback_struct_ptr);
			if an_event_ptr /= default_pointer then 
				create_event (an_event_ptr)
			end
		end;

feature -- Access

	handle: POINTER
			-- Pointer to the C XmAnyCallbackStruct structure

	reason: INTEGER is
			-- Callback reason
			-- (Look in class MEL_CALLBACK_STRUCT_CONSTANTS for all
			-- reasons)
		do
			Result := reason_from (handle)
		end;

	reason_from (cb_ptr: POINTER): INTEGER is
			-- Retrieve the reason from the Xm callback structure `cb_ptr'
		require
			valid_cb_pt: cb_ptr /= default_pointer
		do
			Result := c_reason (cb_ptr)
		end;

	reasons_list: ARRAY [INTEGER] is
			-- List of reasons that is valid for this 
			-- callback structure
			-- (bulletin - XmCR_FOCUS, XmCR_MAP, XmCR_UNMAP
			-- cascade button - XmCR_ACTIVATE, XmCR_CASCADING
			-- text - XmCR_ACTIVATE, XmCR_FOCUS, XmCR_VALUE_CHANGED
			-- message - XmCR_OK, XmCR_CANCEL
			-- gadgets, primitive and manager - XmCR_HELP
			-- shell - XmCR_PROTOCOLS)
		once
			Result := <<XmCR_FOCUS, XmCR_MAP, XmCR_UNMAP,
				XmCR_ACTIVATE, XmCR_CASCADING, XmCR_HELP,
				XmCR_VALUE_CHANGED, XmCR_GAIN_PRIMARY, 
				XmCR_LOSE_PRIMARY, XmCR_PROTOCOLS, XmCR_OK, XmCR_CANCEL>>
		end;

feature {NONE} -- Implementation

	retrieve_widget_from_window (d, w_ptr: POINTER): MEL_WIDGET is
			-- Retrieve mel widget from window pointer `ptr'
		do
			if w_ptr /= default_pointer then
				Result := Mel_widgets.window_to_widget (d, w_ptr)
			end
		end;

	c_reason (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro %"callback_struct.h%"] (XmAnyCallbackStruct *): EIF_INTEGER"
		end;

	c_event (a_callback_struct_ptr: POINTER): POINTER is
		external
			"C [macro %"callback_struct.h%"] (XmAnyCallbackStruct *): EIF_POINTER"
		end;

invariant

	widget_not_void: widget /= Void;
	handle_not_null: handle /= default_pointer

end -- class MEL_ANY_CALLBACK_STRUCT


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
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

