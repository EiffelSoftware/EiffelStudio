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
			snapshot: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [ANY]]]
		do
			create snapshot.make (Current.count)
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
					snapshot.index > snapshot.count
					or is_aborted_stack.item
				loop
					if snapshot.item.valid_operands (a_pebble_tuple) then
						if
							veto_pebble_function /= Void and then
							veto_pebble_function.valid_operands (a_pebble_tuple)
						then
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
			a_tuple: TUPLE [ANY]
		do
			from
				cur := cursor
				a_tuple := [a_pebble]
				start
			until 
				after or Result
			loop
				Result := item.valid_operands (a_tuple) 
				if
					Result and then
					veto_pebble_function /= Void and then
					veto_pebble_function.valid_operands (a_tuple)
				then
					veto_pebble_function.call (a_tuple)
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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

