indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SYSTEM_CHART_PAGE

inherit
	EDITOR_WINDOW_PAGE
		redefine
			make
		end

feature -- Initialization

	make (noteb: EV_NOTEBOOK; ent: ANY) is
			-- Initialize
		local
			sep: EV_HORIZONTAL_SEPARATOR
			fr: EV_FRAME
			h1: EV_HORIZONTAL_BOX
			v1: EV_VERTICAL_BOX
			com: EV_ROUTINE_COMMAND
		do
			precursor ( noteb, ent)
			
			page.set_homogeneous(FALSE)
			page.set_spacing(10)
			!! columns_list.make_with_text ( page,<<"Cluster","Description">>)
			columns_list.set_columns_width (<<150,300>>)
			columns_list.set_single_selection
			columns_list.set_minimum_height(250)
			!! com.make (~edit_description)
			columns_list.add_selection_command(com,Void)
			!! sep.make(page)
			!! fr.make_with_text(page,"Selected Description")
			fr.set_expand(FALSE)
			!! h1.make(fr)
			h1.set_spacing(10)
			h1.set_homogeneous(FALSE)
			!! description.make(h1)
			!! v1.make ( h1 )
			v1.set_spacing(15)
			v1.set_expand(FALSE)
			!! apply_b.make_with_text(v1,"Apply")
			apply_b.set_expand(FALSE)	
			!! com.make(~apply)
			apply_b.add_click_command(com, Void)
			!! reset_b.make_with_text(v1,"Reset")
			!! com.make(~reset_description)
			reset_b.add_click_command(com, Void)
			reset_b.set_expand(FALSE)
			!! sep.make(v1)
			!! next_b.make_with_text(v1,"Next")
			!! com.make(~next_page)
			next_b.add_click_command(com, Void)
			next_b.set_expand(FALSE)
			!! previous_b.make_with_text(v1,"Previous")
			previous_b.set_expand(FALSE)
			!! com.make (~previous_page)
			previous_b.add_click_command(com, Void)
		end

feature -- Implementation 

	apply_b,reset_b,next_b,previous_b: EV_BUTTON

	columns_list: EV_MULTI_COLUMN_LIST

	description: EV_TEXT

	selected_item: LINKABLE_CHART_ITEM

feature -- Access

	reset,do_page is do end

	update is deferred end

	update_from (list: SORTED_TWO_WAY_LIST [LINKABLE_DATA]) is
			-- Generate system chart in list.
		local
			item: LINKABLE_CHART_ITEM
		do
			columns_list.clear_items
			list.start
			list.sort
			from
				list.start
			until
				list.after
			loop
				!! item.make_spc ( columns_list,list.item)
				list.forth
			end
		end

	edit_description(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		-- Edit description corresponding to hightlighted cluster.
		require
			something_selected: columns_list.selected
		local
			item: LINKABLE_CHART_ITEM
		do
			item ?= columns_list.selected_item
			selected_item := item
			description.set_text(selected_item.linkable_data.description.text_value)
		end

	apply(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		-- apply description
		local
			desc: DESCRIPTION_DATA
			s: STRING
			index: INTEGER
		do
			if selected_item /= Void and then description.text /= Void then
				desc := selected_item.linkable_data.description
				desc.wipe_out
				desc.extend(description.text)
				s := description.text
				index := s.index_of('%N',1) 
				if index >1 then
					s := s.substring(1,index-1)
					s.append(" ...")
				end
				selected_item.set_cell_text (2,s)
				observer_management.update_observer(selected_item.linkable_data)
			end
		end

	reset_description (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Reset the description to its former value.
		local
			linkable: LINKABLE_DATA
		do
			if selected_item /= Void then
				linkable := selected_item.linkable_data
				description.set_text(linkable.description.text_value)
			end
		end

	previous_page(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
		end
	
	next_page(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
		end

end -- class SYSTEM_CHART_PAGE
