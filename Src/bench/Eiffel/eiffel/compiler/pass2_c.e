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

	supplier_status_modified: BOOLEAN;
		-- The status of a supplier has changed

	assert_prop_list: LINKED_LIST [INTEGER];
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

	execute is
		do
			if  (associated_class.changed or else associated_class.changed2)
			then
					-- Analysis of inheritance for a class
				analyzer.pass2 (Current, supplier_status_modified);

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
			else
					-- Propagation of assertion modifications only.
				propagate_pass2 (False);
				io.error.putstring ("Pass 2 on class ");
				io.error.putstring (associated_class.class_name);
				io.error.new_line;
			end;
			if assert_prop_list /= Void then
				associated_class.feature_table.propagate_assertions
					(assert_prop_list);
			end;
		end;

	propagate (feature_table, resulting_table: FEATURE_TABLE; 
				pass2_control: PASS2_CONTROL; l: LINKED_LIST [INTEGER]) is
			-- Propagate the pass2 and pass3 according to `resulting_table'
			-- and `pass2_control'
		local
			different_feature_tables: BOOLEAN;
			real_pass2, do_pass2: BOOLEAN;
			do_pass3: BOOLEAN;
		do
					-- Propagation of the assertions
			if assert_prop_list = Void then
				assert_prop_list := l;
			else
				assert_prop_list.finish;
				assert_prop_list.merge_right (l)
			end;

					-- Incremetality test: asked the compiler to apply at
					-- least the second pass to the direct descendants
					-- of the class `associated_class'.
			different_feature_tables := not resulting_table.equiv (feature_table);
			real_pass2 := different_feature_tables or else expanded_modified
					or else deferred_modified;

					-- If the propagation is the result of assertion
					-- modifications, only a `light' pass2 must be done
			do_pass2 := real_pass2 or else assert_prop_list /= Void;

			if pass2_control.propagate_pass3 then
				do_pass2 := True;
				do_pass3 := True;
			end;

			if do_pass2 then
					-- Propagation of second pass in order to update
					-- feature table of direct descendants
				propagate_pass2 (real_pass2);
				if do_pass3 then
					-- Propagation of third pass in order to type check
					-- clients of the current class
					propagate_pass3 (pass2_control, expanded_modified or deferred_modified);
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
			local_cursor: LINKABLE [CLASS_C];
			types: LINKED_LIST [CLASS_TYPE];
		do
			from
				associated_class.set_changed2 (True);
				local_cursor := associated_class.descendants.first_element;
			until
				local_cursor = Void
			loop
				descendant := local_cursor.item;
					-- Insert the descendant in the changed classes list
					-- of the system if not present.
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
				pass3_controler.insert_new_class (descendant);
				pass4_controler.insert_new_class (descendant);

				local_cursor := local_cursor.right
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
			local_cursor: LINKABLE [CLASS_C];
		do
			from
				local_cursor := associated_class.clients.first_element
			until
				local_cursor = Void
			loop
				client := local_cursor.item;
					-- Remember the cause for type checking `client'.
				client.propagators.update (pass2_control);
				if status_modified then
					client.propagators.add_changed_status (associated_class.id);
				end;
					-- Insert the client in the changed classes list
					-- of the system if not present
				pass3_controler.insert_new_class (client);
				pass4_controler.insert_new_class (client);

				local_cursor := local_cursor.right
			end;
		end;

end
