
class GROUP 

inherit

	EB_TABLE [S_CONTEXT]
		rename
			make as table_create
		end
	WINDOWS
		undefine
			is_equal, copy, consistent, setup
		end
	SHARED_CONTEXT
		undefine
			is_equal, copy, consistent, setup
		end
--	SHARED_STORAGE_INFO
--		undefine
--			is_equal, copy, consistent, setup
--		end

creation
	make

feature {NONE} -- Initialization

	eiffel_text: STRING
			-- contains initialization and creation (portion at end of text)

	make (nm: STRING; ctxt_list: LINKED_LIST [CONTEXT]) is
		local
			x,y,w,h: INTEGER
			ctxt: CONTEXT
--			s_context: S_CONTEXT
			is_container: BOOLEAN
			group_c: GROUP_C
			parent_ctxt: CONTAINER_C
			gb_cmd: GROUP_BULLETIN_CMD
			create_cmd: GROUP_CMD
		do
			integer_generator.next
			identifier := integer_generator.value
			entity_name := clone (nm)
			table_create (50)

				-- Get the composite_c from the context
			parent_ctxt ?= ctxt_list.first.parent
			is_container := (ctxt_list.count = 1) and then
							(ctxt_list.first.is_container)

			if is_container then
					-- Use the container for group parent
				ctxt := ctxt_list.first
--				create container.make (ctxt)
--				container.save_group_attributes (ctxt.width, ctxt.height, ctxt.arity)
				ctxt_list.wipe_out
				from
					ctxt.child_start
					ctxt_list.start
				until
					ctxt.child_offright
				loop
					ctxt_list.finish
					ctxt_list.put_right (ctxt.child)
					ctxt_list.forth
					ctxt.child_forth
				end
			else
					-- Figure out the size to enclose grouped
					-- widgets.
--				x := ctxt_list.first.x
--				y := ctxt_list.first.y
--
--				from
--					ctxt_list.start
--				until
--					ctxt_list.after
--				loop
--					ctxt := ctxt_list.item
--					x := x.min (ctxt.x)
--					y := y.min (ctxt.y)
--					w := w.max (ctxt.x+ctxt.width)
--					h := h.max (ctxt.y+ctxt.height)
--					ctxt_list.forth
--				end
--				w := w - x
--				h := h - y
--				x := x - 3
--				y := y - 3
--				w := w + 5
--				h := h + 5
--
--					-- Create a container and save size attributes.
--				!! container.make (Void)
--				container.save_group_attributes (w, h, ctxt_list.count)
			end
--			from
--				ctxt_list.start
--			until
--				ctxt_list.after
--			loop
--				s_context := save_context (ctxt_list.item)
--					-- Reset the position relative to the new
--					-- group parent.
--				s_context.reset_position (x, y)
--				--remove_context_from_table (ctxt_list.item)
--				ctxt_list.forth
--			end
				-- Creation of the first instance
				-- to replace the grouped contexts
			create group_c
			group_c.set_type (Current)

			parent_ctxt.append (group_c)
			group_c.generate_internal_name
			if is_container then
				-- Update the history creating the group
--				x := group_c.x
--				y := group_c.y
				create gb_cmd.make (ctxt)
				gb_cmd.group_create (group_c)
			else
				group_c.oui_create (parent_ctxt.gui_object)
					-- To give new identifier
				for_import.set_item (True)
				create_oui_group (group_c)
				for_import.set_item (False)
					-- Clear the context table.
				context_table.clear_all
				create create_cmd.make (group_c)
				create_cmd.group_create (ctxt_list)

				group_c.gui_object.show
			end

				-- Save the text generated (creation & initialization)
			Eiffel_text := group_c.group_text

				--  After the text generation, the flags
				-- can be cleared
				group_c.reset_modified_flags
			if not is_container then
				group_c.set_position (parent_ctxt.real_x+x, parent_ctxt.real_y+y)
			else
				group_c.set_x_y (group_c.x, group_c.y)
			end
	
					-- Reset the interface
--			tree.display (parent_ctxt)
			context_catalog.add_new_group (Current)
		end

