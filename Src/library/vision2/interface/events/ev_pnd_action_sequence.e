indexing
	description: "Action sequence for PND drop events."
	status: "See notice at end of file."
	keywords: "pick and drop, drag and drop, PND, DND, drop"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PND_ACTION_SEQUENCE

inherit

	ACTION_SEQUENCE [TUPLE [ANY]]
		rename
			make as action_sequence_make
		redefine
			default_create,
			call
		end

	INTERNAL
		undefine
			default_create
		end

creation
	default_create

feature {NONE} -- Initialization
	
	default_create is
			-- Create a ready to use action sequence.
		do
			action_sequence_make ("ev_pnd_drop", <<"a_pebble_tuple">>)
			create names.make (0)
		end

feature -- Basic operations

	call (a_pebble_tuple: TUPLE [ANY]) is
			-- Call each procedure in order unless `is_blocked'.
			-- If `is_paused' delay execution until `resume'.
			-- Stop at current point in list on `abort'.
		do
			debug ("EVENT_TRACE") print (call_log (a_pebble_tuple)) end
			inspect
				state
			when
				Normal_state
			then
				debug ("EVENT_TRACE") print (" calling "+count.out+" actions...%N") end
				from
					cursor_stack.extend (cursor)
					is_aborted_stack.extend (False)
					start
				until
					after
					or is_aborted_stack.item
				loop
					if item.valid_operands (a_pebble_tuple) then
						item.call (a_pebble_tuple)
					end
					forth
				end
				is_aborted_stack.remove
				go_to (cursor_stack.item)
				cursor_stack.remove
			when
				Paused_state
			then
				debug ("EVENT_TRACE") print (" while paused, buffering.%N") end
				call_buffer.extend (a_pebble_tuple)
			when
				 Blocked_state
			then
				debug ("EVENT_TRACE") print (" while blocked, ignoring.%N") end
				-- do_nothing
			end
		end

feature -- Status report

	accepts_pebble (a_pebble: ANY): BOOLEAN is
			-- Do any actions accept `a_pebble'.
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
				forth
			end
			go_to (cur)

		end

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
