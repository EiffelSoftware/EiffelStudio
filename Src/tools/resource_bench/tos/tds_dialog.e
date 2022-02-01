note
	description: "Dialog representation in the tds"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		undefine
			is_equal, copy
		end

create
	make

feature -- Initialization

	make
		do
			list_make
			set_wel_code (True)
			set_type (R_dialog)
			set_inherited_class ("WEL_MODAL_DIALOG")
		end

	make_control_statement
		do
			create statement_list.make (10)
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

	set_current_control (a_control: TDS_CONTROL_STATEMENT)
			-- Set `current_control' to `a_control'.
		require
			a_control_not_void: a_control /= Void
		do
			current_control := a_control
		ensure
			current_control_set: current_control = a_control
		end

	set_x (a_x: INTEGER)
			-- Set `x' to `a_x'.
		do
			x := a_x
		ensure
			x_set: x = a_x
		end

	set_y (a_y: INTEGER)
			-- Set `y' to `a_y'.
		do
			y := a_y
		ensure
			y_set: y = a_y
		end

	set_width (a_width: INTEGER)
			-- Set `width' to `a_width'.
		do
			width := a_width
		ensure
			width_set: width = a_width
		end

	set_height (a_height: INTEGER)
			-- Set `height' to `a_height'.
		do
			height := a_height
		ensure
			height_set: height = a_height
		end

	set_inherited_class (a_class_name: STRING)
			-- Set `inherited_class' to `a_class_name'.
		require
			a_class_name_not_void: a_class_name /= Void
			a_class_name_exists: a_class_name.count > 0
		do
			inherited_class := a_class_name.twin
		ensure
			inherited_class_set: inherited_class.is_equal (a_class_name)
		end

	add_feature (a_feature_name: STRING)
			-- Add a feature to 'redefined_features'.
		require
			a_feature_name_not_void: a_feature_name /= Void
			a_feature_name_exists: a_feature_name.count > 0
		do
			if redefined_features = Void then
				create redefined_features.make
				redefined_features.compare_objects
			end

			if not redefined_features.has (a_feature_name) then
				redefined_features.extend (a_feature_name)
			end
		end

	remove_feature (a_feature_name: STRING)
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

	insert_control (a_control: TDS_CONTROL_STATEMENT)
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

	display
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

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE)
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

	generate_tree_view (a_tree_view: WEL_TREE_VIEW; a_parent: POINTER)
			-- Generate `a_tree_view' control from the tds memory structure.
		local
			tvis: WEL_TREE_VIEW_INSERT_STRUCT
			tv_item: WEL_TREE_VIEW_ITEM
			parent: POINTER
		do
			create tvis.make
			tvis.set_sort
			tvis.set_parent (a_parent)
			create tv_item.make
			tv_item.set_text ("Dialog")
			tvis.set_tree_view_item (tv_item)
			a_tree_view.insert_item (tvis)

			from
				parent := a_tree_view.last_item
				set_tree_view_item (parent)
				start
			until
				after
			loop
				item.id.generate_tree_view (a_tree_view, parent)
				item.set_tree_view_item (a_tree_view.last_item)
				forth
			end 
		end

	generate_wel_code
			-- Generate the eiffel code.
		local
			text_file: PLAIN_TEXT_FILE
			a_filename: STRING
		do
			from 
				start
			until 
				after
			loop
				if is_wel_code_on then
					create a_filename.make (64)
					a_filename.append (class_name)
					a_filename.to_lower
					a_filename.append (".e")

					create text_file.make_open_write (a_filename)

					text_file.putstring ("indexing %N%Tdescription: %"")
					text_file.putstring (class_name)
					text_file.putstring (" class created by Resource Bench.%"%N")

					text_file.putstring ("%Nclass %N%T")
					text_file.putstring (class_name)

					text_file.putstring ("%N%Ninherit%N%T")
					text_file.putstring (inherited_class)

					if redefined_features /= Void then
						text_file.putstring ("%N%T%Tredefine")

						from
							redefined_features.start
						until
							redefined_features.after
						loop
							text_file.putstring ("%N%T%T%T")
							text_file.putstring (redefined_features.item)

							redefined_features.forth
							if not redefined_features.after then
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

					if inherited_class.is_equal ("WEL_MAIN_DIALOG") then
						text_file.putstring ("%N%Tmake is")
						text_file.putstring ("%N%T%T%T-- Create the dialog.")
						text_file.putstring ("%N%T%Tdo")

						if (id.has_number) or else (define_table.has (id.name_id)) then
							text_file.putstring ("%N%T%T%Tmake_by_id (")
							text_file.putstring (id.to_constant_style)
						else
							text_file.putstring ("%N%T%T%Tmake_by_name (%"")
							text_file.putstring (id.to_constant_style)
							text_file.putstring ("%"")
						end
					else
						text_file.putstring ("%N%Tmake (a_parent: WEL_COMPOSITE_WINDOW) is")
						text_file.putstring ("%N%T%T%T-- Create the dialog.")
						text_file.putstring ("%N%T%Trequire")
						text_file.putstring ("%N%T%T%Ta_parent_not_void: a_parent /= Void")
						text_file.putstring ("%N%T%T%Ta_parent_exists: a_parent.exists")

						text_file.putstring ("%N%T%Tdo")

						if (id.has_number) or else (define_table.has (id.name_id)) then
							text_file.putstring ("%N%T%T%Tmake_by_id (a_parent, ")
							text_file.putstring (id.to_constant_style)
						else
							text_file.putstring ("%N%T%T%Tmake_by_name (a_parent, %"")
							text_file.putstring (id.to_constant_style)
							text_file.putstring ("%"")
						end
					end

					text_file.putstring (")")


					if (statement_list /= Void) then
						from
							statement_list.start
						until 
							statement_list.off
						loop
							statement_list.item_for_iteration.generate_make_wel_code (text_file)
							statement_list.forth
						end
					end

					text_file.putstring ("%N%T%Tend%N")

					if redefined_features /= Void then
						text_file.putstring ("%Nfeature -- Behavior%N")

						from
							redefined_features.start
						until
							redefined_features.after
						loop
							text_file.putstring ("%N%T")
							text_file.putstring (redefined_features.item)
							if redefined_features.item.is_equal ("notify") then
								 text_file.putstring (" (control: WEL_CONTROL; notify_code: INTEGER)")
							end
							text_file.putstring (" is%N%T%Tdo%N%T%Tend%N")

							redefined_features.forth
						end
					end

					if (statement_list /= Void) then
						text_file.putstring ("%Nfeature -- Access%N")

						from
							statement_list.start
						until 
							statement_list.off
						loop
							statement_list.item_for_iteration.generate_access_wel_code (text_file)
							statement_list.forth
						end
					end

					text_file.putstring ("%N%Nend -- class ")
					text_file.putstring (class_name)

					text_file.putstring ("%N%N--|-------------------------------------------------------------------")
					text_file.putstring ("%N--| This class was automatically generated by Resource Bench")
					text_file.putstring ("%N--| Copyright (C) 1996-2022, Eiffel Software.")
					text_file.putstring ("%N--|")
					text_file.putstring ("%N--| 5949 Hollister Ave., Goleta, CA 93117 USA")
					text_file.putstring ("%N--| Telephone 805-685-1006")
					text_file.putstring ("%N--| Fax 805-685-6869")
					text_file.putstring ("%N--| Customer support https://support.eiffel.com")
					text_file.putstring ("%N--|-------------------------------------------------------------------%N")

					text_file.close
				end
				forth
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class TDS_DIALOG

