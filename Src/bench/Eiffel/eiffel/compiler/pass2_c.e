class PASS2_C

inherit

	COMP_PASS_C;
	SHARED_SERVER;
	SHARED_PASS;
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

	separate_modified: BOOLEAN;
		-- The separate status of the class has been modified

	supplier_status_modified: BOOLEAN;
		-- The status of a supplier has changed

	assert_prop_list: LINKED_LIST [ROUTINE_ID];
		-- List of routine id to be propagated

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

	set_separate_modified is
			-- Set `separate_modified' to `True'.
		do
			separate_modified := True
		end;

	set_supplier_status_modified is
			-- Set `supplier_status_modified' to `True'.
		do
			supplier_status_modified := True
		end;

	set_assertion_prop_list (l: like assert_prop_list) is
			-- Set `supplier_status_modified' to `True'.
		do
			assert_prop_list := l
		end;

	execute (degree_output: DEGREE_OUTPUT; to_go: INTEGER) is
		local
			do_pass2: BOOLEAN;
		do
				-- Verbose
			degree_output.put_degree_4 (associated_class, to_go);

			associated_class.set_reverse_engineered (False);
			if associated_class.changed then
				do_pass2 := True;
					-- Incrementality: pass3 can be done successfully
					-- on a class marked changed and then
					-- the class is reinserted in pass2_controler
				pass3_controler.insert_new_class (associated_class);
				pass4_controler.insert_new_class (associated_class);
			else
				do_pass2 := associated_class.changed2
			end;
			if do_pass2 then
					-- Analysis of inheritance for a class
				analyzer.pass2 (Current, supplier_status_modified);

					-- No error happened: set the compilation status
					-- of `associated_class'
				check
					No_error: not Error_handler.has_error;
				end;

					-- Update the freeze list for changed hash tables.
				System.melted_set.put (associated_class);
				associated_class.set_generate_descriptors (True)
			elseif (assert_prop_list /= Void) then
					-- Propagation of assertion modifications only.
debug ("ACTIVITY")
	io.error.putstring ("Propagation of assertions only%N");
end;
				propagate_pass2 (False);
			end;

			if assert_prop_list /= Void then
debug ("ACTIVITY")
	io.error.putstring ("FEATURE_TABLE.propagate_assertions%N");
end;
				associated_class.feature_table.propagate_assertions
					(assert_prop_list);
			end;
		end;

	propagate (resulting_table: FEATURE_TABLE; equivalent_table: BOOLEAN;
				pass2_control: PASS2_CONTROL; l: LINKED_LIST [ROUTINE_ID]) is
			-- Propagate the pass2 and pass3 according to `resulting_table'
			-- and `pass2_control'
		local
			real_pass2, do_pass2: BOOLEAN;
			do_pass3: BOOLEAN;
			chg3a   : BOOLEAN
		do
debug ("ACTIVITY")
	io.error.putstring ("=============== PASS2_C.propagate ===============%N");
	io.error.putstring ("Equivalent tables: ");
	io.error.putbool (equivalent_table);
	io.error.putstring ("%Nexpanded_modified: ");
	io.error.putbool (expanded_modified);
	io.error.putstring ("%Ndeferred_modified: ");
	io.error.putbool (deferred_modified);
	io.error.putstring ("%Nseparate_modified: ");
	io.error.putbool (separate_modified);
	if assert_prop_list /= Void then
		if assert_prop_list.empty then
			io.error.putstring ("%Nassert_prop_list: empty");
		else
			io.error.putstring ("%Nassert_prop_list: not empty");
		end;
	else
		io.error.putstring ("%Nassert_prop_list: Void");
	end;
	if l /= Void then
		if l.empty then
			io.error.putstring ("%Nl: empty");
		else
			io.error.putstring ("%Nl: not empty");
		end;
	else
		io.error.putstring ("%Nl: Void");
	end;
	io.error.putstring ("%Npass2_control.propagate_pass3: ");
	io.error.putbool (pass2_control.propagate_pass3);
	io.error.putstring ("%Npass2_control: ");
	pass2_control.trace;
	io.error.new_line;
end;
					-- Propagation of the assertions
			if assert_prop_list = Void then
				assert_prop_list := l;
			elseif l /= Void then
				assert_prop_list.finish;
				assert_prop_list.merge_right (l)
			end;

					-- Incremetality test: asked the compiler to apply at
					-- least the second pass to the direct descendants
					-- of the class `associated_class'.
			real_pass2 := (not equivalent_table) or else expanded_modified
					or else deferred_modified or else separate_modified;

					-- If the set of ancestors has changed (changed3a) we
					-- must propagate.
			chg3a    := associated_class.changed3a;

					-- If the propagation is the result of assertion
					-- modifications, only a `light' pass2 must be done
			do_pass2 := real_pass2 or else assert_prop_list /= Void;

			if pass2_control.propagate_pass3 then
				do_pass2 := True;
				do_pass3 := True;
			end;

			if do_pass2 or else chg3a then
					-- Propagation of second pass in order to update
					-- feature table of direct descendants
				propagate_pass2 (real_pass2);
				if do_pass3 then
					-- Propagation of third pass in order to type check
					-- clients of the current class
					propagate_pass3 (pass2_control, expanded_modified or deferred_modified or separate_modified);
				end;
				if chg3a then
					-- Propagation of third pass in order to type check
					-- classes which depend on the conformance of the
					-- current class.
					force_type_checks (pass2_control);
				end;

				associated_class.set_skeleton (resulting_table.skeleton);
				if not System.freeze then
					resulting_table.melt;
				end;
			end;
		end;

feature -- Propagation of second pass
	
	propagate_pass2 (real_pass2: BOOLEAN) is
			-- Ask the compiler to recalculate the feature table for the
			-- direct descendants. The feature table of the current
			-- class  has varied between two compilations, the feature
			-- tables of the direct descendants must be recalculated.
		local
			descendant: CLASS_C;
			types: LINKED_LIST [CLASS_TYPE];
			desc: LINKED_LIST [CLASS_C]
			chg3a : BOOLEAN
		do
debug ("ACTIVITY")
	io.error.putstring ("Propagate_pass2. real_pass2: ");
	io.error.putbool (real_pass2);
	io.error.new_line;
end;
			from
				desc := associated_class.descendants;
				associated_class.set_changed2 (True);
				chg3a := associated_class.changed3a
				desc.start
			until
				desc.after
			loop
				descendant := desc.item;
					-- Insert the descendant in the changed classes list
					-- of the system if not present.
debug ("ACTIVITY")
	io.error.putstring ("Propagating pass2 to: ");
	io.error.putstring (descendant.name);
	io.error.new_line;
end;
				if chg3a then
					descendant.set_changed3a (True);
				end;

				pass2_controler.insert_new_class (descendant);
				if real_pass2 then
					-- Mark the descendant so if it is not syntactically
					-- `changed', its feature table will be at least
					-- recalculated.
					descendant.set_changed2 (True);
				end;
				if expanded_modified then
					pass2_controler.set_expanded_modified (descendant);
				end;
				if assert_prop_list /= Void then
					assert_prop_list.start;
					pass2_controler.set_assertion_prop_list
					(descendant, assert_prop_list.duplicate (assert_prop_list.count));
				end;

