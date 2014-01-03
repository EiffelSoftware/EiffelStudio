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

			internal_handlers.extend (create {PS_STRING_HANDLER})
			internal_handlers.extend (create {PS_TUPLE_HANDLER})
			internal_handlers.extend (create {PS_SPECIAL_HANDLER})
			internal_handlers.extend (create {PS_DEFAULT_OBJECT_HANDLER})

			internal_plugins.extend (create {PS_AGENT_CRITERION_ELIMINATOR_PLUGIN})
		end

	make_uninitialized
			-- Initialize the factory, but do not set any default handlers and plugins.
			-- Note that a repository created by this factory, when no further handlers
			-- are added, will not be able to process any kind of object.
		do
			create internal_handlers.make
			create internal_plugins.make
			create type_factory.make
			create anomaly_settings
		end

feature -- Access

	handlers: CONTAINER [PS_HANDLER]
			-- The handlers for different object types.
		do
			Result := internal_handlers
		end

	plugins: CONTAINER [PS_PLUGIN]
			-- The plugins to the repository.
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
			internal_handlers.put_front (a_handler)
		ensure
			handler_added: handlers.has (a_handler)
		end

	add_plugin (a_plugin: PS_PLUGIN)
			-- Add `a_plugin' to the plugin list.
		do
			internal_plugins.put_front (a_plugin)
		ensure
			plugin_added: plugins.has (a_plugin)
		end

feature -- Element change: Anomaly Settings

	set_is_dirty_read_allowed (value: BOOLEAN)
			-- Set `anomaly_settings.is_dirty_read_allowed' to `value'.
		do
			anomaly_settings.set_is_dirty_read_allowed (value)
		ensure
			correct: anomaly_settings.is_dirty_read_allowed = value
		end


	set_is_lost_update_allowed (value: BOOLEAN)
			-- Set `anomaly_settings.is_lost_update_allowed' to `value'.
		do
			anomaly_settings.set_is_lost_update_allowed (value)
		ensure
			correct: anomaly_settings.is_lost_update_allowed = value
		end


	set_is_fuzzy_read_allowed (value: BOOLEAN)
			-- Set `anomaly_settings.is_fuzzy_read_allowed' to `value'.
		do
			anomaly_settings.set_is_fuzzy_read_allowed (value)
		ensure
			correct: anomaly_settings.is_fuzzy_read_allowed = value
		end

	set_is_phantom_allowed (value: BOOLEAN)
			-- Set `anomaly_settings.is_phantom_allowed' to `value'.
		do
			anomaly_settings.set_is_phantom_allowed (value)
		ensure
			correct: anomaly_settings.is_phantom_allowed = value
		end

	set_is_read_skew_allowed (value: BOOLEAN)
			-- Set `anomaly_settings.is_read_skew_allowed' to `value'.
		do
			anomaly_settings.set_is_read_skew_allowed (value)
		ensure
			correct: anomaly_settings.is_read_skew_allowed = value
		end

	set_is_write_skew_allowed (value: BOOLEAN)
			-- Set `anomaly_settings.is_write_skew_allowed' to `value'.
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
			connector: PS_REPOSITORY_CONNECTOR
			write_manager: PS_WRITE_MANAGER
		do
			connector := new_connector
			connector.set_transaction_isolation (anomaly_settings)

			internal_plugins.do_all (agent connector.add_plugin)

			create write_manager.make (type_factory, connector)

			internal_handlers.do_all (agent {PS_HANDLER}.set_write_manager (write_manager))
			internal_handlers.do_all (agent write_manager.add_handler)

			create {PS_DEFAULT_REPOSITORY} Result.make_from_factory (
				connector,
				type_factory,
				write_manager,
				internal_handlers,
				anomaly_settings.twin)
		end

feature {NONE} -- Implementation

	new_connector: PS_REPOSITORY_CONNECTOR
			-- Create a backend.
		require
			buildable: is_buildable
		deferred
		end

	type_factory: PS_METADATA_FACTORY
			-- The type factory for the new repsitory.

	internal_handlers: LINKED_LIST [PS_HANDLER]
			-- Mutable container for `handlers'.

	internal_plugins: LINKED_LIST [PS_PLUGIN]
			-- Mutable container for `plugins'.

end
