indexing
	description: "Representation of an indexing clause"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INDEXING_CLAUSE_AS

inherit
	EIFFEL_LIST [INDEX_AS]
		redefine
			process, make, first_token, last_token
		end

create
	make

create {INDEXING_CLAUSE_AS}
	make_filled

feature -- Initialization

	make (n: INTEGER) is
			-- Allocate list with `n' items.
			-- (`n' may be zero for empty list.)
		do
			Precursor {EIFFEL_LIST} (n)
			create lookup_table.make (n)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_indexing_clause_as (Current)
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- First token in current AST node
		do
			if a_list = Void then
				Result := Precursor{EIFFEL_LIST} (a_list)
			else
				Result := indexing_keyword.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- Last token in current AST node
		do
			if a_list = Void then
				Result := Precursor{EIFFEL_LIST} (a_list)
			else
				if end_keyword /= Void then
					Result := end_keyword.last_token (a_list)
				elseif not is_empty then
					Result := Precursor (a_list)
				else
					Result := indexing_keyword.last_token (a_list)
				end
			end
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

	custom_attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS] is
			-- Expression representing custom attributes.
		local
			l_list: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
		do
			Result := internal_custom_attributes (Metadata_header)
			if Result /= Void then
				l_list := internal_custom_attributes (Attribute_header)
				if l_list /= Void then
					Result.append (l_list)
				end
			else
				Result := internal_custom_attributes (Attribute_header)
			end
		end

	class_custom_attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS] is
			-- Expression representing custom attributes.
		local
			l_list: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
		do
			Result := internal_custom_attributes (Class_metadata_header)
			if Result /= Void then
				l_list := internal_custom_attributes (Class_attribute_header)
				if l_list /= Void then
					Result.append (l_list)
				end
			else
				Result := internal_custom_attributes (Class_attribute_header)
			end
		end

	interface_custom_attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS] is
			-- Expression representing custom attributes.
		local
			l_list: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
		do
			Result := internal_custom_attributes (Interface_metadata_header)
			if Result /= Void then
				l_list := internal_custom_attributes (Interface_attribute_header)
				if l_list /= Void then
					Result.append (l_list)
				end
			else
				Result := internal_custom_attributes (Interface_attribute_header)
			end
		end

	assembly_custom_attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS] is
			-- Expression representing custom attributes for an assembly
		local
			l_list: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
		do
			Result := internal_custom_attributes (Assembly_metadata_header)
			if Result /= Void then
				l_list := internal_custom_attributes (Assembly_attribute_header)
				if l_list /= Void then
					Result.append (l_list)
				end
			else
				Result := internal_custom_attributes (Assembly_attribute_header)
			end
		end

	has_global_once: BOOLEAN is
			-- Is current once construct used to be a global once in
			-- multithreaded context?
		local
			i: INDEX_AS
			s: STRING_AS
			l_id: ID_AS
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
						Result := s /= Void and then s.value.is_equal (Global_value)
						if not Result then
							l_id ?= list.item
							Result := l_id /= Void and then l_id.string_value.is_equal (Global_value)
						end
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

	update_lookup (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		require
			v_not_void: v /= Void
		local
			l_index: like item
		do
			if v.tag /= Void then
				lookup_table.search (v.tag)
				if lookup_table.found then
						-- Merge data from two similar `Index_clause' into one.
					l_index := lookup_table.found_item
					l_index.index_list.append (v.index_list)
				else
					create l_index.initialize (v.tag, v.index_list.twin, Void)
					lookup_table.put (l_index, l_index.tag)
				end
--				if obsolete_tags.has (v.tag) then
--					Error_handler.insert_warning (
--						create {OBSOLETE_INDEXING_TAG}.make (
--							System.current_class, v.tag,
--							obsolete_tags.item (v.tag), v.start_location))
--				end
			end
		end

feature {NONE} -- Constants

	External_header: STRING is "external_name"
			-- Index name which holds name as seen by other languages.

	Metadata_header: STRING is "metadata"
			-- Index name which holds custom attributes applied to both implementation
			-- and interface of current class.

	Class_metadata_header: STRING is "class_metadata"
			-- Index name which holds custom attributes applied to associated class only.

	Interface_metadata_header: STRING is "interface_metadata"
			-- Index name which holds custom attributes applied to associated interface only.

	Assembly_metadata_header: STRING is "assembly_metadata"
			-- Index name which holds custom attributes applied to associated assembly.
			-- They are only taken into account for the root_class.

	Attribute_header: STRING is "attribute"
			-- Index name which holds custom attributes applied to both implementation
			-- and interface of current class.

	Class_attribute_header: STRING is "class_attribute"
			-- Index name which holds custom attributes applied to associated class only.

	Interface_attribute_header: STRING is "interface_attribute"
			-- Index name which holds custom attributes applied to associated interface only.

	Assembly_attribute_header: STRING is "assembly_attribute"
			-- Index name which holds custom attributes applied to associated assembly.
			-- They are only taken into account for the root_class.

	Description_header: STRING is "description"
			-- Index name which holds class/feature desciption.

	Assembly_header: STRING is "assembly"
			-- Index name which holds name of assembly.

	Once_status_header: STRING is "once_status"
			-- Index name under which globalness of a once is specified.

	Enum_type_header: STRING is "enum_type"
			-- Type of enum elements.

	global_value: STRING is "global"
			-- Value name of `Once_status_header'.

	obsolete_tags: HASH_TABLE [STRING, STRING] is
			-- Table indexed by obsoleted indexing tag, where key is new indexing tag that
			-- should be used
		do
			create Result.make (5)
			Result.put (Metadata_header, attribute_header)
			Result.put (Class_metadata_header, Class_attribute_header)
			Result.put (Interface_metadata_header, Interface_attribute_header)
			Result.put (Assembly_metadata_header, Assembly_attribute_header)
		ensure
			obsolete_tags_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	internal_custom_attributes (tag: STRING): EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS] is
			-- Expression representing custom attributes.
		local
			i: INDEX_AS
			ca: CUSTOM_ATTRIBUTE_AS
			list: EIFFEL_LIST [ATOMIC_AS]
		do
			i := find_index_as (tag)

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
							Result.extend (ca)
						end
						list.forth
					end
				end
			end
		end

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

feature -- Roundtrip

	indexing_keyword: KEYWORD_AS
			-- Keyword "indexing" associated with current AST node

	end_keyword: KEYWORD_AS
			-- Keyword "end" associated with current AST node

	set_indexing_keyword (a_keyword: KEYWORD_AS) is
			-- Set `indexing_keyword' with `a_keyword'.
		do
			indexing_keyword := a_keyword
		ensure
			indexing_keyword_set: indexing_keyword = a_keyword
		end

	set_end_keyword (a_keyword: KEYWORD_AS) is
			-- Set `end_keyword' with `a_keyword'.
		do
			end_keyword := a_keyword
		ensure
			end_keyword_set: end_keyword = a_keyword
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class FEATURE_LIST_AS
