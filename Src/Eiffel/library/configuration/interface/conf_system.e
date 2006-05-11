indexing
	description: "The configuration system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_SYSTEM

inherit
	CONF_VISITABLE

	CONF_FILE_DATE

create
	make,
	make_with_uuid

feature {NONE} -- Initialization

	make (a_name: STRING) is
			-- Creation with a automatically generated UUID.
		require
			a_name_ok: a_name /= Void and not a_name.is_empty
		do
			make_with_uuid (a_name, (create {UUID_GENERATOR}).generate_uuid)
		end

	make_with_uuid (a_name: STRING; an_uuid: UUID) is
			-- Creation with `a_name' and `an_uuid'.
		require
			a_name_ok: a_name /= Void and not a_name.is_empty
			an_uuid_ok: an_uuid /= Void
		do
			create targets.make (1)
			create target_order.make (1)
			name := a_name.as_lower
			uuid := an_uuid
		ensure
			name_set: name /= Void and then name.is_equal (a_name.as_lower)
			uuid_set: uuid = an_uuid
		end

feature -- Status

	store_successful: BOOLEAN
			-- Was the last `store' operation successful?

	date_has_changed: BOOLEAN is
		local
			str: ANY
			new_date: INTEGER
		do
			str := file_name.to_c
			eif_date ($str, $new_date)
			Result := new_date /= file_date
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
			-- File name of config file.

	file_date: INTEGER
			-- File modification date of config file.

	application_target: CONF_TARGET
			-- Target of application this system is part of.

feature -- Update, in compiled only

	set_file_name (a_file_name: like file_name) is
			-- Set `file_name' to `a_file_name'.
		require
			a_file_name_ok: a_file_name /= Void and then not a_file_name.is_empty
		do
			file_name := a_file_name
		ensure
			name_set: file_name = a_file_name
		end

	set_file_date is
			-- Set `file_date' to last modified date of `file_name'.
		local
			str: ANY
		do
			str := file_name.to_c
			eif_date ($str, $file_date)
		end

	set_application_target (a_target: CONF_TARGET) is
			-- Set `application_target' to `a_target'.
			-- (export status {CONF_ACCESS})
		require
			a_target_not_void: a_target /= Void
		do
			application_target := a_target
		ensure
			application_target_set: application_target = a_target
		end

feature -- Store to disk

	store is
			-- Store system back to its config file (only system itself is stored, libraries are not stored).
		require
			file_name_set: file_name /= Void and then not file_name.is_empty
		local
			l_print: CONF_PRINT_VISITOR
			l_file: PLAIN_TEXT_FILE
		do
			create l_print.make
			process (l_print)
			if not l_print.is_error then
				create l_file.make (file_name)
				if (l_file.exists and then l_file.is_writable) or else l_file.is_creatable then
					l_file.open_write
					l_file.put_string (l_print.text)
					l_file.close
					store_successful := True
				end
			end
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
		do
			name := a_name.as_lower
		ensure
			name_set: name.is_equal (a_name)
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
			target_order.force (a_target)
		end

	remove_target (a_name: STRING) is
			-- Remove the target with name `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		do
			if targets.has (a_name) then
				target_order.search (targets.found_item)
				target_order.remove
				targets.remove (a_name)
			end

			if library_target /= Void and then library_target.name.is_equal (a_name) then
				library_target := Void
			end
		end

	set_library_target (a_target: like library_target) is
			-- Set `library_target' to `a_target'.
		require
			no_overrides: a_target /= Void implies a_target.overrides.is_empty
		do
			library_target := a_target
		end

	set_library_target_by_name (a_target: STRING) is
			-- Set `library_target' to `a_target'.
		require
			a_target_valid: a_target /= Void and then not a_target.is_empty implies targets.has (a_target)
		do
			if a_target /= Void and then not a_target.is_empty then
				set_library_target (targets.item (a_target))
			else
				set_library_target (Void)
			end
		end

	update_targets (a_target_list: LIST [STRING]; a_factory: CONF_FACTORY) is
			-- add/remove/reorder targets so that we get the targets in `a_target_list'
			-- use `a_factory' to create new targets.
		require
			a_factory_not_void: a_factory /= Void
		local
			l_old_targets: like targets
		do
			target_order.wipe_out
			if a_target_list = Void then
				targets.clear_all
			else
				l_old_targets := targets
				create targets.make (l_old_targets.count)
				from
					a_target_list.start
				until
					a_target_list.after
				loop
					l_old_targets.search (a_target_list.item)
					if l_old_targets.found then
						add_target (l_old_targets.found_item)
					else
						add_target (a_factory.new_target (a_target_list.item, Current))
					end
					a_target_list.forth
				end
			end
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

feature {CONF_VISITOR, CONF_ACCESS} -- Implementation

	target_order: ARRAYED_LIST [CONF_TARGET]
			-- Order the targets appear in configuration file.

feature {NONE} -- Implementation

	same_targets: BOOLEAN is
			-- Do targets and target_order have the same content?
		do
			Result := targets.count = target_order.count
			if Result then
				from
					target_order.start
				until
					not Result or target_order.after
				loop
					Result := targets.has (target_order.item.name) and then targets.found_item = target_order.item
					target_order.forth
				end
			end
		end

invariant
	name_ok: name /= Void and then not name.is_empty
	name_lower: name.is_equal (name.as_lower)
	targets_not_void: targets /= Void
	target_order_not_void: target_order /= Void
	target_and_order_same_content: same_targets

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
