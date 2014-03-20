note
	description: "Represents a basic block in the CFG."
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CA_CFG_BASIC_BLOCK

inherit
	HASHABLE
		redefine is_equal end

feature {NONE} -- Initialization

	initialize
			-- Initialization used by descendants.
		do
			create in_edges.make (0)
			create out_edges.make (0)
		end

feature -- Edges

	in_edges, out_edges: ARRAYED_LIST [detachable CA_CFG_BASIC_BLOCK]
			-- List of incoming edges from and outgoing edges to this block.

	add_in_edge (a_edge: attached CA_CFG_BASIC_BLOCK)
			-- Adds `a_edge' to the incoming edges.
		do
			in_edges.extend (a_edge)
		end

	add_out_edge (a_edge: attached CA_CFG_BASIC_BLOCK)
			-- Adds `a_edge' to the outgoing edges.
		do
			out_edges.extend (a_edge)
		end

	wipe_out_in_edges
			-- Wipes out all incoming edges.
		do
			in_edges.wipe_out
		end

	wipe_out_out_edges
			-- Wipes out all outgoing edges.
		do
			out_edges.wipe_out
		end

feature -- Properties

	label: INTEGER
			-- Label, preferrably unique in the CFG.

	set_label (a_label: INTEGER)
			-- Sets the label of `Current' to 'a_label'.
		do
			label := a_label
		end

	hash_code: INTEGER
		do
			Result := label.abs
		end

	is_equal (other: like Current): BOOLEAN
		do
				-- Two blocks from different graphs should not
				-- be compared anyway. Since the associated control
				-- flow graph is not stored in the node, it is not possible
				-- to distingiush two `CA_CFG_BASIC_BLOCK' objects with the
				-- same label but from different graphs.
			Result := label = other.label
		end

end
