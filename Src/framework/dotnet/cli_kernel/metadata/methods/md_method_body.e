note
	description: "Body of an Eiffel method."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_METHOD_BODY

inherit
	MD_SHARED_OPCODES

create
	make

feature {NONE} -- Initialization

	make (token: INTEGER)
			-- Create new instance ready to be updated.
		require
			is_method_token:
				token & {MD_TOKEN_TYPES}.Md_mask = {MD_TOKEN_TYPES}.Md_method_def
		do
			create item.make (Chunk_size)
			create labels.make_empty
			create labels_stack_depth.make_empty
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

	remake (token: like method_token)
			-- Reuse current object for body of method `token'.
		require
			is_method_token:
				token & {MD_TOKEN_TYPES}.Md_mask = {MD_TOKEN_TYPES}.Md_method_def
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
			old_exception_catch_blocks := Void
			current_old_expression_block_position := 0
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

	count: INTEGER
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

	old_exception_catch_blocks: detachable ARRAY [MD_EXCEPTION_CATCH]
			-- Exception clause for catching exception for old expression evaluation.

	current_old_exception_catch_block: detachable MD_EXCEPTION_CATCH
			-- Current old exception catch block
		do
			if attached old_exception_catch_blocks as l_old_exception_catch_blocks then
				Result := l_old_exception_catch_blocks.item (current_old_expression_block_position)
			end
		end

feature -- Status report

	has_locals: BOOLEAN
			-- Has current body some local variables?
		do
			Result := local_token /= 0
		end

	has_exceptions_handling: BOOLEAN
			-- Has an exception block completely defined?
		do
			Result := exception_block.is_defined or else
					once_catch_block.is_defined or else
					once_finally_block.is_defined or else
					is_old_exception_catch_blocks_defined
		end

	is_old_exception_catch_blocks_defined: BOOLEAN
			-- Has old expression evaluation exception block defined?
		local
			i: INTEGER
		do
			if attached old_exception_catch_blocks as l_old_exception_catch_blocks and then
				l_old_exception_catch_blocks.count /= 0
			then
				from
					i := l_old_exception_catch_blocks.lower
				until
					i > l_old_exception_catch_blocks.upper or Result
				loop
					Result := Result or l_old_exception_catch_blocks.item (i).is_defined
					i := i + 1
				end
			end
		end

	is_written: BOOLEAN
			-- Has current body been already written into memory?
			-- If yes, no further update operations are allowed.

	nb_labels: INTEGER
			-- Current number of defined labels for current body.

	is_last_old_expression_exception_block: BOOLEAN
			-- Is `current_old_exception_catch_block' the last one?
		do
			Result := attached old_exception_catch_blocks as l_old_exception_catch_blocks
					and then (current_old_expression_block_position = l_old_exception_catch_blocks.upper)
		end

feature -- Savings

	write_to_stream (m: MANAGED_POINTER; pos: INTEGER)
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

	set_local_token (token: like local_token)
			-- Set a local signature token to current body.
		require
			not_yet_written: not is_written
		do
			local_token := token
		ensure
			local_token_set: local_token = token
		end

	update_stack_depth (delta: INTEGER)
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

	create_old_exception_catch_blocks (a_count: INTEGER)
			-- Create `a_count' old exception catch blocks
		local
			l_block: MD_EXCEPTION_CATCH
			i: INTEGER
			l_old_exception_catch_blocks: like old_exception_catch_blocks
		do
			create l_block.make
			create l_old_exception_catch_blocks.make_filled (l_block, 0, a_count - 1)
			old_exception_catch_blocks := l_old_exception_catch_blocks
			from
				i := 1
			until
				i >= a_count
			loop
				create l_block.make
				l_old_exception_catch_blocks.put (l_block, i)
				i := i + 1
			end
		ensure
			old_exception_catch_blocks_not_void: attached old_exception_catch_blocks as el_blocks
			old_exception_catch_blocks_created: el_blocks.count = a_count
		end

	forth_old_expression_exception_block
			-- Go to next old expression exception block
		require
			old_expression_exception_block_not_last: not is_last_old_expression_exception_block
		do
			current_old_expression_block_position := current_old_expression_block_position + 1
		end

feature -- Opcode insertion

	put_nop
			-- Insert `nop'.
		require
			not_yet_written: not is_written
		do
			internal_put ({MD_OPCODES}.nop.to_integer_8, current_position)
			current_position := current_position + 1
		end

	put_throw
			-- Insert `throw' opcode.
		require
			not_yet_written: not is_written
		do
			put_opcode ({MD_OPCODES}.throw)
			last_current_stack_depth := -1
		end

	put_rethrow
			-- Insert `rethrow' opcode.
		require
			not_yet_written: not is_written
		do
			put_opcode ({MD_OPCODES}.rethrow)
			last_current_stack_depth := -1
		end

	put_opcode (opcode: INTEGER_16)
			-- Insert `opcode'.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		local
			l_pos, l_incr: INTEGER
			l_stack_transition: INTEGER
		do
			check attached opcodes.item (opcode) as l_opcodes_item then
				l_stack_transition := l_opcodes_item.stack_depth_transition
			end

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

	put_string (string_token: INTEGER)
			-- Generate `ldstr' instruction.
		require
			not_yet_written: not is_written
		do
			put_opcode ({MD_OPCODES}.Ldstr)
			add_integer (string_token)
		end

	put_opcode_mdtoken (opcode: INTEGER_16; token: INTEGER)
			-- Insert `opcode' manipulating a metadata token.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			add_integer (token)
		end

	put_opcode_natural_8 (opcode: INTEGER_16; n: NATURAL_8)
			-- Insert `opcode' manipulating an integer.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			internal_put (n.as_integer_8, current_position)
			current_position := current_position + 1
		end

	put_opcode_natural_16 (opcode: INTEGER_16; n: NATURAL_16)
			-- Insert `opcode' manipulating an integer.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			add_natural_16 (n)
		end

	put_opcode_natural_32 (opcode: INTEGER_16; n: NATURAL_32)
			-- Insert `opcode' manipulating a natural.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			add_natural_32 (n)
		end

	put_opcode_natural_64 (opcode: INTEGER_16; n: NATURAL_64)
			-- Insert `opcode' manipulating an natural 64.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			add_natural_64 (n)
		end

	put_opcode_integer_8 (opcode: INTEGER_16; i: INTEGER_8)
			-- Insert `opcode' manipulating an integer.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			internal_put (i, current_position)
			current_position := current_position + 1
		end

	put_opcode_integer_16 (opcode: INTEGER_16; i: INTEGER_16)
			-- Insert `opcode' manipulating an integer.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			add_integer_16 (i)
		end

	put_opcode_integer (opcode: INTEGER_16; i: INTEGER)
			-- Insert `opcode' manipulating an integer.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			add_integer (i)
		end

	put_opcode_integer_64 (opcode: INTEGER_16; i: INTEGER_64)
			-- Insert `opcode' manipulating an integer 64.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			add_integer_64 (i)
		end

	put_opcode_real_32 (opcode: INTEGER_16; r: REAL)
			-- Insert `opcode' manipulating a real.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			add_real_32 (r)
		end

	put_opcode_real_64(opcode: INTEGER_16; d: DOUBLE)
			-- Insert `opcode' manipulating a double.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			add_real_64 (d)
		end

feature -- Labels manipulation

	define_label: INTEGER
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

	mark_label (label_id: INTEGER)
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

	put_opcode_label (opcode: INTEGER_16; label_id: INTEGER)
			-- Insert `opcode' branching to `label'
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			put_opcode (opcode)
			put_label (label_id, 0)
		end

	put_label (label_id: INTEGER; offset: INTEGER)
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

	set_branch_location (branch_inst_pos: INTEGER; jump_offset: INTEGER)
			-- Update code at `branch_inst_pos' with new jump value `jump_offset'.
		require
			valid_pos: branch_inst_pos > 0 and branch_inst_pos + 4 <= count
		do
			item.put_integer_32_le (item.read_integer_32_le (branch_inst_pos) + jump_offset, branch_inst_pos)
		end

