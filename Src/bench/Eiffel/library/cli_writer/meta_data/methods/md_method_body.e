indexing
	description: "Body of an Eiffel method."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_METHOD_BODY
	
inherit
	MD_SHARED_OPCODES

create {MD_METHOD_WRITER}
	make

feature {NONE} -- Initialization

	make (token: INTEGER) is
			-- Create new instance ready to be updated.
		require
			is_method_token:
				token & feature {MD_TOKEN_TYPES}.Md_mask = feature {MD_TOKEN_TYPES}.Md_method_def
		do
			create item.make (Chunk_size)
			create labels.make (1, 5)
			create labels_stack_depth.make (1, 5)
			create exception_block.make
			create once_catch_block.make
			create once_finally_block.make
			remake (token)
		ensure
			current_position_set: current_position = 0
			max_stack_set: max_stack = 0
			current_stack_depth_set: current_stack_depth = 0
			method_token_set: method_token = token
			local_token_set: local_token = 0
			labels_not_void: labels /= Void
			nb_labels_null: nb_labels = 0
			exception_clause_reset: not exception_block.is_defined
			not_is_written: not is_written
		end

feature -- Reset

	remake (token: like method_token) is
			-- Reuse current object for body of method `token'.
		require
			is_method_token:
				token & feature {MD_TOKEN_TYPES}.Md_mask = feature {MD_TOKEN_TYPES}.Md_method_def
		do
			current_position := 0
			max_stack := 0
			current_stack_depth := 0
			last_current_stack_depth := 0
			method_token := token
			local_token := 0
			nb_labels := 0
			exception_block.reset
			once_catch_block.reset
			once_finally_block.reset
			is_written := False
		ensure
			current_position_set: current_position = 0
			max_stack_set: max_stack = 0
			current_stack_depth_set: current_stack_depth = 0
			local_token_set: local_token = 0
			method_token_set: method_token = token
			nb_labels_null: nb_labels = 0
			exception_clause_reset: not exception_block.is_defined
			not_is_written: not is_written
		end

feature -- Access

	count: INTEGER is
			-- Current size in memory.
		do
			Result := current_position
		end
		
	item: MANAGED_POINTER
			-- Hold data for current method_body.
		
	current_stack_depth: INTEGER
			-- Current stack depth.
			
	max_stack: INTEGER
			-- Max stack of current feature.
	
	method_token: INTEGER
			-- Associated method token to current body.

	local_token: INTEGER
			-- Token for signature discribing layout of local vriables
			-- for current method. `0' means they are no local variable present.

	exception_block: MD_EXCEPTION_CATCH
			-- Exception clause for current feature.

	once_catch_block: MD_EXCEPTION_CATCH
			-- Exception clause for catch wrapper of once feature.

	once_finally_block: MD_EXCEPTION_FINALLY
			-- Exception clause for finally wrapper of once feature.

feature -- Status report

	has_locals: BOOLEAN is
			-- Has current body some local variables?
		do
			Result := local_token /= 0
		end
		
	has_exceptions_handling: BOOLEAN is
			-- Has an exception block completely defined?
		do
			Result := exception_block.is_defined or else once_catch_block.is_defined or else once_finally_block.is_defined
		end
		
	is_written: BOOLEAN
			-- Has current body been already written into memory?
			-- If yes, no further update operations are allowed.

	nb_labels: INTEGER
			-- Current number of defined labels for current body.

feature -- Savings

	write_to_stream (m: MANAGED_POINTER; pos: INTEGER) is
				-- Write to stream `m' at position `pos'.
		require
			not_yet_written: not is_written
			m_not_void: m /= Void
			valid_pos: pos >= 0 and pos < m.count
			valid_stack_depth: current_stack_depth = 0
		do
			(m.item + pos).memory_copy (item.item, current_position)
			is_written := True
		ensure
			is_written_set: is_written
		end
		
