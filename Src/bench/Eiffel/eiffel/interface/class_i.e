-- Internal representation of a class. Instance of CLASS_I represent
-- non-compiled classes, but instance of CLASS_C already compiled
-- classes.

class CLASS_I 

inherit

	SHARED_ASSERTION_LEVEL;
	SHARED_TRACE_LEVEL;
	SHARED_OPTIMIZE_LEVEL;
	SHARED_DEBUG_LEVEL;
	SHARED_VISIBLE_LEVEL;
	SHARED_WORKBENCH;
	SYSTEM_CONSTANTS

creation

	make

	
feature 

	class_name: STRING;
			-- Class name

	visible_name: STRING;
			-- Visible name

	cluster: CLUSTER_I;
			-- Cluster to which the class belongs to

	base_name: STRING;
			-- Base file name of the class

	file_name: STRING is
			-- Full file name of the class
		do
			Result := clone (cluster.path)
			Result.extend (Directory_separator);
			Result.append (base_name)
		end;

	date: INTEGER;
			-- Date of the file

	changed: BOOLEAN;
			-- Must the class be recompiled ?

	pass2_done: BOOLEAN;
			-- Pass2 has been done?

	compiled_class: CLASS_C;
			-- Compiled class

	assertion_level: ASSERTION_I;
			-- Assertion checking level

	trace_level: TRACE_I;
			-- Tracing level

	optimize_level: OPTIMIZE_I;
			-- Optimization level

	debug_level: DEBUG_I;
			-- Debug level

	visible_level: VISIBLE_I;
			-- Visible level

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

	reset_options is
			-- Reset the option values of the class
		do
debug
	io.error.putstring ("reset_options: ");
	if class_name /= Void then
		io.error.putstring (class_name);
	end;
	io.error.new_line;
end;
			assertion_level := Default_level;
			trace_level := No_trace;
			optimize_level := No_optimize;
			debug_level := No_debug;
			visible_level := Visible_default;
		end;

	set_class_name (s: STRING) is
			-- Assign `s' to `class_name'.
		do
			class_name := s;
		end;

	set_base_name (s: STRING) is
			-- Assign `s' to `file_name'.
		do
			base_name := s;	
		end;

	set_cluster (c: like cluster) is
			-- Assign `c' to `cluster'.
		do
			cluster := c
		end;

	set_date is
			-- Assign `d' to `date'
		local
			str: ANY;
		do
			str := file_name.to_c;
			date := eif_date ($str);
		end;

	set_changed (b: BOOLEAN) is
			-- Assign `b' to `changed'.
		do
			changed := b;
		end;

	set_compiled_class (c: CLASS_C) is
			-- Assign `c' to `compiled_class'.
		do
			compiled_class := c;
		end;

	date_has_changed: BOOLEAN is
		local
			str: ANY;
			new_date: INTEGER
		do
			str := file_name.to_c;
			new_date := eif_date ($str);
			Result := new_date /= date;
		end;

feature -- Drag and drop

	stone: CLASSI_STONE is
		do
			!!Result.make (Current)
		end;

	append_clickable_name (a_clickable: CLICK_WINDOW) is
			-- Append the name ot the current class in `a_clickable'
		local
			c_name: STRING;
		do
			c_name := clone (class_name)
			c_name.to_upper;
			a_clickable.put_clickable_string (stone, c_name);
		end;

feature -- Compiled class

	class_to_recompile: CLASS_C is
			-- Instance of a class to remcompile
		require
			class_name_exists: class_name /= Void;
		local
			local_system: SYSTEM_I;
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
			else
				!!Result.make (Current);
			end;
		ensure
			Result_exists: Result /= Void;
		end;

	compiled: BOOLEAN is
			-- Is the class already compiled ?
		do
			Result := not (compiled_class = Void);
		end; -- compiled

feature -- Comveniences

	set_assertion_level (l: ASSERTION_I) is
			-- Assign `l' to `assertion_level'.
		do
			assertion_level := l;
debug
	io.error.putstring ("set_assertion_level (");
	io.error.putstring (class_name);
	io.error.putstring ("): ");
	l.trace;
end;
		end;

	set_trace_level (t: TRACE_I) is
			-- Assign `t' to `trace_level'.
		do
			trace_level := t;
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
		do
			if d.is_partial then
				if debug_level.is_partial then
					partial ?= debug_level;
					other_partial ?= d;
					partial.merge (other_partial);
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
				Result := class_name;
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
			optimize_level := other.optimize_level;
			assertion_level := other.assertion_level;
			visible_level := other.visible_level;
			visible_name := other.visible_name;
		end;

feature {NONE} -- Externals

	eif_date (s: POINTER): INTEGER is
			-- Date of file of name `str'.
		external
			"C"
		end;

end
