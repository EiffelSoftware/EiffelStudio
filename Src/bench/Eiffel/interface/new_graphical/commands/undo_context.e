indexing
	description:
		"A context in which reversable operations are performed."
	status: "See notice at end of class"
	keywords: "undo, reverse, redo"
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_CONTEXT

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature -- Initialization

	make_with_list (a_list: LINKED_LIST [UNDO_PAIR]) is
			-- Create with `a_list'.
		do
			undo_list := a_list
			create do_actions
			create undo_actions
			create undo_exhausted_actions
			create redo_exhausted_actions
		end

	default_create is
			-- Create attributes.
		do
			create undo_list.make
			create do_actions
			create undo_actions
			create undo_exhausted_actions
			create redo_exhausted_actions
		end

feature -- Access

	undo_pairs: LINEAR [UNDO_PAIR] is
			-- Undoable actions that have been preformed.
			-- Result.`item' is the action that would be undone if `undo` were called.
		local
			l: ARRAYED_LIST [UNDO_PAIR]
		do
			create l.make (undo_list.count)
			l.fill (undo_list)
			l.start
			l.search (undo_list.item)
			Result := l
		ensure
			Result /= undo_list
		end

feature -- Basic operations

	do_undoable (action, undo_procedure: ANY) is
			-- Perform `action' and put an undo/redo pair on the undo list.
			-- Disgard pairs above the current position.
		require
			action /= Void
			undo_procedure /= Void
			conforms (action, "PROCEDURE [ANY, TUPLE []]")
			or conforms_to_tuple_of_array_of (action, "PROCEDURE [ANY, TUPLE []]")
			conforms (undo_procedure, "PROCEDURE [ANY, TUPLE []]")
			or conforms_to_tuple_of_array_of (undo_procedure, "PROCEDURE [ANY, TUPLE []]")
		local
			t: TUPLE
			action_proc: PROCEDURE [ANY, TUPLE []]
			action_array: ARRAY [ANY]
			undo_proc: PROCEDURE [ANY, TUPLE []]
			undo_array: ARRAY [ANY]
			do_agent: PROCEDURE [ANY, TUPLE []]
			undo_agent: PROCEDURE [ANY, TUPLE []]
			undo_pair: UNDO_PAIR
		do
			from
			until
				undo_list.is_empty or undo_list.islast
			loop
				undo_list.remove_right
			end

			action_proc ?= action
			if action_proc /= Void then
				do_agent := action_proc
			else
				t ?= action
				check t /= Void end
				action_array ?= t.item (1)
				check action_array /= Void end
				do_agent := (~procedure_array_call (action_array))
			end
			undo_proc ?= undo_procedure
			if undo_proc /= Void then
				undo_agent := undo_proc
			else
				t ?= undo_procedure
				check t /= Void end
				undo_array ?= t.item (1)
				check undo_array /= Void end
				undo_agent := (~procedure_array_call (undo_array))
			end
			do_agent.call (Void)
			create undo_pair.make (undo_agent, do_agent)
			if undo_list.is_empty or not undo_list.last.is_inverse (undo_pair) then
				undo_list.extend (undo_pair)
				undo_list.forth
			else
				undo_list.remove
				undo_list.back
			end
			do_actions.call (Void)
			redo_exhausted_actions.call (Void)
		end

	do_named_undoable (a_name: STRING; an_action, an_undo_procedure: ANY) is
			-- Perform `action' and put an undo/redo pair on the undo list.
			-- Disgard pairs above the current position.
		require
			an_action /= Void
			an_undo_procedure /= Void
			a_name /= Void
		do
			do_undoable (an_action, an_undo_procedure)
			undo_list.last.set_name (a_name)
		end

	undo is
			-- Reverse the most recent reversable action.
		require
			not undo_exhausted
		do
			undo_list.item.undo
			undo_list.back
			undo_actions.call (Void)
			if undo_list.off then
				undo_exhausted_actions.call (Void)
			end
		ensure
			undo_list.index = old undo_list.index - 1
		end

	redo is
			-- Reperform the most recently reversed action.
		require
			not redo_exhausted
		do
			undo_list.forth
			undo_list.item.redo
			do_actions.call (Void)
			if undo_list.islast then
				redo_exhausted_actions.call (Void)
			end
		ensure
			undo_list.index = old undo_list.index + 1
		end

feature -- Element change

	wipe_out is
			-- Disgard all previous undoable commands.
		do
			undo_list.wipe_out
		end

feature -- Status report

	undo_exhausted: BOOLEAN is
			-- Are there no remaining actions to undo?
		do
			Result :=
				undo_list.is_empty or else
				undo_list.off
		end

	redo_exhausted: BOOLEAN is
			-- Are there no remaining actions to redo?
		do
			Result :=
				undo_list.is_empty or else
				undo_list.islast
		end

feature -- Event handling

	do_actions: ACTION_SEQUENCE [TUPLE []]
			-- Called when a reversable operation is performed.

	undo_actions: ACTION_SEQUENCE [TUPLE []]
			-- Called when an operation is reversed.

	undo_exhausted_actions: ACTION_SEQUENCE [TUPLE []]
			-- Called when there are no more reversable operations.

	redo_exhausted_actions: ACTION_SEQUENCE [TUPLE []]
			-- Called when there are no more reperformable operations.

feature -- Implementation

	conforms (object: ANY; type: STRING): BOOLEAN is
			-- Does `object' conform to `type'?
		local
			i: INTERNAL
		do
			create i
			if type.substring_index ("PROCEDURE", 0) > 0 then
				Result := True
			else
				Result := i.type_conforms_to (
					i.dynamic_type (object),
					i.dynamic_type_from_string (type)
				)
			end
		end

	conforms_to_array_of (object: ANY; type: STRING): BOOLEAN is
			-- Does `object' conform to ARRAY [`type']?
		local
			a: ARRAY [ANY]
			n: INTEGER
		do
			a ?= object
			if a /= Void then
				from
					Result := True
					n := a.lower
				until
					n > a.upper or not Result
				loop
					if not conforms (a.item (n), type) then
						Result := False
					end
					n := n + 1
				end
			end
		end

	conforms_to_tuple_of_array_of (object: ANY; type: STRING): BOOLEAN is
			-- Does `object' conform to TUPLE [ARRAY [`type']]?
		local
			t: TUPLE
		do
			t ?= object
			if t /= Void then
				Result := conforms_to_array_of (t.item (1), type)
			end
		end

--|FIXME
feature  -- Implementation

	undo_list: LINKED_LIST [UNDO_PAIR]
			-- History of reversable actions.

feature {NONE} -- Implementation

	procedure_array_call (array: ARRAY [ANY]) is
			-- Call all procedures in `array'.
		require
			array /= Void
			conforms_to_array_of (array, "PROCEDURE [ANY, TUPLE []]")
		local
			i: INTEGER
			p: PROCEDURE [ANY, TUPLE []]
		do
			from
				i := array.lower
			until
				i > array.upper
			loop
				p ?= array.item (i)
				check p /= Void end
				p.call (Void)
				i := i + 1
			end
		end

invariant
	undo_list /= Void
	do_actions /= Void
	undo_actions /= Void
	undo_exhausted_actions /= Void
	redo_exhausted_actions /= Void

end -- class UNDO_CONTEXT
