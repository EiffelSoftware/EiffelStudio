indexing

	description: 
		"Internal representation of a class. Instance of CLASS_I represent%
		%non-compiled classes, but instance of CLASS_C already compiled%
		%classes.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_I 

inherit

	SHARED_ASSERTION_LEVEL;
	SHARED_OPTION_LEVEL;
	SHARED_OPTIMIZE_LEVEL;
	SHARED_DEBUG_LEVEL;
	SHARED_VISIBLE_LEVEL;
	SHARED_WORKBENCH;
	SYSTEM_CONSTANTS;
	COMPARABLE
		undefine
			is_equal
		end;
	COMPILER_EXPORTER

creation {COMPILER_EXPORTER}

	make

creation 

	make_with_cluster

feature {NONE} -- Initialization

	make is
			-- initialization
		do
			reset_options;
			if not System.first_compilation then
					-- Time check and genericity (a generic parameter cannot
					-- have the same name as a class)
				System.record_new_class_i (Current)
			end;
		end;

	make_with_cluster (cluster_i: CLUSTER_I) is
			-- Set `cluster' to `cluster_i'.
		do
			make;
			set_cluster (cluster_i);
		end;

feature -- Properties

	name: STRING;
			-- Class name

	cluster: CLUSTER_I;
			-- Cluster to which the class belongs to

	base_name: STRING;
			-- Base file name of the class

	hidden: BOOLEAN;
			-- Is the class hidden in the precompilation sets?

	file_name: FILE_NAME is
			-- Full file name of the class
		do
			!! Result.make_from_string (cluster.path);
			Result.set_file_name (base_name);
		end;

	date: INTEGER;
			-- Date of the file

	compiled_class: CLASS_C;
			-- Compiled class

	assertion_level: ASSERTION_I;
			-- Assertion checking level

	trace_level: OPTION_I;
			-- Tracing level

	profile_level: OPTION_I;
			-- Profile level

	optimize_level: OPTIMIZE_I;
			-- Optimization level

	debug_level: DEBUG_I;
			-- Debug level

	visible_level: VISIBLE_I;
			-- Visible level

	set_base_name (s: STRING) is
			-- Assign `s' to `base_name'.
		do
			base_name := s;	
		end;

	text: STRING is
			-- Text of the Current lace file.
			-- Void if unreadable file
		require
			valid_file_name: file_name /= Void
		local
			a_file: RAW_FILE
		do
			!! a_file.make (file_name);
			if a_file.exists and then a_file.is_readable then
				a_file.open_read;
				a_file.readstream (a_file.count);
				a_file.close;
				Result := clone (a_file.laststring)
			end
		end;

	hide_implementation: BOOLEAN is
			-- Hide the implementation code of 
			-- precompiled classes?
		do
			Result := cluster.hide_implementation
		end

feature -- Access

	compiled: BOOLEAN is
			-- Is the class already compiled ?
		do
			Result := compiled_class /= Void;
		ensure
			compiled: Result implies compiled_class /= Void
		end; 

	date_has_changed: BOOLEAN is
		local
			str: ANY;
		do
			str := file_name.to_c;
			Result := eif_date ($str) /= date;
		end;

feature -- Setting

	set_name (s: like name) is
			-- Assign `s' to `name'.
		do
			name := s;
		ensure
			set: name = s
		end;

	set_file_details (s: like name; b: STRING) is 
			-- Assign `s' to name, `b' to base_name, and
			-- set date of insertion.
		do
			set_name (s);
			set_base_name (b);
			set_date;
		end;

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Class name alphabetic order
		do
			Result := name < other.name
		end;

feature -- Output

	append_name (st: STRUCTURED_TEXT) is
			-- Append the name ot the current class in `a_clickable'
		require
			non_void_st: st /= Void
		local
			c_name: STRING;
		do
			c_name := clone (name)
			c_name.to_upper;
			st.add_classi (Current, c_name) 
		end;

feature {COMPILER_EXPORTER} -- Properties

	visible_name: STRING;
			-- Visible name

	changed: BOOLEAN;
			-- Must the class be recompiled ?

	pass2_done: BOOLEAN;
			-- Pass2 has been done?

feature {COMPILER_EXPORTER} -- Setting

	reset_options is
			-- Reset the option values of the class
		do
debug
	io.error.putstring ("reset_options: ");
	if name /= Void then
		io.error.putstring (name);
	end;
	io.error.new_line;
end;
			assertion_level := Default_level;
			trace_level := No_option;
			profile_level := No_option;
			optimize_level := No_optimize;
			debug_level := No_debug;
			visible_level := Visible_default;
			hidden := False
		end;

	set_changed (b: BOOLEAN) is
			-- Assign `b' to `changed'.
		do
			changed := b;
		end;

	set_compiled_class (c: CLASS_C) is
			-- Assign `c' to `compiled_class'.
		require
			non_void_c: c /= Void
		do
			compiled_class := c
		ensure
			compiled_class = c
		end;

	reset_compiled_class is
			-- Reset `compiled_class' to Void.
		do
			compiled_class := Void
		ensure
			void_compiled_class: compiled_class = Void
		end;

	set_date is
			-- Assign `d' to `date'
		local
			str: ANY;
		do
			str := file_name.to_c;
			date := eif_date ($str);
		end;

	set_cluster (c: like cluster) is
			-- Assign `c' to `cluster'.
		do
			cluster := c
		end;

