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
	execute ( a: ANY ) is 
	local
		aa : GRAPHICAL_DEGREE_OUTPUT
		bb : WARNER_W
		format_case : FORMAT_CASE_STORAGE
		l : LINKED_LIST [ CLUSTER_I ]
		e : SCROLLABLE_LIST_CLUSTERS
	do
		!!aa
		aa.put_case_message("Starting Reverse Process")
	--	aa.put_start_reverse_engineering (300)
		!! bb.make (case_window)
		!! format_case.make (bb,
			aa,FALSE)
		!! l.make
		from
			case_window.scroll_list2.start
		until
			case_window.scroll_list2.after
		loop
			e ?= case_window.scroll_list2.item
			l.extend ( e.cluster )
			case_window.scroll_list2.forth
		end
		format_case.set_list_clusters ( l )

		format_case.execute
		case_window.unrealize
		aa.destroy
	end

end -- class GENERATE_SELEC_REVERSE
