indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_PAGE3

inherit
	REPORT_PAGE
		redefine
			make
		end

creation
	make_with_caller

feature -- Initialization

	make (noteb: EV_NOTEBOOK;win: ANY) is
			-- Initialize
		local
			h1,h2,h3: EV_HORIZONTAL_BOX
			f1,f2: EV_FRAME
			fix: EV_FIXED
			v1,v2,v3,v4: EV_VERTICAL_BOX
			com: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1[EV_LIST]
			sep: EV_VERTICAL_SEPARATOR
			arg2: EV_ARGUMENT1[INTEGER]
		do
			precursor ( noteb, window)
			notebook.append_page(page, "Graphics")
			!! fix.make ( page )
			fix.set_minimum_height(15)
			fix.set_expand(FALSE)
			!! h1.make(page)
			h1.set_spacing(10)
			!! to_print.make(h1)
			!! arg.make(to_print)
			!! com.make(~change_cluster_of_list)
			to_print.add_select_command(com, arg)
			!! not_to_print.make(h1)
			!! arg.make(not_to_print)
			!! com.make(~change_cluster_of_list)
			not_to_print.add_select_command(com, arg)
			initialization (System.clusters_in_system, true)
			!! f1.make_with_text(page,"Output")
			f1.set_expand(FALSE)
			!! h2.make(f1)
			!! v1.make(h2)
			v1.set_vertical_resize(FALSE)
			v1.set_spacing(10)
			!! gif.make_with_text(v1,"GIF")
			!! com.make(~select_gif)
			!! arg2.make(1)
			gif.add_toggle_command(com,arg2)
			!! bitmap.make_with_text(v1,"BITMAP")
			!! arg2.make(0)
			bitmap.add_toggle_command(com, arg2)
			!! postscript.make_with_text(v1,"POSTSCRIPT")
			!! arg2.make(0)
			postscript.add_toggle_command(com, arg2)

			!! sep.make(h2)
			!! v1.make(h2)
			v1.set_spacing(10)
			!! color.make_with_text(v1,"Colored")
			color.set_expand(FALSE)
			color.set_vertical_resize(FALSE)
			!! interlaced.make_with_text(v1,"Interlaced")
			interlaced.set_expand(FALSE)
			interlaced.set_vertical_resize(FALSE)
			
		end

feature {NONE} -- Implementation 

	to_print, not_to_print: EV_LIST

	gif,bitmap,postscript: EV_RADIO_BUTTON

	color,interlaced: EV_CHECK_BUTTON

feature -- Generation

	initiate_generation is
			-- Set the counter
		do
			System.counter.increment_total_general(to_print.count)
		end

	generate is 
		do 
			print_graph ( window.page1.to_disk.state )
		end

	print_graph ( to_file: BOOLEAN)  is
			local
			file: PLAIN_TEXT_FILE;
			cluster: CLUSTER_DATA;
			filename: FILE_NAME;
			postscript_printer: PRINT_CLUSTER_DIAGRAM;
			err : BOOLEAN 
			ssc_elem : PRINTABLE_ITEM
			bitmap_printer :BITMAP_PRINTER 
			i: INTEGER
			no_command, we_stop: BOOLEAN
			string_command: STRING
			exec: EXECUTION_ENVIRONMENT
		do
--			if not err then
--				from
--					i:= 1
--				until
--					i >= to_print.count or no_command or we_stop
--				loop
--					ssc_elem ?= to_print.get_item(i)
--					cluster := ssc_elem.cluster
--					if to_file then
--						!! filename.make_from_string ("d:\pascalf\new")
--						filename.set_file_name (cluster.name)
--					else
--						!! filename.make_from_string (Environment.temporary_file_name);
--					end
--					if postscript.state then 
--						filename.add_extension ("ps")
--					elseif gif.state then
--						filename.add_extension ("gif")
--					elseif bitmap.state then
--						filename.add_extension ("bmp")
--					end
--					if bitmap.state and not to_file then
--							Environment.printer_module.print_graph (cluster )
--					else
--						!! file.make (filename)
--						if file.is_creatable then
--							file.open_write
--							if postscript.state then
--								!! postscript_printer.make (cluster)
--								postscript_printer.set_color (color.state)
--								postscript_printer.execute (file)
--								file.close
--						
--								if not to_file then
--									-- Printing Postscript
--									!! string_command.make (0);
--									string_command.append(Resources.printer_command)
--									if string_command.is_equal ("please_fill" ) then
--										Windows_manager.popup_message ("My", Void,window )
--										Windows_manager.add_error_message ("The printer command is not set")
--										no_command := TRUE 
--									else
--										string_command.replace_substring_all ("file_name", filename)
--										!! exec
--										exec.system (string_command)
--										if exec.return_code>0 then
--											--something went wrong ...
--											we_stop := TRUE 
--										end
--										file.delete
--									end
--								end
--							elseif bitmap.state then
--									-- We know it is to a file ...
--								!! bitmap_printer.make
--								bitmap_printer.generate ( cluster,file, FALSE)
--								file.close
--							elseif gif.state then
--								-- GIF generation here
--							end
--						else	
--							Windows_manager.add_error_message("Can't create file: ")
--							Windows_manager.add_error_message(filename)
--						end
--					end
--					i := i+1
--				end
--			else
--				Windows_manager.popup_message("Mr", Void,window )
--			end
--			rescue
--				err := TRUE
--				Windows_manager.add_error_message("print_to_file of show_graphics_format")
--				retry
		end

feature -- Updates

	initialization ( list: LIST [ CLUSTER_DATA ]; b : BOOLEAN )  is
				-- Initialize the lists
			local
				el : PRINTABLE_ITEM
				ev_list: EV_LIST
			do
				if b then
					ev_list := to_print 
				else
					ev_list := not_to_print
				end
				from
					to_print.clear_items
					not_to_print.clear_items
					list.start
				until
					list.after
				loop
					!! el.make_spc(ev_list,list.item)
					list.forth
				end
			end

	select_gif (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			from_gif: BOOLEAN
			arg: EV_ARGUMENT1[INTEGER]
		do
			arg ?= args
			from_gif := (arg.first=0)
			interlaced.set_insensitive(from_gif)
		end

	change_cluster_of_list (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			ev_list: EV_LIST
			item: PRINTABLE_ITEM
			arg: EV_ARGUMENT1[EV_LIST]
		do
			arg ?= args
			ev_list := arg.first
			check
				list_exists: ev_list /= Void
				selected_item_exists: ev_list.selected
			end
			item ?= ev_list.selected_item
			if to_print=ev_list then
				item.set_parent(not_to_print)
			else
				item.set_parent(to_print)
			end
		end

	update is do end

	reset is 
		-- Clear the lists 
		do 
			to_print.clear_items
			not_to_print.clear_items
		end

invariant
	lists_exists: to_print /= Void and not_to_print /= Void

end -- class REPORT_PAGE3
