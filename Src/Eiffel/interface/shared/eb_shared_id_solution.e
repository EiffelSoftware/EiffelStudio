indexing
	description: "Identifier solution"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_ID_SOLUTION

inherit
	SHARED_WORKBENCH

feature -- Access

	id_of_group (a_group: CONF_GROUP): STRING is
			-- Identifier of `a_group'
			-- "target_uuid.group_name"
		require
			a_group_not_void: a_group /= Void
		do
			create Result.make (50)
			Result.append (a_group.target.system.uuid.out)
			Result.extend (name_sep)
			Result.append (a_group.name)
		ensure
			result_not_void: Result /= Void
		end

	group_of_id (a_id: STRING): CONF_GROUP is
			-- Group of `a_id'
		require
			a_id_not_void: a_id /= Void
		local
			l_strings: LIST [STRING]
			uuid: STRING
			group_name: STRING
			l_target: CONF_TARGET
		do
			l_strings := a_id.split (name_sep)
			if l_strings.count = 2 then
				uuid := l_strings.i_th (1)
				group_name := l_strings.i_th (2)
				if universe.target.system.uuid.out.is_equal (uuid) then
					l_target := universe.target
				else
					l_target := universe.target.all_libraries.item (create {UUID}.make_from_string (uuid))
				end
				if l_target /= Void then
					Result := l_target.groups.item (group_name)
				end
			end
		end

	id_of_class (a_class: CONF_CLASS): STRING is
			-- Unique id of a class in the system
			-- "target_uuid.group_name.class_name"
		require
			a_class_not_void: a_class /= Void
		local
			l_group: CONF_GROUP
		do
			l_group := a_class.group
			create Result.make (50)
			Result.append (l_group.target.system.uuid.out)
			Result.extend (name_sep)
			Result.append (l_group.name)
			Result.extend (name_sep)
			Result.append (a_class.name)
		ensure
			result_not_void: Result /= Void
		end

	class_of_id (a_id: STRING): CONF_CLASS is
			-- Class of `a_id'
		require
			a_id_not_void: a_id /= Void
		local
			l_strings: LIST [STRING]
			uuid: STRING
			group_name: STRING
			class_name: STRING
			l_target: CONF_TARGET
			l_group: CONF_CLUSTER
		do
			l_strings := a_id.split (name_sep)
			if l_strings.count = 3 then
				uuid := l_strings.i_th (1)
				group_name := l_strings.i_th (2)
				class_name := l_strings.i_th (3)
				if universe.target.system.uuid.out.is_equal (uuid) then
					l_target := universe.target
				else
					l_target := universe.target.all_libraries.item (create {UUID}.make_from_string (uuid))
				end
				if l_target /= Void then
					l_group ?= l_target.groups.item (group_name)
					if l_group /= Void then
						Result := l_group.classes.item (class_name)
					end
				end
			end
		end

	generate_uuid: STRING is
			-- Generate uuid
		do
			Result := uuid_gen.generate_uuid.out
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	uuid_gen: UUID_GENERATOR is
			-- UUID generator
		once
			create Result
		end

	name_sep: CHARACTER is '.'
			-- Name separator

invariant
	invariant_clause: True -- Your invariant here

end
