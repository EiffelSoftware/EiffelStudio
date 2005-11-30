-- Byte code for reverse assignment

class REVERSE_B

inherit
	ASSIGN_B
		redefine
			enlarged, process
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_reverse_b (Current)
		end

feature -- Access

	info: CREATE_INFO
			-- Keep info about `target' type.
			-- Never Void.

feature -- Settings

	set_info (a_info: like info) is
			-- Set `info' to `a_info'.
		require
			a_info_not_void: a_info /= Void
		do
			info := a_info
		ensure
			info_set: info = a_info
		end

feature -- Enlarging

	enlarged: REVERSE_BL is
			-- Enlarge current node.	
		do
			create Result.make (Current)
		end

end
