note
	description: "[
		Provides the core functionality root for all specializing applications/libraries. The package class is designed
		to be typically derived from a project root class.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	PACKAGE

feature -- Access

	eiffel_env: like create_eiffel_env
			-- Access to Eiffel environment settings
		local
			l_layout: EIFFEL_LAYOUT
		do
			l_layout := internal_eiffel_layout
			if l_layout = Void then
				create l_layout
				internal_eiffel_layout := l_layout
			end
			if l_layout.is_eiffel_layout_defined then
				Result ?= l_layout.eiffel_layout
			end
			if Result = Void then
					-- No layout defined or the wrong one, in which case, override
				Result := create_eiffel_env
				l_layout.set_eiffel_layout (Result)
			end

		ensure
			result_attached: Result /= Void
		end

	path_provider: like create_path_provider
			-- Access to path provider
		do
			Result := internal_path_provider
			if Result = Void then
				Result := create_path_provider
				internal_path_provider := Result
			end
		ensure
			result_attached: Result /= Void
		end

	cleaner: I_CLEANER
			-- Cleaner used to erase configuration information
		do
			Result := internal_cleaner
			if Result = Void then
				Result := create_cleaner
				internal_cleaner := Result
			end
		ensure
			result_attached: Result /= Void
		end

	backup_manager: I_BACKUP_MANAGER
			-- Backup manager use to backup and restore configurations
		do
			Result := internal_backup_manager
			if Result = Void then
				Result := create_backup_manager
				internal_backup_manager := Result
			end
		ensure
			result_attached: Result /= Void
		end

	error_handler: MULTI_ERROR_MANAGER
			-- Access to global error manager
		do
			Result := internal_error_handler
			if Result = Void then
				Result := create_error_mananger
				internal_error_handler := Result
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Access

	error_displayer: I_ERROR_DISPLAYER
			-- Access to error display used to report errors and warnings
		do
			Result := internal_error_displayer
			if Result = Void then
				Result := create_error_displayer
				internal_error_displayer := Result
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Basic operations

	clean_environment (a_config: I_CLEANING_CONFIG)
			-- Performs a clean on environment configuration settings `a_config'
		require
			a_config_attached: a_config /= Void
			a_config_can_clean: a_config.can_environment_processing_occur
		local
			retried: BOOLEAN
		do
			if not retried then
				reset_errors
				cleaner.clean_environment (a_config)
			end
			show_errors ("Cleaning Error")
		rescue
			retried := True
			retry
		end

	clean_project (a_config: I_CLEANING_CONFIG)
			-- Performs a clean on project configuration settings `a_config'
		require
			a_config_attached: a_config /= Void
			a_config_can_clean: a_config.can_project_processing_occur
		local
			retried: BOOLEAN
		do
			if not retried then
				reset_errors
				cleaner.clean_project (a_config)
			end
			show_errors ("Cleaning Error")
		rescue
			retried := True
			retry
		end

	backup_configs (a_config: I_BACKUP_CONFIG)
			-- Performs a backup on configuration settings `a_config'
		require
			a_config_attached: a_config /= Void
			a_config_can_backup: a_config.can_any_processing_occur
		local
			retried: BOOLEAN
		do
			if not retried then
				reset_errors
				backup_manager.backup (a_config)
			end
			show_errors ("Backup Error")
		rescue
			retried := True
			retry
		end

	restore_configs (a_config: I_BACKUP_CONFIG)
			-- Performs a restore on configuration settings `a_config'
		require
			a_config_attached: a_config /= Void
			a_config_can_restore: a_config.can_any_processing_occur
		local
			retried: BOOLEAN
		do
			if not retried then
				reset_errors
				backup_manager.restore (a_config)
			end
			show_errors ("Restore Error")
		rescue
			retried := True
			retry
		end

feature {NONE} -- Error reporting

	reset_errors
			-- Removes any previous errors from the error handler, for the next operation
		do
			error_handler.reset
		end

	show_errors (a_category: STRING)
			-- Shows any errors or warnings from a performed operation
		require
			a_category_attached: a_category /= Void
			not_a_category_is_empty: not a_category.is_empty
		do
			if not error_handler.successful or else error_handler.has_warnings then
				error_displayer.show (a_category, error_handler)
			end
		end

feature -- Status report

	is_workbench_mode: BOOLEAN assign set_is_workbench_mode
			-- Indicates if pacakge is running under an emulated workbench mode
		do
			Result := eiffel_env.is_workbench
		end

feature -- Status setting

	set_is_workbench_mode (a_value: like is_workbench_mode)
			-- Set `is_workbench_mode' with `a_value'
		do
			eiffel_env.set_is_workbench (a_value)
			workbench_mode_change_actions.call ([a_value])
		ensure
			is_workbench_mode_set: is_workbench_mode = a_value
		end

feature -- Actions

	workbench_mode_change_actions: ACTION_SEQUENCE [TUPLE [BOOLEAN]]
			-- Actions call when `is_workbench_mode'.
			-- The {BOOLEAN} argument represents `is_workbench_mode'

feature {NONE} -- Factory functions

	create_eiffel_env: EC_CLEANER_EIFFEL_LAYOUT
			-- Creates Eiffel environment
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	create_path_provider: PATH_PROVIDER
			-- Create a path provider
		deferred
		ensure
			result_attached: Result /= Void
		end

	create_cleaner: I_CLEANER
			-- Create a new configuration cleaner
		deferred
		ensure
			result_attached: Result /= Void
		end

	create_backup_manager: I_BACKUP_MANAGER
			-- Create a new configuration backup manager
		deferred
		ensure
			result_attached: Result /= Void
		end

	create_error_mananger: MULTI_ERROR_MANAGER
			-- Create a new error manager
		do
			create Result.make
		ensure
			result_attached: Result /= Void
		end

	create_error_displayer: I_ERROR_DISPLAYER
			-- Create a new error displayer
		deferred
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Internal implementation cache

	internal_eiffel_layout: EIFFEL_LAYOUT
			-- Cached Eiffel layout
			-- Note: Do not use directly!

	internal_path_provider: like path_provider
			-- Cache version of `path_provider'
			-- Note: Do not use directly!

	internal_cleaner: like cleaner
			-- Cache version of `cleaner'
			-- Note: Do not use directly!

	internal_backup_manager: like backup_manager
			-- Cache version of `backup_manager'
			-- Note: Do not use directly!

	internal_error_handler: like error_handler
			-- Cache version of `error_handler'
			-- Note: Do not use directly!

	internal_error_displayer: like error_displayer
			-- Cache version of `error_displayer'
			-- Note: Do not use directly!

invariant
	workbench_mode_change_actions_attached: workbench_mode_change_actions /= Void

;note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
