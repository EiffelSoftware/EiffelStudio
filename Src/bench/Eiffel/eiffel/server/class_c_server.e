indexing
	description: "Server to keep track of all classes in system.%
				%Warning: this is not a real server!%
				%Indexed by class id."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_C_SERVER

inherit
	ARRAY [CLASS_C]
		rename
			put as array_put,
			has as array_has,
			make as array_make,
			count as array_count
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
			array_make (1, Chunk)
			!! sorted_classes.make (1, Chunk)
		end

feature -- Access

	sorted_classes: ARRAY [CLASS_C]
			-- Classes sorted by topological id

feature -- Status report

	has (id: INTEGER): BOOLEAN is
			-- Is there a class associated with `id'?
		require
			id_not_void: id > 0
		do
			Result := id <= upper and then item (id) /= Void
		end

feature -- Measurement

	count: INTEGER
			-- Number of classes

feature -- Element change

	put (class_c: CLASS_C; id: INTEGER) is
			-- Insert `class_c' at key `id'.
		require
			class_c_not_void: class_c /= Void
			id_not_void: id > 0
			not_has_id: not has (id)
		local
			class_id: INTEGER
		do
 			class_id := id
 			if upper < class_id then
 				resize (1, class_id + Chunk)
				sorted_classes.resize (1, class_id + Chunk)
 			end
 			array_put (class_c, class_id)
			sorted_classes.put (class_c, class_c.topological_id)
 			count := count + 1
		ensure
			inserted: item (id) = class_c
		end

feature -- Removal

	remove (id: INTEGER) is
			-- Remove class with `id'.
		require
			id_not_void: id > 0
			has_id: has (id)
		local
			a_class: CLASS_C
		do
			a_class := item (id)
			sorted_classes.put (Void, a_class.topological_id)
			array_put (Void, id)
			count := count - 1
		ensure
			removed: not has (id)
		end

feature -- Sort

	sort is
			-- Sort `sorted_classes' by topological ids.
		local
			i, nb: INTEGER
			a_class: CLASS_C
		do
			from
				i := 1
				nb := sorted_classes.upper
			until
				i > nb
			loop
				sorted_classes.put (Void, i)
				i := i + 1
			end
			from
				i := 1
				nb := count
			until
				nb = 0
			loop
				a_class := item (i)
				if a_class /= Void then
					sorted_classes.put (a_class, a_class.topological_id)
					nb := nb - 1
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	Chunk: INTEGER is 150
			-- Chunk size of class arrays

invariant

	sorted_classes_not_void: sorted_classes /= Void

end -- class CLASS_C_SERVER
