
indexing
	description: "Routines which generate information from class"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_GENERATOR

inherit
	SHARED_EIFFEL_PROJECT

feature -- Generations

	generated_clients(cl: CLASS_I): LINKED_LIST[STRING] is
		require
			exists: cl /= Void
			compiled: cl.compiled
		local
			class_c: CLASS_C
		do
			Create Result.make
			class_c := cl.compiled_class
			from
				class_c.clients.start
			until
				class_c.clients.after
			loop
				Result.extend(class_c.clients.item.class_signature)
				class_c.clients.forth
			end
		end

	generated_heirs(cl: CLASS_I): LINKED_LIST[STRING] is
		require
			exists: cl /= Void
			compiled: cl.compiled
		local
			class_c: CLASS_C
		do
			Create Result.make
			class_c := cl.compiled_class
			from
				class_c.descendants.start
			until
				class_c.descendants.after
			loop
				Result.extend(class_c.descendants.item.class_signature)
				class_c.descendants.forth
			end
		end

	generated_suppliers(cl: CLASS_I): LINKED_LIST[STRING] is
		require
			exists: cl /= Void
			compiled: cl.compiled
		local
			class_c: CLASS_C
			li: SUPPLIER_LIST
		do
			Create Result.make
			class_c := cl.compiled_class
			from
				li := class_c.suppliers
				li.start
			until
				li.after
			loop
				if li.item.supplier /= Void then
					Result.extend(li.item.supplier.class_signature)
				end
				li.forth
			end
		end

	generated_parents(cl: CLASS_I): LINKED_LIST[STRING] is
		require
			exists: cl /= Void
			compiled: cl.compiled
		local
			class_c: CLASS_C
			li: FIXED_LIST[CL_TYPE_A]
		do
			Create Result.make
			class_c := cl.compiled_class
			from
				li := class_c.parents
				li.start
			until
				li.after
			loop
				if li.item.associated_class /= Void then
					Result.extend(clone(li.item.associated_class.name))
				end
				li.forth
			end
		end

	generated_routines(cl: CLASS_I): LINKED_LIST[STRING] is
		require
			exists: cl /= Void
			compiled: cl.compiled
		local
			class_c: CLASS_C
		do
			Create Result.make
			class_c := cl.compiled_class
			from
				class_c.clients.start
			until
				class_c.clients.after
			loop
				Result.extend(class_c.clients.item.class_signature)
				class_c.clients.forth
			end
		end

	generate_features(qu_list,com_list: LINKED_LIST[STRING];
						cl: CLASS_I) is
		require
			exist: cl /= Void and qu_list /= Void and com_list /= Void
			compiled: cl.compiled
		local
			tab: FEATURE_TABLE
			feat: FEATURE_I
			cla: CLASS_C
		do
			cla := cl.compiled_class
			tab := cla.feature_table
			from
				tab.start
			until
				tab.after
			loop
				feat := tab.item_for_iteration
				if feat.is_function /= Void and then from_class(feat,cla) then
					qu_list.extend(tab.key_for_iteration)
				elseif feat.is_procedure and then not feat.is_attribute 
						and then from_class(feat,cla) then
						com_list.extend(tab.key_for_iteration)
				end
				tab.forth
			end
		end

	generate_constraints(cl: CLASS_I; li: LINKED_LIST[STRING]) is
		require
			not_void: cl /= Void and li /= Void
			compiled: cl.compiled
		local
			ast: INVARIANT_AS
			lii: EIFFEL_LIST[TAGGED_AS]
			tmp: STRING
		do
			ast := cl.compiled_class.invariant_ast
			if ast /= Void then
				from
					lii := ast.assertion_list
					lii.start
				until
					lii.after
				loop
					if lii.item.tag /= Void and then 
					  lii.item.tag.count>0 then
						tmp:= ""+lii.item.tag
						tmp.replace_substring_all("_"," ")
						li.extend(tmp)
					end
					lii.forth
				end
			end
		end

	generate_indexing(cl: CLASS_I;desc: STRING; li: LINKED_LIST[STRING]) is
		require
			not_void: cl /= Void and desc /= Void and li /= Void
			possible: desc.empty
			compiled: cl.compiled
		local
			indexes: EIFFEL_LIST [INDEX_AS];
			index_list: EIFFEL_LIST [ATOMIC_AS];
			index_tag: STRING;
			index: INDEX_AS;
			ast: CLASS_AS
			s,t: STRING
		do
			ast := cl.compiled_class.ast;
			if ast /= Void then
				indexes := ast.indexes;
				if indexes /= Void then
					from 
						indexes.start 
					until 
						indexes.after 
					loop
						s := ""
						index := indexes.item;
						index_tag := index.tag;
				 
						if	index_tag /= Void then
							t := clone(index_tag)
							t.to_upper
							s := index_tag + ":"
							index_list := index.index_list;
							from 
								index_list.start 
							until 
								index_list.after 
							loop
								s.append(index_list.item.string_value)
								if not index_list.islast then
									s.append(", ")
								end
								index_list.forth
							end
							if t.is_equal("DESCRIPTION") then
								desc.append(s)
								desc.replace_substring_all("DESCRIPTION:","")
							else
								li.extend(s)
							end
						end
						indexes.forth
					end
				end
			end	
		end

	from_class (f: FEATURE_I;cl: CLASS_C): BOOLEAN is
			-- True if f balongs to class 'cl'.
		do
			Result := f.written_class = cl
		end

	any_class: CLASS_C is
   			-- (export status {NONE})
   		once
 			Result := eiffel_system.any_class.compiled_class
 		end
 
feature -- Implementation

	format_generator: HTML_GENERATOR

invariant
	generator_exists: format_generator /= Void
end -- class CLASS_GENERATOR
