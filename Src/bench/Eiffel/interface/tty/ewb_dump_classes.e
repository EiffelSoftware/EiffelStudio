indexing
	description: 
		"Dumps compiled non deferred classed with `default_create' to stdout."
	date: "$Date$"
	revision: "$Revision $"

class EWB_DUMP_CLASSES

inherit

	EWB_CMD
		rename
			name as externals_cmd_name,
			help_message as externals_help,
			abbreviation as externals_abb
		end

	SHARED_WORKBENCH

creation

	do_nothing

feature

	execute is
			-- Dump class information.
		do
			dump_cluster (Universe.clusters)
		end

	dump_cluster (cs: LINEAR [CLUSTER_I]) is
			-- Recursive function called by `execute'.
		local
			l: LINEAR [CLASS_I]
			s: STRING
		do
			from
				cs.start
			until
				cs.after
			loop
				if cs.item.sub_clusters /= Void then
					dump_cluster (cs.item.sub_clusters)
				end
				if cs.item.classes /= Void then
					from
						l := cs.item.classes.linear_representation
						l.start
					until
						l.after
					loop
						if
							l.item.compiled and
							not l.item.compiled_class.is_deferred and
							l.item.compiled_class.creators.has ("default_create")
						then
							s := l.item.name
							s.to_upper
							print (s + "%N")
						end
						l.forth
					end
				end
				cs.forth
			end
			
		end

end -- class EWB_DUMP_CLASSES
