indexing
	description: "Information storage for the Resource script language"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_SYMBOLS_STRUCTURE

inherit
	HASH_TABLE [TDS_RESOURCE, INTEGER]
		rename
			make as table_make
		end

	TDS_DEFINE_TABLE
		undefine
			is_equal, copy
		end

	STORABLE
		undefine
			is_equal, copy
		end

creation

	make, retrieve_tds

feature -- Initialization

	make is
			-- create the `tds'
		do
			table_make (10)
			!! version.make (12)
			version.append ("Version 2.1")
		end

feature -- Access

	version: STRING
			-- Version of Resource Bench.
			
	constant_extension: STRING is "_constant"
			-- Constant string append to a constant name.

	last_token: STRING
			-- The last parsed token.

	current_resource: TDS_RESOURCE
			-- The current parsed resource.

	identifier_type: INTEGER
			-- Type of the current parsed identifier.

	last_style: TDS_STYLE
			-- The last parsed style.

--	new_resource: TDS_RESOURCE
			-- New resource


feature -- Element change

	set_token (a_token: STRING) is
			-- Set `last_token' to `a_token'.
		require
			a_token_exists: a_token /= Void and then a_token.count > 0
		do
			last_token := clone (a_token)
		ensure
			last_token_set: last_token.is_equal (a_token)
		end

	set_current_resource (a_resource: TDS_RESOURCE) is
			-- Set `current_resource' to `a_resource'.
		require
			a_resource_not_void: a_resource /= Void
		do
			current_resource := a_resource
		ensure
			current_resource_set: current_resource = a_resource
		end

	set_identifier_type (an_identifier: INTEGER) is
			-- Set `identifier_type' to `an_identifier'.
		do
			identifier_type := an_identifier
		ensure
			identifier_type_set: identifier_type = an_identifier
		end

	set_style (a_style: TDS_STYLE) is
			-- Set `last_style' to `a_style'.
		require
			a_style_not_void: a_style /= Void
		do
			last_style := a_style
		ensure
			last_style_set: last_style = a_style
		end

feature -- Error Managment

	error (a_message: STRING) is
			-- Display `a_message' error during the parsing.
		require
			a_message_exists: a_message /= Void and then a_message.count > 0
		do
			io.new_line
			io.putstring (a_message)
		end

feature

	convert (an_identifier: STRING) : INTEGER is
			-- Convert `an_identifier' which can be a string or a integer string
			-- into a integer value.
		require
			an_identifier_exists: an_identifier /= Void and then an_identifier.count > 0
		do
			if (an_identifier.is_integer) then
				Result := an_identifier.to_integer
			else
-- ####
				Result := -999
-- ####
			end
		end

	insert_resource (a_resource: TDS_RESOURCE) is
			-- If a TDS_RESOURCE structure exists insert `a_resource'
			-- else create the TDS_RESOURCE structure.
		require
			a_resource_not_void: a_resource /= Void
		local
			resource: TDS_RESOURCE
			type: INTEGER

		do
			type := a_resource.type

			if has (type) then
				resource := item (type)
				resource.insert (a_resource)
			else
				put (a_resource, type)		-- #### It's a bit ugly, it will be better to create an empty instance of resource 'type'.
				a_resource.insert (a_resource)
			end

		end

feature -- Code generation

	display is
			-- Display the tds.
		do
			from
				start
			until
				off
			loop
				item_for_iteration.display
				forth
			end
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		require
			a_resource_file_exists: a_resource_file.exists
			a_resource_file_open: a_resource_file.is_open_write
		do
			generate_include_file

			a_resource_file.putstring ("////////////////////////////////////////////////////////////////%N")
			a_resource_file.putstring ("//%N")
			a_resource_file.putstring ("// Include files%N")
			a_resource_file.putstring ("//%N")
			
			a_resource_file.putstring ("%N#include <windows.h>")
			a_resource_file.putstring ("%N#include %"ids.h%"%N")

			from
				start
			until
				off
			loop
				item_for_iteration.generate_resource_file (a_resource_file)
				forth
			end

			a_resource_file.putstring ("%N")
		end

	generate_include_file is
			-- Generate the include file which contains the definition of constants.
		local
			include_file: PLAIN_TEXT_FILE
		do
			!! include_file.make_open_write ("ids.h")
			include_file.putstring ("////////////////////////////////////////////////////////////////%N")
			include_file.putstring ("//%N")
			include_file.putstring ("// Constants definition%N")
			include_file.putstring ("//%N")

			from
				define_table.start
			until
				define_table.off 
			loop
				if define_table.item_for_iteration.value /= Void and then define_table.item_for_iteration.value.is_integer then
					include_file.putstring ("%N#define ")
					include_file.putstring (define_table.item_for_iteration.name)
					include_file.putstring (" ")
					include_file.putstring (define_table.item_for_iteration.value)
				end

				define_table.forth
			end

			include_file.putstring ("%N%N////////////////////////////////////////////////////////////////")
			include_file.putstring ("%N// This file was automatically generated by Resource Bench")
			include_file.putstring ("%N// Copyright (C) 1996, Interactive Software Engineering, Inc.")
			include_file.putstring ("%N//")
			include_file.putstring ("%N// 270 Storke Road, Suite 7, Goleta, CA 93117 USA")
			include_file.putstring ("%N// Telephone 805-685-1006")
			include_file.putstring ("%N// Fax 805-685-6869")
			include_file.putstring ("%N// Information e-mail <info@eiffel.com>")
			include_file.putstring ("%N// Customer support e-mail <support@eiffel.com>")
			include_file.putstring ("%N//%N")

			include_file.close
		end

--	generate_tree_view (a_tree_view: WEL_TREE_VIEW) is
--			-- Generate `a_tree_view' control from the tds memory structure.
--		require
--			a_tree_view_not_void: a_tree_view /= Void
--		local
--			parent: POINTER
--		do
--			from
--				parent := a_tree_view.last_item
--	       			start
--			until
--				off
--			loop
--				item_for_iteration.generate_tree_view (a_tree_view, parent)
--				forth
--			end
--		end

	generate_tree_view (a_tree_view: EV_TREE_ITEM) is
			-- Generate `a_tree_view' control from the tds memory structure.
		require
			a_tree_view_not_void: a_tree_view /= Void
		local
			parent: POINTER
			test: TDS_DIALOG
		do
			from
--				parent := a_tree_view.last_item
	       		start
			until
				off
			loop
				test ?= item_for_iteration
				if test /= Void then
					item_for_iteration.generate_tree_view (a_tree_view)
				end
				forth
			end
		end

	access_tree_view_item (a_tree_view_item: EV_TREE_NODE): TDS_RESOURCE is
			-- Give the associated object to `a_tree_view_item'.
		local
			resource_type: TDS_RESOURCE
			resource_object: TDS_RESOURCE
			finished: BOOLEAN
		do
			from
				start
			until
				off or finished
			loop
				resource_type ?= item_for_iteration
				finished := resource_type.tree_view_item = a_tree_view_item
				
				if not finished then
					from
						resource_type.start
					until
						resource_type.after or finished
					loop
						resource_object ?= resource_type.item
						finished := resource_object.tree_view_item = a_tree_view_item

						resource_type.forth
					end

					if finished then
						Result := resource_object
					end
				else
					Result := resource_type
				end

				forth
			end

			if not finished then
				Result := Void
			end
		end


