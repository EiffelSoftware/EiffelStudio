indexing
	description: "Objects representing a class format for documentation."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_FORMAT

inherit
	CLASS_FORMAT_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (f_type: INTEGER) is
			-- Create as `f_type'.
		do
			set_type (f_type)
		end

feature -- Status setting

	set_type (a_type: INTEGER) is
			-- Set type to `a_type'.
		require
			a_type_valid: a_type >= cf_Chart and then a_type <= cf_Flatshort
		do
			type := a_type
		end

	set_generated (f: BOOLEAN) is
			-- Set global flag `is_generated' for class format `type' to `f'.
		do
			generated_list.put_i_th (f, type)
		end

feature -- Access

	type: INTEGER
			-- Format constant type.

feature -- Status report

	is_generated: BOOLEAN is
			-- Should format `type' be generated?.
		do
			Result := generated_list @ type
		end

	file_extension: STRING is
			-- To append to the filename.
		do
			inspect
				type
			when cf_Chart then
				Result := "_chart"
			when cf_Diagram then
				Result := "_links"
			when cf_Clickable then
				Result := ""
			when cf_Flat then
				Result := "_flat"
			when cf_Short then
				Result := "_short"
			when cf_Flatshort then
				Result := "_flatshort"
			end
		end

	description: STRING is
			-- Appearing in menu item for example.
		do
			inspect
				type
			when cf_Chart then
				Result := "Chart"
			when cf_Diagram then
				Result := "Relations"
			when cf_Clickable then
				Result := "Text"
			when cf_Flat then
				Result := "Flat"
			when cf_Short then
				Result := "Contracts"
			when cf_Flatshort then
				Result := "Flat contracts"
			end
		end

feature {NONE} -- Implementation

	generated_list: ARRAYED_LIST [BOOLEAN] is
			-- Global list of flags for which format is (to be) generated.
		once
			create Result.make_filled (6)
			Result.put_i_th (True, cf_Chart)
			Result.put_i_th (True, cf_Diagram)
			Result.put_i_th (True, cf_Clickable)
			Result.put_i_th (False, cf_Flat)
			Result.put_i_th (False, cf_Short)
			Result.put_i_th (False, cf_Flatshort)
		end

end -- class CLASS_FORMAT
