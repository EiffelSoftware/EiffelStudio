indexing
	description: "Window which allows to generate HTML report."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_WINDOW

inherit
	EC_TOOL
		rename
			execute as generate
		redefine
			make,
			global_container ,
			cancel
		end
	
	EC_CLOSEABLE

creation
	make

feature -- Initialization
	
	make ( par : EV_WINDOW ) is
			-- Initialization
		local
			sep: EV_HORIZONTAL_SEPARATOR
			fix: EV_FIXED
		do
			precursor ( par )
			prepare_exit(Current)
			set_title("HTML Generation")
			Windows_manager.html_list.extend(Current)

			!! component_list.make
			!! menu.make (Current )
			
			!! global_container.make ( Current )
			global_container.set_homogeneous(FALSE)
			global_container.set_spacing(10)

			!! path_component.make(global_container,Current)

			!! format_component.make(global_container, Current)
	
			!! sep.make(global_container)

			!! progress_bar.make_with_text(global_container,"HTML Generation Status: ")
			!! exec_toolbar.make(Current)
			show
		end

feature -- Graphical Implementation

	component_list: LINKED_LIST [ GRAPHICAL_COMPONENT [ANY]]

	global_container: EV_VERTICAL_BOX

	path_component: PATH_COMPONENT

	format_component: GRAPHICAL_FORMAT_COMPONENT

	exec_toolbar: REPORT_EXEC_BAR

	progress_bar: SMART_PROGRESS_BAR

feature -- Updates 
		
	update is do end

feature -- Callbacks

	cancel(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Exit the window
		do
			destroy
		end

	generate ( arg: EV_ARGUMENT2[ECASE_WINDOW,INTEGER]; data: EV_EVENT_DATA) is
			-- Generate data
		local
			generate_classes_html : GENERATE_CLASSES_HTML
		do
			Environment.set_html_dir("d:\pascalf\new")
			!! generate_classes_html.make(Current)
		end

end -- class HTML_WINDOW
