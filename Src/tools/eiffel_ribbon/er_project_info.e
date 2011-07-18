note
	description: "[
					Users project info
					It will be saved and loaded during sessions
																	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_PROJECT_INFO

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create ribbon_names.make (10)

			-- Default value
			ribbon_window_count := 1
		end

feature -- Query

	project_location: detachable STRING
			--

	ribbon_names: ARRAYED_LIST [detachable STRING]
			-- Names for different ribbons

	ribbon_window_count: INTEGER
			-- How many ribbon windows in current application

feature -- Command

	set_project_location (a_location: like project_location)
			--
		do
			project_location := a_location
		ensure
			set: project_location = a_location
		end

	set_ribbon_window_count (a_count: INTEGER)
			-- Set `ribbon_window_count' with `a_count'
		do
			ribbon_window_count := a_count
		end

	update_ribbon_names_from_ui
			--
		local
			l_shared: ER_SHARED_SINGLETON
			l_list: ARRAYED_LIST [ER_LAYOUT_CONSTRUCTOR]
		do
			from
				create l_shared
				ribbon_names.wipe_out
				l_list := l_shared.layout_constructor_list
				l_list.start
			until
				l_list.after
			loop
				if attached {EV_TREE_NODE} l_list.item.widget.i_th (1) as l_tree_node then
					if attached {ER_TREE_NODE_RIBBON_DATA} l_tree_node.data as l_data then
						ribbon_names.extend (l_data.command_name)
					end
				end
				l_list.forth
			end
		end

	update_ribbon_names_to_ui
			--
		local
			l_shared: ER_SHARED_SINGLETON
			l_list: ARRAYED_LIST [ER_LAYOUT_CONSTRUCTOR]
		do
			from
				create l_shared
				l_list := l_shared.layout_constructor_list
				l_list.start
			until
				l_list.after
			loop
				if attached {EV_TREE_NODE} l_list.item.widget.i_th (1) as l_tree_node then
					if attached {ER_TREE_NODE_RIBBON_DATA} l_tree_node.data as l_data then
						if ribbon_names.valid_index (l_list.index) then
							l_data.set_command_name (ribbon_names.i_th (l_list.index))
						end
					end
				end
				l_list.forth
			end
		end

end
