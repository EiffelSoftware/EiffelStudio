indexing
	description: "Really simple calculator. Demonstrates how to reuse a .NET type."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	WORLD_CALC

inherit 
	WINFORMS_FORM
		rename
			make as make_form,
			refresh as refresh_winform
		redefine
			dispose_boolean
		end

	ANY

create
	make

feature {NONE} -- Initialization

	make is
			--| Call `initialize_components'.
			-- Entry point.
		do
			initialize_components
			{WINFORMS_APPLICATION}.run_form (Current)
		end

feature -- Access

	components: SYSTEM_DLL_SYSTEM_CONTAINER	
			-- System.ComponentModel.Container.

	btn_equals, btn_clear: WINFORMS_BUTTON			
			-- System.Windows.Forms.Button.

	btn_numbers, btn_ops: NATIVE_ARRAY [WINFORMS_BUTTON]
			-- List of btn_numbers, and btn_ops.


	txt_formula: WINFORMS_TEXT_BOX
			-- System.Windows.Forms.TextBox 

	lbl_formula: WINFORMS_LABEL
			-- System.Windows.Forms.Label

feature -- Implementation

	initialize_components is
			-- Initialize all components of window.
		local
			l_size: DRAWING_SIZE
			l_point: DRAWING_POINT
			i: INTEGER
		do
			create components.make
			create txt_formula.make
			create lbl_formula.make
			create btn_equals.make
			create btn_clear.make
			create btn_numbers.make (10)
			create btn_ops.make (4)

			set_text ("Math Greeting")
			-- no need for the keyword `create' as DRAWING_SIZE is an expanded class (.NET value type)
			l_size.make (5, 13) 
			set_auto_scale_base_size (l_size)
			l_size.make (250, 230)
			set_client_size (l_size)

			l_point.make (8, 10)
			lbl_formula.set_location (l_point)
			lbl_formula.set_text ("Formula:")
			l_size.make (155, 20)
			lbl_formula.set_size (l_size)

			l_point.make (8, 28)
			txt_formula.set_location (l_point)
			txt_formula.set_tab_index (0)
			l_size.make (150, 25)
			txt_formula.set_size (l_size)
			txt_formula.set_read_only (True)

			l_point.make (165, 28)
			btn_clear.set_location (l_point)
			l_size.make (80, 25)
			btn_clear.set_size (l_size)
			btn_clear.set_text ("Clear")
			btn_clear.add_click (create {EVENT_HANDLER}.make (Current, $on_btn_clear_clicked))

			btn_numbers.put (0, create {WINFORMS_BUTTON}.make)
			l_point.make (8, 180)
			btn_numbers.item (0).set_location (l_point)
			btn_numbers.item (0).set_text ("0")

			btn_numbers.put (1, create {WINFORMS_BUTTON}.make)
			l_point.make (8, 60)
			btn_numbers.item (1).set_location (l_point)
			btn_numbers.item (1).set_text ("1")

			btn_numbers.put (2, create {WINFORMS_BUTTON}.make)
			l_point.make (48, 60)
			btn_numbers.item (2).set_location (l_point)
			btn_numbers.item (2).set_text ("2")

			btn_numbers.put (3, create {WINFORMS_BUTTON}.make)
			l_point.make (88, 60)
			btn_numbers.item (3).set_location (l_point)
			btn_numbers.item (3).set_text ("3")

			btn_numbers.put (4, create {WINFORMS_BUTTON}.make)
			l_point.make (8, 100)
			btn_numbers.item (4).set_location (l_point)
			btn_numbers.item (4).set_text ("4")

			btn_numbers.put (5, create {WINFORMS_BUTTON}.make)
			l_point.make (48, 100)
			btn_numbers.item (5).set_location (l_point)
			btn_numbers.item (5).set_text ("5")

			btn_numbers.put (6, create {WINFORMS_BUTTON}.make)
			l_point.make (88, 100)
			btn_numbers.item (6).set_location (l_point)
			btn_numbers.item (6).set_text ("6")

			btn_numbers.put (7, create {WINFORMS_BUTTON}.make)
			l_point.make (8, 140)
			btn_numbers.item (7).set_location (l_point)
			btn_numbers.item (7).set_text ("7")

			btn_numbers.put (8, create {WINFORMS_BUTTON}.make)
			l_point.make (48, 140)
			btn_numbers.item (8).set_location (l_point)
			btn_numbers.item (8).set_text ("8")

			btn_numbers.put (9, create {WINFORMS_BUTTON}.make)
			l_point.make (88, 140)
			btn_numbers.item (9).set_location (l_point)
			btn_numbers.item (9).set_text ("9")

			from
				i := 0
			until
				i = 10
			loop
				l_size.make (30, 30)
				btn_numbers.item (i).set_size (l_size)
				btn_numbers.item (i).add_click (create {EVENT_HANDLER}.make (Current, $on_btn_numbers_clicked))
				i := i + 1
			end

			btn_ops.put (0, create {WINFORMS_BUTTON}.make)
			l_point.make (128, 60)
			btn_ops.item (0).set_location (l_point)
			btn_ops.item (0).set_text ("+")

			btn_ops.put (1, create {WINFORMS_BUTTON}.make)
			l_point.make (128, 100)
			btn_ops.item (1).set_location (l_point)
			btn_ops.item (1).set_text ("-")

			btn_ops.put (2, create {WINFORMS_BUTTON}.make)
			l_point.make (128, 140)
			btn_ops.item (2).set_location (l_point)
			btn_ops.item (2).set_text ("*")

			btn_ops.put (3, create {WINFORMS_BUTTON}.make)
			l_point.make (128, 180)
			btn_ops.item (3).set_location (l_point)
			btn_ops.item (3).set_text ("/")

			from
				i := 0
			until
				i = 4
			loop
				l_size.make (30, 30)
				btn_ops.item (i).set_size (l_size)
				btn_ops.item (i).add_click (create {EVENT_HANDLER}.make (Current, $on_btn_op_clicked))
				i := i + 1
			end

			l_point.make (48, 180)
			btn_equals.set_location (l_point)
			l_size.make (70, 30)
			btn_equals.set_size (l_size)
			btn_equals.set_tab_index (1)
			btn_equals.set_text ("Calculate")
			btn_equals.add_click (create {EVENT_HANDLER}.make (Current, $on_btn_equals_clicked))

			controls.add (txt_formula)
			controls.add (lbl_formula)
			controls.add (btn_equals)
			controls.add (btn_clear)

			from
				i := 0
			until
				i = 10
			loop
				controls.add (btn_numbers.item (i))
				i := i + 1
			end

			from
				i := 0
			until
				i = 4
			loop
				controls.add (btn_ops.item (i))
				i := i + 1
			end
		end

