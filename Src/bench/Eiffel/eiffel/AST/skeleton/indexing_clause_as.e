indexing
	description: "Representation of an indexing clause"
	date: "$Date$"
	revision: "$Revision$"

class
	INDEXING_CLAUSE_AS

inherit
	EIFFEL_LIST [INDEX_AS]
		export
			{NONE} all
			{ANY} is_empty
		redefine
			make, extend
		end

create
	make

feature -- Initialization

	make (n: INTEGER) is
			-- Allocate list with `n' items.
			-- (`n' may be zero for empty list.)
		do
			Precursor {EIFFEL_LIST} (n)
			create lookup_table.make (n)
		end

feature -- Access

	description: STRING is
			-- Description.
		do
			Result := string_value (Description_header)
		end
	
	assembly_name: ARRAY [STRING] is
			-- Assembly name (for external classes only)
			-- Name, Version, Culture and Public key in that order
		local
			i: INDEX_AS
			list: EIFFEL_LIST [ATOMIC_AS]
			a_string: STRING_AS
		do
			i := find_index_as (Assembly_header)
			
			if i /= Void then
				list := i.index_list
				from
					list.start
					create Result.make (1, list.count)
				until
					list.after
				loop
					a_string ?= list.item
					if a_string /= Void then
						Result.put (a_string.value, list.index)
					end
					list.forth
				end
			end			
		end
		
	external_name: STRING is
			-- Name of entity holding current indexing clause as seen from
			-- external world.
		do
			Result := string_value (External_header)
		end

	custom_attribute: EIFFEL_LIST [CREATION_EXPR_AS] is
			-- Expression representing a custom attribute
		local
			i: INDEX_AS
			ca: CUSTOM_ATTRIBUTE_AS
			list: EIFFEL_LIST [ATOMIC_AS]
		do
			i := find_index_as (Attribute_header)
			
			if i /= Void then
					-- Do not care if more than one element has been added
					-- to current INDEX_AS list, we take the first one and
					-- forget about the remaining ones.
				list := i.index_list
				if not list.is_empty then
					from
						list.start
						create Result.make (list.count)
					until
						list.after
					loop
						ca ?= list.item
						if ca /= Void then
							Result.extend (ca.creation_expr)
						end
						list.forth
					end
				end
			end			
		end

	has_global_once: BOOLEAN is
			-- Is current once construct used to be a global once in
			-- multithreaded context?
		local
			i: INDEX_AS
			s: STRING_AS
			list: EIFFEL_LIST [ATOMIC_AS]
		do
			i := find_index_as (Once_status_header)

			if i /= Void then
				list := i.index_list
				if not list.is_empty then
					from
						list.start
					until
						list.after or Result
					loop
						s ?= list.item
						Result := s /= Void and then s.value.is_equal ("global")
						list.forth
					end
				end
			end			
		end

	enum_type: STRING is
			-- Is current once construct used to be a global once in
			-- multithreaded context?
		local
			i: INDEX_AS
			s: STRING_AS
			list: EIFFEL_LIST [ATOMIC_AS]
		do
			i := find_index_as (Enum_type_header)

			if i /= Void then
				list := i.index_list
				if not list.is_empty then
					from
						list.start
					until
						list.after or Result /= Void
					loop
						s ?= list.item
						if s /= Void then
							Result := s.value
						end
						list.forth
					end
				end
			end			
		end

feature -- Element change

	extend (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		do
			Precursor {EIFFEL_LIST} (v)
			if v.tag /= Void then
				lookup_table.force (v, v.tag)
			end
		end

feature -- Constants

	External_header: STRING is "external_name"
			-- Index name of entity holding current indexing clause.

	Attribute_header: STRING is "attribute"
			-- Index name of entity holding current indexing clause.
			
	Description_header: STRING is "description"
			-- Index name of entity holding current indexing clause.

	Assembly_header: STRING is "assembly"
			-- Index name of entity holding current indexing clause.

	Once_status_header: STRING is "once_status"
			-- Index name of entity holding current indexing clause.

	Enum_type_header: STRING is "enum_type"

feature {NONE} -- Implementation

	lookup_table: HASH_TABLE [INDEX_AS, STRING]
			-- Fast lookup table for indexing clauses

	find_index_as (tag: STRING): INDEX_AS is
			-- Find INDEX_AS object holding `tag'
			-- Void if not found.
		require
			tag_not_void: tag /= Void
			tag_not_empty: not tag.is_empty
		do
			Result := lookup_table.item (tag)
		ensure
			found_return_same_object: Result /= Void implies Result = find_index_as (tag)
		end

	string_value (tag: STRING): STRING is
			-- String associated with `tag'
			-- Void if not a string or not tag `tag'
		local
			i: INDEX_AS
			list: EIFFEL_LIST [ATOMIC_AS]
			s: STRING_AS
		do
			i := find_index_as (tag)
			
			if i /= Void then
				list := i.index_list
				create Result.make (20)
				from
					list.start
				until
					list.after
				loop
					s ?= list.item
					if s /= Void then
						Result.append (s.value)
					end
					list.forth
					if not list.after and s /= Void then
						Result.append (", ")
					end
				end				
			end
		end
		
end -- class FEATURE_LIST_AS
