-- Makefile generator for final mode C compilation

class FINAL_MAKER

inherit
	MAKEFILE_GENERATOR

creation

	make

feature

	generate_compilation_rule is
			-- Generates the .c -> .o compilation rule
		do
			Make_file.putstring ("%
				%.SUFFIXES: .x .xpp%N%N%
				%.c.o:%N%
				%%T$(CC) $(CFLAGS) -c $<%N%N%
				%.cpp.o:%N%
				%%T$(CC) $(CFLAGS) -c $<%N%N")
			Make_file.putstring ("%
				%.x.o:%N%
				%%T$(EIFFEL4)/bench/spec/$(PLATFORM)/bin/x2c $< $*.c%N%
				%%T$(CC) $(CFLAGS) -c $*.c%N%
				%%T$(RM) $*.c%N%N%
				%.xpp.o:%N%
				%%T$(EIFFEL4)/bench/spec/$(PLATFORM)/bin/x2c $< $*.cpp%N%
				%%T$(CPP) $(CFLAGS) -c $*.cpp%N%
				%%T$(RM) $*.cpp%N%N")
			Make_file.putstring ("%
				%.x.c:%N%
				%%T$(EIFFEL4)/bench/spec/$(PLATFORM)/bin/x2c $< $*.c%N%N%
				%.xpp.cpp:%N%
				%%T$(EIFFEL4)/bench/spec/$(PLATFORM)/bin/x2c $< $*.cpp%N%N")
		end;

	add_specific_objects is
			-- Add objects specific to final C code 
			-- generation
		local
			file_name: STRING;
			i, nb: INTEGER;
		do
			add_in_primary_system_basket (Eref);
			add_in_primary_system_basket (Esize);
			if System.has_separate then
				add_in_primary_system_basket (Epattern);
			end;

				-- Routine tables.
			from
				i := 1;
				nb := Rout_generator.file_counter - 1;
			until
				i > nb
			loop
				!!file_name.make (16);
				file_name.append (Epoly);
				file_name.append_integer (i);
				add_in_system_basket(file_name, i // System_packet_number + 2);
				i := i + 1;
			end;
		end;

	add_cecil_objects is
		local
			cecil_basket: LINKED_LIST [STRING]
		do
			if not System.has_multithreaded then
				cecil_basket := cecil_rt_basket
				cecil_basket.extend ("malloc.o"); cecil_basket.finish
				cecil_basket.extend ("garcol.o"); cecil_basket.finish
				cecil_basket.extend ("local.o"); cecil_basket.finish
				cecil_basket.extend ("except.o"); cecil_basket.finish
				cecil_basket.extend ("store.o"); cecil_basket.finish
				cecil_basket.extend ("retrieve.o"); cecil_basket.finish
				cecil_basket.extend ("hash.o"); cecil_basket.finish
				cecil_basket.extend ("traverse.o"); cecil_basket.finish
				cecil_basket.extend ("hashin.o"); cecil_basket.finish
				cecil_basket.extend ("tools.o"); cecil_basket.finish
				cecil_basket.extend ("internal.o"); cecil_basket.finish
				cecil_basket.extend ("plug.o"); cecil_basket.finish
				cecil_basket.extend ("copy.o"); cecil_basket.finish
				cecil_basket.extend ("equal.o"); cecil_basket.finish
				cecil_basket.extend ("lmalloc.o"); cecil_basket.finish
				cecil_basket.extend ("out.o"); cecil_basket.finish
				cecil_basket.extend ("timer.o"); cecil_basket.finish
				cecil_basket.extend ("urgent.o"); cecil_basket.finish
				cecil_basket.extend ("sig.o"); cecil_basket.finish
				cecil_basket.extend ("hector.o"); cecil_basket.finish
				cecil_basket.extend ("cecil.o"); cecil_basket.finish
				cecil_basket.extend ("bits.o"); cecil_basket.finish
				cecil_basket.extend ("file.o"); cecil_basket.finish
				cecil_basket.extend ("dir.o"); cecil_basket.finish
				cecil_basket.extend ("string.o"); cecil_basket.finish
				cecil_basket.extend ("misc.o"); cecil_basket.finish
				cecil_basket.extend ("pattern.o"); cecil_basket.finish
				cecil_basket.extend ("error.o"); cecil_basket.finish
				cecil_basket.extend ("umain.o"); cecil_basket.finish
				cecil_basket.extend ("memory.o"); cecil_basket.finish
				cecil_basket.extend ("argv.o"); cecil_basket.finish
				cecil_basket.extend ("boolstr.o"); cecil_basket.finish
				cecil_basket.extend ("search.o"); cecil_basket.finish
				cecil_basket.extend ("main.o"); cecil_basket.finish
				cecil_basket.extend ("run_idr.o"); cecil_basket.finish
				cecil_basket.extend ("compress.o"); cecil_basket.finish
				cecil_basket.extend ("console.o"); cecil_basket.finish
				cecil_basket.extend ("path_name.o"); cecil_basket.finish
				cecil_basket.extend ("object_id.o"); cecil_basket.finish
				cecil_basket.extend ("dle.o"); cecil_basket.finish
				cecil_basket.extend ("option.o"); cecil_basket.finish
				cecil_basket.extend ("eif_threads.o"); cecil_basket.finish
				cecil_basket.extend ("eif_rw_lock.o"); cecil_basket.finish
				cecil_basket.extend ("gen_conf.o"); cecil_basket.finish
				cecil_basket.extend ("rout_obj.o"); cecil_basket.finish
				cecil_basket.extend ("eif_once.o"); cecil_basket.finish
				cecil_basket.extend ("eif_project.o"); cecil_basket.finish
				cecil_basket.extend ("eif_special_table.o"); cecil_basket.finish
			else
				cecil_basket := cecil_rt_basket
				cecil_basket.extend ("mtmath.o"); cecil_basket.finish
				cecil_basket.extend ("mtmalloc.o"); cecil_basket.finish
				cecil_basket.extend ("mtgarcol.o"); cecil_basket.finish
				cecil_basket.extend ("mtlocal.o"); cecil_basket.finish
				cecil_basket.extend ("mtexcept.o"); cecil_basket.finish
				cecil_basket.extend ("mtstore.o"); cecil_basket.finish
				cecil_basket.extend ("mtretrieve.o"); cecil_basket.finish
				cecil_basket.extend ("mthash.o"); cecil_basket.finish
				cecil_basket.extend ("mttraverse.o"); cecil_basket.finish
				cecil_basket.extend ("mthashin.o"); cecil_basket.finish
				cecil_basket.extend ("mttools.o"); cecil_basket.finish
				cecil_basket.extend ("mtinternal.o"); cecil_basket.finish
				cecil_basket.extend ("mtplug.o"); cecil_basket.finish
				cecil_basket.extend ("mtcopy.o"); cecil_basket.finish
				cecil_basket.extend ("mtequal.o"); cecil_basket.finish
				cecil_basket.extend ("mtlmalloc.o"); cecil_basket.finish
				cecil_basket.extend ("mtout.o"); cecil_basket.finish
				cecil_basket.extend ("mttimer.o"); cecil_basket.finish
				cecil_basket.extend ("mturgent.o"); cecil_basket.finish
				cecil_basket.extend ("mtsig.o"); cecil_basket.finish
				cecil_basket.extend ("mthector.o"); cecil_basket.finish
				cecil_basket.extend ("mtcecil.o"); cecil_basket.finish
				cecil_basket.extend ("mtbits.o"); cecil_basket.finish
				cecil_basket.extend ("mtfile.o"); cecil_basket.finish
				cecil_basket.extend ("mtdir.o"); cecil_basket.finish
				cecil_basket.extend ("mtstring.o"); cecil_basket.finish
				cecil_basket.extend ("mtmisc.o"); cecil_basket.finish
				cecil_basket.extend ("mtpattern.o"); cecil_basket.finish
				cecil_basket.extend ("mterror.o"); cecil_basket.finish
				cecil_basket.extend ("mtumain.o"); cecil_basket.finish
				cecil_basket.extend ("mtmemory.o"); cecil_basket.finish
				cecil_basket.extend ("mtargv.o"); cecil_basket.finish
				cecil_basket.extend ("mtboolstr.o"); cecil_basket.finish
				cecil_basket.extend ("mtsearch.o"); cecil_basket.finish
				cecil_basket.extend ("mtmain.o"); cecil_basket.finish
				cecil_basket.extend ("mtrun_idr.o"); cecil_basket.finish
				cecil_basket.extend ("mtcompress.o"); cecil_basket.finish
				cecil_basket.extend ("mtconsole.o"); cecil_basket.finish
				cecil_basket.extend ("mtpath_name.o"); cecil_basket.finish
				cecil_basket.extend ("mtobject_id.o"); cecil_basket.finish
				cecil_basket.extend ("mtdle.o"); cecil_basket.finish
				cecil_basket.extend ("mtoption.o"); cecil_basket.finish
				cecil_basket.extend ("mteif_threads.o"); cecil_basket.finish
				cecil_basket.extend ("mteif_rw_lock.o"); cecil_basket.finish
				cecil_basket.extend ("mtgen_conf.o"); cecil_basket.finish
				cecil_basket.extend ("mtrout_obj.o"); cecil_basket.finish
				cecil_basket.extend ("mteif_once.o"); cecil_basket.finish
				cecil_basket.extend ("mteif_project.o"); cecil_basket.finish
				cecil_basket.extend ("mteif_special_table.o"); cecil_basket.finish
			end
		end;

	add_eiffel_objects is
			-- Add class C code objects.
		local
			a_class: CLASS_C;
			types: TYPE_LIST;
			cl_type: CLASS_TYPE;
			object_name, file_name: STRING;
			classes: CLASS_C_SERVER;
			class_array: ARRAY [CLASS_C];
			i, nb: INTEGER;
			string_list: LINKED_LIST [STRING]
		do
			classes := System.classes;
			from classes.start until classes.after loop
				class_array := classes.item_for_iteration;
				nb := Class_counter.item (classes.key_for_iteration).count
				from i := 1 until i > nb loop
					a_class := class_array.item (i)
					if a_class /= Void then
						if not a_class.is_precompiled or else a_class.is_in_system then
							from
								types := a_class.types;
								types.start
							until
								types.after
							loop
								cl_type := types.item;
								if
									types.has_type (cl_type.type)
									and then types.found_item = cl_type
								then
									-- Do not generate twice the same type if it
									-- has been derived in two different merged
									-- precompiled libraries.
									if not empty_class_types.has (cl_type.id) then
											-- C code
										object_name := cl_type.base_file_name;
										!!file_name.make (16);
										file_name.append (object_name);
										file_name.append (".o");
										string_list := object_baskets.item (cl_type.packet_number)
										string_list.extend (file_name);
										string_list.finish
									end;
								end;
								types.forth;
							end;
						end
					end
					i := i + 1
				end
				classes.forth
			end;
		end;

	run_time: STRING is
			-- Run time with which the application must be linked
		do
			Result := "\$(EIFFEL4)/bench/spec/\$(PLATFORM)/lib/"

			if System.has_dynamic_runtime then
				Result.append ("$shared_prefix")
			else
				Result.append ("$prefix")
			end

			if System.has_multithreaded then
				Result.append ("$mt_prefix")
			end

			if System.has_separate then
				Result.append ("$concurrent_prefix")
			end

			Result.append ("$eiflib")

			if System.has_dynamic_runtime then
				Result.append ("$shared_suffix")
			else
				Result.append ("$suffix")
			end

			if System.has_separate then
				Result.append ("\$(EIFFEL4)/library/net/spec/\$(PLATFORM)/lib/libnet.a")
			end
		end;

end
