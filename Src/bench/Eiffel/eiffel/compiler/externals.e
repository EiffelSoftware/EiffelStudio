indexing
	description: "[
		Externals names used by system. Useful for controling
		introduction of a new external in system which trigger a freeze
		operation.
		]"
	date: "$Date$"
	revision: "$Revision$"

class EXTERNALS 

inherit
	EXTEND_TABLE [EXTERNAL_INFO, INTEGER]
		rename
			make as extend_table_make
		end
		
	SHARED_NAMES_HEAP
		export
			{NONE} all
		undefine
			copy, is_equal
		end

creation
	make

feature -- Initialization

	make is
		do
			extend_table_make (Chunk)
			duplicate
		end

feature -- Access

	duplication: like Current
			-- Duplication of current array

feature -- Status

	equiv: BOOLEAN is
			-- Check if current object is equivalent to
			-- duplication
		require
			duplication_exists: duplication /= Void
		do
			from
				Result := True
				start
			until
				after or else not Result
			loop
				Result := duplication.has (key_for_iteration) or else
						-- If name has been added and removed, no
						-- refreezing is needed.
					item_for_iteration.occurrence = 0
debug
	if not Result then
		io.error.putstring ("EXTERNALS.equiv: False on ")
		io.error.putstring (Names_heap.item (key_for_iteration))
		io.error.putstring (" duplication.has: ")
		io.error.putbool (duplication.has (key_for_iteration))
		io.error.putstring (" item_for_iteration.occurrence: ")
		io.error.putint (item_for_iteration.occurrence)
		io.error.new_line
	end
end
				forth
			end
		end
	
feature -- Basic operatios

	duplicate is
			-- Duplicate of Current object
		do
			duplication := clone (Current)
		end
	
	add_occurrence (external_name_id: INTEGER) is
			-- Add one occurrence of `external_name'.
		require
			good_argument: external_name_id > 0
		local
			info: EXTERNAL_INFO
		do
			info := item (external_name_id)
			if info = Void then
				create info
				put (info, external_name_id)
			end
			info.add_occurrence
debug
	io.error.putstring ("After add_occurrence (")
	io.error.putstring (Names_heap.item (external_name_id))
	io.error.putstring (")%N")
	trace
end
		end

	remove_occurrence (external_name_id: INTEGER) is
			--Remove one occurrence of `external_name'.
		require
			good_argument: 	external_name_id > 0
			has_occurrence:	has (external_name_id)
			--good_occurrence: item (external_name).occurrence > 0
		local
			info: EXTERNAL_INFO
		do
			info := item (external_name_id)
			if info.occurrence /= 0 then
				info.remove_occurrence
			end
debug
	io.error.putstring ("After remove_occurrence (")
	io.error.putstring (Names_heap.item (external_name_id))
	io.error.putstring (")%N")
	trace
end
		end

	freeze is
			-- Freeze external table
		local
			available_keys: like keys
			i, nb: INTEGER
			external_name_id: INTEGER
			info: EXTERNAL_INFO
		do
debug
	io.error.putstring ("Freezing externals%N")
	trace
end
			from
				available_keys := current_keys
				i := 1
				nb := available_keys.count
			until
				i > nb
			loop
				external_name_id := available_keys.item (i)
				info := item (external_name_id)
				if info.occurrence <= 0 then
					remove (external_name_id)
				else
					if info.is_valid then
						info.reset_real_body_id
					end
				end
				i := i + 1
			end
				-- Make a duplication
			duplicate
		end

feature {NONE} -- Constants

	Chunk: INTEGER is 50
			-- Array chunk

feature -- Merging

	append (other: like Current) is
			-- Add externals of `other' to `Current'.
			-- Used for precompilation merging.
		local
			external_name_id: INTEGER
		do
			from
				other.start
			until
				other.after
			loop
				external_name_id := other.key_for_iteration
				if has (external_name_id) then
					add_occurrence (external_name_id)
				else
					put (other.item_for_iteration, external_name_id)
				end
				other.forth
			end
			duplicate
		end

feature -- Debug

	trace is
		local
			available_keys: like keys
			i, nb: INTEGER
			external_name_id: INTEGER
			info: EXTERNAL_INFO
		do
			from
				io.error.putstring ("************** Externals ***************%N")
				available_keys := current_keys
				i := 1
				nb := available_keys.count
			until
				i > nb
			loop
				external_name_id := available_keys.item (i)
				info := item (external_name_id)
				io.error.putstring ("Function name: ")
				io.error.putstring (Names_heap.item (external_name_id))
				io.error.new_line
				io.error.putint (info.occurrence)
				io.error.new_line
				i := i + 1
			end
		end

end
