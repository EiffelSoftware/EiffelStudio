
-- Class which provides various features to store and retrieve
-- compact representations of context tree structures
-- The conversion between TWO_WAY_TREE-structures and their compact
-- equivalent is also handled here.

class CONTEXT_STORER  

inherit

	STORABLE_HDL
		export
			{NONE} all
		end;

	CONTEXT_SHARED
		export
			{NONE} all
		end;

	STORAGE_INFO
		export
			{NONE} all
		end;



	
feature {CONTEXT_STORER}

	stored_contexts: LINKED_LIST [EB_TABLE [S_CONTEXT]];

	
feature 

	retrieved_data: LINKED_LIST [CONTEXT];

	
feature {NONE}

	current_table: EB_TABLE [S_CONTEXT];

	
feature 

	store (file_name: STRING) is
		do
			build_stored_contexts;
			current_table := Void;
			retrieved := Void;
			store_by_name (file_name);
			stored_contexts := Void;
		end;

	
feature {NONE}

	build_stored_contexts is
		local
			old_pos: INTEGER
		do
			!!stored_contexts.make;
			from
				old_pos := window_list.index;
				window_list.start
			until
				window_list.after
			loop
				!!current_table.make (100);
				stored_contexts.extend (current_table);
				build_stored_context (window_list.item);
				--****current_table.trim;
				window_list.forth
			end;
			window_list.go_i_th (old_pos)
		end;

	build_stored_context (node: CONTEXT) is
		do
			current_table.put (node.stored_node);
			from
				node.child_start
			until
				node.child_offright
			loop
				build_stored_context (node.child);
				node.child_forth
			end;
		end;

	
feature 

	retrieve (file_name: STRING) is
		local
			void_parent: COMPOSITE_C;
		do
			retrieve_by_name (file_name);
			stored_contexts := retrieved.stored_contexts;
			!!retrieved_data.make;
			from
				stored_contexts.start;
			until
				stored_contexts.after
			loop
				index := 1;
				current_table := stored_contexts.item;
				retrieved_data.extend (context_tree (void_parent));
				stored_contexts.forth
			end;
		end;

	
feature {NONE}

	index: INTEGER;

	context_tree (a_parent: COMPOSITE_C): CONTEXT is
		local
			arity, counter: INTEGER;
			s_context: S_CONTEXT;
			temp: COMPOSITE_C;
			temp_wind: S_TEMP_WIND
		do
			s_context := current_table.item (index);
			temp_wind ?= s_context;
			arity := s_context.arity;
			if temp_wind = Void then
				Result := s_context.context (a_parent);
			else
				temp := find_parent (temp_wind.parent_name);
				Result := s_context.context (temp);
			end;
			context_table.put (Result, s_context.identifier);
			temp ?= Result;
			from
				counter := 1
			until
				counter > arity
			loop
				index := index + 1;
				Result.put_child_right (context_tree (temp));
				Result.child_forth;
				counter := counter + 1
			end;
			--s_context.post_process;
		end;

	find_parent (parent_name: STRING): COMPOSITE_C is
		do
			from 
				retrieved_data.start
			until
				retrieved_data.after or else Result /= Void
			loop
				if parent_name.is_equal (retrieved_data.item.entity_name) then
					Result ?= retrieved_data.item;
				end;
				retrieved_data.forth;
			end;

		debug ("storer")
			io.putstring (Result.entity_name);
			io.new_line;
		end;

			
		end;



end 
