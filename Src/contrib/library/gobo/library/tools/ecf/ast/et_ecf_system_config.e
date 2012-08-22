note

	description:

		"ECF systems or libraries"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2008-2009, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_ECF_SYSTEM_CONFIG

create

	make

feature {NONE} -- Initialization

	make (a_name, a_filename: STRING)
			-- Create a new ECF config.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
			a_filename_not_void: a_filename /= Void
		do
			name := a_name
			filename := a_filename
		ensure
			name_set: name = a_name
			filename_set: filename = a_filename
		end

feature -- Access

	name: STRING
			-- Name

	filename: STRING
			-- ECF filename

	uuid: STRING
			-- UUID;
			-- May be Void when the ECF file described a system

	ecf_namespace: STRING
			-- ECF namespace
			--
			-- May be void if not explicitly specified in ECF file

	ecf_version: UT_VERSION
			-- ECF version
			--
			-- May be void if the ECF namespace has not been explicitly specified
			-- in the ECF file or if it was not recognized

	targets: ET_ECF_TARGETS
			-- Targets that appear in the ECF file

	library_target: ET_ECF_TARGET
			-- Library target, if any

feature -- Setting

	set_targets (a_targets: like targets)
			-- Set `targets' to `a_targets'.
		do
			targets := a_targets
		ensure
			targets_set: targets = a_targets
		end

	set_library_target (a_target: like library_target)
			-- Set `library_target' to `a_target'.
		do
			library_target := a_target
		ensure
			library_target_set: library_target = a_target
		end

	set_uuid (a_uuid: like uuid)
			-- Set `uuid' to `a_uuid'.
		do
			uuid := a_uuid
		ensure
			uuid_set: uuid = a_uuid
		end

	set_ecf_namespace (a_namespace: like ecf_namespace)
			-- Set `ecf_namespace' to `a_namespace'.
		do
			ecf_namespace := a_namespace
		ensure
			ecf_namespace_set: ecf_namespace = a_namespace
		end

	set_ecf_version (a_version: like ecf_version)
			-- Set `ecf_version' to `a_version'.
		do
			ecf_version := a_version
		ensure
			ecf_version_set: ecf_version = a_version
		end

invariant

	name_not_void: name /= Void
	name_not_empty: not name.is_empty
	filename_not_void: filename /= Void

end
