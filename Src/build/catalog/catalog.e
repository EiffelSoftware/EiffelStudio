
deferred class CATALOG [T->DATA] 

inherit

	CONSTANTS
	FORM
		rename
			make as form_create,
			init_toolkit as form_init_toolkit
		end

feature 

	current_page: CAT_PAGE [T]
			-- Page currently shown in catalog

	pages: LINKED_LIST [like current_page]
			-- Contains all pages in the catalog

feature {COMMAND_PAGE}

	button_rc: ROW_COLUMN

feature {NONE}

	page_sw: SCROLLED_W

feature 

	focus_label: FOCUS_LABEL_I is
			-- has to be redefined, so that it returns correct toolkit initializer
			-- to which object belongs for every instance of this class
                local
                        ti: TOOLTIP_INITIALIZER
                do
                        ti ?= top
                        check
                                valid_tooltip_initializer: ti/= Void
                        end
                        Result := ti.label
                end	
	
	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create the catalog interface with `a_screen' 
			-- as the parent.
		do
			form_create (a_name, a_parent)
			create_interface
		end

	create_interface is
			-- Create the interface of the catalog.
		deferred
		end

	add_page (page: CAT_PAGE [T]) is
			-- Add a `page' to the catalog. Also add the button to the
			-- interface. Make the page and button `visible' (i.e create 
			-- the widgets with their corresponding name and parents) 
			-- and attach them appropriately in the interface.
		require
			not_Void_page: page /= Void
		do
			pages.extend (page)
		ensure
			page_has_been_added: pages.has (page)
		end -- add_page

	update_interface is
			-- Update the interface by incorporating the pages 
			-- added. Add the button to the interface. Make the 
			-- page and button `visible' (i.e create the widgets 
			-- with their corresponding name and parents) and 
			-- attach them appropriately in the interface.
			-- If current_page not defined then the first page
			-- added is used by default.
		local
			page: CAT_PAGE [T]
			opt_pages: LINKED_LIST [CAT_PAGE [T]]
			fix_pages: LINKED_LIST [CAT_PAGE [T]]
			bg_color: COLOR
		do
			!! bg_color.make
			bg_color.set_rgb (background_color.red - 65 * 256, background_color.green - 65 * 256, background_color.blue - 65 * 256)	
			page_sw.set_background_color (bg_color)

			if (current_page = Void) then
				set_initial_page (pages.first)
			end
			from
				!! opt_pages.make
				!! fix_pages.make
				pages.start
			until
				pages.after
			loop
				page := pages.item
				if page.is_optional then
					opt_pages.extend (page)
				else
					fix_pages.extend (page)
				end
				pages.forth
			end
			from 
				fix_pages.start
			until
				fix_pages.after
			loop
				page := fix_pages.item
				page.make_button_visible (button_rc)
				fix_pages.forth
			end
			from
				opt_pages.start
			until
				opt_pages.after
			loop
				page := opt_pages.item
				page.make_button_visible (button_rc)
				opt_pages.forth
			end
			current_page.make_unmanaged (page_sw)
			current_page.set_selected_symbol
			if not current_page.empty then
				current_page.go_i_th (1)
				current_page.update_display
			end
			page_sw.set_working_area (current_page)
			current_page.manage
		end -- update_interface 

	set_initial_page (page: CAT_PAGE [T]) is
            -- Set current_page to `page', update the drawing_sw
            -- working area with `page'
        require
            not_Void_page: page /= Void
            page_exists: pages.has (page)
        do
			current_page := page
		end

feature {NONE}

	set_current_page (page: CAT_PAGE [T]; just_created: BOOLEAN) is
			-- Set current_page to `page', update the drawing_sw
			-- working area with `page'
		require
			not_Void_page: page /= Void
			page_exists: pages.has (page)
			current_page_non_Void: current_page /= Void
		do
			current_page.hide
			current_page.set_symbol
			page.set_selected_symbol
			current_page := page
			page.unmanage
			page_sw.set_working_area (page)
			if not just_created and then not page.empty then
					-- Refresh page correctly (ok its for motif)
				page.go_i_th (1)
				page.refresh_display
			end
			page.manage
		end

feature

	update_page (page: CAT_PAGE [T]) is
			-- Execute the command.
		local
			mp: MOUSE_PTR
		do
	--		if current_page /= page then
				if not page.is_visible then
					!! mp					
					mp.set_watch_shape
					page.make_unmanaged (page_sw)
					if not page.empty then
						page.go_i_th (1)
						page.update_display
					end
					page.manage
					set_current_page (page, true)
					mp.restore
				else
					page.show
					set_current_page (page, false)
				end
	--		end
		end -- execute

end 
