indexing
	description: "Window which allows to generate documentation"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_WINDOW

inherit	
	EC_EDITOR_WINDOW [SYSTEM_DATA]
 		redefine
 			make
		end

	SIZE_SAVABLE

creation
	make

feature -- Creation

	make ( par : EV_WINDOW ) is
			-- Initialization
		local
			sep: EV_HORIZONTAL_SEPARATOR
			fix: EV_FIXED
		do
			precursor ( par )
			prepare_exit(Current)
			set_title("Report")
			Windows_manager.report_list.extend(Current)

			!! component_list.make
			!! menu.make (Current )
			
			!! global_container.make ( Current )
			global_container.set_homogeneous(FALSE)
			global_container.set_spacing(10)

			!! sep.make ( global_container )
			!! toolbar.make ( Current )
			!! sep.make ( global_container )

			!! fix.make ( global_container )
			fix.set_minimum_height(20)
			fix.set_expand(FALSE)

			!! notebook.make (global_container)
			!! page1.make_with_caller (notebook,Current)
			!! page2.make_with_caller(notebook,Current)
			!! page3.make_with_caller(notebook,Current)
			!! rich_edit.make(global_container)
			rich_edit.set_size(0,0)
			rich_edit.set_expand(FALSE)
			rich_edit.hide

			!! exec_bar.make (Current)
			--!! generation_progress.make (global_container)
			show
		end

feature -- Graphical Implementation

	page1: REPORT_PAGE1

	page2: REPORT_PAGE2

	page3: REPORT_PAGE3

	exec_bar: REPORT_EXEC_BAR

	rich_edit: EV_TEXT


feature -- Callbacks

	generate ( arg: EV_ARGUMENT2[ECASE_WINDOW,INTEGER]; data: EV_EVENT_DATA) is
			-- Generate data
		do
			System.counter.init_counter
			page1.initiate_generation
			if page1.to_text.state then
				page2.initiate_generation
			end
			if page1.to_graphical.state then
				page3.initiate_generation
			end
			if page1.to_text.state then
				page2.generate
			end
			if page1.to_graphical.state then
				page3.generate
			end
			System.counter.init_counter
			System.init_counter 
		end

feature -- savable parameters

	get_height_name	: STRING	is "mp_print_window_height"
	
	get_width_name	: STRING	is "mp_print_window_width"


end -- class REPORT_WINDOW
