-- `dynamic' option to specify whether some feature calls might be
-- statically bound or not in the DR-system of DLE.

class DYNAMIC_FEAT_I inherit

	DYNAMIC_I
		redefine
			is_partial
		end;

	TWO_WAY_SORTED_SET [STRING]
		rename
			make as twss_make
		export
			{NONE} twss_make
		end

creation

	make

feature {NONE} -- Initialization

	make is
			-- Create a new "dynamic" option.
		do
			twss_make;
			compare_objects
		end;

feature -- Status report

	is_partial: BOOLEAN is
			-- Must some features of the current class be dynamically bound?
		do
			Result := true
		end;

	is_dynamic (feat_name: STRING): BOOLEAN is
			-- Must feature `feat_name' be dynamically bound?
		do
			Result := has (feat_name)
		end;

end -- class DYNAMIC_FEAT_I
