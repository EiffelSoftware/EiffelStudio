note
	description: "[
		Directed or undirected weighted graph edges that consist of
		two node items and a label.
		]"
	author: "Olivier Jeger"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	WEIGHTED_EDGE [G -> HASHABLE, L]

inherit
	EDGE [G, L]
		rename
			make_directed as old_make_directed,
			make_undirected as old_make_undirected
		export {NONE}
			old_make_directed,
			old_make_undirected
		redefine
			is_equal,
			out
		end

create
	make_directed, make_undirected

feature -- Initialization

	make (a_start_node, a_end_node: G; a_label: detachable L; a_weight: REAL_64)
			-- Make a labeled edge from two nodes with weight `a_weight'.
		require
			nodes_not_void: a_start_node /= Void and a_end_node /= Void
		do
			start_node := a_start_node
			end_node := a_end_node
			label := a_label
			internal_weight := a_weight
			user_defined_weight_function := False
		ensure
			nodes_assigned: start_node = a_start_node and
							end_node = a_end_node
			nodes_not_void: start_node /= Void and
							end_node /= Void
			weight_assigned: weight = a_weight
			label_set: label = a_label
			default_weight_function: not user_defined_weight_function
		end

	make_directed (a_start_node, a_end_node: G; a_label: detachable L; a_weight: REAL_64)
			-- Make a directed labeled edge from two nodes with weight `a_weight'.
		require
			nodes_not_void: a_start_node /= Void and a_end_node /= Void
		do
			make (a_start_node, a_end_node, a_label, a_weight)
			is_directed := True
		ensure
			nodes_assigned: start_node = a_start_node and
							end_node = a_end_node
			nodes_not_void: start_node /= Void and
							end_node /= Void
			weight_assigned: weight = a_weight
			label_set: label = a_label
			is_directed: is_directed
		end

	make_undirected (a_start_node, a_end_node: G; a_label: detachable L; a_weight: REAL_64)
			-- Make an undirected labeled edge from two nodes with weight `a_weight'.
		require
			nodes_not_void: a_start_node /= Void and a_end_node /= Void
		do
			make (a_start_node, a_end_node, a_label, a_weight)
			is_directed := False
		ensure
			nodes_assigned: start_node = a_start_node and
							end_node = a_end_node
			nodes_not_void: start_node /= Void and
							end_node /= Void
			weight_assigned: weight = a_weight
			label_set: label = a_label
			not_directed: not is_directed
		end

feature -- Access

	weight: REAL_64
			-- Weight of the edge
		do
			if attached weight_function as l_weight_function then
				Result := l_weight_function.item ([Current])
			else
				Result := internal_weight
			end
		end

feature -- Measurement

feature -- Status report

	user_defined_weight_function: BOOLEAN
			-- Is `weight' computed by a user-defined function?

feature -- Status setting

	restore_default_weight
			-- `weight' will return the assigned edge weight.
		do
			user_defined_weight_function := False
		ensure
			default_weight_function: not user_defined_weight_function
		end

	enable_user_defined_weight_function (a_function: like weight_function)
			-- `weight' will be computed by a user-defined function on `label'.
		do
			user_defined_weight_function := True
			weight_function := a_function
		ensure
			user_defined_weight_function: user_defined_weight_function
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
				-- Start and end node must be equal.
			Result := start_node.is_equal (other.start_node) and
					  end_node.is_equal (other.end_node)

				-- Consider also flipped edges in undirected graphs.
			if not is_directed then
				Result := Result or
						 (start_node.is_equal (other.end_node) and
						  end_node.is_equal (other.start_node))
			end
				-- Labels must be equal.
			Result := Result and equal (attached  {ANY} label as l_label, attached {ANY} other.label as o_label)
				-- Weight must be equal.
			Result := Result and weight = other.weight
			Result := Result or standard_is_equal (other)
		end

feature -- Cursor movement

feature -- Element change

	set_weight (a_weight: REAL_64)
			-- Set the weight of the edge.
		do
			internal_weight := a_weight
		end

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature -- Output

	out: STRING
			-- Textual representation of the edge
		do
			Result := start_node.out
			if is_directed then
				Result.append (" -> ")
			else
				Result.append (" -- ")
			end
			Result.append (end_node.out)
			separate label as s_label do
				if attached s_label as l_label and then not l_label.out.is_equal ("")  then
					Result.append ("  [label=%"")
					Result.append ((create {STRING}.make_from_separate (l_label.out)).out)
					Result.append ("%"]")
				end
			end
			Result.append ("  [weight=")
			Result.append (weight.out)
			Result.append ("]")
		end

feature {NONE} -- Implementation

	internal_weight: REAL_64
			-- Weight of the edge

	weight_function: detachable FUNCTION [TUPLE [WEIGHTED_EDGE [G, L]], REAL_64]
			-- User-defined function to compute `weight'.

end -- class WEIGHTED_EDGE
