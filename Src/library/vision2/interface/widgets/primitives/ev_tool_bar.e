--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision toolbar. Only toolbar items%
		% can be placed into a tool-bar."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR

inherit
	EV_PRIMITIVE
		redefine
			implementation,
			create_action_sequences,
			make_for_test
		end

	EV_ITEM_LIST [EV_TOOL_BAR_ITEM]
		redefine
			implementation,
			create_action_sequences
		end

create
	default_create,
	make_for_test

feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation of button.
		do
			create {EV_TOOL_BAR_IMP} implementation.make (Current)
		end

	create_action_sequences is
		do
			{EV_PRIMITIVE} Precursor
			{EV_ITEM_LIST} Precursor
		end

feature {NONE} -- Contract support

	make_for_test is
		do
			{EV_PRIMITIVE} Precursor
			extend (create {EV_TOOL_BAR_BUTTON}.make_with_text ("ToolBar%NButton"))
			extend (create {EV_TOOL_BAR_SEPARATOR})
			extend (create {EV_TOOL_BAR_TOGGLE_BUTTON}.make_with_text ("ToolBar%NToggle Button"))
			extend (create {EV_TOOL_BAR_SEPARATOR})
			extend (create {EV_TOOL_BAR_RADIO_BUTTON}.make_with_text ("ToolBar%NRadio Button 1"))
			extend (create {EV_TOOL_BAR_RADIO_BUTTON}.make_with_text ("ToolBar%NRadio Button 2"))
			extend (create {EV_TOOL_BAR_RADIO_BUTTON}.make_with_text ("ToolBar%NRadio Button 3"))
		end

feature {EV_ANY_I} -- Initialization

	implementation: EV_TOOL_BAR_I
			-- Platform dependent access.

end -- class EV_TOOL_BAR

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--| Revision 1.15  2000/05/02 20:25:26  king
--| Added basic make_for_test
--|
--| Revision 1.14  2000/04/11 23:32:46  king
--| Removed merge_radio_button_groups
--|
--| Revision 1.13  2000/04/05 21:16:23  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.12  2000/04/04 16:56:38  rogers
--| Added merge_radio_button_groups.
--|
--| Revision 1.11.4.1  2000/04/04 22:58:18  brendel
--| Included EV_ITEM_LIST.create_action_sequences.
--|
--| Revision 1.11  2000/03/01 19:48:53  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.10  2000/03/01 03:27:05  oconnor
--| added make_for_test
--|
--| Revision 1.9  2000/02/29 18:09:11  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.8  2000/02/22 18:39:52  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.7  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.9  2000/02/01 20:17:47  king
--| Changed inheritence structure to use tool_bar_items
--|
--| Revision 1.6.6.8  2000/01/28 22:24:25  oconnor
--| released
--|
--| Revision 1.6.6.7  2000/01/28 19:05:29  king
--| Altered to new generic structure of ev_item_list
--|
--| Revision 1.6.6.6  2000/01/27 19:30:58  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.5  2000/01/26 23:17:24  king
--| Removed redundant features from interface
--|
--| Revision 1.6.6.4  2000/01/20 16:48:56  rogers
--| Implemented create_implementation.
--|
--| Revision 1.6.6.3  1999/12/17 19:24:32  rogers
--| item_type is no longer inherited and therfore is not redefined.
--|
--| Revision 1.6.6.2  1999/12/01 19:13:56  rogers
--| Changed inheritance structure from EV_ITEM_HOLDER to EV_ITEM_LIST
--|
--| Revision 1.6.6.1  1999/11/24 17:30:56  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
