note
	description: "Summary description for {CMS_STORAGE_NULL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_NULL

inherit
	CMS_STORAGE
		redefine
			default_create
		select
			default_create
		end

	CMS_USER_STORAGE_NULL
		undefine
			default_create
		end

	REFACTORING_HELPER
		rename
			default_create as default_create_rh
		end

feature -- Initialization

	default_create
		do
			create error_handler.make
		end

feature -- Status report

	is_available: BOOLEAN
			-- Is storage available?
		do
			Result := True
		end

	is_initialized: BOOLEAN
			-- Is storage initialized?
		do
			Result := True
		end

feature -- URL aliases

	set_path_alias (a_source: READABLE_STRING_8; a_alias: READABLE_STRING_8)
			-- <Precursor>.
		do
		end

	replace_path_alias (a_source: READABLE_STRING_8; a_previous_alias: detachable READABLE_STRING_8; a_alias: READABLE_STRING_8)
			-- Replace eventual previous alias `a_previous_alias' with a new alias `a_alias'
			-- on source `a_source'.
		do
		end

	unset_path_alias (a_source: READABLE_STRING_8; a_alias: READABLE_STRING_8)
			-- Unalias `a_source' from `a_alias'.
		do
		end

	path_alias (a_source: READABLE_STRING_8): detachable READABLE_STRING_8
			-- Return eventual path alias associated with `a_source'.
		do
		end

	source_of_path_alias (a_alias: READABLE_STRING_8): detachable READABLE_STRING_8
			-- Source path for alias `a_alias'.
		do
		end

feature -- Logs

	save_log (a_log: CMS_LOG)
			-- Save `a_log'.
		do
		end

feature -- Custom		

	set_custom_value (a_name: READABLE_STRING_8; a_value: attached like custom_value; a_type: detachable READABLE_STRING_8)
			-- Save data `a_name:a_value' for type `a_type' (or default if none).
		do
		end

	unset_custom_value (a_name: READABLE_STRING_8; a_type: detachable READABLE_STRING_8)
			-- Delete data `a_name' for type `a_type' (or default if none).
		do
		end

	custom_value (a_name: READABLE_STRING_GENERAL; a_type: detachable READABLE_STRING_8): detachable READABLE_STRING_32
			-- Data for name `a_name' and type `a_type' (or default if none).
		do
		end


end
