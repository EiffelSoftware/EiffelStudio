-- Controller of a compiler pass for a class

class PASS_CONTROL 


creation

	make

	
feature 

	removed_features: SEARCH_TABLE [FEATURE_I];
			-- Table of the features written in a class and removed
			-- from a compilation to another one.
			-- [Useful for updating dependances for incremental type
			-- check.]

	propagators: SORTED_SET [DEPEND_UNIT];
			-- List of all the dependance units responsible for
			-- the propagation of the third pass on the class

	melted_propagators: SORTED_SET [DEPEND_UNIT];
			-- List of all the features which are changed from
			-- an attribute (a function resp.) into a function (an attribute
			-- resp.) beetween two recompilations. All the features
			-- using such a feature should be melted.

	make is
			-- Initialization
		do
			!!removed_features.make (5);
			!!propagators.make;
			!!melted_propagators.make;
		end;

	wipe_out is
			-- Empty the structure
		do
			removed_features.clear_all;
			propagators.wipe_out;
			melted_propagators.wipe_out;
		end;

	make_pass3: BOOLEAN is
			-- Has a third pass to be done ?
		do
			Result := propagate_pass3 or else removed_features.count > 0
		end;

	propagate_pass3: BOOLEAN is
			-- Has a third pass to be propagated to clients ?
		do
			Result := not (propagators.empty and then melted_propagators.empty)
		end;

invariant

	removed_features_exists: removed_features /= Void;
	propagators_exists: propagators /= Void;
	melted_propagators_exists: melted_propagators /= Void;

end
