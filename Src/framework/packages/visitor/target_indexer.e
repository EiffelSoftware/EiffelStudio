note
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_INDEXER

inherit
	SHARED_EXECUTION_ENVIRONMENT

	LIBRARY_INDEXER_OBSERVER_FORWARD
		rename
			make as make_observers
		end

	PACKAGE_CONF_VISITOR
		rename
			make as make_visitor
		export
			{NONE} all;
			{ANY} set_is_stopping_at_library, set_is_indexing_class, set_is_ignoring_redirection,
				set_is_any_setting, set_platform, set_concurrency, set_build
		redefine
			visit_target,
			visit_library,
			visit_cluster,
			visit_class,
			reset
		end

create
	make

feature {NONE} -- Initialization

	make (opts: detachable STRING_TABLE [detachable READABLE_STRING_GENERAL])
		do
			make_visitor
			if opts /= Void then
				set_platform (opts.item ("platform"))
				set_concurrency (opts.item ("concurrency"))
				set_build (opts.item ("build"))
				set_is_any_setting (attached opts.item ("is_any") as s and then s.is_case_insensitive_equal ("true"))
				is_il_generation := attached opts.item ("is_il_generation") as s and then s.is_case_insensitive_equal ("True")
					-- FIXME: missing void safety !!!
			end

			make_observers (0)
		end

feature -- Change

	reset
		do
			Precursor
		end

feature -- Execution

	visit_target (a_target: CONF_TARGET)
		do
			on_target (a_target)
			Precursor {PACKAGE_CONF_VISITOR} (a_target)
		end

	visit_library (a_library: CONF_LIBRARY)
		local
			l_state: like current_conf_state
		do
			l_state := current_conf_state
			if is_any_setting then
				update_conditions_to_any_setting (a_library.internal_conditions)
			end
			if
				l_state /= Void and then
				a_library.is_enabled (l_state)
			then
				on_library (a_library)
				if is_stopping_at_library then
				elseif a_library.is_readonly and is_stopping_at_readonly_library then
				else
					Precursor {PACKAGE_CONF_VISITOR} (a_library)
				end
			end
		end

	visit_cluster (a_cluster: CONF_CLUSTER)
		local
			p: PATH
			dir_name, l_name: STRING_32
			fac: LIBRARY_INDEXER_CONF_FACTORY
			l_scan: LIBRARY_EIFFEL_CLASS_SCANNER
		do
			check not is_stopping_at_library end

			if a_cluster.is_hidden then
					-- Class are not "visible"
			else
				on_cluster (a_cluster)
				if is_any_setting then
					update_conditions_to_any_setting (a_cluster.internal_conditions)
					if
						is_indexing_class and then
						attached current_conf_state as l_state and then
						a_cluster.is_enabled (l_state)
					then
						p := a_cluster.location.evaluated_path
						dir_name := p.name
						create fac
						create l_scan.make
						l_scan.process_directory (p)
						across
							l_scan.items as ic
						loop
							p := ic
							if attached p.entry as l_eiffel_file_name then
								l_name := p.parent.name
								if l_name.starts_with_general (dir_name) then
									l_name.remove_head (dir_name.count + 1)
								end
								visit_class (fac.new_class (l_eiffel_file_name.name, a_cluster, l_name, Void))
							end
						end
					end
				else
					Precursor {PACKAGE_CONF_VISITOR} (a_cluster)
				end
			end
		end

	update_condition_to_any_setting (cond: CONF_CONDITION)
		do
			if not is_platform_set then
				cond.wipe_out_platform -- Keep platform, for local index!
			end
			cond.wipe_out_concurrency
			cond.wipe_out_build
			cond.wipe_out_custom
		end

	update_conditions_to_any_setting (lst: detachable CONF_CONDITION_LIST)
		do
			if lst /= Void then
				across
					lst as ic
				loop
					update_condition_to_any_setting (ic)
				end
			end
		end

	visit_class (a_class: CONF_CLASS)
		do
			check not is_stopping_at_library end
			check is_indexing_class end
			on_class (a_class)
			Precursor {PACKAGE_CONF_VISITOR} (a_class)
		end

note
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
