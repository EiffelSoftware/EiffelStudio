-- Warning: this is not a real server!

class
	CLASS_C_SERVER

inherit
	HASH_TABLE [ARRAY [CLASS_C], INTEGER]
		rename
			put as ht_put,
			remove as ht_remove,
			has as ht_has,
			make as ht_make,
			count as ht_count
		end

	SHARED_COUNTER
		undefine
			is_equal, copy
		end

	COMPILER_EXPORTER
		undefine
			is_equal, copy
		end

creation
	make

feature -- Initialization

	make is
			-- Create a new class server.
		do
			ht_make (Initial_size);
			!! current_classes.make (1, Chunk);
			ht_put (current_classes, System.compilation_id)
		end

	init_server is
			-- Initialize server before a new compilation.
		do
			!! current_classes.make (1, Chunk);
			ht_put (current_classes, System.compilation_id)
		end

feature -- Access

	has (id: CLASS_ID): BOOLEAN is
			-- Is there a class associated with `id'?
		require
			id_not_void: id /= Void
		do
			Result := id.associated_class /= Void
		end

	count: INTEGER
			-- Number of classes

feature -- Element change

	put (class_c: CLASS_C; id: CLASS_ID) is
			-- Insert `class_c' at key `id'.
		require
			class_c_not_void: class_c /= Void
			id_not_void: id /= Void
			valid_id: id.compilation_id = System.compilation_id
		local
			internal_id: INTEGER
		do
			internal_id := id.internal_id
			if current_classes.upper < internal_id then
				current_classes.resize (1, internal_id + Chunk)
			end
			current_classes.put (class_c, internal_id)
			count := count + 1
		ensure
			inserted: id.associated_class = class_c
		end
	
	remove (id: CLASS_ID) is
			-- Remove class with `id'.
		require
			id_not_void: id /= Void
			removable: id.compilation_id = System.compilation_id
		local
			internal_id: INTEGER
		do
			current_classes.put (Void, id.internal_id)
			count := count - 1
		ensure
			removed: not has (id)
		end
			
feature -- Merging

	append (other: like Current) is
			-- Append classes of `other' to `Current'.
		require
			other_not_void: other /= Void
		local
			i, nb: INTEGER;
			precomp_id: INTEGER;
			old_cursor: CURSOR;
			a_class: CLASS_C;
			other_class_array, class_array: ARRAY [CLASS_C]
			common_classes: HASH_TABLE [ARRAY [CLASS_C], INTEGER]
		do
			old_cursor := other.cursor;
			!! common_classes.make (other.ht_count);
			from
				other.start
			until
				other.after
			loop
				precomp_id := other.key_for_iteration;
				class_array := other.item_for_iteration
				if ht_has (precomp_id) then
					common_classes.put (class_array, precomp_id)
				else
					ht_put (class_array, precomp_id);
					nb := Class_counter.item (precomp_id).count
					from i := 1 until i > nb loop
						if class_array.item (i) /= Void then
							count := count + 1
						end
						i := i + 1
					end
				end
				other.forth
			end;
			other.go_to (old_cursor);
				-- Merge contents of common classes only here because
				-- descencant classes (in CLASS_C) must have already
				-- been inserted into the server. 
			from common_classes.start until common_classes.after loop
				other_class_array := common_classes.item_for_iteration;
				precomp_id := common_classes.key_for_iteration;
				class_array := item (precomp_id);
				nb := Class_counter.item (precomp_id).count
				from i := 1 until i > nb loop
					a_class := class_array.item (i);
					if a_class /= Void then
						a_class.merge (other_class_array.item (i))
					end;
					i := i + 1
				end
				common_classes.forth
			end
		end

feature {NONE} -- Implementation

	current_classes: ARRAY [CLASS_C]
			-- Classes of current compilation unit

	Chunk: INTEGER is 150
			-- Chunk size of class arrays

	Initial_size: INTEGER is 5
			-- Hash table initial size
		
end -- class CLASS_C_SERVER
