indexing
	description: 
		"Object editor."
	status: "See notice at end of class"
	keywords: "test"
	date: "$Date$"
	revision: "$Revision$"
	
class
	OBJECT_TOOL_TESTER

inherit
	EV_APPLICATION 

	SHARED_CLASS_IMPORTER
		undefine
			copy, default_create
		end
		
	WINDOWS
		undefine
			copy, default_create
		end

create
	
	start

feature

	first_window: EV_TITLED_WINDOW is
			-- Main window.
		once
			create Result.make_with_title ("Title")
			Result.set_minimum_size (400, 400)
			Result.close_request_actions.extend (agent destroy)
		end

	start is
			-- Launch `Current'.
			-- executing `prepare' will run the object tool.
			-- executing `execute_generated_window' shows
			-- an example of using a tool generated from the
			-- object tool.
			-- Only call one or the other. When calling `prepare',
			-- comment out `execute_generated_window'.
			-- `execute_generated_window' is an example set up using
			-- EV_TITLED_WINDOW. If you wish to use the object tool on
			-- other classes, then modify this example accordingly.
		do
			default_create
			prepare
			--execute_generated_window
			launch
		end
		
--	execute_generated_window is
--				-- Test the generated object tool.
--				-- You must use `EV_TITLED_WINDOW' in the
--				-- object tool for the test to work.
--			local
--				test_window: GENERATED_CLASS
--				window: EV_TITLED_WINDOW
--			do
--				create test_window.make
--				create window
--				test_window.set_target (window)
--				window.show
--				test_window.show
--			end
		
		prepare is
				-- Build interface of `Current' for the object tool.
			local
				import_cmd: IMPORT_APPLICATION_CLASS_CMD
				vertical_box: EV_VERTICAL_BOX
				button: EV_BUTTON
				temp: ARRAYED_LIST [APPLICATION_CLASS]
			do
				first_window.close_request_actions.extend (agent destroy)
				create vertical_box
				first_window.extend (vertical_box)
				create list
				create button.make_with_text ("Build object editor")
				vertical_box.extend (list)
				vertical_box.extend (button)
				vertical_box.disable_item_expand (button)
				button.disable_sensitive
				list.select_actions.extend (agent button.enable_sensitive)
				button.select_actions.extend (agent generate_tool)
				
				
				first_window.show
				create import_cmd
				import_cmd.execute (Void)
				temp := clone (class_list)
				from
					class_list.start
				until
					class_list.after
				loop
					list.extend (class_list.item)
					class_list.forth
				end
			end
			
		list: EV_LIST
			-- `EV_LIST' for displaying classes generated from
			-- EiffelStudio ready for use in the object tool.
		
		generate_tool is
				-- Launch the object tool.
			do
				object_tool_generator.display (list.selected_item)
			end
			
end -- Class OBJECT_TOOL_TESTER