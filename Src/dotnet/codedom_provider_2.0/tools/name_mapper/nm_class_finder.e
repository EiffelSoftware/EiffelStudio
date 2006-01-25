indexing
	description: "Search for class information from .NET name"
	date: "$Date$"
	revision: "$Revision$"

class
	NM_CLASS_FINDER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize instance.
		do
			create type_reference_factory
		end

feature -- Access

	searching: BOOLEAN
			-- Are we currently searching for a type?

	found: BOOLEAN is
			-- Was last called to `search' successful?
		do
			Attribute_access_mutex.lock
			Result := internal_found
			Attribute_access_mutex.unlock
		end

	eiffel_name: STRING is
			-- Eiffel name of .NET type whose name was given to `search'.
		do
			Attribute_access_mutex.lock
			Result := internal_eiffel_name
			Attribute_access_mutex.unlock
		end

	members_mapping: HASH_TABLE [STRING, STRING] is
			-- Table of member names mapping
			-- Indexed by .NET member names
		do
			Attribute_access_mutex.lock
			Result := internal_members_mapping
			Attribute_access_mutex.unlock
		end

	dotnet_member_names: LIST [STRING] is
			-- Sorted list of current .NET member names
		do
			Attribute_access_mutex.lock
			Result := internal_dotnet_member_names
			Attribute_access_mutex.unlock
		end

feature -- Basic Operation

	search (a_dotnet_type_name: STRING) is
			-- Spawn worker thread and run `internal_search'.
		require
			non_void_dotnet_type_name: a_dotnet_type_name /= Void
			not_searching: not searching
		do
			searching := True
			create worker_thread.make (agent internal_search (a_dotnet_type_name))
			worker_thread.launch
			Environment.application.process_events_until_stopped
			searching := False
		end

	internal_search (a_dotnet_type_name: STRING) is
			-- Search information for .NET type with name `a_dotnet_type_name'.
		require
			non_void_dotnet_type_name: a_dotnet_type_name /= Void
		local
			l_type_ref: CODE_TYPE_REFERENCE
			l_type: SYSTEM_TYPE
			l_dotnet_names: DS_ARRAYED_LIST [STRING]
			l_features: LIST [LIST [CODE_MEMBER_REFERENCE]]
			l_members_mapping: like members_mapping
			l_retried: BOOLEAN
		do
			if not l_retried then
				l_type_ref := type_reference_factory.type_reference_from_name (a_dotnet_type_name)
				l_type := l_type_ref.dotnet_type
				if l_type /= Void then
					l_features := l_type_ref.members
					create l_members_mapping.make (l_features.count)
					from
						l_features.start
					until
						l_features.after
					loop
						l_members_mapping.put (l_features.item.first.overloaded_eiffel_name, l_features.item.first.name)
						l_features.forth
					end
					create l_dotnet_names.make_from_array (l_members_mapping.current_keys)
					l_dotnet_names.sort (Quick_sorter)
					
					-- Set internal attributes through Attribute_access_mutex
					Attribute_access_mutex.lock
					internal_members_mapping := l_members_mapping
					create {ARRAYED_LIST [STRING]} internal_dotnet_member_names.make_from_array (l_dotnet_names.to_array)
					internal_found := True
					internal_eiffel_name := l_type_ref.eiffel_name
					Attribute_access_mutex.unlock
				else
	
					-- Set internal attributes through Attribute_access_mutex
					Attribute_access_mutex.lock
					internal_eiffel_name := Void
					internal_members_mapping := Void
					internal_dotnet_member_names := Void
					internal_found := False
					Attribute_access_mutex.unlock
				end
			end
			Environment.application.stop_processing
		rescue
			l_retried := True
			retry
		end

feature {NONE} -- Private Access

	worker_thread: WORKER_THREAD
			-- Worker thread

	Thread_abort_exception_type: SYSTEM_TYPE is
			-- Type of .NET type ThreadAbortException
		once
			Result := {SYSTEM_TYPE}.get_type_string ("ThreadAbortException")
		end

	internal_found: BOOLEAN
			-- Cache for `found', must be accessed through
			-- Attribute_access_mutex

	internal_eiffel_name: STRING
			-- Cache for `eiffel_name', must be accessed through
			-- Attribute_access_mutex

	internal_members_mapping: HASH_TABLE [STRING, STRING]
			-- Cache for `members_mapping', must be accessed through
			-- Attribute_access_mutex

	internal_dotnet_member_names: LIST [STRING]
			-- Cache for `dotnet_member_names', must be accessed through
			-- Attribute_access_mutex
		
	Attribute_access_mutex: MUTEX is
			-- Mutex to access public attribute
		once
			create Result
		end
		
	type_reference_factory: CODE_TYPE_REFERENCE_FACTORY
			-- Type reference factory

	Quick_sorter: DS_QUICK_SORTER [STRING] is
			-- Quick sorter
		once
			create Result.make (create {KL_COMPARABLE_COMPARATOR [STRING]}.make)
		end
	
	Environment: EV_ENVIRONMENT is
			-- Vision2 environment
		once
			create Result
		end
		
invariant
	non_void_type_factory: type_reference_factory /= Void

end -- class NM_CLASS_FINDER

--+--------------------------------------------------------------------
--| Name Mapper
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------