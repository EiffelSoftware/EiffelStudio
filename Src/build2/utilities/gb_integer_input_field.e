indexing
	description: "Objects that allow user input of an integer value."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_INTEGER_INPUT_FIELD

inherit
	EV_VERTICAL_BOX
	
	GB_ACCESSIBLE_OBJECT_EDITOR
	
create

	make

feature {NONE} -- Initialization
	
	make (gb_ev_any: GB_EV_ANY; a_parent: EV_CONTAINER; label_text: STRING; an_execution_agent: PROCEDURE [ANY, TUPLE [INTEGER]]; a_validate_agent: FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]) is
			-- Create `Current' with `gb_ev_any' as the client of `Current', we need this to call `update_atribute_editors'.
			-- Build widget structure into `a_parent'. Use `label_text' as the text of the label next to the text field for entry.
			-- `an_execution_agent' is to execute the setting of the attribute.
			-- `a_validate_agent' is used to query whether the current value is valid as an argument for `execution_agent'.
		require
			gb_ev_any_not_void: gb_ev_any /= Void
			a_parent_not_void: a_parent /= Void
			label_text_not_void_or_empty: label_text /= Void and not label_text.is_empty
			an_agent_not_void: an_execution_agent /= Void
			a_validate_agent_not_void: a_validate_agent /= Void
		local
			label: EV_LABEL
		do
			default_create
			create label.make_with_text (label_text)
			extend (label)
			label.align_text_left
			create text_field
			extend (text_field)
			disable_item_expand (label)
			a_parent.extend (Current)
			text_field.return_actions.extend (agent process)
			text_field.focus_in_actions.extend (agent set_initial)
			text_field.focus_out_actions.extend (agent process)
			
				-- Store `an_exection_agent' internally.
			execution_agent := an_execution_agent

				-- Store `a_validate_agent'.
			validate_agent := a_validate_agent
			
			internal_gb_ev_any := gb_ev_any
		ensure
			execution_agent_not_void: execution_agent /= Void
			validate_agent_not_void: validate_agent /= Void
			internal_gb_ev_any_not_void: internal_gb_ev_any /= Void
		end

feature -- Basic operations

	set_text (a_text: STRING) is
			-- Assign `a_text' to text of `text_field'.
		do
			text_field.set_text (a_text)
		end
		
feature -- Access

	text: STRING is
			-- `Result' is text of `text_field'.
		do
			Result := text_field.text
		end
		

feature {NONE} -- Implementation

	execution_agent: PROCEDURE [ANY, TUPLE [INTEGER]]
		-- Agent to execute command associated with value entered into `Current'.

	text_field: EV_TEXT_FIELD
		-- Text field usd for user input.
	
	value_on_entry: STRING
		-- Contents of `text_field' when focus in is received.
	
	internal_gb_ev_any: GB_EV_ANY
		-- instance of GB_EV_ANY that is client of `Current'.

	validate_agent: FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]
		-- Is integer a valid integer for `execution_agent'.

	execute_agent is
			-- call `execution_agent'.
		do
			execution_agent.call ([text_field.text.to_integer])
		end
		
	update_editors is
			-- Short version for calling everywhere.
		do
			update_editors_for_property_change (internal_gb_ev_any.objects.first, internal_gb_ev_any.type, internal_gb_ev_any.parent_editor)			
		end
		
	set_initial is
			-- Assign text of text field to `value_on_entry'.
		require
			text_field_not_void: text_field /= Void
		do
			value_on_entry := text_field.text
		end
		
	process is
			-- Validate information in `text_field' and execute `execute_agent'
			-- if valid. If not valid, then restore previous value to `text_field'.
		do
			if not text_field.text.is_equal (value_on_entry) then
				if not text_field.text.is_empty and text_field.text.is_integer then
					validate_agent.call ([text_field.text.to_integer])
					if validate_agent.last_result then
						execute_agent
						update_editors
					else
						text_field.set_text (value_on_entry)
					end
				else
					text_field.set_text (value_on_entry)
				end
			end
		end

end -- class GB_INTEGER_INPUT_FIELD