feature -- Settings

	set_local_token (token: like local_token) is
			-- Set a local signature token to current body.
		require
			not_yet_written: not is_written
		do
			local_token := token
		ensure
			local_token_set: local_token = token
		end
		
	update_stack_depth (delta: INTEGER) is
			-- Update `max_stack' and `current_stack_depth' according to
			-- new `delta' depth change.
		require
			not_yet_written: not is_written
			is_valid_delta: current_stack_depth + delta >= 0
		do
			current_stack_depth := current_stack_depth + delta
			if current_stack_depth > max_stack then
				max_stack := current_stack_depth
			end
			last_current_stack_depth := current_stack_depth
		ensure
			current_stack_depth_set: current_stack_depth = old current_stack_depth + delta
			max_stack_set: max_stack >= current_stack_depth
		end
		
feature -- Opcode insertion

	put_nop is
			-- Insert `nop'.
		require
			not_yet_written: not is_written
		do
			internal_put (feature {MD_OPCODES}.nop.to_integer_8, current_position)
			current_position := current_position + 1
		end
		
	put_throw is
			-- Insert `throw' opcode.
		require
			not_yet_written: not is_written
		do
			put_opcode (feature {MD_OPCODES}.throw)
			last_current_stack_depth := -1
		end

	put_rethrow is
			-- Insert `rethrow' opcode.
		require
			not_yet_written: not is_written
		do
			put_opcode (feature {MD_OPCODES}.rethrow)
			last_current_stack_depth := -1
		end
		
	put_opcode (opcode: INTEGER_16) is
			-- Insert `opcode'.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		local
			l_pos, l_incr: INTEGER
			l_opcodes: like opcodes
			l_stack_transition: INTEGER
		do
			l_opcodes := opcodes
			l_stack_transition := opcodes.item (opcode).stack_depth_transition
			
			if l_stack_transition /= 0xFF000000 then
				update_stack_depth (l_stack_transition)
			end
			
			l_pos := current_position
			if (opcode & 0xFF00) = 0xFE00 then
					-- Two bytes opcodes.
				l_incr := 2
				internal_put (((opcode & 0xFF00) |>> 8).to_integer_8, l_pos)
				internal_put ((opcode & 0x00FF).to_integer_8, l_pos + 1)
			else
				l_incr := 1
				internal_put (opcode.to_integer_8, l_pos)
			end
			current_position := l_pos + l_incr
		end

	put_string (string_token: INTEGER) is
			-- Generate `ldstr' instruction.
		require
			not_yet_written: not is_written
		do
			put_opcode (feature {MD_OPCODES}.Ldstr)
			add_integer (string_token)
		end
	
	put_opcode_mdtoken (opcode: INTEGER_16; token: INTEGER) is
			-- Insert `opcode' manipulating a metadata token.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			add_integer (token)
		end

	put_opcode_integer_8 (opcode: INTEGER_16; i: INTEGER_8) is
			-- Insert `opcode' manipulating an integer.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			internal_put (i, current_position)
			current_position := current_position + 1
		end

	put_opcode_integer_16 (opcode: INTEGER_16; i: INTEGER_16) is
			-- Insert `opcode' manipulating an integer.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			add_integer_16 (i)
		end

	put_opcode_integer (opcode: INTEGER_16; i: INTEGER) is
			-- Insert `opcode' manipulating an integer.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			add_integer (i)
		end

	put_opcode_real (opcode: INTEGER_16; r: REAL) is
			-- Insert `opcode' manipulating a real.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			add_real (r)
		end

	put_opcode_double (opcode: INTEGER_16; d: DOUBLE) is
			-- Insert `opcode' manipulating a double.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			add_double (d)
		end

	put_opcode_integer_64 (opcode: INTEGER_16; i: INTEGER_64) is
			-- Insert `opcode' manipulating an integer 64.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			add_integer_64 (i)
		end

feature -- Labels manipulation

	define_label: INTEGER is
			-- Create a new label.
		local
			l_label: MD_LABEL
		do
			create l_label.make
			nb_labels := nb_labels + 1
			labels.force (l_label, nb_labels)
			labels_stack_depth.force (-1, nb_labels)
			Result := nb_labels
		end
		
	mark_label (label_id: INTEGER) is
			-- Set position of `label_id' to `current_position' in
			-- stream.
		require
			valid_label_id: label_id > 0 and label_id <= nb_labels
		local
			l_label: MD_LABEL
			l_new_depth: INTEGER
		do
			l_label := labels.item (label_id)
			l_label.mark_position (current_position, Current)
	
				-- Restore current stack depth for this label, which
				-- is the depth we computed when we did a branch to it,
				-- if no branching has been done yet, then we simply
				-- preserve the existing value of `current_stack_depth'.
			check
				new_stack_depth_value_correct:
					(labels_stack_depth.item (label_id) >= 0 and last_current_stack_depth >= 0) implies
						labels_stack_depth.item (label_id) = last_current_stack_depth
			end
			l_new_depth := labels_stack_depth.item (label_id)
			if l_new_depth >= 0 then
				current_stack_depth := l_new_depth
			end
		end
		
	put_opcode_label (opcode: INTEGER_16; label_id: INTEGER) is
			-- Insert `opcode' branching to `label'
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			put_label (label_id, 0)
		end

	put_label (label_id: INTEGER; offset: INTEGER) is
			-- Insert offset of `label', incremented by `offset'.
		require
			not_yet_written: not is_written
		local
			l_label: MD_LABEL
			l_jmp: INTEGER
		do
			l_label := labels.item (label_id)
			if l_label.is_position_set then
				l_jmp := l_label.position - current_position
			else
					-- Store current location so that we can 
					-- update with correct offset as soon as we
					-- know about `l_label' position.
				l_label.mark_branch_position (current_position)
					-- Update the stack level for `label_id'. The following check
					-- is to ensure that if we have multiple branches to the same
					-- label each branching has the same stack depth, otherwise
					-- this shows a bug in our code generation.
				check
					new_stack_depth_value_correct:
						labels_stack_depth.item (label_id) >= 0 implies
							labels_stack_depth.item (label_id) = current_stack_depth
				end
				labels_stack_depth.put (current_stack_depth, label_id)
			end
			add_integer (l_jmp + offset - 4)
				-- When handling a jump we reset `last_current_stack_depth' as it
				-- does not matter to us what the stack depth is if the next call
				-- is a call to `mark_label'.
			last_current_stack_depth := -1
		end

	set_branch_location (branch_inst_pos: INTEGER; jump_offset: INTEGER) is
			-- Update code at `branch_inst_pos' with new jump value `jump_offset'.
		require
			valid_pos: branch_inst_pos > 0 and branch_inst_pos + 4 <= count
		do
			item.put_integer_32_le (item.read_integer_32_le (branch_inst_pos) + jump_offset, branch_inst_pos)
		end
		
