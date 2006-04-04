indexing
	description: "The configuration system."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_SYSTEM

inherit
	CONF_VISITABLE

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; an_uuid: UUID) is
			-- Creation with `a_name' and `an_uuid'.
		require
			a_name_ok: a_name /= Void and not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			create targets.make (1)
			name := a_name
			uuid := an_uuid
		ensure
			name_set: name = a_name
			uuid_set: uuid = an_uuid
		end

feature -- Access, stored in configuration file

	name: STRING
			-- Name of the system.

	description: STRING
			-- A description about the system.

	uuid: UUID
			-- Universal unique identifier that identifies this system.

	targets: HASH_TABLE [CONF_TARGET, STRING]
			-- The configuration targets.

	library_target: CONF_TARGET
			-- The target to use if this is used as a library.

feature -- Access, in compiled only

	file_name: STRING

feature -- Update, in compiled only

	set_file_name (a_file_name: like file_name) is
			-- Set `file_name' to `a_file_name'.
		require
			a_file_name_ok: a_file_name /= Void and then not a_file_name.is_empty
		do
			file_name := a_file_name
		end

feature -- Access queries

	compilable_targets: like targets is
			-- The compilable targets.
		local
			l_target: CONF_TARGET
		do
			create Result.make (targets.count)
			from
				targets.start
			until
				targets.after
			loop
				l_target := targets.item_for_iteration
				if l_target.root /= Void then
					Result.force (l_target, l_target.name)
				end
				targets.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_name (a_name: like name) is
			-- Set `name' to `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_description (a_description: like description) is
			-- Set `description' to `a_description'.
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

	set_uuid (an_uuid: like uuid): BOOLEAN is
			-- Set `uuid' to `a_uuid'.
		require
			an_uuid_valid: an_uuid /= Void
		do
			uuid := an_uuid
		ensure
			uuid_set: uuid = an_uuid
		end

	add_target (a_target: CONF_TARGET) is
			-- Add `a_target' to `targets'.
		require
			a_target_not_void: a_target /= Void
		do
			targets.force (a_target, a_target.name)
		end

	remove_target (a_name: STRING) is
			-- Remove the target with name `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		do
			targets.remove (a_name)

			if library_target /= Void and then library_target.name.is_equal (a_name) then
				library_target := Void
			end
		end

	set_library_target (a_target: like library_target) is
			-- Set `library_target' to `a_target'.
		do
			library_target := a_target
		end

feature -- Equality

	is_group_equivalent (other: like Current): BOOLEAN is
			-- Is `other' and `Current' the same with respect to the group layout?
		local
			l_o_targets: like targets
			l_o_target: CONF_TARGET
		do
			if targets.count = other.targets.count then
				Result := True
				from
					targets.start
					l_o_targets := other.targets
					l_o_targets.start
				until
					not Result or targets.after or l_o_targets.after
				loop
					l_o_target := l_o_targets.item (targets.key_for_iteration)
					Result := l_o_target /= Void and then targets.item_for_iteration.is_group_equivalent (l_o_target)
					targets.forth
					l_o_targets.forth
				end
			end
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_system (Current)
		end

feature -- Dummy

	compile_all_classes: BOOLEAN

invariant
	name_ok: name /= Void and then not name.is_empty
	name_lower: name.is_equal (name.as_lower)
	targets_not_void: targets /= Void
end
