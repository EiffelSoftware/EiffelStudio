indexing
	description: "Class representing the object tool generator %
				% which allows the user to build an object %
				% tool for a specific class."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	OBJECT_TOOL_GENERATOR

inherit

	EB_TOP_SHELL
		redefine
			make
		end

	SHARED_CLASS_IMPORTER

	CLOSEABLE

	COMMAND

	COMMAND_ARGS

creation

	make

feature -- Creation

	make (a_name: STRING; a_screen: SCREEN) is
			-- Create the object tool generator.
		do
			{EB_TOP_SHELL} Precursor (a_name, a_screen)
			!! top_form.make ("", Current)
			!! arrow_form.make ("", top_form)
			!! include_label.make ("Include", arrow_form)
			!! include_all_label.make ("Include all", arrow_form)
			!! exclude_label.make ("Exclude", arrow_form)
			!! exclude_all_label.make ("Exclude all", arrow_form)
			!! include_button.make ("", arrow_form)
			!! include_all_button.make ("", arrow_form)
			!! exclude_button.make ("", arrow_form)
			!! exclude_all_button.make ("", arrow_form)
			!! excluded_label.make ("Excluded queries", top_form)
			!! included_label.make ("Included queries", top_form)
			!! scrolled_w.make ("", top_form)
			!! properties_rc.make ("", scrolled_w)
			!! generate_button.make ("Generate", top_form)
			!! included_list.make ("", top_form)
			!! excluded_list.make ("", top_form)
			set_values
			attach_all
			set_callbacks
			!! form_table.make (10)
		end

	set_values is
			-- Set values for GUI elements.
		local
			set_colors: SET_WINDOW_ATTRIBUTES_COM
			temp_title: STRING
		do
			set_title ("Object tool generator: ")
			set_size (resources.object_tool_generator_width, resources.object_tool_generator_height)
			included_label.set_left_alignment
			excluded_label.set_left_alignment
			include_button.set_down
			include_all_button.set_down
			exclude_button.set_up
			exclude_all_button.set_up
			included_list.set_multiple_selection
			excluded_list.set_multiple_selection
			scrolled_w.set_working_area (properties_rc)
			!! set_colors
			set_colors.execute (Current)
		end

	attach_all is
			-- Perform attachments.
		do
			arrow_form.set_fraction_base (100)
			arrow_form.attach_top (include_button, 0)
			arrow_form.attach_top (include_label, 3)
			arrow_form.attach_top (include_all_button, 0)
			arrow_form.attach_top (include_all_label, 3)

			arrow_form.attach_top_widget (include_button, exclude_button, 5)
			arrow_form.attach_top_widget (include_button, exclude_label, 5)
			arrow_form.attach_top_widget (include_label, exclude_label, 5)
			arrow_form.attach_top_widget (include_all_button, exclude_all_button, 5)
			arrow_form.attach_top_widget (include_all_button, exclude_all_label, 5)
			arrow_form.attach_top_widget (include_all_label, exclude_all_label, 5)

			arrow_form.attach_bottom (exclude_button, 0)
			arrow_form.attach_bottom (exclude_label, 0)
			arrow_form.attach_bottom (exclude_all_button, 0)
			arrow_form.attach_bottom (exclude_all_label, 0)

			arrow_form.attach_left_position (include_button, 20)
			arrow_form.attach_left_position (exclude_button, 20)
			arrow_form.attach_left_widget (include_button, include_label, 3)
			arrow_form.attach_left_widget (exclude_button, exclude_label, 3)

			arrow_form.attach_left_position (include_all_button, 70)
			arrow_form.attach_left_position (exclude_all_button, 70)
			arrow_form.attach_left_widget (include_all_button, include_all_label, 3)
			arrow_form.attach_left_widget (exclude_all_button, exclude_all_label, 3)

			top_form.attach_top (excluded_label, 0)
			top_form.attach_left (excluded_label, 0)
			top_form.attach_right (excluded_label, 0)
			top_form.attach_top_widget (excluded_label, excluded_list, 5)
			top_form.attach_left (excluded_list, 5)
			top_form.attach_right (excluded_list, 5)
			top_form.attach_top_widget (excluded_list, arrow_form, 5)
			top_form.attach_left (arrow_form, 0)
			top_form.attach_right (arrow_form, 0)
			top_form.attach_top_widget (arrow_form, included_label, 5)
			top_form.attach_left (included_label, 5)
			top_form.attach_right (included_label, 5)
			top_form.attach_top_widget (included_label, included_list, 5)
			top_form.attach_left (included_list, 5)
			top_form.attach_right (included_list, 5)
			top_form.attach_top_widget (included_list, scrolled_w, 5)
			top_form.attach_left (scrolled_w, 5)
			top_form.attach_right (scrolled_w, 5)
			top_form.attach_bottom (generate_button, 0)
			top_form.attach_left (generate_button, 5)
			top_form.attach_bottom_widget (generate_button, scrolled_w, 5)
		end

	set_callbacks is
			-- Set the GUI elments callbacks.
		local
			del_com: DELETE_WINDOW
			generate_cmd: GENERATE_OBJECT_TOOL_CMD
		do
			include_button.add_activate_action (Current, First)
			include_all_button.add_activate_action (Current, Second)
			exclude_button.add_activate_action (Current, Third)
			exclude_all_button.add_activate_action (Current, Fourth)
			!! generate_cmd.make
			generate_button.add_activate_action (generate_cmd, Void)
			!! del_com.make (Current)
			set_delete_command (del_com)
		end

