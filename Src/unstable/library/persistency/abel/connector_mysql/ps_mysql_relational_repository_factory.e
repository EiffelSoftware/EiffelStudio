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

feature -- Element change

	manage (type: TYPE [detachable ANY]; primary_key_attribute: STRING)
			-- Manage `type' and deal with the primary key stored in `primary_key_attribute'
		local
			name: IMMUTABLE_STRING_8
		do
				-- Attached types have a nasty '!' at the beginning.
			if type.is_attached then
				name := type.name.tail (type.name.count - 1)
			else
				name := type.name
			end
			mapping.add_primary_key_column (primary_key_attribute, name)
		end

feature -- Factory function

	new_repository: PS_RELATIONAL_REPOSITORY
			-- <Precursor>
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
				if not attached mapping.primary_key_column (cursor.item) then
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

	mapping: PS_DATABASE_MAPPING
			-- A mapping table to override naming and primary key defaults.

end
