indexing
	description: "Check if renamings, options and visiblities are done on valid classes."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CHECKER_VISITOR

inherit
	CONF_CONDITIONED_ITERATOR
		redefine
			process_group,
			process_cluster,
			process_override
		end

create
	make

feature -- Visit nodes

	process_group (a_group: CONF_GROUP) is
			-- Visit `a_group'.
		local
			l_ren: CONF_HASH_TABLE [STRING, STRING]
			l_classes: HASH_TABLE [CONF_CLASS, STRING]
			l_c_opt: HASH_TABLE [CONF_OPTION, STRING]
		do
			l_classes := a_group.classes
			check
				l_classes_not_void: l_classes /= Void
			end

				-- check renamings
			l_ren := a_group.renaming
			if l_ren /= Void then
				from
					l_ren.start
				until
					l_ren.after
				loop
					if not l_classes.has (l_ren.item_for_iteration) then
						add_error (create {CONF_ERROR_RENAM}.make (l_ren.item_for_iteration))
					end
					l_ren.forth
				end
			end
				-- check class options
			l_c_opt := a_group.class_options
			if l_c_opt /= Void then
				from
					l_c_opt.start
				until
					l_c_opt.after
				loop
					if not l_classes.has (l_c_opt.key_for_iteration) then
						add_error (create {CONF_ERROR_CLOPT}.make (l_c_opt.key_for_iteration))
					end
					l_c_opt.forth
				end
			end
		end

	process_cluster (a_cluster: CONF_CLUSTER) is
			-- Visit `a_cluster'.
		local
			l_classes: HASH_TABLE [CONF_CLASS, STRING]
			l_vis: HASH_TABLE [TUPLE [STRING, HASH_TABLE [STRING, STRING]], STRING]
		do
			l_classes := a_cluster.classes
			check
				l_classes_not_void: l_classes /= Void
			end

				-- check visibility
			l_vis := a_cluster.visible
			if l_vis /= Void then
				from
					l_vis.start
				until
					l_vis.after
				loop
					if not l_classes.has (l_vis.key_for_iteration) then
						add_error (create {CONF_ERROR_VISI}.make (l_vis.key_for_iteration))
					end
					l_vis.forth
				end
			end
		end

	process_override (an_override: CONF_OVERRIDE) is
			-- Visit `an_override'.
		do
			process_cluster (an_override)
		end

end
