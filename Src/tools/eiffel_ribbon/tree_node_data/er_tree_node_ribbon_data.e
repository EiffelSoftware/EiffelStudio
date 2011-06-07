note
	description: "Summary description for {ER_TREE_NODE_RIBBON_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_RIBBON_DATA

inherit
	ER_TREE_NODE_DATA
		redefine
			new_unique_command_name
		end

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			command_name_prefix := "ribbon_"
			xml_constants := {ER_XML_CONSTANTS}.ribbon
			new_unique_command_name
		end

feature -- Implementation

	new_unique_command_name
			-- Initialize a command name automatically
		local
			l_shared: ER_SHARED_SINGLETON
			l_command_name: STRING
			l_count: INTEGER
		do
				-- Count how many layout constructors
			create l_shared

			l_count := l_shared.layout_constructor_list.count

				-- check if the command name conflict with others'
			from
				l_command_name := command_name_prefix + l_count.out
			until
				not is_layout_constructor_name_conflict (l_shared.layout_constructor_list, l_command_name)
			loop
				l_count := l_count + 1
				l_command_name := command_name_prefix + l_count.out
			end
			set_command_name (l_command_name)
		end

	is_layout_constructor_name_conflict (a_all_constructors: ARRAYED_LIST [ER_LAYOUT_CONSTRUCTOR]; a_command_name: STRING): BOOLEAN
			--
		require
			not_void: a_all_constructors /= Void
			valid: a_command_name /= Void and then not a_command_name.is_empty
		do
			from
				a_all_constructors.start
			until
				a_all_constructors.after or Result
			loop
				if attached {ER_TREE_NODE_RIBBON_DATA} a_all_constructors.item.widget.data as l_data then
					if attached l_data.command_name as l_command_name then
						Result := l_command_name.same_string (a_command_name)
					end
				end
				a_all_constructors.forth
			end
		end

end
