indexing
	description: "Class representing the object tool generator %
				% which allows the user to build an object %
				% tool for a specific class."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	OBJECT_TOOL_GENERATOR
	
	--| FIXME extracted from Build with minor
	--| modifications.

inherit

	EV_TITLED_WINDOW

	SHARED_CLASS_IMPORTER
		undefine
			default_create, copy
		end

creation

	make

feature -- Creation

	make (a_name: STRING) is
			-- Create the object tool generator.
		local
			vertical_box, v_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			label: EV_LABEL
		do
			default_create
			set_title (a_name)
			create v_box
			extend (v_box)
			create split_window
			v_box.extend (split_window)
			create generate_button.make_with_text ("Generate")
			v_box.extend (generate_button)
			v_box.disable_item_expand (generate_button)
			generate_button.select_actions.extend (agent perform_code_generation)
			create horizontal_box
			split_window.extend (horizontal_box)
			
			create vertical_box
			create label.make_with_text ("Excluded queries")
			vertical_box.extend (label)
			create excluded_list
			vertical_box.extend (excluded_list)
			vertical_box.disable_item_expand (label)
			horizontal_box.extend (vertical_box)
			
			create vertical_box
			create label.make_with_text ("Default")
			vertical_box.extend (label)
			vertical_box.disable_item_expand (label)
			create precondition_test.make_with_text ("Test precondition")
			vertical_box.extend (precondition_test)
			create no_precondition_test.make_with_text ("No preconditions")
			vertical_box.extend (no_precondition_test)
			create include_button.make_with_text ("Include")
			vertical_box.extend (include_button)
			create exclude_button.make_with_text ("Exclude")
			vertical_box.extend (exclude_button)
			create include_all_button.make_with_text ("Include all")
			vertical_box.extend (include_all_button)
			create exclude_all_button.make_with_text ("Exclude all")
			vertical_box.extend (exclude_all_button)
			horizontal_box.extend (vertical_box)
			
			
			create vertical_box
			create label.make_with_text ("Included queries")
			vertical_box.extend (label)
			create included_list
			vertical_box.extend (included_list)
			vertical_box.disable_item_expand (label)
			horizontal_box.extend (vertical_box)
			
			create scrollable_area
			split_window.extend (scrollable_area)
			create scrollable_area_box
			scrollable_area.extend (scrollable_area_box)
			
			set_minimum_size (600, 800)

			set_callbacks
			create form_table.make (10)
		end

	set_values is
			-- Set values for GUI elements.
		local
			temp_title: STRING
		do
			included_list.enable_multiple_selection
			excluded_list.enable_multiple_selection
		end

	set_callbacks is
			-- Set the GUI elments callbacks.
		do
			include_button.select_actions.extend (agent include_queries)
			include_all_button.select_actions.extend (agent include_all_queries)
			exclude_button.select_actions.extend (agent exclude_queries)
			exclude_all_button.select_actions.extend (agent exclude_all_queries)
		end

feature {NONE} -- GUI attributes

	split_window: EV_VERTICAL_SPLIT_AREA
			-- Form of the top shell itself	

	include_button,
			-- Include button

	include_all_button,
			-- Include all button

	exclude_button,
			-- Exclude button

	exclude_all_button: EV_BUTTON
			-- Exclude all button

	included_list,
			-- List of included queries

	excluded_list: EV_LIST
			-- List of excluded queries
			
	generate_button: EV_BUTTON
		-- Causes generation to begin.

feature --{QUERY_EDITOR_FORM}

	no_precondition_test,
			-- No preconditions test by default field

	precondition_test: EV_RADIO_BUTTON
			-- Preconditions test by default field


feature -- Command execution

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

	move_items (source_list, target_list: EV_LIST) is
			-- Move selected items of `source_list' into
			-- `target_list'.
		local
			selected_items: DYNAMIC_LIST [EV_LIST_ITEM]
			removed: BOOLEAN
			a_query: APPLICATION_QUERY
			temp_item: EV_LIST_ITEM
		do
			if source_list.selected_items.count > 0 then
				selected_items := source_list.selected_items
				from
					selected_items.start
				until
					selected_items.after
				loop
					temp_item := selected_items.item
					source_list.prune (temp_item)
					target_list.extend (temp_item)
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
		end

	move_all_items (source_list, target_list: EV_LIST) is
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
			if a_query.query_type.is_equal ("BOOLEAN") then
				create boolean_editor_form.make ("", scrollable_area_box, precondition_test.is_selected)
				boolean_editor_form.set_query (a_query)
				form_table.force (boolean_editor_form, a_query.query_name)
			else
				create any_editor_form.make ("", scrollable_area_box, precondition_test.is_selected)
				any_editor_form.set_query (a_query)
				form_table.force (any_editor_form, a_query.query_name)
			end
		end

	remove_query_editor_form (a_query: APPLICATION_QUERY) is
			-- Remove a form from the set of properties.
		require
			query_not_void: a_query /= Void
			item_referenced: form_table.has (a_query.query_name)
		local
			new_height: INTEGER
			found: BOOLEAN
			query_form: QUERY_EDITOR_FORM
		do
			--| FIXME need to re-initialize size of scrollable after removal.
			from
				scrollable_area_box.start
			until
				scrollable_area_box.off or found
			loop
				query_form ?= scrollable_area_box.item
				check
					query_form_not_void: query_form /= Void
				end
				if a_query.query_name.is_equal (query_form.query.query_name) then
					scrollable_area_box.remove
					found := true
				end
				if not scrollable_area_box.off then
					scrollable_area_box.forth	
				end
			end
			check
				form_found: found
			end
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
			previous_class: APPLICATION_CLASS	
		do
			previous_class := edited_class
			edited_class ?= application_class
			set_class_type_name (edited_class.class_name)
			check
				edited_class_not_void: edited_class /= Void
			end
				show
			if previous_class = Void or else edited_class /= previous_class then
				update_interface
			end
			raise
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
			create temp_title.make (0)
			temp_title.append ("Object tool generator: ")
			temp_title.append (edited_class.class_name)
			set_title (temp_title)
			exclude_all_queries
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
		
	perform_code_generation is
			-- Generate Eiffel class text.
		local
			generate_object_tool: GENERATE_OBJECT_TOOL_CMD
		do
			create generate_object_tool.make
			generate_object_tool.work (Void)
		end
		

feature -- Attributes

	edited_class: APPLICATION_CLASS
			-- Currently edited application class.

	form_table: HASH_TABLE [QUERY_EDITOR_FORM, STRING]
			-- Hash-table containing all the created 
			-- `QUERY_EDITOR_FORM'.
			
	scrollable_area: EV_SCROLLABLE_AREA
			-- Scrollable area to contain `scrollable_area_box'.
	
	scrollable_area_box: EV_VERTICAL_BOX
			-- Box to contain all the `QUERY_EDITOR_FORM'.

end -- class OBJECT_TOOL_GENERATOR
