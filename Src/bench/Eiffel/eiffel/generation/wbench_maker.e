-- Makefile generator for workbench mode C compilation

class WBENCH_MAKER

inherit
	MAKEFILE_GENERATOR
		redefine
			generate_specific_defines, generate_other_objects
		end;

creation

	make

feature

	generate_compilation_rule is
			-- Generates the .c -> .o compilation rule
		do
			Make_file.putstring ("%
				%%N.SUFFIXES:.cpp%N%N%
				%.c.o:%N%
				%%T$(CC) $(CFLAGS) -c $<%N%N%
				%.cpp.o:%N%
				%%T$(CPP) $(CPPFLAGS) -c $<%N%N");
		end;

	generate_specific_defines is
			-- Generate specific "-D" flags.
			-- In this case "-DWORKBENCH"
		do
			Make_file.putstring ("-DWORKBENCH ");
		end;

	add_specific_objects is
			-- Add workbench mode specific files to the object list
		do
			add_in_system_basket (Econform)
			add_in_system_basket (Eoption);
			add_in_system_basket (Epattern);
			add_in_system_basket (Efrozen);
			add_in_system_basket (Edispatch);
			add_in_system_basket (Ecall);
		end;

	add_cecil_objects is
		local
			cecil_basket: LINKED_LIST [STRING]
		do
			if not System.has_multithreaded then
				cecil_basket := cecil_rt_basket
				cecil_basket.extend ("network.o"); cecil_basket.finish
				cecil_basket.extend ("wmath.o"); cecil_basket.finish
				cecil_basket.extend ("wmalloc.o"); cecil_basket.finish
				cecil_basket.extend ("wgarcol.o"); cecil_basket.finish
				cecil_basket.extend ("wlocal.o"); cecil_basket.finish
				cecil_basket.extend ("wexcept.o"); cecil_basket.finish
				cecil_basket.extend ("wstore.o"); cecil_basket.finish
				cecil_basket.extend ("wretrieve.o"); cecil_basket.finish
				cecil_basket.extend ("whash.o"); cecil_basket.finish
				cecil_basket.extend ("wtraverse.o"); cecil_basket.finish
				cecil_basket.extend ("whashin.o"); cecil_basket.finish
				cecil_basket.extend ("wtools.o"); cecil_basket.finish
				cecil_basket.extend ("winternal.o"); cecil_basket.finish
				cecil_basket.extend ("wplug.o"); cecil_basket.finish
				cecil_basket.extend ("wcopy.o"); cecil_basket.finish
				cecil_basket.extend ("wequal.o"); cecil_basket.finish
				cecil_basket.extend ("wlmalloc.o"); cecil_basket.finish
				cecil_basket.extend ("wout.o"); cecil_basket.finish
				cecil_basket.extend ("wtimer.o"); cecil_basket.finish
				cecil_basket.extend ("wurgent.o"); cecil_basket.finish
				cecil_basket.extend ("wsig.o"); cecil_basket.finish
				cecil_basket.extend ("whector.o"); cecil_basket.finish
				cecil_basket.extend ("wcecil.o"); cecil_basket.finish
				cecil_basket.extend ("wbits.o"); cecil_basket.finish
				cecil_basket.extend ("wfile.o"); cecil_basket.finish
				cecil_basket.extend ("wdir.o"); cecil_basket.finish
				cecil_basket.extend ("wstring.o"); cecil_basket.finish
				cecil_basket.extend ("wmisc.o"); cecil_basket.finish
				cecil_basket.extend ("wpattern.o"); cecil_basket.finish
				cecil_basket.extend ("werror.o"); cecil_basket.finish
				cecil_basket.extend ("wumain.o"); cecil_basket.finish
				cecil_basket.extend ("wmemory.o"); cecil_basket.finish
				cecil_basket.extend ("wargv.o"); cecil_basket.finish
				cecil_basket.extend ("wboolstr.o"); cecil_basket.finish
				cecil_basket.extend ("wsearch.o"); cecil_basket.finish
				cecil_basket.extend ("wmain.o"); cecil_basket.finish
				cecil_basket.extend ("debug.o"); cecil_basket.finish
				cecil_basket.extend ("interp.o"); cecil_basket.finish
				cecil_basket.extend ("woption.o"); cecil_basket.finish
				cecil_basket.extend ("update.o"); cecil_basket.finish
				cecil_basket.extend ("wbench.o"); cecil_basket.finish
				cecil_basket.extend ("wrun_idr.o"); cecil_basket.finish
				cecil_basket.extend ("compress.o"); cecil_basket.finish
				cecil_basket.extend ("console.o"); cecil_basket.finish
				cecil_basket.extend ("wpath_name.o"); cecil_basket.finish
				cecil_basket.extend ("wobject_id.o"); cecil_basket.finish
				cecil_basket.extend ("wdle.o"); cecil_basket.finish
				cecil_basket.extend ("weif_threads.o"); cecil_basket.finish
				cecil_basket.extend ("eif_rw_lock.o"); cecil_basket.finish
				cecil_basket.extend ("wgen_conf.o"); cecil_basket.finish
				cecil_basket.extend ("wrout_obj.o"); cecil_basket.finish
				cecil_basket.extend ("eif_once.o"); cecil_basket.finish
				cecil_basket.extend ("weif_project.o"); cecil_basket.finish
				cecil_basket.extend ("eif_special_table.o"); cecil_basket.finish
			else
				cecil_basket := cecil_rt_basket
				cecil_basket.extend ("mtnetwork.o"); cecil_basket.finish
				cecil_basket.extend ("mtwmath.o"); cecil_basket.finish
				cecil_basket.extend ("mtwmalloc.o"); cecil_basket.finish
				cecil_basket.extend ("mtwgarcol.o"); cecil_basket.finish
				cecil_basket.extend ("mtwlocal.o"); cecil_basket.finish
				cecil_basket.extend ("mtwexcept.o"); cecil_basket.finish
				cecil_basket.extend ("mtwstore.o"); cecil_basket.finish
				cecil_basket.extend ("mtwretrieve.o"); cecil_basket.finish
				cecil_basket.extend ("mtwhash.o"); cecil_basket.finish
				cecil_basket.extend ("mtwtraverse.o"); cecil_basket.finish
				cecil_basket.extend ("mtwhashin.o"); cecil_basket.finish
				cecil_basket.extend ("mtwtools.o"); cecil_basket.finish
				cecil_basket.extend ("mtwinternal.o"); cecil_basket.finish
				cecil_basket.extend ("mtwplug.o"); cecil_basket.finish
				cecil_basket.extend ("mtwcopy.o"); cecil_basket.finish
				cecil_basket.extend ("mtwequal.o"); cecil_basket.finish
				cecil_basket.extend ("mtwlmalloc.o"); cecil_basket.finish
				cecil_basket.extend ("mtwout.o"); cecil_basket.finish
				cecil_basket.extend ("mtwtimer.o"); cecil_basket.finish
				cecil_basket.extend ("mtwurgent.o"); cecil_basket.finish
				cecil_basket.extend ("mtwsig.o"); cecil_basket.finish
				cecil_basket.extend ("mtwhector.o"); cecil_basket.finish
				cecil_basket.extend ("mtwcecil.o"); cecil_basket.finish
				cecil_basket.extend ("mtwbits.o"); cecil_basket.finish
				cecil_basket.extend ("mtwfile.o"); cecil_basket.finish
				cecil_basket.extend ("mtwdir.o"); cecil_basket.finish
				cecil_basket.extend ("mtwstring.o"); cecil_basket.finish
				cecil_basket.extend ("mtwmisc.o"); cecil_basket.finish
				cecil_basket.extend ("mtwpattern.o"); cecil_basket.finish
				cecil_basket.extend ("mtwerror.o"); cecil_basket.finish
				cecil_basket.extend ("mtwumain.o"); cecil_basket.finish
				cecil_basket.extend ("mtwmemory.o"); cecil_basket.finish
				cecil_basket.extend ("mtwargv.o"); cecil_basket.finish
				cecil_basket.extend ("mtwboolstr.o"); cecil_basket.finish
				cecil_basket.extend ("mtwsearch.o"); cecil_basket.finish
				cecil_basket.extend ("mtwmain.o"); cecil_basket.finish
				cecil_basket.extend ("mtdebug.o"); cecil_basket.finish
				cecil_basket.extend ("mtinterp.o"); cecil_basket.finish
				cecil_basket.extend ("mtwoption.o"); cecil_basket.finish
				cecil_basket.extend ("mtupdate.o"); cecil_basket.finish
				cecil_basket.extend ("mtwbench.o"); cecil_basket.finish
				cecil_basket.extend ("mtwrun_idr.o"); cecil_basket.finish
				cecil_basket.extend ("mtcompress.o"); cecil_basket.finish
				cecil_basket.extend ("mtconsole.o"); cecil_basket.finish
				cecil_basket.extend ("mtwpath_name.o"); cecil_basket.finish
				cecil_basket.extend ("mtwobject_id.o"); cecil_basket.finish
				cecil_basket.extend ("mtwdle.o"); cecil_basket.finish
				cecil_basket.extend ("mtweif_threads.o"); cecil_basket.finish
				cecil_basket.extend ("mteif_rw_lock.o"); cecil_basket.finish
				cecil_basket.extend ("mtwgen_conf.o"); cecil_basket.finish
				cecil_basket.extend ("mtwrout_obj.o"); cecil_basket.finish
				cecil_basket.extend ("mteif_once.o"); cecil_basket.finish
				cecil_basket.extend ("mtweif_project.o"); cecil_basket.finish
				cecil_basket.extend ("mteif_special_table.o"); cecil_basket.finish
			end
		end;

	add_eiffel_objects is
			-- Add Eiffel objects to the basket, i.e. C code for
			-- each class as well as feature tables and descriptor
			-- tables.
		local
			a_class: CLASS_C;
			types: TYPE_LIST;
			cl_type: CLASS_TYPE;
			object_name, file_name: STRING;
			classes: CLASS_C_SERVER;
			class_array: ARRAY [CLASS_C];
			i, nb, packet_nb: INTEGER;
			string_list: LINKED_LIST [STRING]
		do
			classes := System.classes;
			from classes.start until classes.after loop
				class_array := classes.item_for_iteration;
				nb := Class_counter.item (classes.key_for_iteration).count
				from i := 1 until i > nb loop
					a_class := class_array.item (i)
					if a_class /= Void then
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
		
								if (not cl_type.is_precompiled) then
									packet_nb := cl_type.packet_number
										-- C code
									object_name := cl_type.base_file_name;
									!!file_name.make (16);
									file_name.append (object_name);
									file_name.append (".o");
									string_list := object_baskets.item (packet_nb)
									string_list.extend (file_name)
									string_list.finish

										-- Descriptor file
									!!file_name.make (16);
									file_name.append (object_name);
									file_name.append_character (Descriptor_file_suffix);
									file_name.append (".o");
									string_list := object_baskets.item (packet_nb)
									string_list.extend (file_name)
									string_list.finish
								end;

							end;
							types.forth;
						end;
		
						if (not a_class.is_precompiled) then
								-- Feature table
							object_name := a_class.base_file_name;
							!!file_name.make (16);
							file_name.append (object_name);
							file_name.append_integer (a_class.id.id);
							file_name.append_character (Feature_table_file_suffix);
							file_name.append (".o");
							object_baskets.item (a_class.packet_number).extend (file_name);
						end;
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

			Result.append ("$wkeiflib")

			if System.has_dynamic_runtime then
				Result.append ("$shared_suffix")
			else
				Result.append ("$suffix")
			end

			if System.has_separate then
				Result.append ("\$(EIFFEL4)/library/net/spec/\$(PLATFORM)/lib/libnet.a")
			end
		end;

	generate_other_objects is
		local
			precomp: like Precompilation_directories
			dir: REMOTE_PROJECT_DIRECTORY
		do
			if System.uses_precompiled then
				from
					precomp := Precompilation_directories;
					precomp.start 
				until
					precomp.after
				loop
					dir := precomp.item_for_iteration;
					if dir.has_precompiled_preobj then
						Make_file.putstring ("%T%T");
						Make_file.putstring (dir.precompiled_preobj);
						Make_file.putchar (' ');
						Make_file.putchar (Continuation);
						Make_file.new_line
					end;
					precomp.forth
				end
			end;
		end;

end
