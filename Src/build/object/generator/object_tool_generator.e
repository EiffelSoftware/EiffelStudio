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

	EV_WINDOW
		redefine
			make
		end

	SHARED_CLASS_IMPORTER

	CLOSEABLE

	EV_COMMAND

	COMMAND_ARGS

	CONSTANTS

creation

	make

feature -- Creation

	make (par: EV_WINDOW) is
			-- Create the object tool generator.
		local
			top_box, horizontal_box: EV_HORIZONTAL_BOX
			bottom_box, arrow_box: EV_VERTICAL_BOX
			default_label: EV_LABEL
			frame: EV_FRAME
			include_label, exclude_label,
			include_all_label, exclude_all_label: EV_LABEL
			separator: EV_HORIZONTAL_SEPARATOR
		do
			{EV_WINDOW} Precursor (par)
			create split_area.make (Current)

				--| Top box	
			create top_box.make (split_area)
			top_box.set_spacing (10)
			top_box.set_homogeneous (False)
			create frame.make_with_text (top_box, "Excluded queries")
			create excluded_list.make (frame)
			create arrow_box.make (top_box)
			create frame.make_with_text (top_box, "Included queries")
			create included_list.make (frame)
					--| arrow box
			arrow_box.set_expand (False)
			arrow_box.set_homogeneous (False)
			arrow_box.set_spacing (5)
			create default_label.make_with_text (arrow_box, "Default:")
			default_label.set_vertical_resize (False)
			default_label.set_expand (False)
			create precondition_test.make_with_text (arrow_box,
											"Test preconditions")
			precondition_test.set_expand (False)
			create horizontal_box.make (arrow_box)
			horizontal_box.set_spacing (10)
			horizontal_box.set_expand (False)
			create include_button.make (horizontal_box)
			create include_label.make_with_text (horizontal_box, "Include")
			create horizontal_box.make (arrow_box)
			horizontal_box.set_spacing (10)
			horizontal_box.set_expand (False)
			create exclude_button.make (horizontal_box)
			create exclude_label.make_with_text (horizontal_box, "Exclude")
			create horizontal_box.make (arrow_box)
			horizontal_box.set_spacing (10)
			horizontal_box.set_expand (False)
			create include_all_button.make (horizontal_box)
			create include_all_label.make_with_text (horizontal_box, "Include all")
			create horizontal_box.make (arrow_box)
			horizontal_box.set_spacing (10)
			horizontal_box.set_expand (False)
			create exclude_all_button.make (horizontal_box)
			create exclude_all_label.make_with_text (horizontal_box, "Exclude all")

				--| Bottom box
			create bottom_box.make (split_area)
			bottom_box.set_spacing (5)
			bottom_box.set_homogeneous (False)
			create scrolled_w.make (bottom_box)
			create properties_box.make (scrolled_w)
			create separator.make (bottom_box)
			separator.set_expand (False)
			create generate_button.make_with_text (bottom_box, "Generate")
			generate_button.set_expand (False)
			set_values
			set_callbacks

			create form_table.make (10)
		end

	set_values is
			-- Set values for GUI elements.
		local
			set_colors: SET_WINDOW_ATTRIBUTES_COM
			temp_title: STRING
		do
			set_title ("Object tool generator: ")
			set_minimum_width (resources.object_tool_generator_width)
			set_minimum_height (resources.object_tool_generator_height)
			set_x_y (resources.object_tool_generator_x, resources.object_tool_generator_y)
			included_list.set_multiple_selection
			excluded_list.set_multiple_selection
--			default_label.set_left_alignment
			precondition_test.set_state (True)
--			!! set_colors
--			set_colors.execute (Current)
			include_button.set_text ("->")
			include_button.set_minimum_width (25)
			exclude_button.set_text ("<-")
			exclude_button.set_minimum_width (25)
			include_all_button.set_text (">>")
			include_all_button.set_minimum_width (25)
			exclude_all_button.set_text ("<<")
			exclude_all_button.set_minimum_width (25)

			generate_button.set_horizontal_resize (False)
		end

	set_callbacks is
			-- Set the GUI elements callbacks.
		local
			close_cmd: CLOSE_WINDOW
			generate_cmd: GENERATE_OBJECT_TOOL_CMD
			arg: EV_ARGUMENT1 [ANY]
		do
			create arg.make (First)
 			include_button.add_click_command (Current, arg)
			create arg.make (Second)
 			include_all_button.add_click_command (Current, arg)
			create arg.make (Third)
-- 			included_list.add_default_action (Current, Third)
 			exclude_button.add_click_command (Current, arg)
			create arg.make (Fourth)
 			exclude_all_button.add_click_command (Current, arg)
-- 			excluded_list.add_default_action (Current, First)
-- 			!! generate_cmd.make
-- 			generate_button.add_activate_action (generate_cmd, Void)
 			create close_cmd.make (Current)
 			add_close_command (close_cmd, Void)
		end

