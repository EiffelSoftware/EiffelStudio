
deferred class CATALOG [T->STONE] 

inherit

	FORM
		rename
			make as form_create
		export
			{NONE} all
		end;
	COMMAND
		export
			{NONE} all
		end;
	WIDGET_NAMES
		export
			{NONE} all
		end

feature 

	current_page: CAT_PAGE [T];
			-- Page currently shown in catalog

	pages: LINKED_LIST [like current_page];
			-- Contains all pages in the catalog

feature {NONE}

	button_form, page_form: FORM;

	page_sw: SCROLLED_W;

	type_label: LABEL;
	
feature 

	focus_label: LABEL;
	

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create the catalog interface with `a_screen' 
			-- as the parent.
		do
			form_create (a_name, a_parent);
			create_interface;
		end;

	create_interface is
			-- Create the interface of the catalog.
		deferred
		end;

	add_page (page: CAT_PAGE [T]) is
			-- Add a `page' to the catalog. Also add the button to the
			-- interface. Make the page and button `visible' (i.e create 
			-- the widgets with their corresponding name and parents) 
			-- and attach them appropriately in the interface.
		require
			not_void_page: not (page = Void);
		do
			pages.extend (page);
		ensure
			page_has_been_added: pages.has (page)
		end; -- add_page

	update_interface is
			-- Update the interface by incorporating the pages 
			-- added. Add the button to the interface. Make the 
			-- page and button `visible' (i.e create the widgets 
			-- with their corresponding name and parents) and 
			-- attach them appropriately in the interface.
			-- If current_page not defined then the first page
			-- added is used by default.
		local
			previous_button: ICON; 
			page: CAT_PAGE [T];
			first_time: BOOLEAN;
			opt_pages: LINKED_LIST [CAT_PAGE [T]];
			fix_pages: LINKED_LIST [CAT_PAGE [T]]
		do
			if
				(current_page = Void)
			then
				set_initial_page (pages.first)
			end;
			from
				!!opt_pages.make;
				!!fix_pages.make;
				pages.start
			until
				pages.after
			loop
				page := pages.item;
				if page.is_optional then
					opt_pages.extend (page);
				else
					fix_pages.extend (page);
				end;
				pages.forth;
			end;
			from 
				fix_pages.start;
				first_time := True
			until
				fix_pages.after
			loop
				page := fix_pages.item;
				page.make_button_visible (button_form);
				page.add_button_callback;
				if
					first_time	
				then
					add_first_button (page.button, 10);
					first_time := False;
				else
					add_other_buttons (previous_button, page.button, 10);
				end;
				previous_button := page.button;
				fix_pages.forth
			end;
			from
				opt_pages.start
			until
				opt_pages.after
			loop
				page := opt_pages.item;
				page.make_button_visible (button_form);
				page.add_button_callback;
				if first_time then
					add_first_button (page.button, 10);
					first_time := False;
				else
					add_other_buttons (previous_button, page.button, 10);
				end;
				opt_pages.forth
			end;
			current_page.make_visible (I_con_box1, page_form);
			page_sw.set_working_area (current_page);
		end; -- update_interface 

	add_first_button (b: ICON; i: INTEGER) is 
		do
			button_form.attach_left (b, i);
		end;

	add_other_buttons (pb, b: ICON; i: INTEGER) is
		do
			button_form.attach_left_widget (pb, b, i);
		end;

	set_initial_page (page: CAT_PAGE [T]) is
			-- Set current_page to `page', update the drawing_sw
			-- working area with `page' and set the type_label text
			-- to the page name.
		require
			not_void_page: not (page = Void);
			page_has_been_added: pages.has (page);
			page_name_is_not_Void: not (page.page_name = Void)
		do
			current_page := page;
			update_type_label
		ensure
			initial_page_defined: current_page = page
					and type_label.text = current_page.page_name
		end; -- set_initial_page

	
feature {NONE}

	execute (argument: ANY) is
			-- Execute the command.
		local
			page: CAT_PAGE [T]
		do
			page ?= argument;
			if
				not (page = Void)
			then
				if
					not (current_page = page)
				then
					if not page.is_visible then
						page.make_visible (I_con_box1, page_form);
						if not page.empty then
							page.go_i_th (1);
							page.update_display
						end
					else
						page.show;
					end;
					current_page.hide;
					current_page := page;
					update_type_label;
					page_sw.unmanage;
					page_sw.set_working_area (current_page);
					page_sw.manage;	
				end
			end
		end; -- execute

	update_type_label is
		do
			type_label.set_text (current_page.page_name);
		end;

end 
