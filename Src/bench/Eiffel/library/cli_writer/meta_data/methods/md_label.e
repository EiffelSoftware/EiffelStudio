indexing
	description: "Representation of an IL label"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_LABEL

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize an empty label.
		do
			position := - 1
		ensure
			not_is_position_set: not is_position_set
		end

feature -- Status Report

	is_position_set: BOOLEAN is
			-- Is current label position known?
		do
			Result := position /= -1
		end
		
feature -- Settings

	mark_branch_position (pos: INTEGER) is
			-- Mark `pos' in current MD_METHOD_BODY as it
			-- will need to be updated once position of current
			-- label is known
		do
			if  mark_offsets = Void then
				create mark_offsets.make (10)
			end
			mark_offsets.extend (pos)
		end

	mark_position (pos: INTEGER; body: MD_METHOD_BODY) is
			-- Set `position' to `pos' and update all previous stored
			-- branch positions in `body'.
		require
			valid_pos: pos >= 0
			body_not_void: body /= Void
		local
			l_list: like mark_offsets
		do
			position := pos
			l_list := mark_offsets
			if l_list /= Void then
				from
					l_list.start
				until
					l_list.after
				loop
					body.set_branch_location (l_list.item, pos - (l_list.item + 4))
					l_list.forth
				end
			end
		ensure
			position_set: position = pos
		end
		
feature -- Integer

	position: INTEGER
			-- Position of label in IL stream.
			
	mark_offsets: ARRAYED_LIST [INTEGER]
			-- List all offsets in MD_METHOD_BODY that are performing
			-- a branch instruction on current. We need to store correct
			-- offset as soon as we now current label's position.

end -- class MD_LABEL
