indexing
	description: "[
		Objects implementing {EIFFEL_TEST_PROCESSOR_REGISTRAR_I}
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_PROCESSOR_REGISTRAR

inherit
	EIFFEL_TEST_PROCESSOR_REGISTRAR_I [EIFFEL_TEST_PROCESSOR_I]

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'
		do
			create registered_processors.make_default
		end


feature -- Access

	processor (a_type: !TYPE [!EIFFEL_TEST_PROCESSOR_I]): !EIFFEL_TEST_PROCESSOR_I
			-- <Precursor>
		do
			Result := registered_processors.item (type_hash (a_type))
		end

	processors: !DS_LINEAR [!EIFFEL_TEST_PROCESSOR_I]
			-- <Precursor>
		do
			Result := registered_processors
		end

feature {NONE} -- Access

	registered_processors: !DS_HASH_TABLE [!EIFFEL_TEST_PROCESSOR_I, !HASHABLE]

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	is_registered (a_type: !TYPE [!EIFFEL_TEST_PROCESSOR_I]): BOOLEAN
			-- <Precursor>
		do
			Result := registered_processors.has (type_hash (a_type))
		end

feature {NONE} -- Query

	type_hash (a_type: !TYPE [ANY]): !HASHABLE
			-- Retrieves a hashable object given a type.
			-- Note: This is added for compatiblity, given that {TYPE} is not yet {HASHABLE}. When this is
			--       changed this feature is to be removed and the type used directly.
			--
			-- `a_type': The service type to retrieve a hashable object for.
			-- `Result': A hashable object to use with `services'.
		do
			if {l_hashable: HASHABLE} a_type then
				Result := l_hashable
			else
				Result ?= a_type.generating_type
			end
		end

feature -- Element change

	register (a_processor: !EIFFEL_TEST_PROCESSOR_I; a_type: !TYPE [!EIFFEL_TEST_PROCESSOR_I])
			-- <Precursor>
		do
			registered_processors.put (a_processor, type_hash (a_type))
		end

	unregister (a_type: !TYPE [!EIFFEL_TEST_PROCESSOR_I])
			-- <Precursor>
		do
			registered_processors.remove (type_hash (a_type))
		end

end
