indexing

	description: 
		"Dumps classes, features and attributes to stdout.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_DUMP_UNIVERSE

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
		do
			dump_cluster (Universe.clusters)
		end

	dump_cluster (cs: LINEAR [CLUSTER_I]) is
		local
			l: LINEAR [CLASS_I]
			s: STRING
			fd: EWB_DUMP_FEATURES
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
						if l.item.compiled then
							s := l.item.name
							s.to_upper
							print (s + "%N")
							create fd.make (s)
							fd.enable_operand_dump
							fd.execute
							print ("%N")
						end
						l.forth
					end
				end
				cs.forth
			end
			
		end

end -- class EWB_DUMP_UNIVERSE
