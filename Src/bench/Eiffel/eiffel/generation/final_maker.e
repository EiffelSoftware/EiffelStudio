indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Makefile generator for final mode C compilation

class FINAL_MAKER

inherit
	MAKEFILE_GENERATOR

create

	make

feature

	generate_compilation_rule is
			-- Generates the .c -> .o compilation rule
		do
			Make_file.put_string ("%
				%.SUFFIXES: .x .xpp .o%N%N%
				%.c.o:%N%
				%%T$(CC) $(CFLAGS) -c $<%N%N%
				%.cpp.o:%N%
				%%T$(CPP) $(CPPFLAGS) -c $<%N%N")
			Make_file.put_string ("%
				%.x.o:%N%
				%%T$(X2C) $< $*.c%N%
				%%T$(CC) $(CFLAGS) -c $*.c%N%
				%%T$(RM) $*.c%N%N%
				%.xpp.o:%N%
				%%T$(X2C) $< $*.cpp%N%
				%%T$(CPP) $(CPPFLAGS) -c $*.cpp%N%
				%%T$(RM) $*.cpp%N%N")
			Make_file.put_string ("%
				%.x.c:%N%
				%%T$(X2C) $< $*.c%N%N%
				%.xpp.cpp:%N%
				%%T$(X2C) $< $*.cpp%N%N")
		end;

	add_specific_objects is
			-- Add objects specific to final C code 
			-- generation
		local
			file_name: STRING;
			i, nb: INTEGER;
		do
			add_in_primary_system_basket (Eref);
			add_in_primary_system_basket (Epoly);
			add_in_primary_system_basket (Esize);

				-- Routine tables.
			from
				i := 1;
				nb := Rout_generator.file_counter - 1;
			until
				i > nb
			loop
				create file_name.make (16);
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
				cecil_basket.extend ("misc.o"); cecil_basket.finish
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
				cecil_basket.extend ("option.o"); cecil_basket.finish
				cecil_basket.extend ("eif_threads.o"); cecil_basket.finish
				cecil_basket.extend ("eif_rw_lock.o"); cecil_basket.finish
				cecil_basket.extend ("gen_conf.o"); cecil_basket.finish
				cecil_basket.extend ("eif_type_id.o"); cecil_basket.finish
				cecil_basket.extend ("rout_obj.o"); cecil_basket.finish
				cecil_basket.extend ("eif_project.o"); cecil_basket.finish
				cecil_basket.extend ("idrs.o"); cecil_basket.finish
			else
				cecil_basket := cecil_rt_basket
				cecil_basket.extend ("MTmalloc.o"); cecil_basket.finish
				cecil_basket.extend ("MTgarcol.o"); cecil_basket.finish
				cecil_basket.extend ("MTlocal.o"); cecil_basket.finish
				cecil_basket.extend ("MTexcept.o"); cecil_basket.finish
				cecil_basket.extend ("MTstore.o"); cecil_basket.finish
				cecil_basket.extend ("MTretrieve.o"); cecil_basket.finish
				cecil_basket.extend ("MThash.o"); cecil_basket.finish
				cecil_basket.extend ("MTtraverse.o"); cecil_basket.finish
				cecil_basket.extend ("MThashin.o"); cecil_basket.finish
				cecil_basket.extend ("MTtools.o"); cecil_basket.finish
				cecil_basket.extend ("MTinternal.o"); cecil_basket.finish
				cecil_basket.extend ("MTplug.o"); cecil_basket.finish
				cecil_basket.extend ("MTcopy.o"); cecil_basket.finish
				cecil_basket.extend ("MTequal.o"); cecil_basket.finish
				cecil_basket.extend ("MTlmalloc.o"); cecil_basket.finish
				cecil_basket.extend ("MTout.o"); cecil_basket.finish
				cecil_basket.extend ("MTtimer.o"); cecil_basket.finish
				cecil_basket.extend ("MTurgent.o"); cecil_basket.finish
				cecil_basket.extend ("MTsig.o"); cecil_basket.finish
				cecil_basket.extend ("MThector.o"); cecil_basket.finish
				cecil_basket.extend ("MTcecil.o"); cecil_basket.finish
				cecil_basket.extend ("MTbits.o"); cecil_basket.finish
				cecil_basket.extend ("MTfile.o"); cecil_basket.finish
				cecil_basket.extend ("MTdir.o"); cecil_basket.finish
				cecil_basket.extend ("MTmisc.o"); cecil_basket.finish
				cecil_basket.extend ("MTerror.o"); cecil_basket.finish
				cecil_basket.extend ("MTumain.o"); cecil_basket.finish
				cecil_basket.extend ("MTmemory.o"); cecil_basket.finish
				cecil_basket.extend ("MTargv.o"); cecil_basket.finish
				cecil_basket.extend ("MTboolstr.o"); cecil_basket.finish
				cecil_basket.extend ("MTsearch.o"); cecil_basket.finish
				cecil_basket.extend ("MTmain.o"); cecil_basket.finish
				cecil_basket.extend ("MTrun_idr.o"); cecil_basket.finish
				cecil_basket.extend ("MTcompress.o"); cecil_basket.finish
				cecil_basket.extend ("MTconsole.o"); cecil_basket.finish
				cecil_basket.extend ("MTpath_name.o"); cecil_basket.finish
				cecil_basket.extend ("MTobject_id.o"); cecil_basket.finish
				cecil_basket.extend ("MToption.o"); cecil_basket.finish
				cecil_basket.extend ("MTeif_threads.o"); cecil_basket.finish
				cecil_basket.extend ("MTeif_rw_lock.o"); cecil_basket.finish
				cecil_basket.extend ("MTgen_conf.o"); cecil_basket.finish
				cecil_basket.extend ("MTeif_type_id.o"); cecil_basket.finish
				cecil_basket.extend ("MTrout_obj.o"); cecil_basket.finish
				cecil_basket.extend ("MTeif_project.o"); cecil_basket.finish
				cecil_basket.extend ("MTidrs.o"); cecil_basket.finish
			end
		end;

	add_eiffel_objects is
			-- Add class C code objects.
		local
			a_class: CLASS_C;
			types: TYPE_LIST;
			cl_type: CLASS_TYPE;
			file_name: STRING;
			class_array: ARRAY [CLASS_C];
			i, nb: INTEGER;
			string_list: LINKED_LIST [STRING]
		do
			from
				class_array := system.classes
				nb := Class_counter.count
				i := 1
			until
				i > nb
			loop
				a_class := class_array.item (i)
				if
					a_class /= Void and then a_class.has_types and then
					(not a_class.is_precompiled or else a_class.is_in_system)
				then
					from
						types := a_class.types
						types.start
					until
						types.after
					loop
						cl_type := types.item
						if not empty_class_types.has (cl_type.static_type_id) then
								-- C code
							create file_name.make (16)
							file_name.append (cl_type.base_file_name)
							file_name.append (".o")
							string_list := object_baskets.item (cl_type.packet_number)
							string_list.extend (file_name)
							string_list.finish
						end
						types.forth
					end
				end
				i := i + 1
			end
		end;

	run_time: STRING is
			-- Run time with which the application must be linked
		do
			create Result.make (256)
			
			if System.has_dynamic_runtime then
				Result.append ("-L")
			end
			
			Result.append (lib_location)

			if System.has_dynamic_runtime then
				Result.append (" -l")
			else
				Result.append ("$prefix")
			end

			if System.has_multithreaded then
				Result.append ("$mt_prefix")
			end

			Result.append ("$eiflib")

			if not System.has_dynamic_runtime then
				Result.append ("$suffix")
			end
			
			Result.append (boehm_library)
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
