indexing
	description: ""

class
	WORLD_CALC

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Entry point."
		local
			dummy: SYSTEM_OBJECT
		do
			create my_window.make
			initialize_components

			dummy := my_window.show_dialog
		end

feature -- Access

	my_window: WINFORMS_FORM
			-- Main window.

	components: SYSTEM_DLL_SYSTEM_CONTAINER	
			-- System.ComponentModel.Container.


--	rm: SYSTEM_DLL_RESSOURCE_MANAGER
--	rs WINFORMS_RESSOURCE_SET  // Used when working with a ResourceManager (See code below)


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
			--
		local
			l_size: DRAWING_SIZE
			l_point: DRAWING_POINT
			i: INTEGER
			l_button: WINFORMS_BUTTON
		do
			-- Create an instance of the resource manager.  The second parameter identifies
			-- the "main" assembly.  All searching for satellites is done based on the location, etc ..
			-- of the main assembly.
			--
--			rm = new ResourceManager( ("MyStrings").to_cil, this.GetType().Assembly) 
--			create rm.make (("MyStrings").to_cil, my_window.type.assembly) 

			--
			-- ResourceSet loads all resources at one time. No "Fallback" provided.
			-- To test using ResourceSet, change "rm.string ()" to "rs.string ()"
			-- and uncomment the following line.
			--
			--rs = rm.GetResourceSet(Thread.CurrentThread.CurrentUICulture, true, true) 

			create components.make
			create txt_formula.make
			create lbl_formula.make
			create btn_equals.make
			create btn_clear.make
			create btn_numbers.make (10)
			create btn_ops.make (4)

--			my_window.set_text (rm.string (("Math_Greeting").to_cil))
			my_window.set_text (("Math_Greeting").to_cil)
			l_size.make_from_width_and_height (5, 13)
			my_window.set_auto_scale_base_size (l_size)
			l_size.make_from_width_and_height (250, 230)
			my_window.set_client_size (l_size)

			l_point.make_from_x_and_y (8, 10)
			lbl_formula.set_location (l_point)
--			lbl_formula.set_text (rm.string (("Math_Formula_Label").to_cil))
			lbl_formula.set_text (("Math_Formula_Label").to_cil)
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
--			btn_clear.set_text (rm.string (("Math_Clear_Button").to_cil))
			btn_clear.set_text (("Math_Clear_Button").to_cil)
			btn_clear.add_click (create {EVENT_HANDLER}.make (Current, $btn_clearClicked))


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

			--for (int i = 0 i < 10 i++) {
			from
				i := 0
			until
				i = 10
			loop
				l_size.make_from_width_and_height (30, 30)
				btn_numbers.item (i).set_size (l_size)
				btn_numbers.item (i).add_click (create {EVENT_HANDLER}.make (Current, $btn_numbersClicked))
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

			--for (int i = 0 i < 4 i++) {
			from
				i := 0
			until
				i = 4
			loop
				l_size.make_from_width_and_height (30, 30)
				btn_ops.item (i).set_size (l_size)
				btn_ops.item (i).add_click (create {EVENT_HANDLER}.make (Current, $btn_opClicked))
				i := i + 1
			end


			l_point.make_from_x_and_y (48, 180)
			btn_equals.set_location (l_point)
			l_size.make_from_width_and_height (70, 30)
			btn_equals.set_size (l_size)
			btn_equals.set_tab_index (1)
--			btn_equals.set_text (rm.string (("Math_Calc_Button").to_cil))
			btn_equals.set_text (("Math_Calc_Button").to_cil)
			btn_equals.add_click (create {EVENT_HANDLER}.make (Current, $btn_equalsClicked))

			my_window.controls.add (txt_formula)
			my_window.controls.add (lbl_formula)
			my_window.controls.add (btn_equals)
			my_window.controls.add (btn_clear)

			--for (int i = 0 i < 10 i++) {
			from
				i := 0
			until
				i = 10
			loop
				my_window.controls.add (btn_numbers.item (i))
				i := i + 1
			end

			--for (int i = 0 i < 4 i++) {
			from
				i := 0
			until
				i = 4
			loop
				my_window.controls.add (btn_ops.item (i))
				i := i + 1
			end

		end


feature -- Implementation


	btn_clearClicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			--
		do
			 txt_formula.set_text (("").to_cil)
		end

	btn_numbersClicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- 
		local
			btn: WINFORMS_BUTTON
		do
			btn ?= sender
			txt_formula.set_text ((("").to_cil).concat_string_string (txt_formula.text, btn.text))
		end

	btn_opClicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			--
		local
			btn: WINFORMS_BUTTON
		do
			btn ?= sender
	--		txt_formula.set_text (txt_formula.Text + " " + btn.Text + " "
			txt_formula.set_text ((("").to_cil).concat_string_string_string_string (txt_formula.text, (" ").to_cil, btn.text, (" ").to_cil))
		end


	btn_equalsClicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			--
--		local
--			my_parse: PARSER
		do

-- ***********************************************************************************************************************			
						-- Should load Parser.dll in ace file...
-- ***********************************************************************************************************************			
			
			
			-- parse the formula and get the arguments
			if txt_formula.text.equals (("").to_cil) then
--				try
--				{
--					Parser p = new Parser()
--					Arguments a = p.Parse(txt_formula.Text)
--				-- do the calc and display the results
--					IntegerMath m = new IntegerMath()
--					txt_formula.set_text (m.GetResult(Convert.ToInt32(a.Arg1), a.Op, Convert.ToInt32(a.Arg2))
--				}
--				catch
--				{
--					MessageBox.Show(rm.string ("Math_Calc_Error"), rm.string ("Math_Greeting"))
--				}
			end
		end


end -- Class WORLD_CALC


