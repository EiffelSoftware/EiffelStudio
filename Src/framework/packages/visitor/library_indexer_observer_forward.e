note
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_INDEXER_OBSERVER_FORWARD

inherit
	LIBRARY_INDEXER_OBSERVER
		redefine
			on_ecf_file_found,
			on_folder_enter,
			on_folder_leave,
			on_ecf_file_enter,
			on_ecf_file_leave,
			on_system_enter,
			on_system_leave,
			on_application_system,
			on_target,
			on_library,
			on_cluster,
			on_class
		end

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER)
		do
			create observers.make (n)
		end

feature -- Visit

	frozen on_ecf_file_found (p: PATH)
		do
			across observers as o loop
				o.on_ecf_file_found (p)
			end
		end

	frozen on_folder_enter (p: PATH)
		do
			across observers as o loop
				o.on_folder_enter (p)
			end
		end

	frozen on_folder_leave (p: PATH)
		do
			across observers as o loop
				o.on_folder_leave (p)
			end
		end

	frozen on_ecf_file_enter (p: PATH)
		do
			across observers as o loop
				o.on_ecf_file_enter (p)
			end
		end

	frozen on_ecf_file_leave (p: PATH)
		do
			across observers as o loop
				o.on_ecf_file_leave (p)
			end
		end

	frozen on_system_enter (a_cfg: CONF_SYSTEM)
		do
			across observers as o loop
				o.on_system_enter (a_cfg)
			end
		end

	frozen on_system_leave (a_cfg: CONF_SYSTEM)
		do
			across observers as o loop
				o.on_system_leave (a_cfg)
			end
		end

	frozen on_application_system (a_cfg: CONF_SYSTEM)
		do
			across observers as o loop
				o.on_application_system (a_cfg)
			end
		end

	frozen on_target (a_target: CONF_TARGET)
		do
			across observers as o loop
				o.on_target (a_target)
			end
		end

	frozen on_library (a_lib: CONF_LIBRARY)
		do
			across observers as o loop
				o.on_library (a_lib)
			end
		end

	frozen on_cluster (a_cluster: CONF_CLUSTER)
		do
			across observers as o loop
				o.on_cluster (a_cluster)
			end
		end

	frozen on_class (a_class: CONF_CLASS)
		do
			across observers as o loop
				o.on_class (a_class)
			end
		end

feature -- Observers

	register_observer (obs: LIBRARY_INDEXER_OBSERVER)
		do
			observers.force (obs)
		end

	unregister_observer (obs: LIBRARY_INDEXER_OBSERVER)
		do
			observers.prune_all (obs)
		end

feature {NONE} -- Observers

	Observers: ARRAYED_LIST [LIBRARY_INDEXER_OBSERVER]
			-- Associated observers

;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
