indexing
	description: "Text which possess the properties of pick-and-drop"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	ACTIVE_TEXT

inherit
	CONSTANTS

creation
	make

feature -- Creation

	make is
			-- Initialization
		do
			!! clickable_elements
			!! image.make(20)
			indent_index := 0
		end

feature -- Settings

	set_page (ed: like page) is
		do
			page := ed
		end


feature -- Access

	index: INTEGER is
		do
			Result := indent_index
		end

feature -- Implementation

	clickable_elements: CLICKABLE_STRUCTURE

	page: EDITOR_WINDOW_PAGE

	indent_index: INTEGER

	image: STRING

feature -- Add/Remove elements

	append_string(s: STRING) is
		require
			s_not_void: s/=Void
		do
			image.append(s)
		end

	append_stone(s: STRING; data: DATA) is
		require
			s_possible: s/=Void and then s.count>0
		local
			click_stone: EC_CLICK_STONE
		do
			!! click_stone.make(data,image.count+1,image.count+1+s.count)
			add_stone(click_stone)
			image.append(s)
		end

	new_line is
		local
			i: INTEGER
		do
			image.append("%N")
			if indent_index>0 then
				from
					i := 1
				until
					i > indent_index
				loop
					image.append("%T")
					i := i+1
				end
			end
		end

	exdent is
		require
			exdent_possible: index> 0
		do
			indent_index := indent_index - 1
		end

	indent is
		do
			indent_index := indent_index + 1
		end


feature {NONE} -- Implementation

	add_stone(stone: EC_CLICK_STONE) is
		require
			stone_exists: stone/=Void
		do
			clickable_elements.add_click_stone(stone)
		end

feature -- updates

	clear is
			-- Clear the page
		do
			image.wipe_out
			indent_index := 0
		end

	update is
			-- update page
		do
		
		end

feature -- Container

	set_container (cont: like container) is
		require
			container_exists: cont /= Void
		local
			com: EV_ROUTINE_COMMAND
		do	
			container := cont
			!! com.make(~transport)
			container.activate_pick_and_drop(com,Void)
			!! com.make(~edit)
			container.add_button_press_command(1,com,Void)
			!! com.make(page~accept_stone)
			container.add_pnd_command (stone_types.Any_type_pnd,com,Void)
		end

	container: EV_RICH_TEXT

feature -- Pick and Drop

	transport (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		require
			container_exists: container /= Void
		local
			ev: EV_BUTTON_EVENT_DATA
			position: INTEGER
			st: EC_CLICK_STONE
		do
			ev ?= data
			container.set_transported_data(Void)
			container.set_data_type(Void)
			if ev /= Void then
				position:= container.index_from_position(ev.x,ev.y)
				if position>0 then
					st := clickable_elements.find_stone(position)
					if st /= Void then
						-- st should not be void
						container.set_transported_data(st.data)
						container.set_data_type(st.type)
					end
				end
			end
		end

	edit (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		require
			container_exists: container /= Void
		local
			ev: EV_BUTTON_EVENT_DATA
			position: INTEGER
			st: EC_CLICK_STONE
		do
			ev ?= data
			if ev /= Void then
				position:= container.index_from_position(ev.x,ev.y)
				if position>0 then
					st := clickable_elements.find_stone(position)
					if st /= Void and then page /= Void and then page.namer /= Void then
						--page.namer.update_from(st.data)
					end
				end
			end
		end

--invariant
--	indent_index_possible: indent_index >= 0
--	array_exists: clickable_structure /= Void

end -- class ACTIVE_TEXT
