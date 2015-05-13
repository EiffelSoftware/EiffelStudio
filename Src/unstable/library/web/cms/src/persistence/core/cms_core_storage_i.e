note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_CORE_STORAGE_I

inherit
	SHARED_LOGGER

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

feature -- URL aliases

	set_path_alias (a_source: READABLE_STRING_8; a_alias: READABLE_STRING_8)
			-- Alias `a_source' with `a_alias'.
		deferred
		end

	replace_path_alias (a_source: READABLE_STRING_8; a_previous_alias: detachable READABLE_STRING_8; a_alias: READABLE_STRING_8)
			-- Replace eventual previous alias `a_previous_alias' with a new alias `a_alias'
			-- on source `a_source'.
		deferred
		end

	unset_path_alias (a_source: READABLE_STRING_8; a_alias: READABLE_STRING_8)
			-- Unalias `a_source' from `a_alias'.
		deferred
		end

	path_alias (a_source: READABLE_STRING_8): detachable READABLE_STRING_8
			-- Return eventual path alias associated with `a_source'.
		deferred
		end

	source_of_path_alias (a_alias: READABLE_STRING_8): detachable READABLE_STRING_8
			-- Source path for alias `a_alias'.
		deferred
		end

feature -- Logs

	save_log (a_log: CMS_LOG)
			-- Save `a_log'.
		deferred
		end

feature -- Misc

	set_custom_value (a_name: READABLE_STRING_8; a_value: attached like custom_value; a_type: detachable READABLE_STRING_8)
			-- Save data `a_name:a_value' for type `a_type' (or default if none).
		deferred
		end

	unset_custom_value (a_name: READABLE_STRING_8; a_type: detachable READABLE_STRING_8)
			-- Delete data `a_name' for type `a_type' (or default if none).
		deferred
		end

	custom_value (a_name: READABLE_STRING_GENERAL; a_type: detachable READABLE_STRING_8): detachable READABLE_STRING_32
			-- Data for name `a_name' and type `a_type' (or default if none).
		deferred
		end


end
