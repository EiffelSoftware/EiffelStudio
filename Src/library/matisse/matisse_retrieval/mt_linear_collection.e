indexing
	description: "MATISSE-Eiffel Binding"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MT_LINEAR_COLLECTION [G -> MT_STORABLE]

inherit
	MT_OBJECT_EXTERNAL
		export 
			{NONE} all
		end

feature -- Status

	is_persistent: BOOLEAN is
		deferred
		end
		
	count: INTEGER is
		deferred
		end

	successors_loaded: BOOLEAN is
		deferred
		end
	
feature -- Stream

	open_stream: MT_RELATIONSHIP_STREAM is
		require
			predecessor_and_relationship_not_void: is_persistent
		do
			!! Result.make (predecessor, relationship)
		end
				
feature {NONE} -- Element change

	mt_append (new_successor: G) is
			-- Store new successor to OOS.
		do
			if is_persistent then
				c_add_successor_append (predecessor.oid, relationship.oid, new_successor.oid)
			end
		end
	
	mt_add_first (new_successor: G) is
			-- Store new successor to OOS.
		do
			if is_persistent then
				c_add_successor_first (predecessor.oid, relationship.oid, new_successor.oid)
			end
		end
	
	mt_add_after (new_successor, after_this_object: G) is
			-- Store new successor to OOS.
		do
			if is_persistent then
				c_add_successor_after (predecessor.oid, relationship.oid,
					new_successor.oid, after_this_object.oid)
			end
		end
	
	mt_add_all is
			-- Append all the successors.
		local
			linear_rep: LINEAR [G]
		do
		   if is_persistent then
			linear_rep := linear_representation
			from
				linear_rep.start
			until
				linear_rep.off
			loop
				mt_append (linear_rep.item)
				linear_rep.forth
			end
		   end
		end

	mt_set_all is
		local
			linear_rep: LINEAR [G]
			succ_oids: ARRAY [INTEGER]
			i: INTEGER
		do
			if is_persistent then
				linear_rep := linear_representation
				!! succ_oids.make (0, count - 1)
			
				from
					linear_rep.start
					i := 0
				until
					linear_rep.off
				loop
					succ_oids.put (linear_rep.item.oid, i)
					linear_rep.forth
					i := i + 1
				end
			
				c_set_successors (predecessor.oid, relationship.oid, 
						succ_oids.count, $succ_oids)
			end
		end

	mt_remove (a_successor: G) is
			-- Remove a successor.
		do
			if is_persistent then
				c_remove_successor (predecessor.oid, relationship.oid, a_successor.oid)
			end
		end
	
	mt_remove_all is
			-- Remove all successors.
		do
			if is_persistent then
				c_remove_all_successors (predecessor.oid, relationship.oid)
			end
		end

	mt_remove_ignore_nosuchsucc (a_successor: G) is
			-- Remove a successor.
			-- Ignoring the error MATISSE_NOSUCHSUCC.
		do
			if is_persistent then
				c_remove_successor_ignore_NOSUCHSUCC
					 (predecessor.oid, relationship.oid, a_successor.oid)
			end
		end

feature {MT_RELATIONSHIP, MATISSE} -- Conversion

	linear_representation: LINEAR [G] is
		deferred
		end

feature -- Loading

	mt_put_at_loading (new: G; i: INTEGER) is
			-- Put the new item which is at the i-th position in the relationship.
			-- Some descendant classes ignore the argument 'i'.
		deferred
		end

	mt_resize_at_loading (new_size: INTEGER) is
		deferred
		end

feature {NONE} -- Implementation

	predecessor: MT_STORABLE is
		deferred
		end
	
	relationship: MT_RELATIONSHIP is
		deferred
		end

end -- class MT_LINEAR_COLLECTION
