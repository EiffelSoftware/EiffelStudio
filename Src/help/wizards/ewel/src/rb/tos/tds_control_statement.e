indexing
	description: "Control statement representation in the tds"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	TDS_CONTROL_STATEMENT

inherit
	LINKED_LIST [TDS_CONTROL_STATEMENT]

	TDS_CONTROL_CONSTANTS
		export
			{NONE} all
		end

	TDS_DEFINE_TABLE

feature -- Initialization

	make_style is
		do
			!! style.make
		end

	make_exstyle is
		do
			!! exstyle.make
		end

	finish_control_setup is
		deferred
		end

feature	-- Access
	
	text: STRING
			-- Text of the control statement.

	id: TDS_ID
			-- ID of the control statement.

	x: INTEGER
			-- X position of the control statement within the dialog.

	y: INTEGER
			-- Y position of the control statement within the dialog.

	width: INTEGER
			-- Width of the control statement.

	height: INTEGER
			-- Height of the control statement.

	style: TDS_STYLE_LIST
			-- Style list of the control statement.

	exstyle: TDS_STYLE_LIST
			-- Extended style list of the control statement.

	class_name: STRING
			-- Class name (from Windows) of the control statement.

	wel_class_name: STRING
			-- The WEL class name of the control statement.

	is_wel_code_on: BOOLEAN
			-- Is the WEL code generation turned on?

	type: INTEGER
			-- Type of the current control.

	variable_name: STRING
			-- Name of the control in the wel code generation.

feature -- Element change

	set_id (a_id: STRING) is
			-- Set `id' to `a_id'.
		require
			a_id_exists: a_id /= Void and then a_id.count > 0
		local
			temp: INTEGER
		do
			if id = Void then
				!! id
			end

			if a_id.is_integer then
				temp := a_id.to_integer
				id.set_number_id (temp)
				variable_name := "constant"
				variable_name.append ("_")
				if temp < 0 then
					temp := -temp
					variable_name.append ("minus_")
					set_wel_code (false)
				end
				variable_name.append (temp.out)
			else
				id.set_name_id (a_id)
				if (define_table /= Void)  and then define_table.has (a_id) then
					id.set_number_id (define_table.item (a_id).value.to_integer)
					if id.number_id < 0 then
						set_wel_code (false)
					end
				end
				set_variable_name(id.to_variable_style)
			end
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

	set_text (a_text: STRING) is
			-- Set `text' to `a_text'.
		require
			a_text_exist: a_text /= Void and then a_text.count > 0
		do
			text := clone (a_text)
		ensure
			text_set: text.is_equal (a_text)
		end

	set_style (a_style: TDS_STYLE) is
			-- Set `style' to `a_style'.
		require
			a_style_not_void: a_style /= Void
		do
			if (style = Void) then
				!! style.make
			end

			style.extend (a_style)
		end

	set_exstyle (a_exstyle: TDS_STYLE) is
			-- Set `exstyle' to `a_exstyle'.
		require
			a_exstyle_not_void: a_exstyle /= Void
		do
			if (exstyle = Void) then
				!! exstyle.make
			end

			exstyle.extend (a_exstyle)
		end

	set_class_name (a_class_name: STRING) is
			-- Set `class_name' to `a_class_name'.
		require
			a_class_name_exists: a_class_name /= Void and then a_class_name.count > 0
		do
			class_name := clone (a_class_name)
		ensure
			class_name_set: class_name.is_equal (a_class_name)
		end

	set_wel_class_name (a_class_name: STRING) is
			-- Set `wel_class_name' to `a_class_name'.
		require
			a_class_name_exists: a_class_name /= Void and then a_class_name.count > 0
		do
			wel_class_name := clone (a_class_name)
		ensure
			wel_class_name_set: wel_class_name.is_equal (a_class_name)
		end

	set_wel_code (a_value: BOOLEAN) is
			-- Set `is_wel_code_on' to`a_value'.
		do
			is_wel_code_on := a_value
		ensure 
			is_wel_code_on_set: is_wel_code_on = a_value
		end

	dupplicate (a_control: TDS_CONTROL_STATEMENT) is
			-- Copy `a_control' field to Current.
		require
			a_control_not_void: a_control /= Void
		local
			temp: INTEGER
		do
			text := a_control.text
			id := a_control.id
			x := a_control.x
			y := a_control.y
			width := a_control.width
			height := a_control.height
			style := a_control.style
			exstyle := a_control.exstyle
			class_name := a_control.class_name
			is_wel_code_on := a_control.is_wel_code_on

			if not id.has_name then
				temp := id.number_id
				variable_name.append ("_")
				if temp < 0 then
					temp := -temp
					variable_name.append ("minus_")
				end
				variable_name.append (temp.out)
			else
				set_variable_name(id.to_variable_style)
			end
		end
	
	set_type (a_type: INTEGER) is
			-- Set `type' to `a_type'.
		do
			type := a_type
		ensure
			type_set: type = a_type
		end

	set_variable_name (a_name: STRING) is
			-- Set `variable_name' to `a_name'.
		require
			a_name_not_void: a_name /= Void 
			a_name_exists: a_name.count > 0
		do
--			if variable_name = Void then
				variable_name := clone (a_name)
				if a_name.count <=8 and then specific_id.has (a_name) then
					variable_name.tail (a_name.count - 2)
					variable_name.prepend ("id_")
				end
--				if not off then
--					variable_name.append ("_" + item.id.to_constant_style)
--				end
--			end
		ensure
			variable_name_set: variable_name.count >= a_name.count
		end

	insert (a_control: like Current) is
		do
			extend (a_control)
		end
		
feature -- Code generation

	display is
		deferred
		end


	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		require
			a_resource_file_exists: a_resource_file.exists
		deferred
		end

	generate_make_wel_code (a_text_file: PLAIN_TEXT_FILE) is
			-- Generate the eiffel code in `a_text_file'.
		require
			a_text_file_exists: a_text_file.exists
		do
			from
				start
			until 
				after
			loop
				if item.is_wel_code_on then
					a_text_file.putstring ("%N%T%T%Tcreate ")
					a_text_file.putstring (item.variable_name + "_" + item.id.to_constant_style)
					a_text_file.putstring (".make_by_id (Current, ")
					a_text_file.putstring (item.id.to_constant_style)
					a_text_file.putstring (")")
				end
				forth
			end
		end

	generate_access_wel_code (a_text_file: PLAIN_TEXT_FILE) is
			-- Generate the eiffel code in `a_text_file'.
		require
			a_text_file_exists: a_text_file.exists
		do
			from
				start
			until 
				after
			loop
				if item.is_wel_code_on then
					a_text_file.putstring ("%N%T")
					a_text_file.putstring (item.variable_name + "_" + item.id.to_constant_style)
					a_text_file.putstring (": ")
					a_text_file.putstring (item.wel_class_name)
				end
				forth
			end
		end

feature {NONE}

	specific_id: ARRAY [STRING] is
			-- Store the specific ids used by the resource compiler:
			-- idcancel, idok... (see WEL_ID_CONSTANTS for the list).
		once
			!! result.make (0,8)
			result.compare_objects
			result.make_from_array (<<"idok", "idcancel", "idabort", "idretry", "idignore", "idyes",
						     "idno", "idclose", "idhelp">>)
		end

end -- class TDS_CONTROL_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
