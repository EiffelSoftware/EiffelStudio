indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class 
	GENERATE_SELEC_REVERSE
inherit

	CASE_COMMAND2

creation

	make

feature

	execute (a: ANY) is 
		local
			aa : GRAPHICAL_DEGREE_OUTPUT
			bb : WARNER_W
			format_case : FORMAT_CASE_STORAGE
			l : LINKED_LIST [ CLUSTER_I ]
			e : SCROLLABLE_LIST_CLUSTERS
		do
			case_window.hide
			!!aa
			aa.set_parent_window (case_window.Project_tool.implementation)
			aa.put_case_message("Starting Reverse Process")
			!! bb.make (Project_tool)
			!! format_case.make (bb, aa,FALSE)
			!! l.make
			from
				case_window.scroll_list2.start
			until
				case_window.scroll_list2.after
			loop
				e ?= case_window.scroll_list2.item
				l.extend ( e.cluster )
				l.forth
				case_window.scroll_list2.forth
			end
			format_case.set_list_clusters ( l )
	
			format_case.execute ( case_window.text_field1.text )
			aa.destroy
		end

end -- class GENERATE_SELEC_REVERSE