indexing
	description: "Represents a Matisse index."

class 
	MT_INDEX

inherit 
	MT_METASCHEMA
	
	MT_INDEX_EXTERNAL
		undefine 
			is_equal 
		end

	MT_CONSTANTS
		undefine 
			is_equal 
		end

Creation 
	make

feature {NONE} -- Initilization

	make (arg_name: STRING) is
			-- Get index from name
		require
			arg_name_not_void: arg_name /= Void
			arg_name_not_empty: not arg_name.is_empty
		local
			c_index_name: ANY
			a_criterion: MT_INDEX_CRITERION
			a_class: MT_CLASS
			i, num_classes: INTEGER
			index_name: STRING
		do	
			index_name := Clone (arg_name)
			c_index_name := index_name.to_c
			oid := c_get_index ($c_index_name)
			c_load_index_info (oid)
			
			criteria_count := c_get_index_criteria_count
			!! criteria.make (0, criteria_count - 1)
			from
				i := 0
			until
				i = criteria_count
			loop
				!! a_criterion.make (
					c_get_index_criterion_attr_oid (i),
					c_get_index_criterion_type (i),
					c_get_index_criterion_size (i),
					c_get_index_criterion_order (i))
				criteria.put (a_criterion, i)
				i := i + 1
			end
			
			num_classes := c_get_index_classes_count
			!! classes.make (0, num_classes - 1)
			from
				i := 0
			until
				i = num_classes
			loop
				a_class ?= current_db.eif_object_from_oid (c_get_index_class(i))
				classes.put (a_class, i)
				i := i + 1
			end
			scan_direction := Mt_Direct
		end -- make

feature -- Status Report

	entries_count: INTEGER is 
			-- The number of entries in the index.
			-- Not implemented
		do
			Result := c_index_entries_count (oid)
		end -- entries_count

	criteria_count: INTEGER -- Number of criteria

	classes_count: INTEGER is
			-- Number of classes in the index
		do
			Result := classes.count
		end
	
	classes: ARRAY [MT_CLASS]

	stream_opened: BOOLEAN is
		do
			Result := stream /= void
		end

feature -- Access
	
	criteria: ARRAY [MT_INDEX_CRITERION] 
		-- Criterions of current index

feature -- Stream

	open_stream: MT_INDEX_STREAM is
		do
			!! stream.make_from_index (Current)
			Result := stream
		end

feature -- Criterion value

	scan_direction: INTEGER
		-- Mt_Reverse or Mt_Direct.
	
	constraint_class: MT_CLASS
	
feature -- Setting criterion

	set_scan_direction (direction: INTEGER) is
		require
			direction = Mt_Reverse or else direction = Mt_Direct
		do
			scan_direction := direction
		end
	
	set_class (a_class: MT_CLASS) is
		do
			constraint_class := a_class
		end

feature {MT_INDEX_STREAM} -- Implementation

	stream: MT_INDEX_STREAM
		-- Stream of objects in Index.

invariant
	consistent_criteria: criteria.count = criteria_count

end -- class MT_INDEX
