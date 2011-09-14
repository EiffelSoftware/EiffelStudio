note
	description: "[
					EiffelRibbon output tool
					It display outputs from UICC.exe, link.exe etc
																								]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_OUTPUT_TOOL

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create widget
			create content.make_with_widget (widget, "ER_OUTPUT_TOOL")

			build_ui
		end

	build_docking_content
			-- Build docking content
		do
			content.set_long_title ("Output")
			content.set_short_title ("Output")
			content.set_type ({SD_ENUMERATION}.tool)
		end

	build_ui
			-- Build GUI
		do
			build_docking_content
			widget.disable_edit
		end

feature -- Command

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER)
			-- Attach to docking manager
		require
			not_void: a_docking_manager /= Void
		local
			l_env: EV_ENVIRONMENT
		do
			a_docking_manager.contents.extend (content)
			content.set_auto_hide ({SD_ENUMERATION}.bottom)

			create l_env
			if attached l_env.application as l_app then
				l_app.add_idle_action (agent append_output_in_idle)
			end
		end

	append_output (a_string: STRING_32)
			-- Append output
		require
			not_void: a_string /= Void
		local
			l_list: LIST [STRING_32]
			l_sub_string: STRING_32
		do
			if a_string.has ('%R') and a_string.count /= 1 then
				l_list := a_string.split ('%R')
				from
					l_list.start
				until
					l_list.after
				loop
					l_sub_string := l_list.item
					if l_sub_string.count > 1 then

						if l_sub_string.ends_with ("%R") then
							l_sub_string := l_sub_string.substring (1, l_sub_string.count - 1)
						end

						lock.lock
						output_string.extend (l_sub_string)
						lock.unlock
					end

					l_list.forth
				end
			elseif not a_string.is_empty then
				lock.lock
				output_string.extend (a_string)
				lock.unlock
			end
		end

	show
			-- Show current on screen
		do
			content.show
		end

	wipe_out
			-- Clear output
		do
			widget.set_text ("")
		end

feature -- Query

	widget: EV_RICH_TEXT
			-- Main dockig content widget

feature {NONE} -- Implementation

	content: SD_CONTENT
			-- Docking content

feature {NONE} -- Multi threading

	lock: MUTEX
		-- Mutex for `output_string'
		once ("PROCESS")
			create Result.make
		end

	output_string: ARRAYED_LIST [STRING_32]
			-- Global output string among threads
		once ("PROCESS")
			create Result.make (100)
		end

	append_output_in_idle
			-- In main process, append output to EV_RICK_TEXT
		do
			if lock.try_lock then
				from
					output_string.start
				until
					output_string.after
				loop
					widget.append_text (output_string.item)
					output_string.forth
				end
				output_string.wipe_out
				lock.unlock
			end
		end

end