feature {NONE} -- GUI attributes

	top_form,
			-- Form of the top shell itself

	arrow_form: FORM
			-- Form containing the arrows

	excluded_label,
			-- Excluded attribute label

	included_label,
			-- Included attribute label

	include_label,
			-- Include button label

	include_all_label,
			-- Include all button label

	exclude_label,
			-- Exclude button label

	exclude_all_label: LABEL
			-- Exclude all button label

	include_button,
			-- Include button

	include_all_button,
			-- Include all button

	exclude_button,
			-- Exclude button

	exclude_all_button: ARROW_B
			-- Exclude all button

	scrolled_w: SCROLLED_W
			-- Scrolled window containing the various properties

	properties_rc: ROW_COLUMN
			-- Row column containing the list of element composing
			-- the interface of the object editor

	generate_button: PUSH_B
			-- `Generate' button

	included_list,
			-- List of included queries

	excluded_list: SCROLLABLE_LIST
			-- List of excluded queries

feature -- Command execution

	execute (arg: ANY) is
		do
			if arg = First then
				include_queries
			elseif arg = Second then
				include_all_queries
			elseif arg = Third then
				exclude_queries
			elseif arg = Fourth then
				exclude_all_queries
			end
		end

	include_queries is
			-- Include selected queries.
		do
			move_items (excluded_list, included_list)
		end



	include_all_queries is
			-- Include all queries.
		do
			move_all_items (excluded_list, included_list)
		end

	exclude_queries is
			-- Exclude selected queries.
		do
			move_items (included_list, excluded_list)
		end

	exclude_all_queries is
			-- Exclude all queries.
		do
			move_all_items (included_list, excluded_list)
		end

	move_items (source_list, target_list: SCROLLABLE_LIST) is
			-- Move selected items of `source_list' into
			-- `target_list'.
		local
			selected_items: LINKED_LIST [SCROLLABLE_LIST_ELEMENT]
			removed: BOOLEAN
			a_query: APPLICATION_QUERY
		do
			if source_list.selected_count > 0 then
				selected_items := source_list.selected_items
				from
					selected_items.start
				until
					selected_items.after
				loop
					target_list.extend (selected_items.item)
					a_query ?= selected_items.item
					if a_query /= Void then
						if target_list = included_list then
							add_query_editor_form (a_query)
						else
							remove_query_editor_form (a_query)
						end
					end
					from
						source_list.start
						removed := False
					until
						removed or source_list.after
					loop
						if selected_items.item = source_list.item then
							removed := True
							source_list.remove
						else
							source_list.forth
						end
					end
					selected_items.forth
				end
			end
			properties_rc.manage
		end

	move_all_items (source_list, target_list: SCROLLABLE_LIST) is
			-- Move all items from `source_list' into
			-- `target_list'.
		local
			a_query: APPLICATION_QUERY
		do
			if source_list.count > 0 then
				from
					source_list.start
				until
					source_list.after
				loop
					target_list.extend (source_list.item)
					a_query ?= source_list.item
					if a_query /= Void then
						if target_list = included_list then
							add_query_editor_form (a_query)
						else
							remove_query_editor_form (a_query)
						end
					end
					source_list.forth
				end
				source_list.wipe_out
			end
			properties_rc.manage
		end

	add_query_editor_form (a_query: APPLICATION_QUERY) is
			-- Add a form to edit `a_query' properties.
		require
			query_not_void: a_query /= Void
		local
			editor_form: ANY_QUERY_EDITOR_FORM
		do
			if form_table.has (a_query.query_name) and form_table.item (a_query.query_name) /= Void then
				form_table.item (a_query.query_name).manage
			else
				!! editor_form.make ("", properties_rc)
				editor_form.set_query (a_query)
				form_table.force (editor_form, a_query.query_name)
			end
		end

	remove_query_editor_form (a_query: APPLICATION_QUERY) is
			-- Remove a form from the set of properties.
		require
			query_not_void: a_query /= Void
			item_referenced: form_table.has (a_query.query_name)
		do
			form_table.item (a_query.query_name).unmanage
		end
feature -- Closeable

	close is
			-- Close object tool generator.
		do
			hide
		end

	display (application_class: SCROLLABLE_LIST_ELEMENT) is
			-- Display object tool generator.
		require
			class_not_void: application_class /= Void
		do
			if not realized then
				realize
			else
				show
			end
			edited_class ?= application_class
			check
				edited_class_not_void: edited_class /= Void
			end
			update_interface
		end

feature {NONE} -- Implementation

	update_interface is
			-- Update the interface according to the new application
			-- class that is edited.
		require
			edited_class_not_void: edited_class /= Void
		local
			query_list: LINKED_LIST [APPLICATION_QUERY]
			temp_title: STRING
		do
			!! temp_title.make (0)
			temp_title.append ("Object tool generator: ")
			temp_title.append (edited_class.class_name)
			set_title (temp_title)
			excluded_list.wipe_out
			included_list.wipe_out
			query_list := edited_class.query_list
			from
				query_list.start
			until
				query_list.after
			loop
				excluded_list.extend (query_list.item)
				query_list.forth
			end
		end

feature -- Attributes

	edited_class: APPLICATION_CLASS
			-- Currently edited application class

	form_table: HASH_TABLE [QUERY_EDITOR_FORM, STRING]
			-- Hash-table containing all the created 
			-- QUERY_EDITOR_FORM

end -- class OBJECT_TOOL_GENERATOR
