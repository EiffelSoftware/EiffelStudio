indexing

	description:
		"Descriptions of classes that may be dynamically loaded";

	keywords: "Dynamic Linking in Eiffel";
	product: DLE;
	status: "See notice at end of class";
	date: "$Date$";
 	revision: "$Revision$"
	
class DYNAMIC_CLASS creation

	make

feature -- Initialization

	make (class_name, dc_dir: STRING) is
			-- Initialize to representation of the dynamic class of name
			-- `class_name' in the DC-set whose directory is `dc_dir'.
			-- Set `retrieve_status' to non-zero value if not such class
			-- can be found.
		require
			class_name_exists: class_name /= Void;
			class_name_not_empty: not class_name.empty;
			DC_set_path_exists: dc_dir /= Void;
			DC_set_path_not_empty: not dc_dir.empty
		local
			upper_name: STRING
		do
			initialize;
			if DC_directory.empty then
				retrieve_status := dle_retrieve (Current, dc_dir.to_c)
				if not retrieve_failed then
					DC_directory.copy (dc_dir);
					upper_name := clone (class_name);
					upper_name.to_upper;
					retrieve_status := dle_search (Current, upper_name.to_c)
				end
			elseif not DC_directory.is_equal (dc_dir) then
				retrieve_status := Duplicate_dc_set
			else
				upper_name := clone (class_name);
				upper_name.to_upper;
				retrieve_status := dle_search (Current, upper_name.to_c)
			end
		end;

feature -- Instances

	instance: DYNAMIC is
			-- An instance of the class represented by the current object,
			-- initialized by procedure `make' of that class, using
			-- `argument' as argument
		require
			class_exists: not retrieve_failed
		do
			Result := dle_instance (dynamic_type, argument)
		ensure
			instance_not_void: Result /= Void
		end;

	argument: ANY;
			-- Argument to be passed to creation procedures
			-- by subsequent calls to `instance'

	set_argument (val: like argument) is
			-- Define `val' to be the argument to be passed to creation 
			-- procedures by subsequent calls to `instance'.
		do
			argument := val
		ensure
			argument_set: argument = val
		end;

feature -- Dynamic features

	retrieved_feature (featname: STRING): DYNAMIC_FEATURE is
			-- Description of feature of name `featname' in class
			-- described by current object; 
			-- Void if no such feature
		require
			name_not_void: featname /= Void;
			name_not_empty: not featname.empty
		do
			-- Not implemented
		end;

feature -- Status report

	retrieve_failed: BOOLEAN is
			-- Did an error occur during last `make' creation call?
		do
			Result := retrieve_status /= No_error
		end;

	retrieve_status: INTEGER;
			-- Status code of the last `make' creation procedure

	No_error: INTEGER is 0;
			-- The class description has been correctly retrieved

	Bad_DC_directory: INTEGER is 1;
			-- `dc_dir' is not the name of a directory containing the 
			-- proper information about a DC-set

	No_dynamic_class: INTEGER is 2;
			-- No dynamic class exists for `class_name' in the DC-set

	Unreadable_file: INTEGER is 3;
			-- The corresponding files in `dc_dir' cannot be read
	
	Bad_class: INTEGER is 4;
			-- There is such a class and it can be read but it is not a 
			-- descendant of `DYNAMIC'

	Duplicate_class_name: INTEGER is 5;
			-- The retrieved class has the same name as a previously
			-- retrieved dynamic class (This error is possible because
			-- a system can use two or more DC-sets.)

	Duplicate_dc_set: INTEGER is 6;
			-- Another DC-set has already been retrieved

	Not_supported: INTEGER is 7;
			-- The DLE mechanism facilities are not supported

feature {NONE} -- Implementation

	initialize is
			-- Initialization of the DLE mechanism.
		once
			c_pass_dle_routines ($set_dynamic_type)
		end;

	dynamic_type: INTEGER;
			-- Dynamic type derived from the current dynamic class,
			-- if any (i.e. not retrieve_error)

	set_dynamic_type (dtype: INTEGER) is
			-- Assign `dtype' to `dynamic_type'.
		do
			dynamic_type := dtype
		end;

	DC_directory: STRING is
			-- Name of the DC-set directory currently loaded;
			-- Empty string if no DC-set has been retrieved yet
		once
			Result := ""
		end;

	dle_retrieve (obj, dc_dir: ANY): INTEGER is
			-- Retrieve the DC-set information from the project
			-- directory `dc_dir'. Return the retrieve status code.
		external
			"C | %"eif_dle.h%""
		end;

	dle_search (obj, class_name: ANY): INTEGER is
			-- Search for `class_name' in the currently loaded DC-set.
			-- If found, set `dynamic_type' to the proper value and
			-- return the search status code.
		external
			"C | %"eif_dle.h%""
		end;

	dle_instance (dtype: INTEGER; arg: ANY): DYNAMIC is
			-- An object of dynamic type `dtype', initialized by procedure
			-- `make' of its base class, using `arg' as argument
		external
			"C | %"eif_dle.h%""
		end;

	c_pass_dle_routines (set_dtype: POINTER) is
			-- Pass the address of `set_dtype' to C.
		external
			"C | %"eif_dle.h%""
		end;

end -- class DYNAMIC_CLASS


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

