note
	description: "[
		Provides features to read and parse ini files and generate XI_CONFIGs
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XI_READER [G ->  XI_CONFIG create make_empty end]

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER
	XU_SHARED_OUTPUTTER


feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
		end

feature -- Acces

feature -- Status report

	check_attributes (a_config: G): detachable G
			-- Checks if all attributes have been set
		deferred
		end

feature -- Status setting

	process_file (a_file_name: STRING): detachable G
			-- Processes a config file an generates a XS_CONFIG object
		do
			if attached {INI_DOCUMENT} open_ini_file (a_file_name) as ini_doc then
				Result := check_attributes (process_properties (ini_doc.properties))
			end
		end


feature {NONE} -- Internal Status setting

	process_properties (a_properties: LIST [INI_PROPERTY]): G
			-- Process document properties
		local
			l_cursor: CURSOR
			l_config: G
		do
			create l_config.make_empty
			l_cursor := a_properties.cursor
			from a_properties.start until a_properties.after loop
				process_property (a_properties.item, l_config)
				a_properties.forth
			end
			a_properties.go_to (l_cursor)
			Result := l_config
		ensure
			a_properties_unmoved: a_properties.cursor.is_equal (old a_properties.cursor)
		end

	process_property (a_property: INI_PROPERTY; a_config: G)
			-- Process document properties
		deferred
		end

	open_ini_file (a_file_name: STRING): detachable INI_DOCUMENT
			-- Attempts to open `a_file_name' as an INI document.
		require
			not_a_file_name_is_empty: not a_file_name.is_empty
			error_manager_attached: error_manager /= Void
		local
			l_file: PLAIN_TEXT_FILE
			l_reader: INI_DOCUMENT_READER
		do
			create l_file.make (a_file_name)
			if l_file.exists and l_file.is_readable then
				l_file.open_read
				if l_file.is_open_read then
					create l_reader.make
					l_reader.read_from_file (l_file, True)
					if l_reader.successful then
						Result := l_reader.read_document
					else
						error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (a_file_name), False)
					end
					l_file.close
				else
					error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (a_file_name), False)
				end
			else
				error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (a_file_name), False)
			end
		end
end

