indexing
	description:
		"Eiffel Vision button.%N%
		%Push button widget that can display text and/or a pixmap.%N%
		%(Also the base class for other button widgets)"
	status: "See notice at end of class"
	keywords: "press, push, label, pixmap"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_BUTTON

inherit
	EV_PRIMITIVE
		redefine
			create_action_sequences,
			implementation
		end

	EV_TEXTABLE
		redefine
			implementation
		end

	EV_PIXMAPABLE
		redefine
			implementation
		end

create
	default_create,
	make_with_text,
	make_with_text_and_action
	
feature {NONE} -- Initialization
	
	make_with_text_and_action
		(a_text: STRING; an_action: PROCEDURE [ANY, TUPLE []]) is
			-- Create with 'a_text' and `an_action' in `press_actions'.
			--| FIXME this is just an idea for evaluation, tell me what you
			--| think. Sam 20000119
		require
			text_not_void: a_text /= Void
			an_action_not_void: an_action /= Void
			default_create_not_already_called: not default_create_called
		do
			default_create
			set_text (a_text)
			press_actions.extend (an_action)
		ensure
			text_assigned: text.is_equal (a_text)
			press_actions_has_an_action: press_actions.has (an_action)
		end
	
feature -- Event handling

	press_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions performed when button is pressed and then released.

feature {EV_ANY_I} -- Implementation

	implementation: EV_BUTTON_I
			-- Implementation of button.

feature {NONE} -- Implementation

	create_action_sequences is
			-- Create action sequences for button.
		do
			{EV_PRIMITIVE} Precursor
			create press_actions
		end

	create_implementation is
			-- Create implementation of button.
		do
			create {EV_BUTTON_IMP} implementation.make (Current)
		end

invariant
	press_actions_not_void: press_actions /= Void
 
end -- class EV_BUTTON

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.22  2000/02/14 11:40:52  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.21.6.25  2000/02/04 21:18:28  king
--| Removed make_with_text feature
--|
--| Revision 1.21.6.24  2000/01/28 20:00:19  oconnor
--| released
--|
--| Revision 1.21.6.23  2000/01/28 17:44:20  oconnor
--| changed export status of  Implementation to allow access from EV_ANY_I
--|
--| Revision 1.21.6.22  2000/01/27 19:30:53  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.21.6.21  2000/01/27 19:03:08  oconnor
--| changed comment from press_actions
--|
--| Revision 1.21.6.20  2000/01/19 20:56:24  oconnor
--| precondition glitch
--|
--| Revision 1.21.6.19  2000/01/19 20:47:50  oconnor
--| syntax glitch
--|
--| Revision 1.21.6.18  2000/01/19 20:45:42  oconnor
--| added experimental make_with_text_and_action
--|
--| Revision 1.21.6.17  2000/01/19 08:06:27  oconnor
--| removed inheritance of EV_FONTABLE_I
--|
--| Revision 1.21.6.16  2000/01/19 01:45:12  king
--| Added inheritance of EV_FONTABLE.
--|
--| Revision 1.21.6.15  2000/01/14 02:41:54  oconnor
--| comment improvements
--|
--| Revision 1.21.6.14  1999/12/30 01:05:19  rogers
--| Removing debugging line, added by mistake.
--|
--| Revision 1.21.6.13  1999/12/30 00:56:14  rogers
--| valid position has been changed to valid_caret_position.
--| position has been changed to caret_position, and set_insertion_position
--| has been changed to set_caret_position.
--|
--| Revision 1.21.6.12  1999/12/16 03:54:02  oconnor
--| mutiple inheritance of creation_action_sequences tweaked
--|
--| Revision 1.21.6.11  1999/12/16 03:45:49  oconnor
--| added width and height
--|
--| Revision 1.21.6.10  1999/12/15 16:46:35  oconnor
--| formatting
--|
--| Revision 1.21.6.9  1999/12/10 00:51:25  brendel
--| Cosmetics.
--|
--| Revision 1.21.6.8  1999/12/07 18:08:37  brendel
--| Changed description to saying: Objects that...
--|
--| Revision 1.21.6.7  1999/12/03 04:56:17  oconnor
--| fixed comments
--|
--| Revision 1.21.6.6  1999/12/01 17:11:57  oconnor
--| put precondition back
--|
--| Revision 1.21.6.5  1999/12/01 17:04:39  brendel
--| Commented out one precondition to which button does not have access.
--| The feature is called: `make_called'.
--|
--| Revision 1.21.6.4  1999/12/01 16:07:42  oconnor
--| make_called renamed to default_create_called
--|
--| Revision 1.21.6.3  1999/11/29 17:50:59  brendel
--| Ignore previous log message. Changed small things in cosmetics.
--|
--| Revision 1.21.6.2  1999/11/24 22:48:07  brendel
--| Just managed to compile figure cluster example.
--|
--| Revision 1.21.6.1  1999/11/23 23:54:22  oconnor
--| merged from REVIEW_BRANCH
--|
--| Revision 1.21.2.5  1999/11/23 23:02:07  oconnor
--| rearranged init sequence, see frozen default create in EV_ANY
--|
--| Revision 1.21.2.4  1999/11/18 03:41:50  oconnor
--| rewrote press command handling to use action sequence
--|
--| Revision 1.21.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.21.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
 
