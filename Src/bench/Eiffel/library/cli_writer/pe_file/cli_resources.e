indexing
	description: "Container for manifest resources binary stored in memory."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_RESOURCES

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize new instance of CLI_RESOURCES.
		do
			create resources.make (2)
		end

feature -- Access

	item: MANAGED_POINTER is
			-- Concatenation of all resources.
		do
			if not resources.is_empty then
				from
					resources.start
					Result := resources.item.twin
					resources.forth
				until
					resources.after
				loop
					Result.append (resources.item)
					resources.forth
				end
			end
		ensure
			item_valid: not resources.is_empty implies Result /= Void
		end
		
feature -- Status report

	count: INTEGER is
			-- Size of all resources.
		do
			from
				resources.start
			until
				resources.after
			loop
				Result := Result + resources.item.count
				resources.forth
			end
		ensure
			count_positive: Result >= 0
		end

	i_th_position (i: INTEGER): INTEGER is
			-- Position of `i'-th resource in memory.
		require
			valid_index: valid_index (i)
		local
			j: INTEGER
		do
			from
				resources.start
				j := 1
			until
				j = i
			loop
				Result := Result + resources.item.count
				resources.forth
				j := j + 1
			end
		ensure
			i_th_position_positive: Result >= 0
		end

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' a valid index?
		do
			Result := resources.valid_index (i)
		end
	
feature -- Settings

	extend (p: MANAGED_POINTER) is
			-- Convenience feature.
		do
			resources.extend (p)
		ensure
			inserted: resources.has (p)
		end		

feature {NONE} -- Implementation: Access

	resources: ARRAYED_LIST [MANAGED_POINTER]
			-- List of all recorded resources.

invariant
	resources_not_void: resources /= Void
	resources_compare_references: not resources.object_comparison

end -- class CLI_RESOURCES
