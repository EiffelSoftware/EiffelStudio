indexing
	description: "Procedure widget."

class
	EV_PROCEDURE_WIDGET [TARGET, OPERANDS -> TUPLE create make end]

inherit
	EV_PROCEDURE [TARGET, OPERANDS]
		undefine
			default_create
		redefine
			make,
			dispose,
			apply
		end

	EV_FRAME
		undefine
			copy,
			out,
			is_equal
		redefine
			dispose
		end

create
	make

feature {NONE} -- Initialization

	make (a_procedure: PROCEDURE [ANY, OPERANDS]; procedure_name: STRING;
		procedure_operand_names: ARRAY [STRING]) is
			-- Adapt from `a_procedure' using `procedure_name' and
 			-- `operand_names'.
		local
			box: EV_HORIZONTAL_BOX
			button: EV_BUTTON
			label: EV_LABEL
			i: INTEGER
			tf: EV_TEXT_FIELD
	        do
			default_create
			{EV_PROCEDURE} Precursor (a_procedure, procedure_name, procedure_operand_names)
			create operands.make
			set_text (name)
			create box
			box.set_padding (5)
			extend (box)
			from
				i := 1
			until
				i > open_count
			loop
				create label.make_with_text (
					operand_name (i) + ": " + operand_type_name (i) + " = "
				)
				if i > 1 then
					label.set_text ("; " + label.text)
				end
				box.extend (label)
				box.disable_child_expand (label)
				if operand_type (i) = internal.dynamic_type_from_string ("STRING") then
					create tf
					box.extend (tf)
					tf.drop_actions.extend (tf~set_text)
					tf.change_actions.extend (~set_string_operand (tf, i))
				else
					create label.make_with_text ("?")
					label.align_text_left
					label.drop_actions.extend (~set_operand (label, ? , i))
					box.extend (label)
				end
				i := i + 1
			end
			create button.make_with_text_and_action ("apply", ~apply)
			box.extend (button)
			box.disable_child_expand (button)
		end

feature  -- Basic operations

	apply is
			-- Check `operands' then `apply'.
		require else
			True
		do
			if valid_operands (operands) then
				{EV_PROCEDURE} Precursor
			else
				(create {EV_INFORMATION_DIALOG}.make_with_text ("Invalid operands!")).show
			end
		end

feature {NONE} -- Implementation

	dispose is
			-- Call both precursors.
		do
			{EV_PROCEDURE} Precursor
			{EV_FRAME} Precursor
		end

	set_operand (label: EV_LABEL; o: ANY; i: INTEGER) is
			-- Set operand `i' to `o'.
			-- Udate `label' accordingly.
		local
			s: STRING
		do
			operands.force (o, i)
			s := o.tagged_out
			label.set_text (s.substring (1, s.index_of ('%N', 1) - 1))
		end

	set_string_operand (tf: EV_TEXT_FIELD; i: INTEGER) is
			-- Set operand `i' to text from `tf'.
			-- Udate `label' accordingly.
		do
			operands.force (tf.text, i)
		end

end -- class EV_PROCEDURE_WIDGET
