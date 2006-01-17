indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Makefile generator for workbench mode C compilation

class WBENCH_MAKER

inherit
	MAKEFILE_GENERATOR
		redefine
			generate_specific_defines, generate_other_objects
		end;

create

	make

feature

	generate_compilation_rule is
			-- Generates the .c -> .o compilation rule
		do
			Make_file.put_string ("%
				%%N.SUFFIXES:.cpp .o%N%N%
				%.c.o:%N%
				%%T$(CC) $(CFLAGS) -c $<%N%N%
				%.cpp.o:%N%
				%%T$(CPP) $(CPPFLAGS) -c $<%N%N");
		end;

	generate_specific_defines is
			-- Generate specific "-D" flags.
			-- In this case "-DWORKBENCH"
		do
			Make_file.put_string ("-DWORKBENCH ");
		end;

	add_specific_objects is
			-- Add workbench mode specific files to the object list
		do
			add_in_primary_system_basket (Eoption);
			add_in_primary_system_basket (Epattern);
			add_in_primary_system_basket (Efrozen);
			add_in_primary_system_basket (Ecall);
		end;

	add_cecil_objects is
		local
			cecil_basket: LINKED_LIST [STRING]
		do
			if not System.has_multithreaded then
				cecil_basket := cecil_rt_basket
				cecil_basket.extend ("network.o"); cecil_basket.finish
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
				cecil_basket.extend ("wmisc.o"); cecil_basket.finish
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
				cecil_basket.extend ("wcompress.o"); cecil_basket.finish
				cecil_basket.extend ("wconsole.o"); cecil_basket.finish
				cecil_basket.extend ("wpath_name.o"); cecil_basket.finish
				cecil_basket.extend ("wobject_id.o"); cecil_basket.finish
				cecil_basket.extend ("weif_threads.o"); cecil_basket.finish
				cecil_basket.extend ("weif_rw_lock.o"); cecil_basket.finish
				cecil_basket.extend ("wgen_conf.o"); cecil_basket.finish
				cecil_basket.extend ("weif_type_id.o"); cecil_basket.finish
				cecil_basket.extend ("wrout_obj.o"); cecil_basket.finish
				cecil_basket.extend ("weif_project.o"); cecil_basket.finish
				cecil_basket.extend ("idrs.o"); cecil_basket.finish
			else
				cecil_basket := cecil_rt_basket
				cecil_basket.extend ("MTnetwork.o"); cecil_basket.finish
				cecil_basket.extend ("MTwmalloc.o"); cecil_basket.finish
				cecil_basket.extend ("MTwgarcol.o"); cecil_basket.finish
				cecil_basket.extend ("MTwlocal.o"); cecil_basket.finish
				cecil_basket.extend ("MTwexcept.o"); cecil_basket.finish
				cecil_basket.extend ("MTwstore.o"); cecil_basket.finish
				cecil_basket.extend ("MTwretrieve.o"); cecil_basket.finish
				cecil_basket.extend ("MTwhash.o"); cecil_basket.finish
				cecil_basket.extend ("MTwtraverse.o"); cecil_basket.finish
				cecil_basket.extend ("MTwhashin.o"); cecil_basket.finish
				cecil_basket.extend ("MTwtools.o"); cecil_basket.finish
				cecil_basket.extend ("MTwinternal.o"); cecil_basket.finish
				cecil_basket.extend ("MTwplug.o"); cecil_basket.finish
				cecil_basket.extend ("MTwcopy.o"); cecil_basket.finish
				cecil_basket.extend ("MTwequal.o"); cecil_basket.finish
				cecil_basket.extend ("MTwlmalloc.o"); cecil_basket.finish
				cecil_basket.extend ("MTwout.o"); cecil_basket.finish
				cecil_basket.extend ("MTwtimer.o"); cecil_basket.finish
				cecil_basket.extend ("MTwurgent.o"); cecil_basket.finish
				cecil_basket.extend ("MTwsig.o"); cecil_basket.finish
				cecil_basket.extend ("MTwhector.o"); cecil_basket.finish
				cecil_basket.extend ("MTwcecil.o"); cecil_basket.finish
				cecil_basket.extend ("MTwbits.o"); cecil_basket.finish
				cecil_basket.extend ("MTwfile.o"); cecil_basket.finish
				cecil_basket.extend ("MTwdir.o"); cecil_basket.finish
				cecil_basket.extend ("MTwmisc.o"); cecil_basket.finish
				cecil_basket.extend ("MTwerror.o"); cecil_basket.finish
				cecil_basket.extend ("MTwumain.o"); cecil_basket.finish
				cecil_basket.extend ("MTwmemory.o"); cecil_basket.finish
				cecil_basket.extend ("MTwargv.o"); cecil_basket.finish
				cecil_basket.extend ("MTwboolstr.o"); cecil_basket.finish
				cecil_basket.extend ("MTwsearch.o"); cecil_basket.finish
				cecil_basket.extend ("MTwmain.o"); cecil_basket.finish
				cecil_basket.extend ("MTdebug.o"); cecil_basket.finish
				cecil_basket.extend ("MTinterp.o"); cecil_basket.finish
				cecil_basket.extend ("MTwoption.o"); cecil_basket.finish
				cecil_basket.extend ("MTupdate.o"); cecil_basket.finish
				cecil_basket.extend ("MTwbench.o"); cecil_basket.finish
				cecil_basket.extend ("MTwrun_idr.o"); cecil_basket.finish
				cecil_basket.extend ("MTwcompress.o"); cecil_basket.finish
				cecil_basket.extend ("MTwconsole.o"); cecil_basket.finish
				cecil_basket.extend ("MTwpath_name.o"); cecil_basket.finish
				cecil_basket.extend ("MTwobject_id.o"); cecil_basket.finish
				cecil_basket.extend ("MTweif_threads.o"); cecil_basket.finish
				cecil_basket.extend ("MTweif_rw_lock.o"); cecil_basket.finish
				cecil_basket.extend ("MTwgen_conf.o"); cecil_basket.finish
				cecil_basket.extend ("MTweif_type_id.o"); cecil_basket.finish
				cecil_basket.extend ("MTwrout_obj.o"); cecil_basket.finish
				cecil_basket.extend ("MTweif_project.o"); cecil_basket.finish
				cecil_basket.extend ("MTidrs.o"); cecil_basket.finish
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
			class_array: ARRAY [CLASS_C];
			i, nb, packet_nb: INTEGER;
			string_list: LINKED_LIST [STRING]
		do
			from
				class_array := System.classes
				nb := Class_counter.count
				i := 1
			until
				i > nb
			loop
				a_class := class_array.item (i)
				if a_class /= Void and then a_class.has_types then
					from
						types := a_class.types;
						types.start
					until
						types.after
					loop
						cl_type := types.item;
						if (not cl_type.is_precompiled) then
							packet_nb := cl_type.packet_number
								-- C code
							object_name := cl_type.base_file_name;
							create file_name.make (16);
							file_name.append (object_name);
							file_name.append (".o");
							string_list := object_baskets.item (packet_nb)
							string_list.extend (file_name)
							string_list.finish

								-- Descriptor file
							create file_name.make (16);
							file_name.append (object_name);
							file_name.append_character (Descriptor_file_suffix);
							file_name.append (".o");
							string_list := object_baskets.item (packet_nb)
							string_list.extend (file_name)
							string_list.finish
						end;
						types.forth;
					end;
	
					if (not a_class.is_precompiled) then
							-- Feature table
						create file_name.make (16);
						file_name.append (a_class.base_file_name);
						file_name.append_integer (a_class.feature_table_file_id);
						file_name.append_character (Feature_table_file_suffix);
						file_name.append (".o");
						object_baskets.item (a_class.packet_number).extend (file_name);
					end;
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
			
			Result.append (Lib_location)
	
			if System.has_dynamic_runtime then
				Result.append (" -l")
			else
				Result.append ("$prefix")
			end
	
			if System.has_multithreaded then
				Result.append ("$mt_prefix")
			end
	
			Result.append ("$wkeiflib")
	
			if not System.has_dynamic_runtime then
				Result.append ("$suffix")
			end

			Result.append (boehm_library)
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
						Make_file.put_string ("%T%T");
						Make_file.put_string (dir.precompiled_preobj);
						Make_file.put_character (' ');
						Make_file.put_character (Continuation);
						Make_file.put_new_line
					end;
					precomp.forth
				end
			end;
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
