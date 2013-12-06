note
	description: "A factory for repository objects. Every ABEL backend should ship with its own factory."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_REPOSITORY_FACTORY

inherit
	PS_ABEL_EXPORT

feature {NONE} -- Initialization

	make
			-- Initialize with default handlers and plugins.
		do
			make_uninitialized

			internal_handler.extend (create {PS_STRING_HANDLER})
			internal_handler.extend (create {PS_TUPLE_HANDLER})
			internal_handler.extend (create {PS_SPECIAL_HANDLER})
			internal_handler.extend (create {PS_DEFAULT_OBJECT_HANDLER})

			internal_plugins.extend (create {PS_AGENT_CRITERION_ELIMINATOR_PLUGIN})
		end

	make_uninitialized
			-- Do not initialize any defaults.
		do
			create internal_handler.make
			create internal_plugins.make
			create id_manager.make
			create key_mapper.make
			create anomaly_settings
		end

feature -- Access

	handler: CONTAINER [PS_HANDLER]
			-- The handler for different object types.
		do
			Result := internal_handler
		end

	plugins: CONTAINER [PS_PLUGIN]
			-- The defined plugins
		do
			Result := internal_plugins
		end

	anomaly_settings: PS_TRANSACTION_SETTINGS
			-- The transaction isolation settings for new repositories.

feature -- Status report

	is_buildable: BOOLEAN
			-- Does `Current' have enough information to build a repository?
		deferred
		end

feature -- Element change

	add_handler (a_handler: PS_HANDLER)
			-- Add `a_handler' to the handlers.
			-- The new handler has precedence over any previously added handlers.
		do
			internal_handler.put_front (a_handler)
		end

	add_plugin (a_plugin: PS_PLUGIN)
			-- Add `a_plugin' to the plugin list.
		do
			internal_plugins.put_front (a_plugin)
		end

feature -- Element change: Anomaly Settings

	set_is_dirty_read_allowed (value: BOOLEAN)
			-- Set `anomaly_settings.is_dirty_read_allowed' to `value'
		do
			anomaly_settings.set_is_dirty_read_allowed (value)
		ensure
			correct: anomaly_settings.is_dirty_read_allowed = value
		end


	set_is_lost_update_allowed (value: BOOLEAN)
			-- Set `anomaly_settings.is_lost_update_allowed' to `value'
		do
			anomaly_settings.set_is_lost_update_allowed (value)
		ensure
			correct: anomaly_settings.is_lost_update_allowed = value
		end


	set_is_fuzzy_read_allowed (value: BOOLEAN)
			-- Set `anomaly_settings.is_fuzzy_read_allowed' to `value'
		do
			anomaly_settings.set_is_fuzzy_read_allowed (value)
		ensure
			correct: anomaly_settings.is_fuzzy_read_allowed = value
		end

	set_is_phantom_allowed (value: BOOLEAN)
			-- Set `anomaly_settings.is_phantom_allowed' to `value'
		do
			anomaly_settings.set_is_phantom_allowed (value)
		ensure
			correct: anomaly_settings.is_phantom_allowed = value
		end

	set_is_read_skew_allowed (value: BOOLEAN)
			-- Set `anomaly_settings.is_read_skew_allowed' to `value'
		do
			anomaly_settings.set_is_read_skew_allowed (value)
		ensure
			correct: anomaly_settings.is_read_skew_allowed = value
		end

	set_is_write_skew_allowed (value: BOOLEAN)
			-- Set `anomaly_settings.is_write_skew_allowed' to `value'
		do
			anomaly_settings.set_is_write_skew_allowed (value)
		ensure
			correct: anomaly_settings.is_write_skew_allowed = value
		end

feature -- Factory function

	new_repository: PS_REPOSITORY
			-- Create a new repository.
		require
			buildable: is_buildable
		local
			backend: PS_BACKEND
			write_manager: PS_WRITE_MANAGER
		do
			backend := new_backend

			internal_plugins.do_all (agent backend.add_plugin)

			create write_manager.make (id_manager.metadata_manager, id_manager, key_mapper, backend)

			internal_handler.do_all (agent {PS_HANDLER}.set_write_manager (write_manager))
			internal_handler.do_all (agent write_manager.add_handler)

			create {PS_DEFAULT_REPOSITORY} Result.make_from_factory (
				backend,
				id_manager,
				key_mapper,
				write_manager,
				internal_handler,
				anomaly_settings.twin)
		end

feature {NONE} -- Implementation

	new_backend: PS_BACKEND
			-- Create a backend.
		require
			buildable: is_buildable
		deferred
		end


	id_manager: PS_OBJECT_IDENTIFICATION_MANAGER

	key_mapper: PS_KEY_POID_TABLE

	internal_handler: LINKED_LIST [PS_HANDLER]

	internal_plugins: LINKED_LIST [PS_PLUGIN]

end
