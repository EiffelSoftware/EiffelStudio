indexing
	description: "Objects that represent an EiffelBuild DIRECTORY constant."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_DIRECTORY_CONSTANT
	
inherit
	GB_CONSTANT
	
	GB_SHARED_OBJECT_EDITORS
		export
			{NONE} all	
		end
	
create
	make_with_name_and_value
	
feature {NONE} -- Initialization

	make_with_name_and_value (a_name, a_value: STRING) is
			-- Assign `a_name' to `name' and `a_value' to value.
		require
			a_name_valid: a_name /= Void and then a_value /= Void
			a_value_valid: a_value /= Void and then a_value /= Void
		do
			name := a_name.twin
			value := a_value.twin
			create referers.make (4)
			create cross_referers.make (4)
		ensure
			name_set: name.is_equal (a_name) and name /= a_name
			value_set: value.is_equal (a_Value) and value /= a_value
		end

feature -- Access

	type: STRING is
			-- Type represented by `Current'
		once
			Result := directory_constant_type
		end

	value: STRING
		-- Value of `Current'.
		
	value_as_string: STRING is
			-- Value represented by `Current' as a STRING.
		do
			Result := value.twin
		end
		
	as_multi_column_list_row: EV_MULTI_COLUMN_LIST_ROW is
			-- Representation of `Current' as a multi column list row.
		do
			create Result
			Result.set_pixmap (Icon_directory @ 1)
			Result.extend (name)
			Result.extend (type)
			Result.extend (value)
			Result.set_data (Current)
		end
		
	cross_referers: ARRAYED_LIST [GB_CONSTANT]
		-- All constants dependent on `Current'.

feature -- Status setting

	set_value (a_value: STRING) is
			-- Assign `a_value' to `value'.
		require
			value_ok: a_value /= Void and then not a_value.is_empty
		do
			value := a_value
		ensure
			value_set: a_value = value
		end
		
	add_cross_referer (cross_referer: GB_CONSTANT) is
			-- Add `cross_referer' to `cross_referers'.
		require
			cross_referer_not_void: cross_referer /= Void
		do
			cross_referers.extend (cross_referer)
		ensure
			has_cross_referer: cross_referers.has (cross_referer)
		end
	
	remove_cross_referer (cross_referer: GB_CONSTANT) is
			-- Remove `cross_referer' from `cross_referers'.
		require
			cross_referer_not_void: cross_referer /= Void
		do
			cross_referers.prune_all (cross_referer)
		ensure
			not_has_cross_referer: not cross_referers.has (cross_referer)
		end
		
feature {GB_CONSTANTS_DIALOG} -- Implementation
		
	modify_value (new_value: STRING) is
			-- Modify `value' to `new_value' and update all referers.
		local
			pixmap_constant: GB_PIXMAP_CONSTANT
			editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
		do
			value := new_value
			from
				cross_referers.start
			until
				cross_referers.off
			loop
				pixmap_constant ?= cross_referers.item
				check
					only_pixmaps_cross_reference_directories: pixmap_constant /= Void
				end
				pixmap_constant.update
				editors := all_editors
				from
					editors.start
				until
					editors.off
				loop
					editors.i_th (editors.index).constant_changed (pixmap_constant)
					editors.forth
				end
				cross_referers.forth
			end
		ensure
			value_set: value = new_value
		end

invariant
	value_not_void: value /= Void
	cross_referers_not_void: cross_referers /= Void

end -- class GB_DIRECTORY_CONSTANT
