indexing
	description: "Selection of a view"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	VIEW_PAGE


inherit
	WINDOWS_MANAGER

creation
	make

feature -- Initialization

	make(par: EV_CONTAINER; new_mode: INTEGER) is
			-- Initialization
		require
			notebook_exists: par /= Void
		local
			com: EV_ROUTINE_COMMAND
			v1,v2: EV_VERTICAL_BOX
			h1,h2: EV_HORIZONTAL_BOX
			fix: EV_FIXED 
			note: EV_NOTEBOOK
			sep: EV_HORIZONTAL_SEPARATOR
		do
			mode := new_mode
			note ?= par
			caller_window ?= par
			!! v1.make(par)
			v1.set_spacing(10)
			if note /= Void then
				note.append_page(v1,"Views")
			end
			!! ev_list.make(v1)
			if mode=1 then
				!! com.make(~change_view)
				ev_list.add_selection_command(com, Void)
			elseif mode=3 then
				!! com.make(~display_view)
				ev_list.add_selection_command(com,Void)
			end
		
			if mode=2 then
				!! sep.make(v1)
				!! v2.make(v1)
				v2.set_expand(FALSE)
				!! h1.make(v2)
				!! name_t.make_horizontal(h1,"View Name: ")
				name_t.text_field.set_vertical_resize(FALSE)
				!! h2.make(v1)
				h2.set_expand(FALSE)
				!!fix.make(h2) 
				fix.set_minimum_width(10)
				fix.set_expand(FALSE)
				!! display_b.make_with_text(h2,"Display")
				display_b.set_horizontal_resize(FALSE)
				!! com.make(~change_view)
				display_b.add_click_command(com, VOid)
				!! add_b.make_with_text(h2,"Add")
				add_b.set_horizontal_resize(FALSE)
				!! com.make(~create_view)
				add_b.add_click_command(com, Void)
				
				!! delete_b.make_with_text(h2,"Delete")
				delete_b.set_horizontal_resize(FALSE)
				!! com.make(~delete_view)
				delete_b.add_click_command(com, Void)
			end


			fill_list
		end

	set_mode3(retriev: RETRIEVE_PROJECT;view_l: SYSTEM_VIEW_LIST) is
		require

		do
			retrieve_project := retriev
			view_list:= view_l
		end

feature -- Updates

	fill_list is
		local
			system_view_info: SYSTEM_VIEW_INFO
			system_view_list: SYSTEM_VIEW_LIST
			elem: VIEW_ITEM
			s: STRING
		do
			if mode=3 and then view_list /= Void then
				system_view_list := view_list 
			else
				system_view_list := System.retrieve_view_list
			end
			if system_view_list /= Void then	
				if system.view_name /= Void then 	
					s:= system.view_name
				end
				from
					system_view_list.start
					ev_list.clear_items
				until
					system_view_list.after
				loop
					system_view_info := system_view_list.item
					!! elem.make_with_view_info(ev_list,system_view_info)
					if s /= Void and then s.is_equal(system_view_info.view_name) then
						elem.set_selected(TRUE)
					end
					system_view_list.forth
				end
			end
		end

feature -- Implementation

	ev_list: EV_LIST

	display_b,delete_b,add_b: EV_BUTTON

	name_t: SMART_TEXT_FIELD

	mode: INTEGER
		-- Mode = 1 => used in Main Window
		-- Mode = 2 => used in View Tool

	retrieve_project: RETRIEVE_PROJECT

	view_list: SYSTEM_VIEW_LIST

	caller_window: VIEW_TOOL

feature -- Actions

	update is
		do
			ev_list.clear_items
			fill_list
		end

	change_view (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			project_directory: STRING
		do
			!! retrieve_project.make (first_window, Void)
			
			project_directory := retrieve_project.extract_directory (system.current_directory)
			
			retrieve_project.set_project_name (project_directory)

			display_view(Void,Void)
		end

	create_view (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			list: SYSTEM_VIEW_LIST
		do
			if name_t.text.count>0 then
				list := System.retrieve_view_list
				list.add_view_with_name (name_t.text)
				name_t.set_text("")
			end
			ev_list.clear_items
			fill_list
			first_window.update
		end
	
	delete_view (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			elem: VIEW_ITEM
			list: SYSTEM_VIEW_LIST
		do
			elem ?= ev_list.selected_item
			if elem /= VOid then
				list := System.retrieve_view_list
				list.delete_view_with_id(elem.view_info.view_id,
						Environment.view_file_name)
			end		
			first_window.update
		end

	display_view(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			elem: VIEW_ITEM	
		do
			elem ?= ev_list.selected_item
			if elem /= Void then
				--if mode=3 then
					retrieve_project.load_project (elem.view_info.view_id)
				--end
				if caller_window /= Void then
					caller_window.destroy
				end
			end
		end

invariant
	mode_consistent1: (mode = 1 implies (display_b=Void and delete_b=Void and add_b=Void))
	mode_consistent2: (mode = 2 implies (display_b/=VOid and delete_b/=Void and add_b/=Void))
	--mode_consistent3: (mode = 3 implies (display_b/=Void and delete_b=Void and add_b=Void))

end -- class VIEW_PAGE
