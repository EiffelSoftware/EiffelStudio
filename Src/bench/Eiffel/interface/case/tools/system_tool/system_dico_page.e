indexing
	description: "Dictionnary of the system"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_DICO_PAGE

inherit
	EDITOR_WINDOW_PAGE
		redefine
			make
		end

	ONCES

creation
	make

feature -- Initialization

	make (noteb: EV_NOTEBOOK; ent: ANY) is
			-- Initialize
		local
			h1,h2: EV_HORIZONTAL_BOX
			f1: EV_FRAME
			fix: EV_FIXED
			v1: EV_VERTICAL_BOX
			com: EV_ROUTINE_COMMAND
		do
			precursor ( noteb, ent)
			notebook.append_page(page, "Dictionary")
			!! fix.make ( page )
			fix.set_minimum_height(15)
			fix.set_expand(FALSE)
			!! f1.make_with_text ( page,"Find a string" )
			f1.set_expand(FALSE)
			!! h1.make ( f1 )
			h1.set_spacing(20)
			h1.set_vertical_resize(FALSE)
			!! search_text.make(h1)
			search_text.set_expand(FALSE)
			search_text.set_minimum_width_in_characters(20)
			!! find_b.make_with_text(h1,"FIND CLUSTERS AND CLASSES")
			find_b.set_vertical_resize(FALSE)
			find_b.set_expand(FALSE)
			!!com.make(~find)
			find_b.add_click_command(com, Void)
			!! v1.make(h1)
			!! cluster_selected.make_with_text(v1,"Cluster")
			cluster_selected.set_state(TRUE)
			!! class_selected.make_with_text(v1,"Class")
			class_selected.set_state(TRUE)
			!! description_selected.make_with_text(v1,"Description")
			description_selected.set_state(TRUE)
			!! ev_list.make ( page )
		end

feature {NONE} -- Implementation 
	
	cluster_selected ,class_selected, description_selected: EV_CHECK_BUTTON

	search_text: EV_TEXT_FIELD

	find_b: EV_BUTTON

	ev_list: EV_LIST

feature -- Access

	reset, do_page is do end

	update_from(list: SORTED_TWO_WAY_LIST [LINKABLE_DATA];linkable, description: BOOLEAN) is
		-- Fill the page with Current System
		local
			item: LINKABLE_ITEM
			s: STRING
			add_linkable: BOOLEAN
			look_for: STRING
		do
			list.start
			list.sort
			from
				list.start
				look_for := search_text.text
				look_for.to_lower
			until
				list.after
			loop
				if linkable then
					s:= list.item.name
					s.to_lower
					add_linkable := (s.substring_index(look_for,1)>0)
				end
				if not add_linkable and then description then
					s:= list.item.description.text_value
					s.to_lower
					add_linkable := (s.substring_index(look_for,1)>0)
				end
				if add_linkable then
					!! item.make_spc ( ev_list,list.item)
				end
				list.forth
			end
		end

	update is
			-- Empty the list since some of their data may have changed.
		do
			ev_list.clear_items
		end

feature -- Operations

	find(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Find "linkables" responding to the criteria *_selected
		local
			clu, cla, des: BOOLEAN
		do
			ev_list.clear_items
			clu := cluster_selected.state
			cla := class_selected.state
			des := description_selected.state
			if clu or des then
				update_from(system.clusters_in_system, clu, des )
			end
			if cla or des then
				update_from(system.classes_in_system, clu, des )
			end		
		end

end -- class SYSTEM_DICO_PAGE
