indexing
	description: 
		"Object editor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- Class OBJECT_TOOL_TESTER