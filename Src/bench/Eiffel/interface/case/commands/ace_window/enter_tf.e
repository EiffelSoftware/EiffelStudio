indexing
	description: "Process Enter in the Text Field"
	date: "$Date$"
	revision: "$Revision$"

class
	ENTER_TF

inherit
	EV_COMMAND

	ONCES

creation
	make

feature -- init

	make ( ace : like ace_w; l: like list; t: like text_field) is 
	do
		ace_w := ace
		list := l
		text_field := t
	end

feature -- exec

	ace_w : EC_ACE_WINDOW
 
	list: EV_LIST

	text_field: SMART_TEXT_FIELD

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
	local
		cl : CLUSTER_DATA
		elem : SCROLL_ELEMENT_FOR_ACE
	do
		elem ?= list.selected_item
		if elem/= Void and then text_field/= Void then
			cl := elem.cluster_data

			if cl.is_root_for_generation then
			--	cl.save_file_name (text_field.text)
			else
			--	cl.set_file_name (text_field.text )
			end

			elem.set_text (elem.value)

			--Windows.main_graph_window.set_not_saved
			--ace_w.initialize_cluster_paths ( ace_w.cluster )
		end
	end

end -- class ENTER_TF
