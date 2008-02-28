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
				Result := indexing_keyword (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- Last token in current AST node
		do
			if a_list = Void then
				Result := Precursor{EIFFEL_LIST} (a_list)
			else
				Result := end_keyword (a_list)
				if Result = Void then
					if not is_empty then
						Result := Precursor (a_list)
					else
						Result := indexing_keyword (a_list)
					end
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

	property_custom_attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS] is
			-- Expression representing custom attributes for a property
		do
			Result := internal_custom_attributes (Property_metadata_header)
		end

	property_name: STRING is
			-- Expression representing custom attributes for a property
		local
			i: INDEX_AS
			s: STRING_AS
			id: ID_AS
			list: EIFFEL_LIST [ATOMIC_AS]
		do
			i := find_index_as (property_name_header)
			if i /= Void then
				list := i.index_list
				if not list.is_empty then
					s ?= list.first
					if s /= Void then
							-- Explicit property name
						Result := s.value
					else
						id ?= list.first
						if id /= Void and then id.name.as_lower.is_equal ("auto") then
								-- Implicit property name
							Result := ""
						end
					end
				end
			end
		end

	dotnet_constructors: ARRAYED_LIST [STRING] is
			-- Dotnet constructors indexing clause value
		local
			l_index: INDEX_AS
			l_list: EIFFEL_LIST [ATOMIC_AS]
			l_string: STRING_AS
			l_id: ID_AS
		do
			l_index := find_index_as (Dotnet_constructors_header)
			if l_index /= Void then
				l_list := l_index.index_list
				if not l_list.is_empty then
					create Result.make (l_list.count)
					from
						l_list.start
					until
						l_list.after
					loop
						l_string ?= l_list.item
						if l_string /= Void then
							Result.extend (l_string.value)
						else
							l_id ?= l_list.item
							if l_id /= Void then
								Result.extend (l_id.name)
							end
						end
						l_list.forth
					end
					Result.compare_objects
				end
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
							Result := l_id /= Void and then l_id.name.is_equal (Global_value)
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
		obsolete
			"Not needed anymore"
		require
			v_not_void: v /= Void
		do
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

	Property_metadata_header: STRING is "property_metadata"
			-- Index name which holds custom attributes applied to associated property.

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

	Dotnet_constructors_header: STRING is "dotnet_constructors"
			-- Index name which holds list of creation routines to be used as type constructors.

	Description_header: STRING is "description"
			-- Index name which holds class/feature desciption.

	Assembly_header: STRING is "assembly"
			-- Index name which holds name of assembly.

	Once_status_header: STRING is "once_status"
			-- Index name under which globalness of a once is specified.

	Property_name_header: STRING is "property"
			-- Index name which holds name of an associated property.

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

	find_index_as (tag: STRING): INDEX_AS is
			-- Find INDEX_AS object holding `tag'
			-- Void if not found.
		require
			tag_not_void: tag /= Void
			tag_not_empty: not tag.is_empty
		local
			i, nb: INTEGER
			l_index: INDEX_AS
		do
			from
				i := lower
				nb := upper
			until
				i > nb
			loop
				l_index := i_th (i)
				if l_index.tag /= Void and then l_index.tag.name.is_equal (tag) then
					Result := l_index
						-- Jump out of loop
					i := nb
				end
				i := i + 1
			end
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

	indexing_keyword_index: INTEGER
			-- Index of keyword "indexing" associated with current AST node

	end_keyword_index: INTEGER
			-- Index of keyword "end" associated with current AST node

	indexing_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keyword "indexing" associated with current AST node
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := indexing_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	end_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keyword "end" associated with current AST node
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := end_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	set_indexing_keyword (a_keyword: KEYWORD_AS) is
			-- Set `indexing_keyword' with `a_keyword'.
		do
			if a_keyword /= Void then
				indexing_keyword_index := a_keyword.index
			end
		ensure
			indexing_keyword_set: a_keyword /= Void implies indexing_keyword_index = a_keyword.index
		end

	set_end_keyword (a_keyword: KEYWORD_AS) is
			-- Set `end_keyword' with `a_keyword'.
		do
			if a_keyword /= Void then
				end_keyword_index := a_keyword.index
			end
		ensure
			end_keyword_set: a_keyword /= Void implies end_keyword_index = a_keyword.index
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
