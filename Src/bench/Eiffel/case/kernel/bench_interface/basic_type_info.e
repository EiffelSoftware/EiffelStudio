indexing

	description: 
		"Basic class type that does not have explicit % 
		%declaration of class types. Basic class type %
		%are `like features', `formal' type and %
		%`like current' type";
	date: "$Date$";
	revision: "$Revision $"

class BASIC_TYPE_INFO

inherit

	TYPE_INFO
		undefine
			copy, is_equal
		end

creation

	make_from_storer, set_name

feature -- Initialization

	make_from_storer (storer: S_BASIC_TYPE_INFO) is 
		require else
			valid_storer	: storer	/= void
		do 
			free_text_name := storer.free_text_name
		end

feature -- Properties

	is_instantiated: BOOLEAN is 
			-- Is Current instantiated?
			-- (False by default)
		do 
		end;

feature -- Access
	
	dummy_stone (a_data: DATA; type_dec: TYPE_DECLARATION): DUMMY_CLASS_STONE is
		do
			!! Result.make (a_data, type_dec)
		end;

	stone (a_data: DATA; type_dec: TYPE_DECLARATION): DUMMY_CLASS_STONE is
		do
			!! Result.make (a_data, type_dec)
		end;

feature -- Output

	name: STRING is
		do
			Result := free_text_name
			Result.to_upper
		end;

feature -- Update

	update_type (class_data: CLASS_DATA) is
		do
		end;

feature -- Storage

	storage_info: S_BASIC_TYPE_INFO is 
		do 
			!! Result.make (free_text_name)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		require else
			valid_other	: other	/= void
		do
			Result := free_text_name.is_equal (other.free_text_name)
		end;

feature -- Duplication

	copy (other: like Current) is
		require else
			valid_other	: other	/= void
		do
			free_text_name := clone (other.free_text_name)
		end;

invariant

	valid_free_text_name: free_text_name /= Void

end -- class BASIC_TYPE_INFO
