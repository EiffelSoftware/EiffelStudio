note
	description: "The model for a graph item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EG_ITEM

inherit
	HASHABLE
		rename
			hash_code as id
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Create an EG_ITEM.
		do
			create name_change_actions
			name_change_actions.compare_objects
		end

feature -- Access

	graph: detachable EG_GRAPH
			-- The graph model `Current' is part of (if not Void).

	id: INTEGER
			-- Unique id.
		do
			if internal_hash_id = 0  then
				counter.put (counter.item + 1)
				internal_hash_id := counter.item
			end
			Result := internal_hash_id
		end

	name_32: detachable READABLE_STRING_32
			-- Name of `Current'.

	name: detachable STRING
			-- Name of `Current'.
		obsolete "Use `name_32` instead. [2020-05-31]"
		do
			if attached name_32 as n then
				Result := {UTF_CONVERTER}.string_32_to_utf_8_string_8 (n)
			end
		end

	set_name_32 (a_name: detachable READABLE_STRING_32)
			-- Set `name' to `a_name'.
		do
			if
				attached a_name /= attached name_32 or else
				attached a_name and then attached name_32 as n and then not a_name.same_string (n)
			then
				name_32 := a_name
				name_change_actions.call (Void)
			end
		ensure
			set: name_32 = a_name
		end

	set_name (a_name: detachable STRING)
			-- Set `name' to `a_name'.
		obsolete "Use `set_name_32` instead. [2020-05-31]"
		do
			if attached a_name then
				set_name_32
					(if {UTF_CONVERTER}.is_valid_utf_8_string_8 (a_name) then
						{UTF_CONVERTER}.utf_8_string_8_to_string_32 (a_name)
					else
						a_name.as_string_32
					end)
			else
				set_name_32 (Void)
			end
		ensure
			set: name ~ a_name
		end

	name_change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Called when `name' was changed.

feature {EG_GRAPH} -- Element change.

	set_graph (a_graph: detachable like graph)
			-- Set `graph' to `a_graph'.
		do
			graph := a_graph
		ensure
			set: graph = a_graph
		end

feature {NONE} -- Implementation

	internal_hash_id: like id
			-- internal id for the hash code.

	counter: CELL [INTEGER]
			-- Id counter.
		once
			create Result.put (0)
		ensure
			counter_not_void: Result /= Void
		end

invariant
	name_change_actions_not_void: name_change_actions /= Void

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EG_ITEM