feature {NONE} -- GUI attributes

	split_area: EV_VERTICAL_SPLIT_AREA
			-- Form of the top shell itself

	include_button,
			-- Include button

	include_all_button,
			-- Include all button

	exclude_button,
			-- Exclude button

	exclude_all_button,
			-- Exclude all button

	generate_button: EV_BUTTON
			-- `Generate' button

	scrolled_w: EV_SCROLLABLE_AREA
			-- Scrolled window containing the various properties

	properties_box: EV_VERTICAL_BOX
			-- Vertical box containing the list of element composing
			-- the interface of the object editor

	included_list,
			-- List of included queries

	excluded_list: EV_LIST
			-- List of excluded queries

feature {QUERY_EDITOR_FORM}

	precondition_test: EV_CHECK_BUTTON
			-- Preconditions test by default field


feature -- Command execution

	execute (args: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
		local
--			mp: MOUSE_PTR
		do
--			!! mp
--			mp.set_watch_shape
			if args.first = First then
				include_queries
			elseif args.first = Second then
				include_all_queries
			elseif args.first = Third then
				exclude_queries
			elseif args.first = Fourth then
				exclude_all_queries
			end
--			mp.restore
		end

	include_queries is
			-- Include selected queries.
		do
--			move_items (excluded_list, included_list)
		end



	include_all_queries is
			-- Include all queries.
		do
--			move_all_items (excluded_list, included_list)
		end

	exclude_queries is
			-- Exclude selected queries.
		do
--			move_items (included_list, excluded_list)
		end

	exclude_all_queries is
			-- Exclude all queries.
		do
--			move_all_items (included_list, excluded_list)
--			properties_box.set_size (0, 0)
		end

	move_items (source_list, target_list: SCROLLABLE_LIST) is
			-- Move selected items of `source_list' into
			-- `target_list'.
		local
			selected_items: LINKED_LIST [SCROLLABLE_LIST_ELEMENT]
			removed: BOOLEAN
			a_query: APPLICATION_QUERY
		do
-- 			if source_list.selected_count > 0 then
-- 				selected_items := source_list.selected_items
-- 				from
-- 					selected_items.start
-- 				until
-- 					selected_items.after
-- 				loop
-- 					target_list.extend (selected_items.item)
-- 					a_query ?= selected_items.item
-- 					if a_query /= Void then
-- 						if target_list = included_list then
-- 							add_query_editor_form (a_query)
-- 						else
-- 							remove_query_editor_form (a_query)
-- 						end
-- 					end
-- 					from
-- 						source_list.start
-- 						removed := False
-- 					until
-- 						removed or source_list.after
-- 					loop
-- 						if selected_items.item = source_list.item then
-- 							removed := True
-- 							source_list.remove
-- 						else
-- 							source_list.forth
-- 						end
-- 					end
-- 					selected_items.forth
-- 				end
-- 			end
-- 			properties_box.manage
		end

	move_all_items (source_list, target_list: SCROLLABLE_LIST) is
			-- Move all items from `source_list' into
			-- `target_list'.
		local
			a_query: APPLICATION_QUERY
		do
-- 			if source_list.count > 0 then
-- 				from
-- 					source_list.start
-- 				until
-- 					source_list.after
-- 				loop
-- 					target_list.extend (source_list.item)
-- 					a_query ?= source_list.item
-- 					if a_query /= Void then
-- 						if target_list = included_list then
-- 							add_query_editor_form (a_query)
-- 						else
-- 							remove_query_editor_form (a_query)
-- 						end
-- 					end
-- 					source_list.forth
-- 				end
-- 				source_list.wipe_out
-- 			end
-- 			properties_box.manage
		end

	add_query_editor_form (a_query: APPLICATION_QUERY) is
			-- Add a form to edit `a_query' properties.
		require
			query_not_void: a_query /= Void
		local
			any_editor_form: ANY_QUERY_EDITOR_FORM
			boolean_editor_form: BOOLEAN_QUERY_EDITOR_FORM
			new_height: INTEGER
		do
-- 			if form_table.has (a_query.query_name) and form_table.item (a_query.query_name) /= Void then
-- 				new_height := properties_box.height + form_table.item (a_query.query_name).height
-- 				form_table.item (a_query.query_name).manage
-- 			else
-- 				new_height := properties_box.height
-- 				if a_query.query_type.is_equal ("BOOLEAN") then
-- 					!! boolean_editor_form.make ("", properties_box)
-- 					boolean_editor_form.set_query (a_query)
-- 					form_table.force (boolean_editor_form, a_query.query_name)
-- 					new_height := new_height + boolean_editor_form.height
-- 				else
-- 					!! any_editor_form.make ("", properties_box)
-- 					any_editor_form.set_query (a_query)
-- 					form_table.force (any_editor_form, a_query.query_name)
-- 					new_height := new_height + any_editor_form.height
-- 				end
-- 			end
-- 			properties_box.set_size (properties_box.width, new_height)
		end

	remove_query_editor_form (a_query: APPLICATION_QUERY) is
			-- Remove a form from the set of properties.
		require
			query_not_void: a_query /= Void
			item_referenced: form_table.has (a_query.query_name)
		local
			new_height: INTEGER
		do
-- 			new_height := properties_box.height - form_table.item (a_query.query_name).height
-- 			form_table.item (a_query.query_name).unmanage
-- 			properties_box.set_size (properties_box.width, new_height)
		end
feature -- Closeable

	close is
			-- Close object tool generator.
		do
			hide
		end

	display (application_class: EV_LIST_ITEM) is
			-- Display object tool generator.
		require
			class_not_void: application_class /= Void
		local	
--			mp: MOUSE_PTR
			previous_class: APPLICATION_CLASS	
		do
-- 			!! mp
-- 			mp.set_watch_shape
 			previous_class := edited_class
 			edited_class ?= application_class
 			check
 				edited_class_not_void: edited_class /= Void
 			end
			show
 			if previous_class = Void or else edited_class /= previous_class then
 				update_interface
 			end
-- 			mp.restore
-- 			raise
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
			list_item: EV_LIST_ITEM
		do
 			create temp_title.make (0)
 			temp_title.append ("Object tool generator: ")
 			temp_title.append (edited_class.class_name)
 			set_title (temp_title)
 			exclude_all_queries
 			excluded_list.clear_items
 			included_list.clear_items
 			query_list := edited_class.query_list
 			from
 				query_list.start
 			until
 				query_list.after
 			loop
				create list_item.make_with_text (excluded_list,
												query_list.item.value)
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
