indexing
	description: "Objects that represent constants for colors."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COLOR_CONSTANT
	
inherit
	GB_CONSTANT
	
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end
	
create
	make_with_name_and_value
	
feature {NONE} -- Initialization

	make_with_name_and_value (a_name: STRING; a_value: EV_COLOR) is
			-- 	Assign `a_name' to `name' and `a_value' to `value'.
		require
			a_name_valid: a_name /= Void and then a_value /= Void
			a_value_valid: a_value /= Void and then a_value /= Void
		do
			name := a_name.twin
			value := a_value
			build_small_pixmap
			create referers.make (4)
		ensure
			name_set: name.is_equal (a_name) and name /= a_name
			value_set: value.is_equal (a_value)
		end

	type: STRING is
			-- Type represented by `Current'
		once
			Result := Color_constant_type
		end
		
feature -- Access
		
	value: EV_COLOR
		-- Value of `Current'.
		
	value_as_string: STRING is
			-- Value represented by `Current' as a STRING.
		do
			Result := build_string_from_color (value)
		end
		
	as_multi_column_list_row: EV_MULTI_COLUMN_LIST_ROW is
			-- Representation of `Current' as a multi column list row.
		do
			create Result
			Result.set_pixmap (small_pixmap)
			Result.extend (name)
			Result.extend (type)
			Result.extend (value.red_8_bit.out + ", " + value.green_8_bit.out + ", " + value.blue_8_bit.out)
			Result.set_data (Current)
		end

feature -- Status setting

	set_value (a_value: EV_COLOR) is
			-- Assign `a_value' to `value'.
		require
			value_not_void: a_value /= Void
		do
			value := a_value
		ensure
			value_set: a_value = value
		end
		
feature {GB_CONSTANTS_DIALOG} -- Implementation

	modify_value (new_value: EV_COLOR) is
			-- Modify `value' to `new_value' and update all referers.
		local
			constant_context: GB_CONSTANT_CONTEXT
			execution_agent: PROCEDURE [ANY, TUPLE [EV_COLOR]]
		do
			value := new_value
			build_small_pixmap
			from
				referers.start
			until
				referers.off
			loop
				constant_context := referers.item
				execution_agent ?= new_gb_ev_any (constant_context).execution_agents.item (constant_context.attribute)
				check
					execution_agent_not_void: execution_agent /= Void
				end
				execution_agent.call ([value])
				referers.forth
			end
		ensure
			value_set: value = new_value
		end

feature {NONE} -- Implementation

	build_small_pixmap is
			-- Build `small_pixmap' representing `value'.
		do
			create small_pixmap
			small_pixmap.set_size (16, 16)
			small_pixmap.set_background_color (value)
			small_pixmap.clear
		ensure
			small_pixmap_not_void: small_pixmap /= Void
		end
		

invariant
	value_not_void: value /= Void

end -- class GB_COLOR_CONSTANT
