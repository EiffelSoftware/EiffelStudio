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

	found: BOOLEAN
			-- Was last called to `search' successful?

	eiffel_name: STRING
			-- Eiffel name of .NET type whose name was given to `search'.

	members_mapping: HASH_TABLE [STRING, STRING]
			-- Table of member names mapping
			-- Indexed by .NET member names

	dotnet_member_names: LIST [STRING]
			-- Sorted list of current .NET member names

feature -- Basic Operation

	search (a_dotnet_type_name: STRING) is
			-- Spawn worker thread and run `internal_search'.
		require
			non_void_dotnet_type_name: a_dotnet_type_name /= Void
		local
			l_worker_thread: WORKER_THREAD
		do
			create l_worker_thread.make (agent internal_search (a_dotnet_type_name))
			l_worker_thread.launch;
			(create {EV_ENVIRONMENT}).application.process_events_until_stopped
		end

	internal_search (a_dotnet_type_name: STRING) is
			-- Search information for .NET type with name `a_dotnet_type_name'.
		require
			non_void_dotnet_type_name: a_dotnet_type_name /= Void
		local
			l_type_ref: CODE_TYPE_REFERENCE
			l_type: TYPE
			l_dotnet_names: DS_ARRAYED_LIST [STRING]
			l_features: LIST [LIST [CODE_MEMBER_REFERENCE]]
		do
			Only_one_thread_mutex.lock
			l_type_ref := type_reference_factory.type_reference_from_name (a_dotnet_type_name)
			l_type := l_type_ref.dotnet_type
			found := l_type /= Void
			if found then
				eiffel_name := l_type_ref.eiffel_name
				l_features := l_type_ref.members
				create members_mapping.make (l_features.count)
				from
					l_features.start
				until
					l_features.after
				loop
					members_mapping.put (l_features.item.first.overloaded_eiffel_name, l_features.item.first.name)
					l_features.forth
				end
				create l_dotnet_names.make_from_array (members_mapping.current_keys)
				l_dotnet_names.sort (Quick_sorter)
				create {ARRAYED_LIST [STRING]} dotnet_member_names.make_from_array (l_dotnet_names.to_array)
			else
				eiffel_name := Void
				members_mapping := Void
				dotnet_member_names := Void
			end
			(create {EV_ENVIRONMENT}).application.stop_processing
			Only_one_thread_mutex.unlock
		end

feature {NONE} -- Private Access

	type_reference_factory: CODE_TYPE_REFERENCE_FACTORY
			-- Type reference factory

	Quick_sorter: DS_QUICK_SORTER [STRING] is
			-- Quick sorter
		once
			create Result.make (create {KL_COMPARABLE_COMPARATOR [STRING]}.make)
		end
	
	Only_one_thread_mutex: MUTEX is
			-- Mutex to guarentee that there is only one worker thread running at any given time
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