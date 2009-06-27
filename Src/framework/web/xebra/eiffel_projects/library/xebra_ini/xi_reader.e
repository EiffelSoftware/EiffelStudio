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


feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
		end

feature -- Acces

feature -- Status report

	check_attributes (a_config: G): detachable G
			-- Checks if all attributes have been set
		require
			a_config_attached: a_config /= Void
		deferred
		end

feature -- Status setting

	process_file (a_file_name: STRING): detachable G
			-- Processes a config file an generates a XS_CONFIG object
		require
			not_a_file_name_is_detached_or_empty: a_file_name /= Void and then not a_file_name.is_empty
		do
			if attached {INI_DOCUMENT} open_ini_file (a_file_name) as ini_doc then
				Result := check_attributes (process_properties (ini_doc.properties))
			end
		end


feature {NONE} -- Internal Status setting

	process_properties (a_properties: LIST [INI_PROPERTY]): G
			-- Process document properties
		require
			a_properties_attached: a_properties /= Void
		local
			l_cursor: CURSOR
			l_config: G
			l_error: BOOLEAN
		do
			l_error := False
			create l_config.make_empty
			l_cursor := a_properties.cursor
			from a_properties.start until a_properties.after or l_error loop
				if a_properties.item.name /= Void and a_properties.item.value /= Void  then
					process_property (a_properties.item, l_config)
				else
					l_error := True
					error_manager.add_error (create {XERROR_CONFIG_ERROR}.make , False)
				end
				a_properties.forth
			end
			a_properties.go_to (l_cursor)
			Result := l_config
		ensure
			a_properties_unmoved: a_properties.cursor.is_equal (old a_properties.cursor)
			Result_attached: Result /= Void
		end

	process_property (a_property: INI_PROPERTY; a_config: G)
			-- Process document properties
		require
			a_property_attached: a_property /= Void
			a_config_attached: a_config /= Void
			a_property_name_attached: a_property.name /= Void
			a_property_value_attached: a_property.value /= Void
		deferred
		end

	open_ini_file (a_file_name: STRING): detachable INI_DOCUMENT
			-- Attempts to open `a_file_name' as an INI document.
		require
			not_a_file_name_is_detached_or_empty: a_file_name /= Void and then not a_file_name.is_empty
		local
			l_reader: INI_DOCUMENT_READER
			l_f_utils: XU_FILE_UTILITIES
		do

			create l_f_utils.make
			create l_reader.make
			if attached l_f_utils.plain_text_file_read (a_file_name) as l_file then
				l_reader.read_from_file (l_file, True)
				if l_reader.successful then
					Result := l_reader.read_document
				else
					error_manager.add_error (create {XERROR_CANNOT_READ_INI}.make (a_file_name), False)
				end
				l_f_utils.close
			end

		end
end