feature {COMPILER_EXPORTER} -- Compiled class

	class_to_recompile: CLASS_C is
			-- Instance of a class to remcompile
		require
			name_exists: name /= Void;
		local
			local_system: SYSTEM_I
		do
			local_system := system;
			if Current = local_system.boolean_class then
				!BOOLEAN_B! Result.make (Current)
			elseif Current = local_system.character_class then
				!CHARACTER_B! Result.make (Current)
			elseif Current = local_system.integer_class then
				!INTEGER_B! Result.make (Current)
			elseif Current = local_system.real_class then
				!REAL_B! Result.make (Current)
			elseif Current = local_system.double_class then
				!DOUBLE_B! Result.make (Current)
			elseif Current = local_system.pointer_class then
				!POINTER_B! Result.make (Current)
			elseif Current = local_system.any_class then
				!ANY_B! Result.make (Current)
			elseif Current = local_system.special_class then
				!SPECIAL_B! Result.make (Current)
			elseif Current = local_system.to_special_class then
				!TO_SPECIAL_B! Result.make (Current)
			elseif Current = local_system.array_class then
				!ARRAY_CLASS_B! Result.make (Current)
			elseif Current = local_system.string_class then
				!STRING_CLASS_B! Result.make (Current)
			elseif Current = local_system.character_ref_class then
				!CHARACTER_REF_B! Result.make (Current)
			elseif Current = local_system.boolean_ref_class then
				!BOOLEAN_REF_B! Result.make (Current)
			elseif Current = local_system.integer_ref_class then
				!INTEGER_REF_B! Result.make (Current)
			elseif Current = local_system.real_ref_class then
				!REAL_REF_B! Result.make (Current)
			elseif Current = local_system.double_ref_class then
				!DOUBLE_REF_B! Result.make (Current)
			elseif Current = local_system.pointer_ref_class then
				!POINTER_REF_B! Result.make (Current)
			elseif Current = local_system.tuple_class then
				!TUPLE_CLASS_B! Result.make (Current)
			else
				!! Result.make (Current);
			end;
		ensure
			Result_exists: Result /= Void;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_assertion_level (l: ASSERTION_I) is
			-- Assign `l' to `assertion_level'.
		do
			assertion_level := l;
debug
	io.error.putstring ("set_assertion_level (");
	io.error.putstring (name);
	io.error.putstring ("): ");
	l.trace;
end;
		end;

	set_trace_level (t: like trace_level) is
			-- Assign `t' to `trace_level'.
		do
			trace_level := t;
		end;

	set_profile_level (t: like profile_level) is
			-- Assign `t' to `trace_level'.
		do
			profile_level := t;
		end;

	set_hide_level (b: BOOLEAN) is
			-- Assign `b' to `hidden'.
		do
			hidden := b
debug ("HIDE_OPTION")
	io.error.putstring ("class name: ");
	io.error.putstring (name);
	io.error.putstring (" is_hidden: ");
	io.error.putbool (hidden);
	io.error.new_line;
end;
		end;

	set_optimize_level (o: OPTIMIZE_I) is
			-- Assign `o' to `optimize_level'.
		do
			optimize_level := o;
		end;

	set_debug_level (d: DEBUG_I) is
			-- Assign `d' to `debug_level'.
		local
			other_partial, partial: DEBUG_TAG_I;
			new_partial: DEBUG_TAG_I
		do
			if d.is_partial then
				if debug_level.is_partial then
					partial ?= debug_level;
					other_partial ?= d;
					!! new_partial.make;
					new_partial.merge (partial);
					new_partial.merge (other_partial);
					debug_level := new_partial;
				else
					debug_level := d;
				end;
			else
				debug_level := d;
			end;
		end;

	set_visible_level (v: VISIBLE_I) is
			-- Assign `v' to `visible_level'.
		do
			visible_level := v;
		end;

	set_visible_name (s: STRING) is
			-- Assign `s' to `visible_name'.
		do
			visible_name := s;
		end;

	external_name: STRING is
			-- Name of the class for the external environment
		do
			if visible_name = Void then
				Result := name;
			else
				Result := visible_name;
			end;
		end;

	copy_options (other: CLASS_I) is
			-- Copy compilation options from `other' into Current.
		require
			good_argument: not (other = Void);
		do
			debug_level := other.debug_level;
			trace_level := other.trace_level;
			profile_level := other.profile_level;
			optimize_level := other.optimize_level;
			assertion_level := other.assertion_level;
			visible_level := other.visible_level;
			visible_name := other.visible_name;
			hidden := other.hidden;
		end;

feature -- Document processing

	document_file_name: FILE_NAME is
			-- File name specified for the document
			-- (.e is removed from end)
		local
			bname: STRING;
			tmp: STRING
			d_name: DIRECTORY_NAME;
			i: INTEGER;
		do
			d_name := cluster.document_path;
			if d_name /= Void then
				!! Result.make_from_string (d_name);
				bname := clone (base_name);
				i := bname.count;
				if 
					i > 2 and then
					bname.item (i - 1) = Dot and then
					valid_class_file_extension (bname.item (i))
				then
					bname.head (i - 2);
				end;
				Result.set_file_name (bname)
			end
		end

feature {NONE} -- Document processing

	No_word: STRING is "no"

feature {NONE} -- Implementation

	valid_class_file_extension (c: CHARACTER): BOOLEAN is
			-- Is `c' a valid class file extension?
		do
			Result := c = 'e' or c = 'E'
		end

feature {NONE} -- Externals

	eif_date (s: POINTER): INTEGER is
			-- Date of file of name `str'.
		external
			"C"
		end

end -- class CLASS_I
