note
	description: "Cells that can be linked to two neighbour cells."
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: item, left, right

frozen class
	V_DOUBLY_LINKABLE [G]

inherit
	V_CELL [G]

create
	put

feature -- Access

	right: detachable V_DOUBLY_LINKABLE [G]
			-- Next cell.
		note
			guard: not_right
		attribute
		end

	left: detachable V_DOUBLY_LINKABLE [G]
			-- Previous cell.
		note
			guard: not_left
		attribute
		end

feature -- Replacement

	connect_right (cell: V_DOUBLY_LINKABLE [G])
			-- Connect current list segment to the segment beginning with `cell'.
		note
			explicit: contracts
		require
			different: cell /= Current
			wrapped: is_wrapped
			cell_wrapped: cell.is_wrapped
			segment_end: right = Void
			segment_start: cell.left = Void
			modify_model (["right", "subjects", "observers"], Current)
			modify_model (["left", "subjects", "observers"], cell)
		do
			cell.unwrap
			put_right (cell)
			cell.put_left (Current)
			cell.wrap
		ensure
			wrapped: is_wrapped
			cell_wrapped: cell.is_wrapped
			connected: right = cell
		end

	insert_right (front, back: V_DOUBLY_LINKABLE [G])
			-- Insert a list segment `front'-`back' to the right of current cell.
		note
			explicit: contracts, wrapping
		require
			wrapped: is_wrapped
			front_wrapped: front.is_wrapped
			back_wrapped: back.is_wrapped
			right_wrapped: right.is_wrapped
			segment_start: front.left = Void
			segment_end: back.right = Void
			modify_model (["right", "subjects", "observers"], [Current, back])
			modify_model (["left", "subjects", "observers"], [right, front])
		do
			unwrap_all (create {MML_SET [ANY]} & Current & right & front & back)
			back.put_right (right)
			right.put_left (back)
			put_right (front)
			front.put_left (Current)
			wrap_all (create {MML_SET [ANY]} & Current & back.right & front & back)
		ensure
			front_connected: right = front
			back_connected: back.right = old right
			wrapped: is_wrapped
			front_wrapped: front.is_wrapped
			back_wrapped: back.is_wrapped
			right_wrapped: (old right).is_wrapped
		end

	remove_right
			-- Remove the cell to the right of current cell.
		note
			explicit: contracts, wrapping
		require
			wrapped: is_wrapped
			right_wrapped: right.is_wrapped
			next_wrapped: right.right.is_wrapped
			modify_model (["right", "subjects", "observers"], Current)
			modify_model (["left", "subjects", "observers"], right.right)
			modify (right)
		do
			unwrap_all (create {MML_SET [ANY]} & Current & right & right.right)
			put_right (right.right)
			right.put_left (Current)
			wrap_all (create {MML_SET [ANY]} & Current & right)
		ensure
			right_set: right = old right.right
			wrapped: is_wrapped
			right_wrapped: right.is_wrapped
		end

feature {V_DOUBLY_LINKABLE, V_DOUBLY_LINKED_LIST} -- Replacement

	put_right (cell: detachable V_DOUBLY_LINKABLE [G])
			-- Replace `right' with `cell'.
		require
			open: is_open
			right_open: attached right as r implies r.is_open
			inv_only ("subjects_definition", "observers_definition")
			modify_field (["right", "subjects", "observers"], Current)
		do
			right := cell
			set_subjects
				(if attached left as c then create {MML_SET [ANY]}.singleton (c) else create {MML_SET [ANY]} end +
				if attached right as c then create {MML_SET [ANY]}.singleton (c) else create {MML_SET [ANY]} end)
			set_observers (subjects)
		ensure
			right_effect: right = cell
			inv_only ("subjects_definition", "observers_definition")
		end

	put_left (cell: detachable V_DOUBLY_LINKABLE [G])
			-- Replace `left' with `cell'.
		require
			open: is_open
			left_open: attached left as l implies l.is_open
			inv_only ("subjects_definition", "observers_definition")
			modify_field (["left", "subjects", "observers"], Current)
		do
			left := cell
			set_subjects
				(if attached left as c then create {MML_SET [ANY]}.singleton (c) else create {MML_SET [ANY]} end +
				if attached right as c then create {MML_SET [ANY]}.singleton (c) else create {MML_SET [ANY]} end)
			set_observers (subjects)
		ensure
			left_effect: left = cell
			inv_only ("subjects_definition", "observers_definition")
		end

feature -- Specification

	not_left (new_left: V_DOUBLY_LINKABLE [G]; o: ANY): BOOLEAN
			-- Is `o' different from `left'?
		note
			status: functional, ghost
		do
			Result := o /= left
		end

	not_right (new_right: V_DOUBLY_LINKABLE [G]; o: ANY): BOOLEAN
			-- Is `o' different from `right'?
		note
			status: functional, ghost
		do
			Result := o /= right
		end

invariant
	subjects_definition: subjects =
		if attached left as c then create {MML_SET [ANY]}.singleton (c) else create {MML_SET [ANY]} end +
		if attached right as c then create {MML_SET [ANY]}.singleton (c) else create {MML_SET [ANY]} end
	observers_definition: observers = subjects
	left_consistent: attached left as l implies l.right = Current
	right_consistent: attached right as r implies r.left = Current

note
	explicit: subjects, observers
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
