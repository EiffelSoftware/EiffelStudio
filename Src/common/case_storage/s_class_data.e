class S_CLASS_DATA

inherit

	STORABLE;
	S_LINKABLE_DATA
		rename
			make as old_make
		redefine
			chart, set_chart
		end;
	S_CASE_INFO

creation

	make

feature

	id: INTEGER;
			-- Id of Current

	feature_number: INTEGER;
			-- Number of created features

	generics: FIXED_LIST [S_GENERIC_DATA];
			-- Number of generic parameters

	is_deferred: BOOLEAN;
			-- Is the current class deferred?

	is_effective: BOOLEAN;
			-- Is the current class an effecting a deferred class ?

	is_interfaced: BOOLEAN
			-- Is the current class interfaced with externals ?

	is_persistent: BOOLEAN;
			-- Does the current class have persistant instances ?

	is_reused: BOOLEAN;
			-- Is the current class already implemented
			-- in a previous project and reused in the current one.

	is_root: BOOLEAN;
			-- Is the current class the root of
			-- the system ?

feature

	set_booleans (is_d, is_e, is_i, is_p, is_re, is_ro: BOOLEAN) is
			-- Set all booleans for Current.
		do
			is_deferred := is_d;
			is_effective := is_e;
			is_interfaced := is_i;
			is_persistent := is_p;
			is_reused := is_re;
			is_root := is_ro;
		ensure
			booleans_are_set: is_deferred = is_d and then
								is_effective = is_e and then
								is_interfaced = is_i and then
								is_persistent = is_p and then
								is_reused = is_re and then
								is_root = is_ro;
		end;

    set_id (i: INTEGER) is
            -- Set id to `i'.
        require
            valid_i: i > 0
        do
            id := i
        ensure
            id_set: id = i
        end;
 
	set_is_effective is
			-- Set is_effective to `true'.
		do
			is_effective := True
		ensure
			is_effective: is_effective
		end;

	set_generics (l: like generics) is
			-- Set generics to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty;
			not_have_void: not l.has (Void)
		do
			generics := l
		ensure
			generics_set: generics = l
		end;

	set_feature_number (i: INTEGER) is
			-- Set feature_number to `i'.
		do
			feature_number := i
		end;


feature {NONE}

	disk_content: S_CLASS_CONTENT;
			-- Information stored to disk

	make (a_name: STRING) is
		do
			old_make (a_name);
			!! disk_content;
		end;

feature

	features: ARRAYED_LIST [S_FEATURE_DATA] is
			-- Features of class
		do
			Result := disk_content.features
		end;
 
	invariants: FIXED_LIST [S_ASSERTION_DATA] is
			-- Invariants of the current class
		do
			Result := disk_content.invariants
		end;
 
	chart: S_CLASS_CHART is
			-- Informal description of Current class
		do
			Result := disk_content.chart
		end;

	set_features (l: like features) is
			-- Set features to `l'.
			--| Allow empty features to be stored
			--| to disk (because of bench).
		require
			valid_l: l /= Void;
		do
			disk_content.set_features (l)
		ensure
			features_set: features = l
		end;
 
	set_invariants (l: like invariants) is
			-- Set invariants to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty;
			not_have_void: not l.has (Void)
		do
			disk_content.set_invariants (l)
		ensure
			invariants_set: invariants = l
		end;
 
	set_chart (ch: like chart) is
			-- Set chart to `ch'.
		do
			disk_content.set_chart (ch);
		end;

feature -- Storing

	store_to_disk (storage_path: STRING) is
			-- Store internal information to disk.
		require
			valid_path: storage_path /= Void;
			valid_view_id: view_id > 0
		local
			internal_file: RAW_FILE;
			path: STRING;
			dir: DIRECTORY
		do
			path := clone (storage_path);
			path.extend (Operating_environment.directory_separator);
			path.append_integer (directory_number (view_id));
			!! dir.make (path);
			if not dir.exists then
				dir.create
			end;
			path.extend (Operating_environment.directory_separator);
			path.append_integer (view_id);
			!! internal_file.make_open_write (path);
			independent_store (internal_file);
			internal_file.close;
			disk_content := Void;
		ensure
			disk_content_is_void: disk_content = Void
		end;

	retrieve_from_disk (p: STRING) is
			-- Retrieve internal information from disk.
		require
			valid_path: p /= Void;
			valid_view_id: view_id > 0
		local
			internal_file: RAW_FILE;
			path: STRING
		do
			path := clone (p);
			path.append_integer (directory_number (view_id));
			path.extend (Operating_environment.directory_separator);
			path.append_integer (view_id);
			!! internal_file.make (p);
			if internal_file.exists and then internal_file.is_readable then
				internal_file.open_read;
				disk_content ?= retrieved (internal_file);
				check
					valid_disk_content: disk_content /= Void
				end
			else
				io.error.putstring ("Error in retrieving file %N");
				io.error.putstring (p);
				io.error.new_line
			end
		end;

	wipe_out_information is
			-- Wipe out information that is not needed.
		do
			disk_content := Void
		ensure
			disk_content_is_void: disk_content = Void
		end;

	is_valid: BOOLEAN is
			-- Is Current valid after the retrieve ?
		do
			Result := disk_content /= Void
		end

end