-- FIXME
-- The next line should NOT be here
-- Check the histroy in integrator. Xavier

-- Insertion in pass4_controler is needed

				pass3_controler.insert_new_class (descendant);

					-- Insert in pass4_controler so that the skeletons of all
					-- the descendants are updated
				pass4_controler.insert_new_class (descendant);

				desc.forth
			end;
		end;

feature -- Propagation of third pass

	propagate_pass3 (pass2_control: PASS2_CONTROL; status_modified: BOOLEAN) is
			-- Ask to the compiler to execute the third pass on all
			-- the clients of the class
		require
			good_argument: pass2_control /= Void;
			good_context: pass2_control.propagate_pass3;
		local
			client: CLASS_C;
			clients: LINKED_LIST [CLASS_C]
		do
debug ("ACTIVITY")
	io.error.putstring ("Propagate pass3%N");
end;
			from
				clients := associated_class.clients;
				clients.start
			until
				clients.after
			loop
				client := clients.item;
					-- Remember the cause for type checking `client'.
debug ("ACTIVITY")
	io.error.putstring ("Propagating pass3 to: ");
	io.error.putstring (client.name);
	io.error.new_line;
end;
				client.propagators.update (pass2_control);
				if status_modified then
					client.propagators.add_changed_status (associated_class.id);
				end;
					-- Insert the client in the changed classes list
					-- of the system if not present
				pass3_controler.insert_new_class (client);
				pass4_controler.insert_new_class (client);

				clients.forth
			end;
		end;

feature -- Force type checks on conformance dependent classes.

	force_type_checks (pass2_control : PASS2_CONTROL) is

		require
			good_argument : pass2_control /= Void
		local
			cdc : LINKED_LIST [CLASS_C];
			cdi : CLASS_C
		do
			cdc := associated_class.conf_dep_classes

			if cdc /= Void then
				from
					cdc.start
				until
					cdc.after
				loop
					cdi := cdc.item;

					cdi.propagators.update (pass2_control);
					-- Loosing an ancestor is considered to
					-- be a status change.
					cdi.propagators.add_changed_status (associated_class.id);
					pass3_controler.insert_new_class (cdi);
					pass4_controler.insert_new_class (cdi);

					cdc.forth
				end
			end;
		end

end
