note
	description: "API for a CMS"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_API

inherit
	ANY

	REFACTORING_HELPER

	CMS_ENCODERS

create
	make

feature {NONE} -- Initialize

	make (a_setup: CMS_SETUP)
			-- Create the API service with a setup  `a_setup'
		do
			setup := a_setup
			create error_handler.make
			create {CMS_ENV_LOGGER} logger.make
			initialize
		ensure
			setup_set: setup = a_setup
			error_handler_set: not error_handler.has_error
		end

	initialize
				-- Initialize the persitent layer.
		do
			to_implement ("Refactor database setup")
			if attached setup.storage (error_handler) as l_storage then
				storage := l_storage
			else
				create {CMS_STORAGE_NULL} storage
			end
		end

feature -- Access

	setup: CMS_SETUP
			-- CMS setup.

	logger: CMS_LOGGER
			-- Logger

	storage: CMS_STORAGE
			-- Persistence storage.				

feature -- Status Report

	has_error: BOOLEAN
			-- Has error?
		do
			Result := error_handler.has_error
		end

	string_representation_of_errors: STRING_32
			-- String representation of all error(s).
		do
			Result := error_handler.as_string_representation
		end

feature -- Query: module

	module (a_type: TYPE [CMS_MODULE]): detachable CMS_MODULE
			-- Enabled module typed `a_type', if any.
			--| usage: if attached module ({FOO_MODULE}) as mod then ...
		do
			across
				setup.modules as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if
					not Result.is_enabled
					or else Result.generating_type /~ a_type
				then
					Result := Void
				end
			end
		end

	module_by_name (a_name: READABLE_STRING_GENERAL): detachable CMS_MODULE
			-- Enabled module named `a_name', if any.
		do
			across
				setup.modules as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if
					not Result.is_enabled
					or else not Result.name.is_case_insensitive_equal_general (a_name)
				then
					Result := Void
				end
			end
		ensure
			Result /= Void implies Result.name.is_case_insensitive_equal_general (a_name)
		end

feature -- Query: API

	user_api: CMS_USER_API
		local
			l_api: like internal_user_api
		do
			l_api := internal_user_api
			if l_api = Void then
				create l_api.make (Current)
				internal_user_api := l_api
			end
			Result := l_api
		end

feature -- Element Change: Error

	reset_error
			-- Reset error handler.
		do
			error_handler.reset
		end

feature {NONE}-- Implemenation

	error_handler: ERROR_HANDLER
			-- Error handler.

	internal_user_api: detachable like user_api
			-- Cached value for `user_api'.

feature -- Layout

	module_configuration (a_module_name: READABLE_STRING_GENERAL; a_name: detachable READABLE_STRING_GENERAL): detachable CONFIG_READER
			-- Configuration reader for `a_module', and if `a_name' is set, using name `a_name'.
		local
			p, l_path: PATH
			ut: FILE_UTILITIES
		do
			p := setup.layout.config_path.extended ("modules").extended (a_module_name)
			if a_name = Void then
				p := p.extended (a_module_name)
			else
				p := p.extended (a_name)
			end
			l_path := p.appended_with_extension ("json")
			if ut.file_path_exists (l_path) then
				create {JSON_CONFIG} Result.make_from_file (l_path)
			else
				l_path := p.appended_with_extension ("ini")
				if ut.file_path_exists (l_path) then
					create {INI_CONFIG} Result.make_from_file (l_path)
				end
			end
			if Result = Void and a_name /= Void then
					-- Use sub config from default?
				if attached {CONFIG_READER} module_configuration (a_module_name, Void) as cfg then
					Result := cfg.sub_config (a_name)
				else
					-- Maybe try to use the global cms.ini ?	
				end
			end
		end

end

