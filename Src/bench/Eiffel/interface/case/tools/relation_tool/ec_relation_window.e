indexing
	description: "Editor which edits a class"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EC_RELATION_WINDOW 

inherit
	EC_EDITOR_WINDOW [RELATION_DATA]
		rename
			toolbar as class_toolbar
		redefine
			make,class_toolbar,
			entity
		end

creation
	make

feature -- Initialization

	make(par: EV_WINDOW ) is
			-- Initialize
		local
			sep: EV_HORIZONTAL_SEPARATOR 

			class_data: CLASS_DATA
		do
			precursor(par)
			set_title(widget_names.relation_tool)

			!! relation_label_page.make(notebook, entity)
			!! relation_handles_page.make(notebook, entity)
			!! relation_link_page.make(notebook, entity)

			fill_menu

			if component_list /= Void then
				component_list.extend (relation_label_page)
				component_list.extend (relation_handles_page)
				component_list.extend (relation_link_page)
			end
			show
		end

feature -- Properties

	entity: RELATION_DATA

feature -- Implementation

	class_toolbar: RELATION_WINDOW_TOOLBAR

	relation_label_page: EC_RELATION_LABEL_PAGE
	relation_handles_page: RELATION_HANDLES_PAGE
	relation_link_page: RELATION_LINK_PAGE

	label_i: EV_RADIO_MENU_ITEM
	handles_i: EV_RADIO_MENU_ITEM
	link_i: EV_RADIO_MENU_ITEM

	fill_menu is
		local
			com: EV_ROUTINE_COMMAND
		--	default_command: IMPORT_INDEXING_COM
		--	browse_command: IMPORT_INDEXING_COM
		--	chart_command: SHOW_CLASS_CHART
		--	specification_command: SHOW_CLASS_CHART
		--	eiffel_code_command: SHOW_CLASS_CODE
		--	relations_command: SHOW_RELATIONS

			select_page_notebook: SELECT_PAGE_NOTEBOOK
			format_argument: EV_ARGUMENT1 [INTEGER]

		do
			if menu /= Void then

				-- Format Menu
				!! select_page_notebook.make (notebook)

				!! label_i.make_with_text (menu.format_m, widget_names.label)
				!! format_argument.make (1)
				label_i.add_select_command (select_page_notebook, clone (format_argument))

				!! handles_i.make_peer_with_text (menu.format_m, widget_names.handles, label_i)
				!! format_argument.make (2)
				handles_i.add_select_command (select_page_notebook, clone (format_argument))

				!! link_i.make_peer_with_text (menu.format_m, widget_names.link, label_i)
				!! format_argument.make (3)
				link_i.add_select_command (select_page_notebook, clone (format_argument))

			end
		end
 
feature -- savable parameters

	get_height_name	: STRING	is "class_tool_height"
	
	get_width_name	: STRING	is "class_tool_width"

end -- class CLASS_WINDOW
