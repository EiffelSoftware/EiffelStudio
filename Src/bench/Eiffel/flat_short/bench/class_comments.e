indexing
	description: 
		"Comments for an eiffel class. Eiffel comments are hashed%
		%on position within the eiffel text.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_COMMENTS

inherit
	HASH_TABLE [EIFFEL_COMMENTS, INTEGER]
		rename
			make as table_make
		export
			{CLASS_COMMENTS} all;
			{ANY} put, clear_all, remove, item, is_empty, valid_key
		end

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		undefine
			is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make (id: like class_id; init_size: INTEGER) is
			-- Create precompiled comments with class_id `id'
			-- with initial size `init_size'.
		require
			valid_id: id /= 0
		do
			table_make (init_size);
			class_id := id
		ensure
			class_id = id
		end;

feature -- Debug

	trace is
		do
			from
				start
			until
				after
			loop
				io.error.put_string ("Position: ");
				io.error.put_integer (key_for_iteration);
				io.error.put_new_line;
				item_for_iteration.trace;
				forth
			end
		end;

invariant

	class_id_not_void: class_id /= 0

end -- class CLASS_COMMENTS
