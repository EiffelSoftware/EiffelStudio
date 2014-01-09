note
	description: "Summary description for {PS_MYSQL_RELATIONAL_REPOSITORY_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MYSQL_RELATIONAL_REPOSITORY_FACTORY

inherit
	PS_MYSQL_REPOSITORY_FACTORY
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
			create mapping.make
		end

feature -- Access

	mapping: PS_DATABASE_MAPPING
			-- A mapping table to override naming and primary key defaults.

feature -- Factory function

	new_repository: PS_RELATIONAL_REPOSITORY
			-- Create a new repository.
		local
			connector: PS_RELATIONAL_CONNECTOR
			write_manager: PS_WRITE_MANAGER
			internal: INTERNAL
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
				if not attached mapping.primary_key_column (cursor.item.as_lower) then
					Result.override_expanded_type (internal.type_of_type (internal.dynamic_type_from_string (cursor.item)))
				end
			end
		end


feature {NONE} -- Implementation

	new_connector: PS_RELATIONAL_CONNECTOR
			-- <Precursor>
		local
			l_db: PS_SQL_DATABASE
		do
			l_db := new_internal_database
			internal_database := l_db
			check attached database as db_name then
				create Result.make (l_db, mapping, db_name)
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

end