feature -- Opcode insertion with manual update of `current_stack_depth'.

	put_static_call (feature_token, nb_arguments: INTEGER; is_function: BOOLEAN)
			-- Perform a static call to `feature_token' with proper stack size computation.
		require
			not_yet_written: not is_written
		do
			internal_put_call ({MD_OPCODES}.call, feature_token,
				nb_arguments, is_function, False)
		end

	put_call (opcode: INTEGER_16; feature_token, nb_arguments: INTEGER; is_function: BOOLEAN)
			-- Perform call to `feature_token' with proper stack size computation.
		require
			not_yet_written: not is_written
			has_opcodes: opcodes.has (opcode)
		do
			internal_put_call (opcode, feature_token, nb_arguments, is_function, True)
		end

	put_newobj (constructor_token: INTEGER; nb_arguments: INTEGER)
			-- Perform creation of object through `constructor_token'
			-- with proper stack size computation.
		require
			not_yet_written: not is_written
		do
			internal_put_call ({MD_OPCODES}.newobj, constructor_token,
				nb_arguments, True, False)
		end

feature {NONE} -- Implementation

	internal_put_call (opcode: INTEGER_16; feature_token, nb_arguments: INTEGER; is_function, needs_current: BOOLEAN)
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

	add_natural_16 (val: NATURAL_16)
			-- Add `val' to current.
		require
			not_yet_written: not is_written
		local
			l_val: NATURAL_16
			l_pos: INTEGER
		do
			l_val := val
			l_pos := current_position
			internal_put ((l_val & 0x00FF).to_integer_8, l_pos)
			l_val := l_val |>> 8
			internal_put ((l_val & 0x00FF).to_integer_8, l_pos + 1)
			current_position := l_pos + 2
		end

	add_natural_32 (val: NATURAL_32)
			-- Add `val' to current.
		require
			not_yet_written: not is_written
		local
			l_val: NATURAL_32
			l_pos: INTEGER
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

	add_natural_64 (val: NATURAL_64)
			-- Add `val' to current.
		require
			not_yet_written: not is_written
		local
			l_val: NATURAL_64
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

	add_integer_16 (val: INTEGER_16)
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

	add_integer (val: INTEGER)
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

	add_integer_64 (val: INTEGER_64)
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

	add_real_32 (val: REAL)
			-- Add `val' to current.
		require
			not_yet_written: not is_written
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 4)
			item.put_real_32_le (val, l_pos)
			current_position := l_pos + 4
		end

	add_real_64 (val: DOUBLE)
			-- Add `val' to current.
		require
			not_yet_written: not is_written
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 8)
			item.put_real_64_le (val, l_pos)
			current_position := l_pos + 8
		end

	internal_put (val: INTEGER_8; pos: INTEGER)
			-- Safe insertion that will resize `item' if needed.
		require
			not_yet_written: not is_written
			valid_pos: pos >= 0
		do
			allocate (pos + 1)
			item.put_integer_8_le (val, pos)
		end

feature {NONE} -- Stack depth management

	allocate (new_size: INTEGER)
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

	current_old_expression_block_position: INTEGER
			-- Current position of `old_exception_catch_blocks'

	last_current_stack_depth: INTEGER
			-- Depth at the previous IL offset. Used for checking that
			-- our generated code is indeed valid.

	Chunk_size: INTEGER = 50
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

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