feature -- Access

	entity_name: STRING

	identifier: INTEGER

	counter: INTEGER

	context_type: CONTEXT_GROUP_TYPE is
		local
			a_list: LINKED_LIST [CONTEXT_GROUP_TYPE]
			found: BOOLEAN
		do
			a_list := context_catalog.context_group_types
			from
				a_list.start
			until
				a_list.after or found
			loop
				if a_list.item.group = Current then
					found := True
					Result := a_list.item
				end
				a_list.forth
			end
		end

	reset_counter is
		do
			if identifier > integer_generator.value then
				from
				until
					identifier = integer_generator.value
				loop
					integer_generator.next
				end
			end
			counter := 0
		end

	increment_counter is
		do
			counter := counter + 1
		end

	decrement_counter is
		require
			counter_positive: counter > 0
		do
			counter := counter - 1
		end

	not_used: BOOLEAN is
			-- Can the group be removed fom the catalog
		local
			used: BOOLEAN
		do
			from
				Shared_group_list.start
			until
				Shared_group_list.after or else used
			loop
				if Shared_group_list.item /= Current then
					used := Shared_group_list.item.use_group (identifier)
				end
				Shared_group_list.forth
			end
			Result := (counter = 0) and  then not used
		end

feature -- Status setting

	set_entity_name (new_name: STRING) is
		require
			valid_new_name: new_name /= Void
		do
			entity_name := clone (new_name)
		end 

	new_id_after_import: INTEGER is
		local
			found: BOOLEAN
			different: BOOLEAN
			e_name: STRING
		do
			from
				Shared_group_list.start
			until
				Shared_group_list.after or found
			loop
				e_name := Shared_group_list.item.entity_name
				if entity_name.is_equal (e_name) then
					found := True
					if eiffel_text /= Void and then
						eiffel_text.is_equal 
							(Shared_group_list.item.eiffel_text) 
					then
						Result := Shared_group_list.item.identifier
					else
						different := True
					end
				end
				Shared_group_list.forth
			end
			if different then
				entity_name := generated_name
			end
			if not found or different then
				integer_generator.next
				identifier := integer_generator.value
				Result := identifier
				Shared_group_list.finish
				Shared_group_list.put_right (Current)
			end
		end

	update_subgroup_id (group_table: INT_H_TABLE [INTEGER]) is
		local
			saved_group: S_GROUP
			i: INTEGER
		do
			from
				i := 1
			until
				i > count
			loop
				saved_group ?= item (i)
				if (saved_group /= Void) then
					saved_group.set_group_type (group_table.item (saved_group.group_type))
					saved_group.update_group_within_group_id (group_table)
				end
				i := i + 1
			end
		end

	create_oui_group (group_c: GROUP_C) is
		local
			saved_identifier: INTEGER
			ctxt: CONTEXT
		do
				-- Identifier is used as a global variable
				-- for the recursive function create_context_tree
			saved_identifier := identifier
				-- Reset the values of `group_c'
--			container.set_context_attributes (group_c)
			group_c.set_position (group_c.parent.x, group_c.parent.y)
			identifier := 1
			from
			until
				identifier > count
			loop
				ctxt := create_context_tree (group_c)
--				ctxt.retrieve_oui_widget
				ctxt.gui_object.show
				identifier := identifier + 1
				group_c.add_group_child (ctxt)
			end
			identifier := saved_identifier
			if (eiffel_text = Void) then
				eiffel_text := group_c.group_text
			end
		end

feature -- Code generation

	entity_name_to_upper: STRING is
		do
			Result := clone (entity_name)
			Result.to_upper
		end

	updated_eiffel_text: STRING is
			-- Updated eiffel text to reflect
			-- any modifications made to group types
		do
            !!Result.make (100)
            Result.append ("class ")
            Result.append (entity_name_to_upper)

            -- Inheritance
            Result.append ("%N%Ninherit%N%N%TEB_BULLETIN")
            Result.append ("%N%T%Trename%N%T%T%Tmake as eb_bulletin_make")
            Result.append ("%N%T%Tend")

            -- Feature clause
            Result.append ("%N%Ncreation%N%N%Tmake")
            Result.append ("%N%Nfeature%N%N")

            -- Group declaration 
            Result.append (group_declaration)
			Result.append (eiffel_text)
			Result.append ("%T%Tend%N%Nend%N%N")
		end

	 group_declaration: STRING is
            -- Eiffel declaration of group widgets.
        local
            s_group: S_GROUP
			i: INTEGER
			group: GROUP
			decl: STRING
        do
            !!Result.make (0)
            from
				i := 1
            until
				i > count
            loop
                s_group ?= item (i)
                if s_group /= Void then
					group := corresponding_group (s_group.group_type)
					if group = Void then
							-- Should not happen. Something may have
							-- went wrong in importing of groups
						io.error.putstring ("Not able to find group: ")
						io.error.putstring (s_group.internal_name)
						io.error.putstring (".%N")
					else	
						!! decl.make (0)
						decl.extend ('%T')
						decl.append (s_group.internal_name)
						decl.append (": ")
						decl.append (group.entity_name_to_upper)
						decl.append ("%N")
						Result.append (decl)
					end
                end
              	i := i + 1 
            end
        end

feature {NONE} -- Implementation

--	container: S_CONTAINER --S_BULLETIN

	save_context (ctxt: CONTEXT): S_CONTEXT is
			-- Convert `ctxt' to storage data (S_CONTEXT).
			-- Store Result into current table (side effect
			-- in routine but needs to be done since current
			-- is stored to disk and we don't want temporary
			-- attributes).
		local
			lost_s_context: S_CONTEXT
		do
			Result := ctxt.stored_node
			put (Result)
				-- Recursive store the children
			from
				ctxt.child_start
			until
				ctxt.child_offright
			loop
				lost_s_context := save_context (ctxt.child)
				ctxt.child_forth
			end
		end

	create_context_tree (a_parent: CONTAINER_C): CONTEXT is
		local
			i: INTEGER
			s_context: S_CONTEXT
			temp: CONTAINER_C
		do
			s_context :=  item (identifier)
			Result := s_context.context (a_parent)
			temp ?= Result
			from
				i := s_context.arity
			until
				i <= 0
			loop
				identifier := identifier + 1
				Result.put_child_right (create_context_tree (temp))
				Result.child_forth
				i := i - 1
