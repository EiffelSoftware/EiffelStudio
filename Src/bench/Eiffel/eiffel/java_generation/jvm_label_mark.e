indexing
	description: "[
					  Representation of a JVM Label Mark.
					  A `JVM_LABEL_MARK' points to a `JVM_LABEL'.
					  Since the jump offset of (forward) jumps cannot be known at the time
					  the jump should be appended to the byte code of a method, we need to
					  store label marks, that point to a symbolic jump tarket.
		Once the position of the label is known (the label is closed) , we can go
					  back to the label mark and generate the actual jump offset.
					  ]"
					  date: "$Date$"
					  revision: "$Revision$"

class
	JVM_LABEL_MARK

create
	make

feature {NONE} -- Initialisation

	make (a_label: JVM_LABEL; pos: INTEGER) is
			-- `a_label' is the symbolic target position
			-- `pos' is the byte code position (starting at 1) in the
			-- methods byte code where the target will be written to.
		require
			valid_label: a_label /= Void
			valid_pos: pos > 0
		do
			label := a_label
			byte_code_position := pos
		ensure
			label_set: label = a_label
			byte_code_position_set: byte_code_position = pos
		end
			
feature -- Access
			
	label: JVM_LABEL
			-- the label `Current' is pointing to.
			-- This will be used to calculate the actual jump offset
			-- once the label is closed.
			
	byte_code_position: INTEGER
			-- absolute position (starting at 1) of the label_mark's
			-- jump instruction in the
			-- method's byte code. Exactly at this point the jump offset
			-- will be written at.
			
	jump_offset: INTEGER is
			-- relative jump offset.
			-- If the `Result' is positive it means we will jump forward.
			-- If the `Result' is negative it means we will jump backwards.
		require
			label_closed: label.is_closed
		do
			Result := label.byte_code_position - byte_code_position
		end
																	
feature {ANY} -- Basic operations
			
invariant
	label_not_void: label /= Void
	byte_code_position_valid: byte_code_position > 0
																	
end



