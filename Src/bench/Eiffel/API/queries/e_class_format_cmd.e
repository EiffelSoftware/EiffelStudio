indexing

	description: 
		"Abstract description for a class format command which%
		%displays features of `current_class' that follow `criterium'.";
	date: "$Date$";
	revision: "$Revision $"

deferred class E_CLASS_FORMAT_CMD

inherit

	SHARED_EIFFEL_PROJECT;
	E_CLASS_CMD

feature -- Access

	criterium (f: E_FEATURE): BOOLEAN is 
			-- Criterium for feature `f'
		deferred 
		end;

	any_criterium (f: E_FEATURE): BOOLEAN is
			-- True if:
			--	`f' is written in a descendant of ANY
			--	 or if formatted class is a parent of ANY
		do
			Result :=
				 f.written_class > Any_class;
			Result := Result or
				(current_class <= Any_class);
		ensure
			valid_result: Result implies 
				f.written_class > Any_class or else
					current_class <= Any_class
		end;

	display_feature (f: E_FEATURE; c: E_CLASS) is
			-- Display feature `f' defined in class `c'
			-- to the output window.
		do
			f.append_clickable_signature (output_window, c);
		end;

feature -- Execution

	execute is
			-- Display routines of `current_class' that follow `criterium'.
		local
				-- Compiler structures
			feature_table: E_FEATURE_TABLE;
			e_feature: E_FEATURE;
			e_class: E_CLASS;
			id: INTEGER;
				-- Temporary structures
			list: SORTED_TWO_WAY_LIST [E_FEATURE];
			table: EXTEND_TABLE [SORTED_TWO_WAY_LIST [E_FEATURE], INTEGER];
			classes: PART_SORTED_TWO_WAY_LIST [E_CLASS];
			c: like current_class
		do
			c := current_class;
			feature_table := c.feature_table;
			
			-- Group the features in terms of their origin.
			from
				!! table.make (20);
				!! classes.make;
				feature_table.start
			until
				feature_table.after
			loop
				e_feature := feature_table.item_for_iteration;
				if criterium (e_feature) then
					e_class := e_feature.written_class;
					id := e_class.id;
					if table.has (id) then
						list := table.item (id);
					else
						!! list.make;
						table.put (list, id);
						classes.put_front (e_class);
					end;
					list.put_front (e_feature);
				end;
				feature_table.forth
			end;
			classes.sort;

				-- Display the features.
			from
				classes.start
			until
				classes.after
			loop
				output_window.put_string ("Class ");
				e_class := classes.item;
				e_class.append_clickable_signature (output_window);
				output_window.put_string (":%N%N");
				list := table.item (e_class.id);
				list.sort;
				from
					list.start
				until
					list.after
				loop
					e_feature := list.item;
					output_window.put_char ('%T');
					display_feature (e_feature, c);
					output_window.new_line;
					list.forth
				end;
				output_window.new_line;
				classes.forth
			end
		end

feature {NONE} -- Implementation

	any_class: E_CLASS is
		once
			Result := Eiffel_system.any_class.compiled_eclass
		end;

end -- class E_CLASS_FORMAT_CMD
