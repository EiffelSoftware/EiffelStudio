indexing

	description: 
		"Item to denote a class_name.";
	date: "$Date$";
	revision: "$Revision $"

class CLUSTER_NAME_TEXT

inherit

	BASIC_TEXT
		rename
			make as old_make
		redefine
			append_to
		end

create

	make

feature -- Initialization

    make (t: like image; c: like cluster_i) is
            -- Initialize Current with cluster_i `e'
            -- and image `t'.
        do
            image := t;
            cluster_i := c;
        ensure
            set: image = t and then
                    cluster_i = c
        end;

feature -- Property

	cluster_i: CLUSTER_I;
			-- Eiffel cluster associated with cluster text

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current class name text to `text'.
		do
			text.process_cluster_name_text (Current)
		end

end -- class CLUSTER_NAME_TEXT
