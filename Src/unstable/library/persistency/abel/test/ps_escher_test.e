note
	description: "A small unit test for ESCHER integration."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_ESCHER_TEST

inherit

	EQA_TEST_SET
		redefine
			on_prepare, on_clean
		end

	PS_ABEL_EXPORT
		undefine
			default_create
		end

feature

	escher_add_attribute
			-- Test if added attribute is handled correctly
		local
			query: PS_QUERY [ESCHER_TEST_CLASS_2]
			retried: BOOLEAN
		do
			escher_integration.set_simulation (True)
			escher_integration.set_simulation_added_attribute (True)
			if not retried then
				create query.make
				transaction.insert (test_data.escher_test_2)
				transaction.execute_query (query)
				query.close
			end
		end

	escher_change_attribute_type
			-- Test if attribute type change is handled correctly
		local
			query: PS_QUERY [ESCHER_TEST_CLASS_2]
			retried: BOOLEAN
		do
			escher_integration.set_simulation (True)
			escher_integration.set_simulation_attribute_type_changed (True)
			if not retried then
				create query.make
				transaction.insert (test_data.escher_test_2)
				transaction.execute_query (query)
				query.close
			end
		end

	escher_change_attribute_name
			-- Test if attribute name change is handled correctly
		local
			query: PS_QUERY [ESCHER_TEST_CLASS_2]
			retried: BOOLEAN
		do
			escher_integration.set_simulation (True)
			escher_integration.set_simulation_attribute_name_changed (True)
			if not retried then
				create query.make
				transaction.insert (test_data.escher_test_2)
				transaction.execute_query (query)
				query.close
			end
		end

	escher_remove_attribute
			-- Test if removed attribute is handled correctly
		local
			query: PS_QUERY [ESCHER_TEST_CLASS_2]
			retried: BOOLEAN
		do
			escher_integration.set_simulation (True)
			escher_integration.set_simulation_removed_attribute (True)
			if not retried then
				create query.make
				transaction.insert (test_data.escher_test_2)
				transaction.execute_query (query)
				query.close
			end
		end

	escher_multiple_changes
			-- Test whether multiple changes are handled correctly
			-- Uses 'v4_to_v5' from APPLICATION_SCHEMA_EVOLUTION_HANDLER
		local
			query: PS_QUERY [ESCHER_TEST_CLASS_2]
			retried: BOOLEAN
		do
			escher_integration.set_simulation (True)
			escher_integration.set_simulation_added_attribute (True)
			escher_integration.set_simulation_attribute_type_changed (True)
			escher_integration.set_simulation_attribute_name_changed (True)
			escher_integration.set_simulation_removed_attribute (True)
			-- All other simulations need to be set before the simulation for multiple changes can be set
			escher_integration.set_simulation_multiple_changes (True)
			if not retried then
				create query.make
				transaction.insert (test_data.escher_test_2)
				transaction.execute_query (query)
				query.close
			end
		end

	escher_normal_operation
			-- Test if no version mismatch gets handled correctly
		local
			query: PS_QUERY [ESCHER_TEST_CLASS]
		do
			escher_integration.set_simulation (False)
			create query.make
			transaction.insert (test_data.escher_test)
			transaction.execute_query (query)
			query.close
		end

--	escher_version_mismatch
--			-- Test the ESCHER version checking by simulating a version mismatch.
--		local
--			query: detachable PS_OBJECT_QUERY [ESCHER_TEST_CLASS]
--			retried: BOOLEAN
--		do
--			escher_integration.set_simulation (True)

--			if not retried then
--				create query.make
--				transaction.insert (test_data.escher_test)
--				transaction.execute_query (query)
--			end

--			if attached query then
--				query.close
--			end

--		rescue
--			assert ("No version mismatch error was raised", transaction.has_error and then attached {PS_VERSION_MISMATCH_ERROR} transaction.last_error)
--			retried := True
--			retry
--		end

feature {NONE}

	test_data: PS_TEST_DATA

	escher_integration: PS_VERSIONING_PLUGIN

	schema_evolution_manager: SCHEMA_EVOLUTION_PROJECT_MANAGER

	on_prepare
			-- Set up an in-memory database with an ESCHER integration layer
		local
--			real_backend: PS_IN_MEMORY_DATABASE
			factory: PS_IN_MEMORY_REPOSITORY_FACTORY
			repo: PS_REPOSITORY
		do
			create test_data.make
			create schema_evolution_manager.make
			create escher_integration.make (schema_evolution_manager.schema_evolution_handler)

			create factory.make
--			repo := factory.create_in_memory_repository
--			repo.backend.add_plug_in (escher_integration)
			factory.add_plugin (escher_integration)
			repo := factory.new_repository

			transaction := repo.new_transaction
		end

	on_clean
		do
			transaction.commit
		end

	transaction: PS_TRANSACTION

end
