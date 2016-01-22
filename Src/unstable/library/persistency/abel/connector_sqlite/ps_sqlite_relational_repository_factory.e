note
	description: "Summary description for {PS_SQLITE_RELATIONAL_REPOSITORY_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_SQLITE_RELATIONAL_REPOSITORY_FACTORY

inherit
	PS_SQLITE_REPOSITORY_FACTORY
		redefine
			new_connector,
			new_repository,
			make_uninitialized
		end

create
	make, make_uninitialized

feature {NONE} -- Initialization

	make_uninitialized
			-- <Precursor>
		do
			Precursor
			create managed_types.make (0)
		end

feature -- Element change

	manage (type: TYPE [detachable ANY]; primary_key_attribute: STRING)
			-- Manage `type' and deal with the primary key stored in `primary_key_attribute'
		local
			type_meta: PS_TYPE_METADATA
			internal: INTERNAL
		do
			create internal
			type_meta := type_factory.create_metadata_from_type_id (internal.detachable_type (type.type_id))
			managed_types.extend (primary_key_attribute, type_meta)
		end

feature -- Factory function

	new_repository: PS_RELATIONAL_REPOSITORY
			-- <Precursor>
		local
			connector: PS_RELATIONAL_CONNECTOR
			write_manager: PS_WRITE_MANAGER
			internal: INTERNAL
			type: PS_TYPE_METADATA
		do
			connector := new_connector
			connector.set_transaction_isolation (anomaly_settings)

			internal_plugins.do_all (agent connector.add_plugin)

			create write_manager.make (type_factory, connector)

			internal_handlers.do_all (agent {PS_HANDLER}.set_write_manager (write_manager))
			internal_handlers.do_all (agent write_manager.add_handler)

			create Result.make_from_factory (
				connector,
				type_factory,
				write_manager,
				internal_handlers,
				anomaly_settings.twin)

			across
				connector.stored_types as cursor
			from
				create internal
			loop
				type := type_factory.create_metadata_from_string (cursor.item)
				if not attached managed_types [type] then
					Result.override_expanded_type (type.type)
				end
			end
		end


feature {NONE} -- Implementation

	new_connector: PS_RELATIONAL_CONNECTOR
			-- <Precursor>
		local
			l_db: PS_SQLITE_DATABASE
		do
			check from_precondition: attached database as l_database then
				create l_db.make (l_database)
				internal_database := l_db
				create Result.make (l_db, managed_types, create {PS_SQLITE_STRINGS})
			end
		ensure then
			db_set: attached internal_database
		end

	internal_database: detachable PS_SQL_DATABASE
			-- An internal database.
		note
			option: stable
		attribute
		end

	managed_types: HASH_TABLE [STRING, PS_TYPE_METADATA]
			-- The managed types and their primary key column.


end
