indexing
	description: "Really simple calculator. %
				% Show how to use external assemblies."

class
	WORLD_CALC

inherit 
	WINFORMS_FORM
		rename
			make as make_form,
			refresh as refresh_winform
		undefine
			to_string, finalize, equals, get_hash_code
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
		local
			dummy: SYSTEM_OBJECT
		do
			initialize_components

			feature {WINFORMS_APPLICATION}.run_form (Current)
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
			l_button: WINFORMS_BUTTON
		do
			create components.make
			create txt_formula.make
			create lbl_formula.make
			create btn_equals.make
			create btn_clear.make
			create btn_numbers.make (10)
			create btn_ops.make (4)

			set_text (("Math_Greeting").to_cil)
			l_size.make_from_width_and_height (5, 13)
			set_auto_scale_base_size (l_size)
			l_size.make_from_width_and_height (250, 230)
			set_client_size (l_size)

			l_point.make_from_x_and_y (8, 10)
			lbl_formula.set_location (l_point)
			lbl_formula.set_text (("Formula:").to_cil)
			l_size.make_from_width_and_height (155, 20)
			lbl_formula.set_size (l_size)

			l_point.make_from_x_and_y (8, 28)
			txt_formula.set_location (l_point)
			txt_formula.set_tab_index (0)
			l_size.make_from_width_and_height (150, 25)
			txt_formula.set_size (l_size)
			txt_formula.set_read_only (True)

			l_point.make_from_x_and_y (165, 28)
			btn_clear.set_location (l_point)
			l_size.make_from_width_and_height (80, 25)
			btn_clear.set_size (l_size)
			btn_clear.set_text (("Clear").to_cil)
			btn_clear.add_click (create {EVENT_HANDLER}.make (Current, $on_btn_clear_clicked))

			btn_numbers.put (0, create {WINFORMS_BUTTON}.make)
			l_point.make_from_x_and_y (8, 180)
			btn_numbers.item (0).set_location (l_point)
			btn_numbers.item (0).set_text (("0").to_cil)

			btn_numbers.put (1, create {WINFORMS_BUTTON}.make)
			l_point.make_from_x_and_y (8, 60)
			btn_numbers.item (1).set_location (l_point)
			btn_numbers.item (1).set_text (("1").to_cil)

			btn_numbers.put (2, create {WINFORMS_BUTTON}.make)
			l_point.make_from_x_and_y (48, 60)
			btn_numbers.item (2).set_location (l_point)
			btn_numbers.item (2).set_text (("2").to_cil)

			btn_numbers.put (3, create {WINFORMS_BUTTON}.make)
			l_point.make_from_x_and_y (88, 60)
			btn_numbers.item (3).set_location (l_point)
			btn_numbers.item (3).set_text (("3").to_cil)

			btn_numbers.put (4, create {WINFORMS_BUTTON}.make)
			l_point.make_from_x_and_y (8, 100)
			btn_numbers.item (4).set_location (l_point)
			btn_numbers.item (4).set_text (("4").to_cil)

			btn_numbers.put (5, create {WINFORMS_BUTTON}.make)
			l_point.make_from_x_and_y (48, 100)
			btn_numbers.item (5).set_location (l_point)
			btn_numbers.item (5).set_text (("5").to_cil)

			btn_numbers.put (6, create {WINFORMS_BUTTON}.make)
			l_point.make_from_x_and_y (88, 100)
			btn_numbers.item (6).set_location (l_point)
			btn_numbers.item (6).set_text (("6").to_cil)

			btn_numbers.put (7, create {WINFORMS_BUTTON}.make)
			l_point.make_from_x_and_y (8, 140)
			btn_numbers.item (7).set_location (l_point)
			btn_numbers.item (7).set_text (("7").to_cil)

			btn_numbers.put (8, create {WINFORMS_BUTTON}.make)
			l_point.make_from_x_and_y (48, 140)
			btn_numbers.item (8).set_location (l_point)
			btn_numbers.item (8).set_text (("8").to_cil)

			btn_numbers.put (9, create {WINFORMS_BUTTON}.make)
			l_point.make_from_x_and_y (88, 140)
			btn_numbers.item (9).set_location (l_point)
			btn_numbers.item (9).set_text (("9").to_cil)

			from
				i := 0
			until
				i = 10
			loop
				l_size.make_from_width_and_height (30, 30)
				btn_numbers.item (i).set_size (l_size)
				btn_numbers.item (i).add_click (create {EVENT_HANDLER}.make (Current, $on_btn_numbers_clicked))
				i := i + 1
			end

			btn_ops.put (0, create {WINFORMS_BUTTON}.make)
			l_point.make_from_x_and_y (128, 60)
			btn_ops.item (0).set_location (l_point)
			btn_ops.item (0).set_text (("+").to_cil)

			btn_ops.put (1, create {WINFORMS_BUTTON}.make)
			l_point.make_from_x_and_y (128, 100)
			btn_ops.item (1).set_location (l_point)
			btn_ops.item (1).set_text (("-").to_cil)

			btn_ops.put (2, create {WINFORMS_BUTTON}.make)
			l_point.make_from_x_and_y (128, 140)
			btn_ops.item (2).set_location (l_point)
			btn_ops.item (2).set_text (("*").to_cil)

			btn_ops.put (3, create {WINFORMS_BUTTON}.make)
			l_point.make_from_x_and_y (128, 180)
			btn_ops.item (3).set_location (l_point)
			btn_ops.item (3).set_text (("/").to_cil)

			from
				i := 0
			until
				i = 4
			loop
				l_size.make_from_width_and_height (30, 30)
				btn_ops.item (i).set_size (l_size)
				btn_ops.item (i).add_click (create {EVENT_HANDLER}.make (Current, $on_btn_op_clicked))
				i := i + 1
			end

			l_point.make_from_x_and_y (48, 180)
			btn_equals.set_location (l_point)
			l_size.make_from_width_and_height (70, 30)
			btn_equals.set_size (l_size)
			btn_equals.set_tab_index (1)
			btn_equals.set_text (("Calculate").to_cil)
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
			dummy: WINFORMS_DIALOG_RESULT
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
			 txt_formula.set_text (("").to_cil)
		end

	on_btn_numbers_clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Feature performed when button `btn_numbers' is clicked.
		local
			btn: WINFORMS_BUTTON
		do
			btn ?= sender
			check
				non_void_btn: btn /= Void
			end
			txt_formula.set_text ((("").to_cil).concat_string_string (txt_formula.text, btn.text))
		end

	on_btn_op_clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Feature performed when button `btn_op' is clicked.
		local
			btn: WINFORMS_BUTTON
		do
			btn ?= sender
			check
				non_void_btn: btn /= Void
			end
			txt_formula.set_text ((("").to_cil).concat_string_string_string_string (txt_formula.text, (" ").to_cil, btn.text, (" ").to_cil))
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
				if not txt_formula.text.equals (("").to_cil) then
						-- parse the formula and get the arguments
					create my_parse.make
					l_args := my_parse.parse (txt_formula.text)
					create l_int_math.make
					txt_formula.set_text (l_int_math.get_result 
						(feature {CONVERT}.to_int_32_string (l_args.arg_1),
						l_args.op, 
						feature {CONVERT}.to_int_32_string (l_args.arg_2)))
				end
			else
				res := feature {WINFORMS_MESSAGE_BOX}.show (("Invalid calculation entered.%N%N  Enter 'num1' 'op' 'num2'%N%N").to_cil)
			end
		rescue
			retried := True
			retry
		end

end -- Class WORLD_CALC