--	access_tree_view_item (a_tree_view_item: POINTER): TDS_RESOURCE is
--			-- Give the associated object to `a_tree_view_item'.
--		local
--			resource_type: TDS_RESOURCE
--			resource_object: TDS_RESOURCE
--			finished: BOOLEAN
--		do
--			from
--				start
--			until
--				off or finished
--			loop
--				resource_type ?= item_for_iteration
--				finished := resource_type.tree_view_item = a_tree_view_item
--				
--				if not finished then
--					from
--						resource_type.start
--					until
--						resource_type.after or finished
--					loop
--						resource_object ?= resource_type.item
--						finished := resource_object.tree_view_item = a_tree_view_item
--
--						resource_type.forth
--					end
--
--					if finished then
--						Result := resource_object
--					end
--				else
--					Result := resource_type
--				end
--
--				forth
--			end
--
--			if not finished then
--				Result := Void
--			end
--		end

	generate_wel_code is
			-- Generate the eiffel code.
		local
			text_file: PLAIN_TEXT_FILE
		do
			from
				start
			until
				off
			loop
				item_for_iteration.generate_wel_code
				forth
			end

			!! text_file.make_open_write ("application_ids.e")
			text_file.putstring ("class %N%TAPPLICATION_IDS%N")

			if define_table /= Void then
				text_file.putstring ("%Nfeature -- Access%N") 
	
				from
					define_table.start
				until
					define_table.off 
				loop
					if define_table.item_for_iteration.value /= Void
					   and then define_table.item_for_iteration.value.is_integer then
						text_file.putstring ("%N%T")
						text_file.putstring (string_to_constant_form (define_table.item_for_iteration.name))
						text_file.putstring (constant_extension)
						text_file.putstring (": INTEGER is ")
						text_file.putint (define_table.item_for_iteration.value.to_integer)
					end
	
					define_table.forth
				end
			end

			text_file.putstring ("%N%Nend -- class APPLICATION_IDS")

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

feature -- Save and restore a tds

	store_tds (a_file: RAW_FILE) is
			-- store the `tds' structure into the file `a_file'.
		require
			a_file_exists: a_file.exists
		do
			independent_store (a_file)
		end

	retrieve_tds (a_file: RAW_FILE) is
			-- retrieve the `tds' structure from the file `a_file'.
		require
			a_file_exists: a_file.exists
		local
			the_tds: TABLE_OF_SYMBOLS_STRUCTURE
		do
			the_tds ?= retrieved (a_file)
			standard_copy (the_tds)
		end

feature {NONE}

	string_to_constant_form (a_string: STRING): STRING is
		require
			a_string_exists: a_string /= Void and then a_string.count > 0
		local
			first_character: STRING
		do
			Result := clone (a_string)
			Result.to_lower

			first_character := Result.substring (1,1)
			first_character.to_upper

			Result.remove (1)
			Result.prepend_string (first_character)
	end

end -- TABLE_OF_SYMBOLS_STRUCTURE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
