indexing
	description: 
		"Comments for an eiffel class. Eiffel comments are hashed%
		%on position within the eiffel text.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_COMMENTS

inherit
	EXTEND_TABLE [EIFFEL_COMMENTS, INTEGER]
		rename
			make as table_make
		export
			{NONE} all;
			{ANY} put, clear_all, remove, item, empty
		end;
	IDABLE
		rename
			id as class_id
		export
			{NONE} all;
		undefine
			is_equal, copy
		end

creation
	make

feature {NONE} -- Initialization

	make (id: like class_id; init_size: INTEGER) is
			-- Create precompiled comments with class_id `id'
			-- with initial size `init_size'.
		require
			valid_id: id /= Void
		do
			table_make (init_size);
			class_id := id
		ensure
			class_id = id
		end;

feature -- Properties

	class_id: CLASS_ID;
			-- Class id for class comments

feature {NONE} -- Implementation

	set_id (i: like class_id) is
		do
			class_id := i
		end;

feature -- Debug

	trace is
		do
			from
				start
			until
				after
			loop
				io.error.putstring ("Position: ");
				io.error.putint (key_for_iteration);
				io.error.new_line;
				item_for_iteration.trace;
				forth
			end
		end;

invariant

	class_id_not_void: class_id /= Void

end -- class CLASS_COMMENTS
