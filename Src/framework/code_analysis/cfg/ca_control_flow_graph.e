note
	description: "[
			Represents a Control Flow Graph implemented as a doubly linked graph.
			
			This class is used for rules of type `CA_CFG_RULE'. These rules make
			use of `CA_CFG_ITERATOR', that iterates through the graph using a
			work list algorithm for a fixed point iteration. For example, rule #20,
			`variable not read', requires such a fixed point iteration.
			
			This class is intended to represent a control flow graph of a routine.
			The control flow goes from `a_start_node' to `a_end_node'. These two
			nodes are `skip' nodes, i. e. dummy nodes. They do not represent any
			instruction or condition. (The graph may contain other `skip' nodes.
			
			The graph is implicitely given by the paths from `start_node' to
			`end_node'. Since the control flow graph is directed, each node
			has information about incoming edges and outgoing edges. These
			edges are implicitely given; nodes keep lists of other nodes that
			are direct predecessors or successors. If B is among A's successrs, then
			A must be also among B's predecessors.
			
			The graph must be created by `CA_CFG_BUILDER'.
			
			Each node in the graph must have an unique label. For a graph with n
			nodes, `CA_CFG_BUILDER'	creates the graph in the way that labels are
			numbered from 1 to n. The numbering order does not imply any graph order.
			
			Apart from the `skip' node there exist `if', `loop', and `inspect', and
			`instruction' nodes. The latter represent any instruction that is neither
			`if', `loop', nor `inspect'. `elseif' clauses are converted to `if' nodes
			by the cfg builder.
		]"
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_CONTROL_FLOW_GRAPH

create {CA_CFG_BUILDER}
	make

feature {NONE} -- Initialization

	make (a_start_label, a_end_label: INTEGER)
			-- Initialization for `Current' with label `a_start_label' for
			-- entry node and label `a_end_label' for exit node.
		require
			different_labels: a_start_label /= a_end_label
			valid_labels: is_valid_label (a_start_label) and is_valid_label (a_end_label)
		do
			create start_node.make (a_start_label)
			create end_node.make (a_end_label)
		end

feature -- Properties

	start_node, end_node: CA_CFG_SKIP
			-- First and last node of CFG.

	max_label: INTEGER
			-- Largest number used for labels.

	is_valid_label (a_label: INTEGER): BOOLEAN
			-- Is `a_label' within the valid range for a node label?
		do
			Result := a_label >= 1
				-- At least `1' for use in data structures.
		end

feature {CA_CFG_BUILDER} -- Utilities

	set_max_label (a_max: INTEGER)
			-- Set largest number used for labels.
		do
			max_label := a_max
		end

end
