class PASS2_C

inherit

	COMP_PASS_C;
	SHARED_SERVER;
	SHARED_ERROR_HANDLER;
	SHARED_INHERITED
		rename
			Inherit_table as analyzer
		end;

creation

	make

feature

	expanded_modified: BOOLEAN;
		-- The expanded status of the class has been modified

	deferred_modified: BOOLEAN;
		-- The deferred status of the class has been modified

	set_expanded_modified is
			-- Set `expanded_modifed' to `True'.
		do
			expanded_modified := True
		end;

	set_deferred_modified is
			-- Set `deferred_modified' to `True'.
		do
			deferred_modified := True
		end;

	execute is
		do
			if  (associated_class.changed or else associated_class.changed2)
			then
					-- Analysis of inheritance for a class
				analyzer.set_a_class (associated_class);
				analyzer.pass2 (Current);

					-- No error happened: set the compilation status
					-- of `associated_class'
				check
					No_error: not Error_handler.has_error;
				end;

					-- Update the freeze list for changed hash tables.
				if associated_class.changed2 then
					System.freeze_set2.put (associated_class.id);
					System.melted_set.put (associated_class.id);
				end;
			end;
		end;

	propagate (feature_table, resulting_table: FEATURE_TABLE; pass2_control: PASS2_CONTROL) is
			-- Propagate the pass2 and pass3 according to `resulting_table'
			-- and `pass2_control'
		local
			different_feature_tables: BOOLEAN;
			propagate_pass2: BOOLEAN;
			propagate_pass3: BOOLEAN;
		do
					-- Incremetality test: asked the compiler to apply at
					-- least the second pass to the direct descendants
					-- of the class `associated_class'.
			different_feature_tables := not resulting_table.equiv (feature_table);
			propagate_pass3 := pass2_control.propagate_pass3;
			propagate_pass2 := different_feature_tables or else expanded_modified or else deferred_modified;

			if pass2_control.propagate_pass3 then
				propagate_pass2 := True;
				propagate_pass3 := True;
			end;

			if propagate_pass2 then
					-- Propagation of second pass in order to update
					-- feature table of direct descendants
				associated_class.propagate_pass2;
				if different_feature_tables then
					associated_class.set_skeleton (resulting_table.skeleton);
					resulting_table.melt;
				end;
			end;
			if propagate_pass3 then
				-- Propagation of third pass in order to type check
				-- clients of the current class
				associated_class.propagate_pass3 (pass2_control, expanded_modified or deferred_modified);
			end;
		end;

end
