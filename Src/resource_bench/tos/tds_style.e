indexing
	description: "Style representation in the tds"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_STYLE

creation

	make 
	
feature -- Initialization

	make is
		do
			activate := true
		end

feature -- Access

	activate: BOOLEAN
			-- Tell if the style is activated or not.

	style: STRING
			-- The style string.


feature -- Element change

	set_desactivate is
			-- Set `activate' to false
		do
			activate := false
		ensure
			activate_set: not activate
		end

	set_style (a_style: STRING) is
			-- Set `a_style' to `style'.
		require
			a_style_exists: a_style /= Void and then a_style.count > 0
		do
			style := clone (a_style)
		ensure
			style_set: style.is_equal (a_style)
		end

feature -- Query

	is_style_equal (a_style: TDS_STYLE) : BOOLEAN is
			-- Is `a_style' equal to `style'?
		require
			a_style_not_void: a_style /= Void
		do
			Result := (style.is_equal (a_style.style)) and (activate = a_style.activate)
		ensure
			Result_not_void: Result /= Void
		end
	
	is_style_almost_equal (a_style: TDS_STYLE) : BOOLEAN is
			-- Is a part of `a_style' contained by `style'?
		require
			a_style_not_void: a_style /= Void
		do
			Result := (style.substring_index (a_style.style, 1)> 0) AND (activate = a_style.activate)
		ensure
			Result_not_void: Result /= Void
		end

feature -- Code generation

	display is
		do
			if (not activate) then
				io.putstring ("not ")
			end

			io.putstring (style)
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		require
			a_resource_file_exists: a_resource_file.exists
		do
			if (not activate) then
				a_resource_file.putstring ("not ")
			end

			a_resource_file.putstring (style)
		end
		
end -- class TDS_STYLE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
