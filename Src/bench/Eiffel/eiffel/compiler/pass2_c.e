class PASS2_C

inherit

	COMP_PASS_C;
	SHARED_SERVER;
	SHARED_ERROR_HANDLER;
	SHARED_INHERITED
		rename
			Inherit_table as analyzer
		end;
	SHARED_HISTORY_CONTROL

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
				analyzer.pass2;

					-- No error happened: set the compilation status
					-- of `associated_class'
				check
					No_error: not Error_handler.has_error;
				end;

					-- Update the freeze list for changed hash tables.
				if associated_class.changed2 then
					system.update_freeze_list (associated_class.id);
				end;

				history_control.check_overload;
			end;
		end;

end
