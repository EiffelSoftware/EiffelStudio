indexing
	description: "Set a cluster in the Cluster Editor"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SELECT_CLUSTER

inherit
	EV_COMMAND

	ONCES

creation
	make

feature -- Initialization

	make (c: like cluster_name; m: like main_window) is
			-- Initialize
		do
			cluster_name := c
			main_window := m
		end

feature -- Properties

	cluster_name: STRING
	main_window: EC_EDITOR_WINDOW [CLUSTER_DATA]

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			cluster: CLUSTER_DATA
		do
			if main_window /= Void then

				cluster := system.cluster_of_name (cluster_name)
				main_window.set_entity (cluster)
			end
		end

end -- class SELECT_CLUSTER
