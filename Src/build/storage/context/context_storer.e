indexing
	description: "Class used to store context tree structures."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	note: "The conversion between TWO_WAY_TREE-structures and their compact%
			% equivalent is also handled here."

class CONTEXT_STORER

inherit
	STORABLE_HDL

	SHARED_CONTEXT

	SHARED_STORAGE_INFO

feature {CONTEXT_STORER}

	stored_contexts: LINKED_LIST [EB_TABLE [S_CONTEXT]]

feature -- Access

	retrieved_data: LINKED_LIST [CONTEXT]

	file_name: STRING is 
		do
			Result := Environment.interface_file_name
		end

	tmp_store (dir_name: STRING) is
		require
			valid_dir_name: dir_name /= Void
		do
			build_stored_contexts
			current_table := Void
			retrieved := Void
			tmp_store_by_name (dir_name)
			stored_contexts := Void
		end

	retrieve (dir_name: STRING) is
		do
			retrieve_by_name (dir_name)
			stored_contexts := retrieved.stored_contexts
			debug ("STORER")
				io.error.putstring ("RETRIEVING CONTEXT%N")
			end
			create retrieved_data.make
			from
				stored_contexts.start
			until
				stored_contexts.after
			loop
				index := 1
				current_table := stored_contexts.item
				retrieved_data.extend (context_tree (Void))
				stored_contexts.forth
			end
		end

feature {NONE} -- Implementation

	current_table: EB_TABLE [S_CONTEXT]

	build_stored_contexts is
		local
			old_cursor: CURSOR
		do
			create stored_contexts.make
			from
				old_cursor := Shared_window_list.cursor
				Shared_window_list.start
			until
				Shared_window_list.after
			loop
				create current_table.make (30)
				stored_contexts.extend (current_table)
				build_stored_context (Shared_window_list.item)
				Shared_window_list.forth
			end
			Shared_window_list.go_to (old_cursor)
		end

	build_stored_context (node: CONTEXT) is
		do
			current_table.put (node.stored_node)
			from
				node.child_start
			until
				node.child_offright
			loop
				build_stored_context (node.child)
				node.child_forth
			end
		end

	index: INTEGER

	context_tree (a_parent: COMPOSITE_C): CONTEXT is
		local
			arity, counter: INTEGER
			s_context: S_CONTEXT
			temp: COMPOSITE_C
			temp_wind: S_TEMP_WIND
		do
			s_context := current_table.item (index)
			temp_wind ?= s_context
			arity := s_context.arity
			if temp_wind = Void then
				Result := s_context.context (a_parent)
			else
				temp := find_parent (temp_wind.parent_name)
				Result := s_context.context (temp)
			end
			debug ("STORER_CHECK")
				if context_table.has (s_context.identifier) then
					io.error.putstring ("**** Error: Context already exists: ")
					io.error.putstring (Result.full_name)
					io.error.putstring (" ****")
					io.error.putstring (" id: ")
					io.error.putint (s_context.identifier)
					io.error.new_line
				else
					io.error.putstring ("CT put: ")
					io.error.putstring (Result.full_name)
					io.error.putstring (" id: ")
					io.error.putint (Result.identifier)
					io.error.putstring (" old id: ")
					io.error.putint (s_context.identifier)
					if Result.is_in_a_group then
						io.error.putstring (" is in a group")
					end
					io.error.new_line
				end
			end
				-- Record the retrieved identifier
			context_table.put (Result, s_context.identifier)
			debug ("STORER") 
				s_context.trace
				io.error.new_line
			end
			temp ?= Result
			from
				counter := 1
			until
				counter > arity
			loop
				index := index + 1
				Result.put_child_right (context_tree (temp))
				Result.child_forth
				counter := counter + 1
			end
			--s_context.post_process
		end

	find_parent (parent_name: STRING): COMPOSITE_C is
		do
			from 
				retrieved_data.start
			until
				retrieved_data.after or else Result /= Void
			loop
				if parent_name.is_equal (retrieved_data.item.entity_name) then
					Result ?= retrieved_data.item
				end
				retrieved_data.forth
			end
		end

end -- class CONTEXT_STORER

