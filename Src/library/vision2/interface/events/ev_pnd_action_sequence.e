﻿note
	description:
		"Action sequence for PND drop events."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "pick and drop, drag and drop, PND, DND, drop"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PND_ACTION_SEQUENCE

inherit
	EV_LITE_ACTION_SEQUENCE [detachable TUPLE [pebble: ANY]]
		redefine
			call
		end

create
	default_create

create {EV_PND_ACTION_SEQUENCE}
	arrayed_list_make,
	make_filled

feature -- Basic operations

	call (a_pebble_tuple: detachable TUPLE [pebble: ANY])
			-- Call each procedure in order unless `is_blocked'.
			-- If `is_paused' delay execution until `resume'.
			-- Stop at current point in list on `abort'.
		local
			snapshot: ARRAYED_LIST [PROCEDURE [ANY, detachable TUPLE [ANY]]]
			l_is_accepting: BOOLEAN
			l_tuple: TUPLE [ANY]
		do
			if attached a_pebble_tuple then
				create snapshot.make (count)
				snapshot.fill (Current)
				inspect
					state
				when
					Normal_state
				then
					from
						is_aborted_stack.extend (False)
						l_is_accepting := veto_pebble_function_result (a_pebble_tuple.pebble)
						snapshot.start
					until
						snapshot.index > snapshot.count
						or is_aborted_stack.item
					loop
						if snapshot.item.valid_operands (a_pebble_tuple) and l_is_accepting then
							l_tuple := snapshot.item.empty_operands
							l_tuple.put (a_pebble_tuple.item (1), 1)
							snapshot.item.call (l_tuple)
						end
						snapshot.forth
					variant
						snapshot.count + 1 - snapshot.index
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
		end

feature -- Status setting

	set_veto_pebble_function (a_function: detachable FUNCTION [ANY, TUPLE [ANY], BOOLEAN])
			-- Assign `a_function' to `veto_pebble_function'.
		do
			veto_pebble_function := a_function
		end

feature -- Status report

	accepts_pebble (a_pebble: ANY): BOOLEAN
			-- Do any actions accept `a_pebble'.
		require
			a_pebble_not_void: a_pebble /= Void
		local
			cur: CURSOR
			l_tuple: TUPLE [ANY]
			l_is_accepting: BOOLEAN
		do
			from
				l_is_accepting := veto_pebble_function_result (a_pebble)
				l_tuple := [a_pebble]
				cur := cursor
				start
			until
				Result or else after
			loop
				Result := item.valid_operands (l_tuple) and l_is_accepting
				forth
			end
			go_to (cur)
		end

	veto_pebble_function: detachable FUNCTION [ANY, TUPLE [ANY], BOOLEAN]
			-- User function to determine whether dropping is allowed.

feature -- Element change

	set_item_name (an_item: PROCEDURE [ANY, TUPLE [ANY]]; a_name: READABLE_STRING_GENERAL)
			-- Acociate `a_name' with `an_item'.
		obsolete
			"Removed because did nothing useful."
		do
		end

feature {NONE} -- Convenience

	veto_pebble_function_result (a_pebble: detachable ANY): BOOLEAN
			-- Find out the computation of `veto_pebble_function' with `a_pebble'.
		local
			l_tuple: TUPLE [ANY]
		do
			if attached veto_pebble_function as l_veto_pebble_function then
				l_tuple := l_veto_pebble_function.empty_operands
				if l_tuple.valid_type_for_index (a_pebble, 1) then
					l_tuple.put (a_pebble, 1)
					Result := l_veto_pebble_function.valid_operands (l_tuple) and then
						l_veto_pebble_function.item (l_tuple)
				else
						-- The `a_pebble' does not match what the veto even accept, we should
						-- clearly reject the drop.
					Result := False
				end
			else
				Result := True
			end
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
