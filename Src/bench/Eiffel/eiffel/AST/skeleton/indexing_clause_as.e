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
		local
			i: INDEX_AS
			list: EIFFEL_LIST [ATOMIC_AS]
			s: STRING_AS
		do
			i := find_index_as (description_header)
			
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
		
	external_name: STRING is
			-- Name of entity holding current indexing clause as seen from
			-- external world.
		local
			i: INDEX_AS
			s: STRING_AS
		do
			i := find_index_as (external_header)
			
			if i /= Void then
					-- Do not care if more than one element has been added
					-- to current INDEX_AS list, we take the first one and
					-- forget about the remaining ones.
				s ?= i.index_list.first
				if s /= Void then
					Result := s.value
				end
			end
		ensure
			return_same_object: Result = external_name
		end

	custom_attribute: EIFFEL_LIST [CREATION_EXPR_AS] is
			-- Expression representing a custom attribute
		local
			i: INDEX_AS
			ca: CUSTOM_ATTRIBUTE_AS
			list: EIFFEL_LIST [ATOMIC_AS]
		do
			i := find_index_as (attribute_header)
			
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
			i := find_index_as (once_status_header)

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
			i := find_index_as (enum_type_header)

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

	external_header: STRING is "external_name"
			-- Index name of entity holding current indexing clause.

	attribute_header: STRING is "attribute"
			-- Index name of entity holding current indexing clause.
			
	description_header: STRING is "description"
			-- Index name of entity holding current indexing clause.

	once_status_header: STRING is "once_status"
			-- Index name of entity holding current indexing clause.

	enum_type_header: STRING is "enum_type"

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

end -- class FEATURE_LIST_AS