feature -- Opcode insertion with manual update of `current_stack_depth'.

	put_static_call (feature_token, nb_arguments: INTEGER; is_function: BOOLEAN) is
			-- Perform a static call to `feature_token' with proper stack size computation.
		require
			not_yet_written: not is_written
		do
			internal_put_call (feature {MD_OPCODES}.call, feature_token,
				nb_arguments, is_function, False)
		end
		
	put_call (opcode: INTEGER_16; feature_token, nb_arguments: INTEGER; is_function: BOOLEAN) is
			-- Perform call to `feature_token' with proper stack size computation.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			internal_put_call (opcode, feature_token, nb_arguments, is_function, True)
		end
	
	put_newobj (constructor_token: INTEGER; nb_arguments: INTEGER) is
			-- Perform creation of object through `constructor_token'
			-- with proper stack size computation.
		require
			not_yet_written: not is_written
		do
			internal_put_call (feature {MD_OPCODES}.newobj, constructor_token,
				nb_arguments, True, False)
		end

feature {NONE} -- Implementation

	internal_put_call (opcode: INTEGER_16; feature_token, nb_arguments: INTEGER; is_function, needs_current: BOOLEAN) is
			-- Perform call to `feature_token' with proper stack size computation.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		local
			l_additional: INTEGER
		do
			put_opcode (opcode)
			add_integer (feature_token)
			if needs_current then
					-- We remove target of calls from stack.
				l_additional := 1
			end
			if is_function then
				update_stack_depth (- nb_arguments - l_additional + 1)
			else
				update_stack_depth (- nb_arguments - l_additional)
			end
		end

feature {NONE} -- Opcode insertion helpers

	add_integer_16 (val: INTEGER_16) is
			-- Add `val' to current.
		require
			not_yet_written: not is_written
		local
			l_val: INTEGER_16
			l_pos: INTEGER
		do
			l_val := val
			l_pos := current_position
			internal_put ((l_val & 0x00FF).to_integer_8, l_pos)
			l_val := l_val |>> 8
			internal_put ((l_val & 0x00FF).to_integer_8, l_pos + 1)
			current_position := l_pos + 2
		end

	add_integer (val: INTEGER) is
			-- Add `val' to current.
		require
			not_yet_written: not is_written
		local
			l_val, l_pos: INTEGER
			i: INTEGER
		do
			from
				l_val := val
				l_pos := current_position
				i := 1
			until
				i > 4
			loop
				internal_put ((l_val & 0x000000FF).to_integer_8, l_pos)
				l_pos := l_pos + 1
				l_val := l_val |>> 8
				i := i + 1
			end
			current_position := l_pos
		end
		
	add_integer_64 (val: INTEGER_64) is
			-- Add `val' to current.
		require
			not_yet_written: not is_written
		local
			l_val: INTEGER_64
			l_pos: INTEGER
			i: INTEGER
		do
			from
				l_val := val
				l_pos := current_position
				i := 1
			until
				i > 8
			loop
				internal_put ((l_val & 0x00000000000000FF).to_integer_8, l_pos)
				l_pos := l_pos + 1
				l_val := l_val |>> 8
				i := i + 1
			end
			current_position := l_pos
		end
	
	add_real (val: REAL) is
			-- Add `val' to current.
		require
			not_yet_written: not is_written
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 4)
			item.put_real (val, l_pos)
			current_position := l_pos + 4
		end

	add_double (val: DOUBLE) is
			-- Add `val' to current.
		require
			not_yet_written: not is_written
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 8)
			item.put_double (val, l_pos)
			current_position := l_pos + 8
		end

	internal_put (val: INTEGER_8; pos: INTEGER) is
			-- Safe insertion that will resize `item' if needed.
		require
			not_yet_written: not is_written
			valid_pos: pos >= 0
		do
			allocate (pos + 1)
			item.put_integer_8 (val, pos)
		end

feature {NONE} -- Stack depth management

	allocate (new_size: INTEGER) is
			-- Resize `item' if needed so that it can accomdate `new_size'.
		local
			l_capacity: INTEGER
		do
			l_capacity := item.count
			if new_size > l_capacity then
				item.resize (new_size.max (l_capacity + Chunk_size))
			end
		ensure
			enough_size: item.count >= new_size
		end
		
feature {NONE} -- Implementation

	current_position: INTEGER
			-- Current position in `item' for next insertion.

	last_current_stack_depth: INTEGER
			-- Depth at the previous IL offset. Used for checking that
			-- our generated code is indeed valid.

	Chunk_size: INTEGER is 50
			-- Default body size.

	labels: ARRAY [MD_LABEL]
			-- List all labels used in current body.

	labels_stack_depth: ARRAY [INTEGER]
			-- List of depth associated for each label.
			
invariant
	item_not_void: item /= Void
	current_position_valid: current_position >= 0 and current_position <= item.count
	valid_max_stack: max_stack >= 0 and then max_stack < 65535
	exception_block_not_void: exception_block /= Void
	once_catch_block_not_void: once_catch_block /= Void
	once_finally_block_not_void: once_finally_block /= Void

end -- class MD_METHOD_BODY