--			  s_context.post_process
			end
		end

	corresponding_group (a_type: INTEGER): GROUP is
			-- Group associated with `a_type' identifier
		do
			from
                Shared_group_list.start
            until
                Shared_group_list.after or else Result /= Void
            loop
                if Shared_group_list.item.identifier = a_type then
                    Result := Shared_group_list.item
                else
                    Shared_group_list.forth
                end
            end
		end
	
	remove_context_from_table (ctxt: CONTEXT) is
		local
			con_group: GROUP_C
			ctxt_list: LINKED_LIST [CONTEXT]
		do
			if context_table.has (ctxt.identifier) then
				context_table.remove (ctxt.identifier)
			end
			con_group ?= ctxt
			if con_group = Void then
				from
					ctxt.child_start
				until
					ctxt.child_offright
				loop
					remove_context_from_table (ctxt.child)
					ctxt.child_forth
				end
			else
				ctxt_list := con_group.subtree
				from
					ctxt_list.start
				until
					ctxt_list.after
				loop
					remove_context_from_table (ctxt_list.item)
					ctxt_list.forth
				end
			end
		end

feature {NONE} -- Internal namer

	integer_generator: INT_GENERATOR is
		once
			!!Result
			Result.set (100)
		end

	local_namer: LOCAL_NAMER is
		once
			!!Result.make ("group")
		end

	generated_name: STRING is
		local
			found: BOOLEAN
			e_name: STRING
		do
			local_namer.next
			Result := local_namer.Value
			from
				Shared_group_list.start
			until
				Shared_group_list.after or found
			loop
				e_name := Shared_group_list.item.entity_name
				if Result.is_equal (e_name) then
					found := True
					Result := generated_name
				else
					Shared_group_list.forth
				end
			end
		end

feature {GROUP}

	use_group (a_group_id: INTEGER): BOOLEAN is
			-- Does the current group use `a_group' in its tree
		local
			found: BOOLEAN
			saved_group: S_GROUP
			i: INTEGER
		do
			from
				i := 1
			until
				i > count or found
			loop
				saved_group ?= item (i)
				if saved_group /= Void and then
					saved_group.group_type = a_group_id then
					found := True
				end
				i := i + 1
			end
			Result := found
		end

feature {CONTEXT_GROUP_TYPE}

	update_entity_name_in_tree is
			-- Update the entity_name (eiffel_type for group_c) in
			-- context tree
		do
			Tree.disable_drawing
			from
				Shared_window_list.start
			until
				Shared_window_list.after
			loop
				Shared_window_list.item.update_group_name_in_tree (Current)
				Shared_window_list.forth
			end
			Tree.enable_drawing
			if not Shared_window_list.empty then
				Tree.display (Shared_window_list.first)
			end
		end

end -- class GROUP

