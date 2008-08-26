indexing
	description:
		"Action sequence for PND drop events."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "pick and drop, drag and drop, PND, DND, drop"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_PND_ACTION_SEQUENCE

inherit

	ACTION_SEQUENCE [TUPLE [ANY, SD_CONTENT]]
		redefine
			default_create,
			call
		end

create
	default_create

create {SD_PND_ACTION_SEQUENCE}
	make_filled

feature {NONE} -- Initialization

	default_create is
			-- Create a ready to use action sequence.
		do
			Precursor {ACTION_SEQUENCE}
			create names.make (0)
		end

feature -- Basic operations

	call (a_pebble_tuple: TUPLE [ANY, SD_CONTENT]) is
			-- Call each procedure in order unless `is_blocked'.
			-- If `is_paused' delay execution until `resume'.
			-- Stop at current point in list on `abort'.
		local
			snapshot: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [ANY]]]
		do
			create snapshot.make (count)
			snapshot.fill (Current)
			inspect
				state
			when
				Normal_state
			then
				from
					is_aborted_stack.extend (False)
					snapshot.start
				until
					snapshot.index > snapshot.count
					or is_aborted_stack.item
				loop
					if snapshot.item.valid_operands (a_pebble_tuple) then
						if
							veto_pebble_function /= Void and then
							veto_pebble_function.valid_operands (a_pebble_tuple)
						then
							if veto_pebble_function.item (a_pebble_tuple) then
								snapshot.item.call (a_pebble_tuple)
							end
						else
							snapshot.item.call (a_pebble_tuple)
						end
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

feature -- Status setting

	set_veto_pebble_function (a_function: FUNCTION [ANY, TUPLE [ANY, SD_CONTENT], BOOLEAN]) is
			-- Assign `a_function' to `veto_pebble_function'.
		do
			veto_pebble_function := a_function
		end

feature -- Status report

	accepts_pebble (a_pebble: ANY; a_content: SD_CONTENT): BOOLEAN is
			-- Do any actions accept `a_pebble'.
		require
			a_pebble_not_void: a_pebble /= Void
		local
			cur: CURSOR
			a_tuple: TUPLE [ANY, SD_CONTENT]
		do
			from
				cur := cursor
				a_tuple := [a_pebble, a_content]
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
					Result := Result and then veto_pebble_function.item (a_tuple)
				end
				forth
			end
			go_to (cur)

		end

	veto_pebble_function: FUNCTION [ANY, TUPLE [ANY, SD_CONTENT], BOOLEAN]
			-- User function to determine whether dropping is allowed.
			-- Argument {SD_CONTENT} means which {SD_CONTENT} stone will be dropped to

feature -- Element change

	set_item_name (an_item: PROCEDURE [ANY, TUPLE [ANY]]; a_name: STRING_GENERAL) is
			-- Acociate `a_name' with `an_item'.
		do
			names.force (a_name, an_item)
		end

feature {NONE} -- Implementation

	names: HASH_TABLE [STRING_GENERAL, PROCEDURE [ANY, TUPLE]]

invariant
	names_not_void: names /= Void

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end
