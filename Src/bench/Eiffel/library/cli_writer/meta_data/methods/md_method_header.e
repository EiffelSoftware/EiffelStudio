indexing
	description: "Abstract representation of a CLI header for a feature"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_METHOD_HEADER

feature -- Access

	count: INTEGER is
			-- Size of structure once emitted.
		deferred
		end
		
feature -- Saving

	write_to_stream (m: MANAGED_POINTER; pos: INTEGER) is
			-- Write to stream `m' at position `pos'.
		require
			m_not_void: m /= Void
			valid_pos: pos >=0 and pos < m.count
			enough_space: m.count >= pos + count
		deferred
		end
		
end -- class MD_METHOD_HEADER
