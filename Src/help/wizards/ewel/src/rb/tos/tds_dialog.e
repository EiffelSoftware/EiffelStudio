indexing
	description: "Dialog representation in the tds"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_DIALOG

inherit
	TDS_RESOURCE
		rename
			make as list_make
		end

	TDS_DEFINE_TABLE

creation
	make

feature -- Initialization

	make is
		do
			list_make
			set_wel_code (true)
			set_type (R_dialog)
			set_inherited_class ("WEL_MODAL_DIALOG")
		end

	make_control_statement is
		do
			!! statement_list.make (10)
		end

feature -- Access

	x: INTEGER
			-- `x' position of the dialog.
                        
	y: INTEGER
			-- `y' position of the dialog.

	width: INTEGER
			-- The dialog `width'.

	height: INTEGER
			-- The dialog `height'.

	current_control: TDS_CONTROL_STATEMENT
			-- The current parsed control.

	statement_list: HASH_TABLE [TDS_CONTROL_STATEMENT, INTEGER]
			-- List of dialog controls.

	redefined_features: LINKED_LIST [STRING]
			-- List of redefined features of the current dialog.

	inherited_class: STRING
			-- Name of the inherited WEL class.


feature -- Element change

	set_current_control (a_control: TDS_CONTROL_STATEMENT) is
			-- Set `current_control' to `a_control'.
		require
			a_control_not_void: a_control /= Void
		do
			current_control := a_control
		ensure
			current_control_set: current_control = a_control
		end

	set_x (a_x: INTEGER) is
			-- Set `x' to `a_x'.
		do
			x := a_x
		ensure
			x_set: x = a_x
		end

	set_y (a_y: INTEGER) is
			-- Set `y' to `a_y'.
		do
			y := a_y
		ensure
			y_set: y = a_y
		end

	set_width (a_width: INTEGER) is
			-- Set `width' to `a_width'.
		do
			width := a_width
		ensure
			width_set: width = a_width
		end

	set_height (a_height: INTEGER) is
			-- Set `height' to `a_height'.
		do
			height := a_height
		ensure
			height_set: height = a_height
		end

	set_inherited_class (a_class_name: STRING) is
			-- Set `inherited_class' to `a_class_name'.
		require
			a_class_name_not_void: a_class_name /= Void
			a_class_name_exists: a_class_name.count > 0
		do
			inherited_class := clone (a_class_name)
		ensure
			inherited_class_set: inherited_class.is_equal (a_class_name)
		end

	add_feature (a_feature_name: STRING) is
			-- Add a feature to 'redefined_features'.
		require
			a_feature_name_not_void: a_feature_name /= Void
			a_feature_name_exists: a_feature_name.count > 0
		do
			if redefined_features = Void then
				!! redefined_features.make
				redefined_features.compare_objects
			end

			if not redefined_features.has (a_feature_name) then
				redefined_features.extend (a_feature_name)
			end
		end

	remove_feature (a_feature_name: STRING) is
			-- Add a feature to 'redefined_features'.
		require
			a_feature_name_not_void: a_feature_name /= Void
			a_feature_name_exists: a_feature_name.count > 0
		do
			if redefined_features /= Void then
				if redefined_features.has (a_feature_name) then
					redefined_features.prune_all (a_feature_name)
				end
			end
		end

	insert_control (a_control: TDS_CONTROL_STATEMENT) is
			-- If a TDS_CONTROL_STATEMENT structure exists insert `a_control'
			-- else create the TDS_CONTROL_STATEMENT structure
		require
			a_control_not_void: a_control /= Void
		local
			control: TDS_CONTROL_STATEMENT
		do			
			if statement_list.has (a_control.type) then
				control := statement_list.item (a_control.type)
				control.insert (a_control)
			else
				statement_list.put (a_control, a_control.type)		-- #### It's a bit ugly, it will be better to create an empty instance of control 'type'.
				a_control.insert (a_control)
			end
		end

feature -- Code generation

	display is
			-- Display the tds.
		do
			from 
				start
			until 
				after
			loop
				io.putstring ("%N------------------------------------")
				io.putstring ("%NDialog ID : ")
				id.display

				if (load_and_mem_attributes /= Void) then
					load_and_mem_attributes.display
				end                

				io.putstring ("%Nx = ")
				io.putint (x)

				io.putstring ("%Ny = ")
				io.putint (y)

				io.putstring ("%Nwidth = ")
				io.putint (width)

				io.putstring ("%Nheight = ")
				io.putint (height)

				if (options /= Void) then
					io.new_line
					options.display
				end

				if (statement_list /= Void) then
					io.new_line

					from
						statement_list.start
					until 
						statement_list.off
					loop
						statement_list.item_for_iteration.display
						statement_list.forth
					end
				end

				io.new_line
				forth
			end
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		do
			a_resource_file.putstring ("%N////////////////////////////////////////////////////////////////%N")
			a_resource_file.putstring ("//%N")
			a_resource_file.putstring ("// DIALOG%N")
			a_resource_file.putstring ("//%N")

			from 
				start
			until 
				after
			loop
				a_resource_file.new_line
				id.generate_resource_file (a_resource_file)
				a_resource_file.putstring (" DIALOG ")

				if (load_and_mem_attributes /= Void) then
					load_and_mem_attributes.generate_resource_file (a_resource_file)
				end                

				a_resource_file.putint (x)

				a_resource_file.putstring (", ")
				a_resource_file.putint (y)

				a_resource_file.putstring (", ")
				a_resource_file.putint (width)

				a_resource_file.putstring (", ")
				a_resource_file.putint (height)

				if (options /= Void) then
					options.generate_resource_file (a_resource_file)
				end

				a_resource_file.putstring ("%NBEGIN")
					
				if (statement_list /= Void) then
                                	from
						statement_list.start
					until 
						statement_list.off
					loop
						statement_list.item_for_iteration.generate_resource_file (a_resource_file)
						statement_list.forth
					end
				end
				a_resource_file.putstring ("%NEND")

				a_resource_file.new_line
				forth
			end
		end

	generate_tree_view (a_tree_view: EV_TREE_ITEM) is
			-- Generate `a_tree_view' control from the tds memory structure.
		local
			tv_item: EV_TREE_ITEM
		do
			create tv_item.make_with_text ("Dialog")
			tv_item.set_data (Void)
			a_tree_view.extend (tv_item)
			
			from
				start
			until
				after
			loop
				item.id.generate_tree_view (tv_item)
				item.set_tree_view_item (tv_item.last)
				forth
			end 
		end

	generate_wel_code is
			-- Generate the eiffel code.
		local
			text_file: PLAIN_TEXT_FILE
			a_filename: STRING
			control_list: TDS_CONTROL_STATEMENT
			cur_dialog: TDS_DIALOG
		do
			from 
				start
			until 
				after
			loop
				cur_dialog ?= item
				if cur_dialog /= Void then
					if cur_dialog.is_wel_code_on then
						!! a_filename.make (64)
						a_filename.append (cur_dialog.class_name)
						a_filename.to_lower
						a_filename.append (".e")
	
						!! text_file.make_open_write (a_filename)

						text_file.putstring ("indexing %N%Tdescription: %"")
						text_file.putstring (cur_dialog.class_name)
						text_file.putstring (" class created by Resource Bench.%"%N")

						text_file.putstring ("%Nclass %N%T")
						text_file.putstring (cur_dialog.class_name)

						text_file.putstring ("%N%Ninherit%N%T")
						text_file.putstring (cur_dialog.inherited_class)
	
						if cur_dialog.redefined_features /= Void then
							text_file.putstring ("%N%T%Tredefine")
	
							from
								cur_dialog.redefined_features.start
							until
								cur_dialog.redefined_features.after
							loop
								text_file.putstring ("%N%T%T%T")
								text_file.putstring (cur_dialog.redefined_features.item)
	
								cur_dialog.redefined_features.forth
								if not cur_dialog.redefined_features.after then
									text_file.putstring (",")
								end
							end

							text_file.putstring ("%N%T%Tend%N")
						else
							text_file.new_line
						end
	
						text_file.putstring ("%N%TAPPLICATION_IDS%N%T%Texport%N%T%T%T{NONE} all%N%T%Tend%N")
	
						text_file.putstring ("%Ncreation%N%Tmake%N")
						text_file.putstring ("%Nfeature {NONE} -- Initialization%N")
	
						if cur_dialog.inherited_class.is_equal ("WEL_MAIN_DIALOG") then
							text_file.putstring ("%N%Tmake is")
							text_file.putstring ("%N%T%T%T-- Create the dialog.")
							text_file.putstring ("%N%T%Tdo")
	
							if (cur_dialog.id.has_number) or else (cur_dialog.define_table.has (cur_dialog.id.name_id)) then
								text_file.putstring ("%N%T%T%Tmake_by_id (")
								text_file.putstring (cur_dialog.id.to_constant_style)
							else
								text_file.putstring ("%N%T%T%Tmake_by_name (%"")
								text_file.putstring (cur_dialog.id.to_constant_style)
								text_file.putstring ("%"")
							end
						else
							text_file.putstring ("%N%Tmake (a_parent: WEL_COMPOSITE_WINDOW) is")
							text_file.putstring ("%N%T%T%T-- Create the dialog.")
							text_file.putstring ("%N%T%Trequire")
							text_file.putstring ("%N%T%T%Ta_parent_not_void: a_parent /= Void")
							text_file.putstring ("%N%T%T%Ta_parent_exists: a_parent.exists")
	
							text_file.putstring ("%N%T%Tdo")
	
							if (cur_dialog.id.has_number) or else (cur_dialog.define_table.has (id.name_id)) then
								text_file.putstring ("%N%T%T%Tmake_by_id (a_parent, ")
								text_file.putstring (cur_dialog.id.to_constant_style)
							else
								text_file.putstring ("%N%T%T%Tmake_by_name (a_parent, %"")
								text_file.putstring (cur_dialog.id.to_constant_style)
								text_file.putstring ("%"")
							end
						end
	
						text_file.putstring (")")

	
						if (cur_dialog.statement_list /= Void) then
							from
								cur_dialog.statement_list.start
							until 
								cur_dialog.statement_list.off
							loop
								cur_dialog.statement_list.item_for_iteration.generate_make_wel_code (text_file)
								cur_dialog.statement_list.forth
							end
						end
	
						text_file.putstring ("%N%T%Tend%N")
	
						if cur_dialog.redefined_features /= Void then
							text_file.putstring ("%Nfeature -- Behavior%N")
	
							from
								cur_dialog.redefined_features.start
							until
								cur_dialog.redefined_features.after
							loop
								text_file.putstring ("%N%T")
								text_file.putstring (cur_dialog.redefined_features.item)
								if cur_dialog.redefined_features.item.is_equal ("notify") then
									 text_file.putstring (" (control: WEL_CONTROL; notify_code: INTEGER)")
								end
								text_file.putstring (" is%N%T%Tdo%N%T%Tend%N")
	
								cur_dialog.redefined_features.forth
							end
						end
	
						if (cur_dialog.statement_list /= Void) then
							text_file.putstring ("%Nfeature -- Access%N")
	
							from
								cur_dialog.statement_list.start
							until 
								cur_dialog.statement_list.off
							loop
								cur_dialog.statement_list.item_for_iteration.generate_access_wel_code (text_file)
								cur_dialog.statement_list.forth
							end
						end
	
						text_file.putstring ("%N%Nend -- class ")
						text_file.putstring (cur_dialog.class_name)
	
						text_file.putstring ("%N%N--|-------------------------------------------------------------------")
						text_file.putstring ("%N--| This class was automatically generated by Resource Bench")
						text_file.putstring ("%N--| Copyright (C) 1996-1997, Interactive Software Engineering, Inc.")
						text_file.putstring ("%N--|")
						text_file.putstring ("%N--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA")
						text_file.putstring ("%N--| Telephone 805-685-1006")
						text_file.putstring ("%N--| Fax 805-685-6869")
						text_file.putstring ("%N--| Information e-mail <info@eiffel.com>")
						text_file.putstring ("%N--| Customer support e-mail <support@eiffel.com>")
						text_file.putstring ("%N--|-------------------------------------------------------------------%N")
	
						text_file.close
					end
				end
				forth
			end
		end

end -- class TDS_DIALOG

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
