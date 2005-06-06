indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID_VALUE_LINE

inherit

	ES_OBJECTS_GRID_LINE
		rename
			data as object,
			set_data as set_object
		redefine
			object,
			reset_special_attributes_values
		end

create
	make_with_value

feature {NONE}

	make_with_value (dv: ABSTRACT_DEBUG_VALUE; ot: like tool) is
		require
			dv /= Void
		local
			conv_abs_ref: ABSTRACT_REFERENCE_VALUE
			conv_abs_spec: ABSTRACT_SPECIAL_VALUE
		do
			make (ot)
			conv_abs_ref ?= dv
			if conv_abs_ref /= Void then
				object_address := conv_abs_ref.address
			else
				conv_abs_spec ?= dv
				if conv_abs_spec /= Void then
					object_address := conv_abs_spec.address
					object_is_special_value := True
					object_spec_capacity := conv_abs_spec.capacity
				else
					object_address := Void -- "Unknown address"
				end
			end
			set_object (dv)
		end

feature -- Properties

	object: ABSTRACT_DEBUG_VALUE

	object_name: STRING is
		do
			Result := object.name
		end

	object_address: STRING

	object_dynamic_class: CLASS_C is
		do
			Result := object.dynamic_class
		end

	object_spec_capacity: INTEGER

feature -- Query

	has_attributes_values: BOOLEAN is
		do
			Result := object.expandable
		end

	reset_special_attributes_values is
		local
			spec_items: ABSTRACT_SPECIAL_VALUE
		do
			spec_items ?= object
			if spec_items /= Void then
				spec_items.reset_items
				spec_items.set_sp_bounds (object_spec_lower, object_spec_upper)
			end
		end

	sorted_attributes_values: DS_LIST [ABSTRACT_DEBUG_VALUE] is
		do
			Result := object.sorted_children
		end

	sorted_once_functions: LIST [E_FEATURE] is
		local
			l_class: CLASS_C
		do
			l_class := object_dynamic_class
			if l_class = Void then
				--| Q: Why do we have Void dynamic_class ?
				--| ANSWER : because of external class in dotnet system
				--| Should be fixed now by using SYSTEM_OBJECT for unknown type
			else
				Result := l_class.once_functions
			end
		end

	associated_debug_value: ABSTRACT_DEBUG_VALUE is
		do
			Result := object
		end

feature -- Graphical changes

	compute_grid_display is
		local
			dv: ABSTRACT_DEBUG_VALUE
			dmdv: DUMMY_MESSAGE_DEBUG_VALUE
		do
			if row /= Void and not compute_grid_display_done then
				compute_grid_display_done := True
				dv := object
				check dv /= Void end
				if dv.is_dummy_value then
					last_dump_value := Void
					dmdv ?= dv
					set_name (dv.name)
					set_type (Interface_names.l_Dummy)
					set_address (Void)
					set_value (dmdv.display_message)
					set_pixmap (Icons @ (dv.kind))
				else
					last_dump_value := dv.dump_value
					set_name (dv.name)
					set_type (last_dump_value.generating_type_representation)
					set_address (dv.address)
					set_value (last_dump_value.output_for_debugger)
					set_pixmap (Icons @ (dv.kind))

					if dv.expandable then
						row.ensure_expandable
						expand_actions.extend (agent on_row_expand)
						collapse_actions.extend (agent on_row_collapse)
						if display then
							row.expand
						end
					end
				end
				update
			end
		end

invariant
	object_not_void: object /= Void

end
