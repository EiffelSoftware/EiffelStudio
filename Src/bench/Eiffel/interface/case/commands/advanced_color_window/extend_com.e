indexing
	description: "Extend the List with the Classes of the Current Class's Cluster"
	author: "kolli"
	date: "$Date$"
	revision: "$Revision$"

class
	EXTEND_COM

inherit
	--EC_COMMAND

	EV_COMMAND

creation
	make

feature -- Initialization

	make (a: like algo_window) is
			-- Initialize
		do
			algo_window := a
		end

feature
		-- Properties
	algo_window: ADVANCED_COLOR_WINDOW
feature
	-- EC_COMMAND Implementation

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
	local
	--	scroll_list: EC_SCROLLABLE_LIST
	--	scroll_element: ELEMENT_SCROLL_FOR_ALGO
		class_data: CLASS_DATA
		cluster: CLUSTER_DATA
	do
	--	scroll_list := algo_window.scroll_list2
	--	scroll_element ?= scroll_list.selected_item
	--	if scroll_element /= Void then
	--		class_data := scroll_element.class_data
	--		cluster := class_data.parent_cluster
	--		extend (cluster)
	--	end
	end

feature
		--execution

	extend (cluster: CLUSTER_DATA) is
	local
		class_list: LINKED_LIST [CLASS_DATA]
	do
	--	class_list := cluster.classes
	--	from
	--		class_list.start
	--	until
	--		class_list.after
	--	loop
	--		algo_window.add_class_in_list (class_list.item)
	--		class_list.forth
	--	end

	end
end -- class EXTEND_COM
