indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_PAGE2

inherit
	REPORT_PAGE
		redefine
			make
		end

creation
	make_with_caller

feature -- Initialization

	make (noteb: EV_NOTEBOOK;win:ANY) is
			-- Initialize
		local
			h1: EV_HORIZONTAL_BOX
			f1,f2: EV_FRAME
			fix: EV_FIXED
			v1,v2: EV_VERTICAL_BOX
			com: EV_ROUTINE_COMMAND
		do
			precursor ( noteb, window)
			notebook.append_page(page, "Texts")
			!! fix.make ( page )
			fix.set_minimum_height(15)
			fix.set_expand(FALSE)
			!! f1.make_with_text(page,"Document Types")
			!! h1.make(f1)
			h1.set_expand(FALSE)
			h1.set_spacing(15)
			!! v1.make(h1)
			v1.set_vertical_resize(FALSE)
			!! v2.make(h1)
			v2.set_vertical_resize(FALSE)
			!! cla_chart.make_with_text(v1, "Class Charts")
			!! clu_chart.make_with_text(v1, "Cluster Charts")
			!! sys_chart.make_with_text(v1, "Sytem Chart")
			!! dico.make_with_text(v2,"Dictionary")
			!! cla_spec.make_with_text(v2,"Class Specifications")
			!! fix.make(v2)
			
			!! f2.make_with_text(page,"Format")
			!! format_list.make(f2)
			format_list.set_minimum_height(150)
			fill_list
		end

	fill_list is
		-- Fill the list of available formats.
		local
			filter_dir: DIRECTORY;
			dir: PLAIN_TEXT_FILE;
			file_name: STRING;
			filter_names: SORTED_TWO_WAY_LIST [STRING]
			item: EV_LIST_ITEM
		do
			!! dir.make (Environment.filters_directory)
			if not dir.is_directory and then not dir.exists then
				Windows_manager.popup_error ("Ei",
						Environment.filters_directory,
						Windows_manager.first_window)
				format_list.clear_items
			else
				!! filter_dir.make (Environment.filters_directory);
				!! filter_names.make;
				filter_dir.open_read;
				from
					filter_dir.start;
					filter_dir.readentry;
					file_name := filter_dir.lastentry
				until
					file_name = Void
				loop
					if
						file_name.count > 4 and then
						file_name.substring (file_name.count - 3,
									file_name.count).is_equal (".fil")
					then
						file_name.head (file_name.count - 4);
						filter_names.extend (file_name)
					end;
					filter_dir.readentry;
					file_name := filter_dir.lastentry
				end;
				filter_dir.close
				format_list.clear_items
				from
					filter_names.start
				until
					filter_names.after
				loop
					!! item.make_with_text(format_list,filter_names.item)
					filter_names.forth
				end
				if format_list.count>0 then
					format_list.select_item (1)
				end
			end
		end

feature  -- Implementation 

	clu_chart, cla_chart,cla_spec,dico,sys_chart: EV_CHECK_BUTTON

	format_list: EV_LIST

feature -- generation 

	generate is
			-- Generate texts into files, according to the selection within the page.
		require
			caller_exists: window /= Void
		do
			if window.page1.to_printer.state then
				System.generate_documentation ("" , --Environment.printer_module.dc,
					format_list.selected_item.text,
					True,
					clu_chart.state,
					sys_chart.state,
					cla_spec.state,
					cla_chart.state,
					dico.state)
			else
					System.generate_documentation ("d:\pascalf\new\CASEGEN\DOC" , --Environment.printer_module.dc,
					format_list.selected_item.text,
					FALSE,
					clu_chart.state,
					sys_chart.state,
					cla_spec.state,
					cla_chart.state,
					dico.state)	
			end
		end

	initiate_generation is
			-- Set the counter
		do
			System.counter.count_classes_and_clusters_in_cluster (System.root_cluster)
			if cla_chart.state then
				System.counter.increment_total_general ( System.counter.max_class)
			end
			if dico.state then
				System.counter.increment_total_general ( System.counter.max_class)
			end
			if cla_spec.state then
				System.counter.increment_total_general ( System.counter.max_class)	
			end
			if clu_chart.state then
				System.counter.increment_total_general ( System.counter.max_cluster)
			end
			if sys_chart.state then
				System.counter.increment_total_general ( 1 )
			end	
		end

feature -- Updates

	update is do end

	reset is do end

end -- class REPORT_PAGE2
