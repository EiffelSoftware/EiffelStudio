indexing
	description: 
		"Multiple widget container accessible as a list."
	status: "See notice at end of class"
	keywords: "widget list, container"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_WIDGET_LIST

inherit
	EV_CONTAINER
		undefine
			extend,
			prune_all,
			put,
			replace,
			item
		redefine
			create_action_sequences,
			implementation,
			make_for_test
		end

	EV_DYNAMIC_LIST [EV_WIDGET]
		redefine
			create_action_sequences,
			implementation
		select
			put,
			set_extend
		end

feature {NONE} -- Initialization

	create_action_sequences is
		do
			{EV_CONTAINER} Precursor
			{EV_DYNAMIC_LIST} Precursor
		end

	make_for_test is
			-- Instance of `Current' for testing purposes.
		local
			radio: EV_BUTTON
			i: INTEGER
		do
			default_create
			from i := 1 until i = 6 or full
			loop
				create radio.make_with_text ("item " + i.out)
				extend (radio)
				inspect i
					when 1 then radio.set_background_color
						(create {EV_COLOR}.make_with_rgb (0.7,0.2,0.2))
					when 2 then radio.set_background_color
						(create {EV_COLOR}.make_with_rgb (0.7,0.7,0.2))
					when 3 then radio.set_background_color
						(create {EV_COLOR}.make_with_rgb (0.2,0.7,0.2))
					when 4 then radio.set_background_color
						(create {EV_COLOR}.make_with_rgb (0.2,0.7,0.7))
					when 5 then radio.set_background_color
						(create {EV_COLOR}.make_with_rgb (0.2,0.2,0.7))
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	implementation: EV_WIDGET_LIST_I
			-- Responsible for interaction with the native graphics toolkit.

end -- class EV_WIDGET_LIST

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
--| Revision 1.21  2000/06/07 17:28:12  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.20.2.2  2000/05/13 00:04:20  king
--| Converted to new EV_CONTAINABLE class
--|
--| Revision 1.20.2.1  2000/05/03 19:10:08  oconnor
--| mergred from HEAD
--|
--| Revision 1.20  2000/04/26 17:03:10  oconnor
--| test now uses EV_BUTTON not EV_RADIO_BUTTON
--|
--| Revision 1.19  2000/04/05 21:16:18  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.18.2.2  2000/04/04 22:59:32  brendel
--| Added is_parent_of.
--|
--| Revision 1.18.2.1  2000/04/03 18:13:34  brendel
--| Removed all features now implemented by EV_DYNAMIC_LIST.
--| Added contract support features.
--|
--| Revision 1.18  2000/03/20 19:41:36  king
--| Redefined extend from container to add item_is_old_item post cond
--|
--| Revision 1.17  2000/03/18 00:52:23  oconnor
--| formatting, layout and comment tweaks
--|
--| Revision 1.16  2000/03/17 23:47:16  oconnor
--| Moved uniqueness and parenting invariants from widget_list to container.
--|
--| Revision 1.15  2000/03/16 23:12:28  king
--| Revised post conditions on insertion
--|
--| Revision 1.14  2000/03/07 02:58:50  brendel
--| Added redefine of make_for_test.
--|
--| Revision 1.13  2000/03/07 02:43:59  brendel
--| Added `make_for_test'.
--|
--| Revision 1.12  2000/03/03 19:41:04  brendel
--| Removed feature `put_left'.
--|
--| Revision 1.11  2000/03/03 18:31:12  brendel
--| Added redefinition of `put_left', since the implementation in
--| DYNAMIC_CHAIN causes the invariant to be called.
--|
--| Revision 1.10  2000/03/03 16:51:13  brendel
--| off -> after
--|
--| Revision 1.9  2000/03/02 20:09:05  brendel
--| Fixed minor bug in contract support features.
--|
--| Revision 1.8  2000/03/02 19:47:08  brendel
--| Added redefinition of `merge_left' and `merge_right', because the
--| original implementation removes the items explicitly and our versions
--| of `put_right', `put_left' adn `put_front' delete an item automatically
--| when it was in another list.
--|
--| Revision 1.7  2000/03/02 18:01:45  oconnor
--| improved prune comment further :)
--|
--| Revision 1.6  2000/03/02 17:09:52  brendel
--| Improved comment on `prune'.
--|
--| Revision 1.5  2000/03/02 01:32:43  brendel
--| Removed conditional `has (v)' from feature `prune', to let the
--| implementation take care of this.
--|
--| Revision 1.4  2000/02/26 06:26:07  oconnor
--| added extra postconditions to start and finish
--|
--| Revision 1.3  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.2  2000/02/14 12:05:14  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.4.17  2000/02/08 09:36:54  oconnor
--| Removed inheritance of EV_DYNAMIC_LIST
--| This created more problems than it solved.
--| Most preconditions and invaraints require somthing better that G
--| as the item type and there with ireconsilable noconformities involving like
--|
--| Revision 1.1.4.16  2000/02/08 05:11:31  oconnor
--| formatting
--|
--| Revision 1.1.4.15  2000/02/08 01:44:51  king
--| Correctly implemented item_parent and its caller
--|
--| Revision 1.1.4.14  2000/02/08 00:19:38  king
--| Changed inheritence to deal with changes in ev_dynamic_list
--|
--| Revision 1.1.4.13  2000/02/07 20:19:42  king
--| Added remove_from_parent
--|
--| Revision 1.1.4.12  2000/02/07 19:08:12  king
--| Implemented to fit in with new ev_dynamic_list structure
--|
--| Revision 1.1.4.11  2000/01/28 20:00:15  oconnor
--| released
--|
--| Revision 1.1.4.10  2000/01/28 16:45:05  oconnor
--| changed replace from  if has (v) then  to  if not has (v) then
--|
--| Revision 1.1.4.9  2000/01/27 19:30:53  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.4.8  2000/01/17 18:03:16  oconnor
--| added checks and comments to prevent insertion of Void items
--|
--| Revision 1.1.4.7  2000/01/17 03:18:21  oconnor
--| fixed comments, removed io.putstring (index.out) from remove_left
--|
--| Revision 1.1.4.6  1999/12/17 19:46:31  rogers
--| Now inherits EV_INVISIBLE_CONTAINER instead of EV_CONTAINER. Will only now
--| add an item if the item is not already in the list.
--|
--| Revision 1.1.4.5  1999/12/15 20:17:30  oconnor
--| reworking box formatting, contracts and names
--|
--| Revision 1.1.4.4  1999/12/15 17:38:47  oconnor
--| formatting
--|
--| Revision 1.1.4.3  1999/12/15 17:03:41  oconnor
--| formatting
--|
--| Revision 1.1.4.2  1999/11/30 22:16:36  oconnor
--| comment improvements
--|
--| Revision 1.1.4.1  1999/11/24 00:15:57  oconnor
--| merged from REVIEW_BRANCH_19991006
--|
--| Revision 1.1.2.3  1999/11/17 02:01:58  oconnor
--| inherit SET
--|
--| Revision 1.1.2.2  1999/11/09 16:53:16  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.1.2.1  1999/11/05 18:02:35  oconnor
--| initial
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
