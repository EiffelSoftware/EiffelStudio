indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID_ADDRESS_LINE

inherit

	ES_OBJECTS_GRID_LINE
		rename
			data as object_address,
			set_data as set_object_address
		redefine
			object_address,
			recycle
		end

create
	make_with_address,
	make_with_call_stack_element,
	make_with_dump_value

feature {NONE}

	make_with_address (add: STRING; dtype: CLASS_C; ot: like tool) is
		require
			add /= Void
		do
			make (ot)
			object_dynamic_class := dtype
			object_is_special_value := object_dynamic_class.is_special
			set_object_address (add)
		end

	make_with_call_stack_element (elem: EIFFEL_CALL_STACK_ELEMENT; ot: like tool) is
			-- Initialize `Current' and associate it with object
			-- represented by `elem'.
		require
			elem_not_void: elem /= Void
		do
			make_with_address (elem.object_address, elem.dynamic_class, ot)
		end

	make_with_dump_value (dumpvalue: DUMP_VALUE; ot: like tool) is
			-- Initialize `Current' and associate it with object
			-- represented by `elem'.
		require
			dumpvalue_not_void: dumpvalue /= Void
		do
			last_dump_value := dumpvalue
			make_with_address (dumpvalue.address, dumpvalue.dynamic_class, ot)
		end

feature -- Recycling

	recycle is
			-- Recycle data
			-- in order to free special data (for instance dotnet references)
		do
			Precursor
			internal_associated_dump_value := Void
		end

feature -- Properties

	object_name: STRING is
		do
			Result := title
		end

	object_address: STRING

	object_dynamic_class: CLASS_C

	object_spec_capacity: INTEGER is
		do
			Result := debugged_object_manager.special_object_capacity_at_address (object_address)
		end

feature -- Query

	has_attributes_values: BOOLEAN is
		do
			if application.is_valid_object_address (object_address) then
				Result := debugged_object_manager.object_at_address_has_attributes (object_address)
			end
		end

	sorted_attributes_values: DS_LIST [ABSTRACT_DEBUG_VALUE] is
		do
			if application.is_valid_object_address (object_address) then
				Result := debugged_object_manager.sorted_attributes_at_address (object_address, object_spec_lower, object_spec_upper)
			end
		end

	sorted_once_functions: LIST [E_FEATURE] is
		do
			if object_dynamic_class /= Void then
				Result := object_dynamic_class.once_functions
			end
		end

	object_value: STRING is
			-- Full ouput representation for related object
		do
			if last_dump_value = Void then
				get_last_dump_value
			end
			Result := last_dump_value.output_for_debugger
		end

	object_type_representation: STRING is
			-- Full ouput representation for related object
		do
			if last_dump_value = Void then
				get_last_dump_value			
			end
			Result := last_dump_value.generating_type_representation
		end
		
	get_last_dump_value is
		do
			last_dump_value := associated_dump_value
		ensure
			last_dump_value /= Void
		end

	associated_dump_value: DUMP_VALUE is
		do
			Result := internal_associated_dump_value
			if Result = Void then
				Result := Application.dump_value_at_address_with_class (object_address, object_dynamic_class)
				internal_associated_dump_value := Result
			end
		end

	internal_associated_dump_value: like associated_dump_value

feature -- Graphical changes

	compute_grid_display is
		do
			if row /= Void and not compute_grid_display_done then
				compute_grid_display_done := True
				if title = Void then
					set_name ("default")
				else
					set_name (title)
				end
				set_value (object_value)
				set_type (object_type_representation)
				set_address (object_address)				
				set_pixmap (Pixmaps.Icon_object_symbol)
				row.ensure_expandable
				expand_actions.extend (agent on_row_expand)
				collapse_actions.extend (agent on_row_collapse)
				if display then
					row.expand
				end

				update
			end
		end

end
