indexing
	description: "Eiffel cluster, used to initialize ace file"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ACE_CLUSTER

inherit
	CODE_NAMED_ENTITY

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_path: like path) is
			-- Initialize instance
		require
			non_void_name: a_name /= Void
			non_void_path: a_path /= Void
		do
			name := a_name
			path := a_path
			create {ARRAYED_LIST [STRING]} visible_clauses.make (10)
			create {ARRAYED_LIST [STRING]} exclude_clauses.make (10)
		ensure
			name_set: name = a_name
			path_set: path = a_path
		end

feature -- Access

	path: STRING
			-- Cluster path

	visible_clauses: LIST [STRING]
			-- Visible clauses

	exclude_clauses: LIST [STRING]
			-- Exclude clauses

	is_library: BOOLEAN
			-- Is cluster a library cluster?

	namespace: STRING
			-- Cluster namespace

	code: STRING is
			-- Cluster LACE code
		do
			create Result.make (512)
			if is_library then
				Result.append ("library ")
			end
			Result.append_character ('"')
			Result.append (name)
			Result.append ("%":%T%"")
			Result.append (path)
			Result.append ("%"%N")
			from
				exclude_clauses.start
				if not exclude_clauses.after then
					Result.append ("%T%Texclude%N%T%T%T%"")
					Result.append (exclude_clauses.item)
					Result.append_character ('"')
					exclude_clauses.forth
				end
			until
				exclude_clauses.after
			loop
				Result.append ("; %"")
				Result.append (exclude_clauses.item)
				Result.append_character ('"')
				exclude_clauses.forth
			end
			if exclude_clauses.count > 0 then
				Result.append ("%N")
			end
			from
				visible_clauses.start
			until
				visible_clauses.after
			loop
				Result.append ("%T%T%T")
				Result.append (visible_clauses.item)
				Result.append ("%N%T%T%T%Tend%N")
				visible_clauses.forth
			end
			if namespace /= Void then
				Result.append ("%T%Tdefault%N%T%T%Tnamespace (%"")
				Result.append (namespace)
				Result.append ("%")%N")
			end
			if exclude_clauses.count > 0 or visible_clauses.count > 0 or namespace /= Void then
				Result.append ("%T%Tend%N")
			end
		end
		
feature -- Element Settings

	add_visible_clause (a_name: STRING) is
			-- Add `a_name' to `visible_clauses'.
		require
			non_void_name: a_name /= Void
		do
			visible_clauses.extend (a_name)
		ensure
			added: visible_clauses.has (a_name)
		end
		
	add_exclude_clause (a_name: STRING) is
			-- Add `a_name' to `exclude_clauses'.
		require
			non_void_name: a_name /= Void
		do
			exclude_clauses.extend (a_name)
		ensure
			added: exclude_clauses.has (a_name)
		end
	
	set_is_library is
			-- Set `is_library' to `True'.
		do
			is_library := True
		ensure
			is_library: is_library
		end
	
	set_namespace (a_namespace: like namespace) is
			-- Set `namespace' with `a_namespace'.
		do
			namespace := a_namespace
		ensure
			namespace_set: namespace = a_namespace
		end
		
invariant
	non_void_path: path /= Void

end -- class CODE_ACE_CLUSTER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------