feature -- Implementation

	dispose_boolean (a_disposing: BOOLEAN) is
			-- method called when form is disposed.
		local
			retried: BOOLEAN
		do
			if not retried then
				if components /= Void then
					components.dispose	
				end
			end
			Precursor {WINFORMS_FORM}(a_disposing)
		rescue
			retried := true
			retry
		end

	on_btn_clear_clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Feature performed when button `btn_clear' is clicked.
		do
			 txt_formula.set_text ("")
		end

	on_btn_numbers_clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Feature performed when button `btn_numbers' is clicked.
		local
			btn: WINFORMS_BUTTON
			l_text: STRING
		do
			btn ?= sender
			check
				non_void_btn: btn /= Void
			end
			l_text := txt_formula.text
			l_text.append (btn.text)
			txt_formula.set_text (l_text)
		end

	on_btn_op_clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Feature performed when button `btn_op' is clicked.
		local
			btn: WINFORMS_BUTTON
			l_text: STRING
		do
			btn ?= sender
			check
				non_void_btn: btn /= Void
			end
			l_text := txt_formula.text
			l_text.append (" ")
			l_text.append (btn.text)
			l_text.append (" ")
			txt_formula.set_text (l_text)
		end

	on_btn_equals_clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Feature performed when button `btn_equal' is clicked.
		local
			my_parse: PARSER_PARSER
			retried: BOOLEAN
			res: WINFORMS_DIALOG_RESULT
			l_args: PARSER_ARGUMENTS
			l_int_math: INTEGER_MATH
		do
			if not retried then
				if not txt_formula.text.equals ({SYSTEM_STRING}.empty) then
						-- parse the formula and get the arguments
					create my_parse.make
					l_args := my_parse.parse (txt_formula.text)
					create l_int_math.make
					txt_formula.set_text (l_int_math.get_result (
						{SYSTEM_CONVERT}.to_int_32 (l_args.arg_1),
						l_args.op, {SYSTEM_CONVERT}.to_int_32 (l_args.arg_2)))
				end
			else
				res := {WINFORMS_MESSAGE_BOX}.show (
					"Invalid calculation entered.%N%N  Enter 'num1' 'op' 'num2'%N%N")
			end
		rescue
			retried := True
			retry
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- Class WORLD_CALC


