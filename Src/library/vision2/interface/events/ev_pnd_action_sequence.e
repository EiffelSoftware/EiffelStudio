indexing
	description:
		"Action sequence for PND drop events."
	status: "See notice at end of file."
	keywords: "pick and drop, drag and drop, PND, DND, drop"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PND_ACTION_SEQUENCE

inherit

	ACTION_SEQUENCE [TUPLE [ANY]]
		redefine
			default_create,
			call
		end

	INTERNAL
		undefine
			default_create, copy, is_equal
		end

creation
	default_create

feature {NONE} -- Initialization
	
	default_create is
			-- Create a ready to use action sequence.
		do
			Precursor {ACTION_SEQUENCE}
			create names.make (0)
		end

feature -- Basic operations

	call (a_pebble_tuple: TUPLE [ANY]) is
			-- Call each procedure in order unless `is_blocked'.
			-- If `is_paused' delay execution until `resume'.
			-- Stop at current point in list on `abort'.
		local
			snapshot: LINKED_LIST [PROCEDURE [ANY, TUPLE [ANY]]]
		do
			create snapshot.make
			snapshot.fill (Current)
			inspect
				state
			when
				Normal_state
			then
				from
					is_aborted_stack.extend (False)
					snapshot.start
				variant
					snapshot.count + 1 - snapshot.index
				until
					snapshot.off
					or is_aborted_stack.item
				loop
					if snapshot.item.valid_operands (a_pebble_tuple) then
						if veto_pebble_function /= Void then
							veto_pebble_function.call (a_pebble_tuple)
							if veto_pebble_function.last_result then
								snapshot.item.call (a_pebble_tuple)
							end
						else
							snapshot.item.call (a_pebble_tuple)
						end
					end
					snapshot.forth
				end
				is_aborted_stack.remove
			when
				Paused_state
			then
				call_buffer.extend (a_pebble_tuple)
			when
				 Blocked_state
			then
				-- do_nothing
			end
		end

feature -- Status setting

	set_veto_pebble_function (a_function: FUNCTION [ANY, TUPLE [ANY], BOOLEAN]) is
			-- Assign `a_function' to `veto_pebble_function'.
		do
			veto_pebble_function := a_function
		end

feature -- Status report

	accepts_pebble (a_pebble: ANY): BOOLEAN is
			-- Do any actions accept `a_pebble'.
		require
			a_pebble_not_void: a_pebble /= Void
		local
			cur: CURSOR
		do
			from
				cur := cursor
				start
			until 
				after or Result
			loop
				Result := item.valid_operands ([a_pebble]) 
				if
					veto_pebble_function /= Void and then
					Result
				then
					veto_pebble_function.call ([a_pebble])
					Result := Result and then veto_pebble_function.last_result
				end
				forth
			end
			go_to (cur)

		end

	veto_pebble_function: FUNCTION [ANY, TUPLE [ANY], BOOLEAN]
			-- User function to determine whether dropping is allowed.

feature -- Element change

	set_item_name (an_item: PROCEDURE [ANY, TUPLE [ANY]]; a_name: STRING) is
			-- Acociate `a_name' with `an_item'.
		do
			names.force (a_name, an_item)
		end

feature {NONE} -- Implementation

	names: HASH_TABLE [STRING, PROCEDURE [ANY, TUPLE]]

invariant
	names_not_void: names /= Void

end

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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.11  2001/07/14 12:16:30  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.10  2001/06/07 23:08:18  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.11  2001/02/22 00:03:22  manus
--| Since LINKED_LIST now defines `copy' and `is_equal' correctly we need to
--| undefine those coming from ANY.
--|
--| Revision 1.1.2.10  2000/10/02 19:13:48  oconnor
--| updated for feature_create in ACTION_SEQUENCE
--|
--| Revision 1.1.2.9  2000/09/08 19:02:41  xavier
--| The veto function is now called only if pebble matches a drop action.
--|
--| Revision 1.1.2.8  2000/08/31 16:14:19  manus
--| Removed the change with precondition test since it is not working and as a consequence everything
--| that relies on the previous behavior does not work at all.
--|
--| We should look into it in a year from now when we really have `precondition' in ROUTINE.
--|
--| Revision 1.1.2.6  2000/08/10 16:55:56  xavier
--| Put away some parenthesis.
--|
--| Revision 1.1.2.5  2000/08/10 00:22:09  xavier
--| Added a boolean function agent to forbid drops on user-defined places.
--|
--| Revision 1.1.2.4  2000/07/24 22:46:58  oconnor
--| removed calls to call_log
--|
--| Revision 1.1.2.3  2000/07/23 21:13:58  oconnor
--| removed textual names from action sequence creation
--|
--| Revision 1.1.2.2  2000/05/03 19:09:54  oconnor
--| mergred from HEAD
--|
--| Revision 1.9  2000/04/05 17:09:14  king
--| Added pebble_not_void precondition to set_pebble
--|
--| Revision 1.8  2000/02/29 18:09:06  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.7  2000/02/26 05:05:10  oconnor
--| fixed item.vail_operands to snapshot.item.valid_operands in call
--|
--| Revision 1.6  2000/02/25 20:31:06  oconnor
--| changed to match new action sequence implementation. See ACTION_SEQUENCE 1.14
--|
--| Revision 1.5  2000/02/22 18:39:46  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.4  2000/02/15 18:43:45  oconnor
--| added copyright notice
--|
--|----------------------------------------------------------------
