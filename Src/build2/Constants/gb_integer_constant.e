indexing
	description: "[
		Objects that represent an EiffelBuild INTEGER constant.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_INTEGER_CONSTANT
	
inherit
	GB_CONSTANT
	
create
	make_with_name_and_value
	
feature {NONE} -- Initialization

	make_with_name_and_value (a_name: STRING; a_value: INTEGER) is
			-- Assign `a_name' to `name' and `a_value' to value.
		require
			a_name_valid: a_name /= Void and then a_value /= Void
			a_value_valid: a_value /= Void and then a_value /= Void
		do
			name := clone (a_name)
			value := a_value
			create referers.make (4)
		ensure
			name_set: name.is_equal (a_name) and name /= a_name
			value_set: value.is_equal (a_Value) and value /= a_value
		end

feature -- Access

	type: STRING is
			-- Type represented by `Current'
		once
			Result := Integer_constant_type
		end
		
	value: INTEGER
		-- Value of `Current'.
		
	value_as_string: STRING is
			-- Value represented by `Current' as a STRING.
		do
			Result := value.out
		end
		
	as_multi_column_list_row: EV_MULTI_COLUMN_LIST_ROW is
			-- Representation of `Current' as a multi column list row.
		do
			create Result
			Result.set_pixmap (Icon_integer @ 1)
			Result.extend (name)
			Result.extend (type)
			Result.extend (value.out)
			Result.set_data (current)
		end

feature -- Status setting

	set_value (a_value: INTEGER) is
			-- Assign `a_value' to `value'.
		do
			value := a_value
		ensure
			value_set: a_value = value
		end
		
feature {GB_CONSTANTS_DIALOG} -- Implementation

	can_modify_to_value (new_value: INTEGER): BOOLEAN is
			-- May `Current' be changed to `new_value' or are certain
			-- referers not permitted to use `new_value'?
		local
			constant_context: GB_CONSTANT_CONTEXT
			gb_ev_any: GB_EV_ANY
			validate_agent: FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]
		do
			Result := True
			from
				referers.start
			until
				referers.off or not Result
			loop
				constant_context := referers.item
					
					validate_agent ?= new_gb_ev_any (constant_context).validate_agents.item (constant_context.attribute)
					check
						validate_agent_not_void: validate_agent /= Void
					end
					validate_agent.call ([new_value])
					Result := validate_agent.last_result
				referers.forth
			end
		end
		
	modify_value (new_value: INTEGER) is
			-- Modify `value' to `new_value' and update all referers.
		local
			constant_context: GB_CONSTANT_CONTEXT
			gb_ev_any: GB_EV_ANY
			execution_agent: PROCEDURE [ANY, TUPLE [INTEGER]]
		do
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
				execution_agent.call ([new_value])
				referers.forth
			end
			value := new_value
		ensure
			value_set: value = new_value
		end

invariant
	value_not_void: value /= Void

end -- class GB_INTEGER_CONSTANT