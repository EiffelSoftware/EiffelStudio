class PROFILE_SET

creation
	make

feature -- Creation

	make is
			-- Creation feature
		do
			!! eiffel_profiling_list.make;
			!! c_profiling_list.make;
			!! cycle_profiling_list.make;
			calls_min_eiffel := -1;
			calls_min_c := -1;
			calls_min_cycle := -1;
		end;
		
feature -- Iteration

	start is
			-- Set `item' to first item in the set.
		do
			eiffel_profiling_list.start;
			c_profiling_list.start;
			cycle_profiling_list.start;
		end;

	finish is
			-- Set `item' to last item in the set.
		do
			eiffel_profiling_list.finish;
			eiffel_profiling_list.forth;
			c_profiling_list.finish;
			c_profiling_list.forth;
			cycle_profiling_list.finish;
		end;

	forth is
			-- Make next item the current.
		require
			not_after: not after;
		do
			if not eiffel_profiling_list.after then
				eiffel_profiling_list.forth;
			else
				if not c_profiling_list.after then
					c_profiling_list.forth;
				else
					if not cycle_profiling_list.after then
						cycle_profiling_list.forth;
					end;
				end;
			end;
		end;

	back is
			-- Make previous item the current.
		require
			not_before: not before;
		do
			if not cycle_profiling_list.before then
				cycle_profiling_list.back;
			else
				if not c_profiling_list.before then
					c_profiling_list.back;
				else
					if not eiffel_profiling_list.before then
						eiffel_profiling_list.back;
					end;
				end;
			end;
		end;

	after: BOOLEAN is
			-- Is there no next item left?
		do
			Result := eiffel_profiling_list.after and then
						c_profiling_list.after and then
						cycle_profiling_list.after;
		end;

	before: BOOLEAN is
			-- Is there no previous item left?
		do
			Result := cycle_profiling_list.before and then
						c_profiling_list.before and then
						eiffel_profiling_list.before;
		end;

	item: PROFILE_DATA is
			-- The current item.
		do
			if not eiffel_profiling_list.after then
				Result := eiffel_profiling_list.item;
			else
				if not c_profiling_list.after then
					Result := c_profiling_list.item; 
				else
					if not cycle_profiling_list.after then
						Result := cycle_profiling_list.item;
					end;
				end;
			end;
		end;

feature {FILTER} -- Adding

	insert_unknown_profile_data (data: PROFILE_DATA) is
			-- Puts `data' in the set.
		local
			ed: EIFFEL_PROFILE_DATA;
			cyd: CYCLE_PROFILE_DATA;
			cd: C_PROFILE_DATA;
		do
			ed ?= data;
			if ed /= Void then
				insert_eiffel_profiling_data (ed);
			end;

			cd ?= data;
			if cd /= Void then
				insert_c_profiling_data (cd);
			end;

			cyd ?= data;
			if cyd /= Void then
				insert_cycle_profiling_data (cyd);
			end;
		end;

feature {PROFILE_INFORMATION, FILTER} -- Adding

	insert_eiffel_profiling_data (data: EIFFEL_PROFILE_DATA) is
		do
			eiffel_profiling_list.extend (data);
			update_eiffel (data);
		end;

	insert_c_profiling_data (data: C_PROFILE_DATA) is
		do
			c_profiling_list.extend (data);
			update_c (data);
		end;

	insert_cycle_profiling_data (data: CYCLE_PROFILE_DATA) is
		do
			cycle_profiling_list.extend (data);
			update_cycle (data);
		end;

	add_function_to_cycle (function: FUNCTION; number: INTEGER) is
		local
			function_added: BOOLEAN;
		do
			from
				cycle_profiling_list.start;
			until
				cycle_profiling_list.after or else function_added
			loop
				if cycle_profiling_list.item.number = number then
					cycle_profiling_list.item.add_function (function);
					function_added := true;
				else
					cycle_profiling_list.forth;
				end;
			end;
		end;

	has_cycle (number: INTEGER): BOOLEAN is
		do
			from
				cycle_profiling_list.start;
			until
				cycle_profiling_list.after or else Result
			loop
				if cycle_profiling_list.item.number = number then
					Result := true;
				else
					cycle_profiling_list.forth;
				end;
			end;
		end;

	stop_computation is
			-- Stops computation i.e. computes the averages.
		local
			calls_avg_eiffel_real,
			calls_avg_c_real,
			calls_avg_cycle_real: REAL
			count: INTEGER;
		do
			count := eiffel_profiling_list.count;
			if count > 0 then
				percentage_avg_eiffel := percentage_avg_eiffel / count;
				total_avg_eiffel := total_avg_eiffel / count;
				self_avg_eiffel := self_avg_eiffel / count;
				descendents_avg_eiffel := descendents_avg_eiffel / count;
				calls_avg_eiffel_real := calls_avg_eiffel / count;
				calls_avg_eiffel := calls_avg_eiffel_real.truncated_to_integer;
			end;

			count := c_profiling_list.count;
			if count > 0 then
				percentage_avg_c := percentage_avg_c / count;
				total_avg_c := total_avg_c / count;
				self_avg_c := self_avg_c / count;
				descendents_avg_c := descendents_avg_eiffel / count;
				calls_avg_c_real := calls_avg_c / count;
				calls_avg_c := calls_avg_c_real.truncated_to_integer;
			end;

			count := cycle_profiling_list.count;
			if count > 0 then
				percentage_avg_cycle := percentage_avg_cycle / count;
				total_avg_cycle := total_avg_cycle / count;
				self_avg_cycle := self_avg_cycle / count;
				descendents_avg_cycle := descendents_avg_cycle / count;
				calls_avg_cycle_real := calls_avg_cycle / count;
				calls_avg_cycle := calls_avg_cycle_real.truncated_to_integer;
			end;
		end;

feature -- Status report

	number_of_feature_calls: INTEGER is
			-- Number of calls to Eiffel features
		do
			from
				eiffel_profiling_list.start;
			until
				eiffel_profiling_list.after
			loop
				Result := Result + eiffel_profiling_list.item.number_of_calls;
				eiffel_profiling_list.forth;
			end;
		end;

	number_of_function_calls: INTEGER is
			-- Number of calls to C functions
		do
			from
				c_profiling_list.start;
			until
				c_profiling_list.after
			loop
				Result := Result + c_profiling_list.item.number_of_calls;
				c_profiling_list.forth;
			end;
		end;

	number_of_cycles: INTEGER is
			-- Number of cycles detected during the run.
		do
			Result := cycle_profiling_list.count;
		end;

	number_of_eiffel_features: INTEGER is
			-- Number of Eiffel features called during the run.
		do
			Result := eiffel_profiling_list.count;
		end;

	number_of_c_functions: INTEGER is
			-- Number of C functions called during the run.
		do
			Result := c_profiling_list.count;
		end;

feature -- Attributes

	eiffel_profiling_list: TWO_WAY_LIST [EIFFEL_PROFILE_DATA]
		-- Profiling data of all Eiffel features

	c_profiling_list: TWO_WAY_LIST [C_PROFILE_DATA]
		-- Profiling data of all C functions

	cycle_profiling_list: TWO_WAY_LIST [CYCLE_PROFILE_DATA]
		-- Profiling data of all cycles

feature {NONE} -- Implementation

	init_eiffel (data: EIFFEL_PROFILE_DATA) is
			-- Initialization of column-attributes for the
			-- language Eiffel.
		do
			calls_min_eiffel := data.number_of_calls;
			calls_max_eiffel := data.number_of_calls;
			calls_avg_eiffel := data.number_of_calls;
			percentage_min_eiffel := data.percentage;
			percentage_max_eiffel := data.percentage;
			percentage_avg_eiffel := data.percentage;
			descendents_min_eiffel := data.descendents_sec;
			descendents_max_eiffel := data.descendents_sec;
			descendents_avg_eiffel := data.descendents_sec;
			self_min_eiffel := data.self_sec;
			self_max_eiffel := data.self_sec;
			self_avg_eiffel := data.self_sec;
			total_min_eiffel := data.total_sec;
			total_max_eiffel := data.total_sec;
			total_avg_eiffel := data.total_sec;
		end;

	init_c (data: C_PROFILE_DATA) is
			-- Initialization of column-attributes for the
			-- language C.
		do
			calls_min_c := data.number_of_calls;
			calls_max_c := data.number_of_calls;
			calls_avg_c := data.number_of_calls;
			percentage_min_c := data.percentage;
			percentage_max_c := data.percentage;
			percentage_avg_c := data.percentage;
			descendents_min_c := data.descendents_sec;
			descendents_max_c := data.descendents_sec;
			descendents_avg_c := data.descendents_sec;
			self_min_c := data.self_sec;
			self_max_c := data.self_sec;
			self_avg_c := data.self_sec;
			total_min_c := data.total_sec;
			total_max_c := data.total_sec;
			total_avg_c := data.total_sec;
		end;

	init_cycle (data: CYCLE_PROFILE_DATA) is
			-- Initialization of column-attributes for the
			-- cycles.
		do
			calls_min_cycle := data.number_of_calls;
			calls_max_cycle := data.number_of_calls;
			calls_avg_cycle := data.number_of_calls;
			percentage_min_cycle := data.percentage;
			percentage_max_cycle := data.percentage;
			percentage_avg_cycle := data.percentage;
			descendents_min_cycle := data.descendents_sec;
			descendents_max_cycle := data.descendents_sec;
			descendents_avg_cycle := data.descendents_sec;
			self_min_cycle := data.self_sec;
			self_max_cycle := data.self_sec;
			self_avg_cycle := data.self_sec;
			total_min_cycle := data.total_sec;
			total_max_cycle := data.total_sec;
			total_avg_cycle := data.total_sec;
		end;

	update_eiffel (data: EIFFEL_PROFILE_DATA) is
			-- Updates all column-attributes for the language
			-- Eiffel.
		do
			if calls_min_eiffel = -1 then
				init_eiffel (data);
			else
				if data.number_of_calls < calls_min_eiffel then
					calls_min_eiffel := data.number_of_calls;
				end;
				if data.number_of_calls > calls_max_eiffel then
					calls_max_eiffel := data.number_of_calls;
				end;
				calls_avg_eiffel := calls_avg_eiffel + data.number_of_calls;
				if data.descendents_sec < descendents_min_eiffel then
					descendents_min_eiffel := data.descendents_sec;
				end;
				if data.descendents_sec > descendents_max_eiffel then
					descendents_max_eiffel := data.descendents_sec;
				end;
				descendents_avg_eiffel := descendents_avg_eiffel + data.descendents_sec;
				if data.self_sec < self_min_eiffel then
					self_min_eiffel := data.self_sec;
				end;
				if data.self_sec > self_max_eiffel then
					self_max_eiffel := data.self_sec;
				end;
				self_avg_eiffel := self_avg_eiffel + data.self_sec;
				if data.total_sec < total_min_eiffel then
					total_min_eiffel := data.total_sec;
				end;
				if data.total_sec > total_max_eiffel then
					total_max_eiffel := data.total_sec;
				end;
				total_avg_eiffel := total_avg_eiffel + data.total_sec;
				if data.percentage < percentage_min_eiffel then
					percentage_min_eiffel := data.percentage;
				end;
				if data.percentage > percentage_max_eiffel then
					percentage_max_eiffel := data.percentage;
				end;
				percentage_avg_eiffel := percentage_avg_eiffel + data.percentage;
			end;
		end;

	update_c (data: C_PROFILE_DATA) is
			-- Updates all column-attributes for the language C.
		do
			if calls_min_c = -1 then
				init_c (data);
			else
				if data.number_of_calls < calls_min_c then
					calls_min_c := data.number_of_calls;
				end;
				if data.number_of_calls > calls_max_c then
					calls_max_c := data.number_of_calls;
				end;
				calls_avg_c := calls_avg_c + data.number_of_calls;
				if data.descendents_sec < descendents_min_c then
					descendents_min_c := data.descendents_sec;
				end;
				if data.descendents_sec > descendents_max_c then
					descendents_max_c := data.descendents_sec;
				end;
				descendents_avg_c := descendents_avg_eiffel + data.descendents_sec;
				if data.self_sec < self_min_c then
					self_min_c := data.self_sec;
				end;
				if data.self_sec > self_max_c then
					self_max_c := data.self_sec;
				end;
				self_avg_c := self_avg_c + data.self_sec;
				if data.total_sec < total_min_c then
					total_min_c := data.total_sec;
				end;
				if data.total_sec > total_max_c then
					total_max_c := data.total_sec;
				end;
				total_avg_c := total_avg_c + data.total_sec;
				if data.percentage < percentage_min_c then
					percentage_min_c := data.percentage;
				end;
				if data.percentage > percentage_max_c then
					percentage_max_c := data.percentage;
				end;
				percentage_avg_c := percentage_avg_c + data.percentage;
			end;
		end;

	update_cycle (data: CYCLE_PROFILE_DATA) is
			-- Updates all column-attributes for the Cycles.
		do
			if calls_min_cycle = -1 then
				init_cycle (data);
			else
				if data.number_of_calls < calls_min_cycle then
					calls_min_cycle := data.number_of_calls;
				end;
				if data.number_of_calls > calls_max_cycle then
					calls_max_cycle := data.number_of_calls;
				end;
				calls_avg_cycle := calls_avg_cycle + data.number_of_calls;
				if data.descendents_sec < descendents_min_cycle then
					descendents_min_cycle := data.descendents_sec;
				end;
				if data.descendents_sec > descendents_max_cycle then
					descendents_max_cycle := data.descendents_sec;
				end;
				descendents_avg_cycle := descendents_avg_cycle + data.descendents_sec;
				if data.self_sec < self_min_cycle then
					self_min_cycle := data.self_sec;
				end;
				if data.self_sec > self_max_cycle then
					self_max_cycle := data.self_sec;
				end;
				self_avg_cycle := self_avg_cycle + data.self_sec;
				if data.total_sec < total_min_cycle then
					total_min_cycle := data.total_sec;
				end;
				if data.total_sec > total_max_cycle then
					total_max_cycle := data.total_sec;
				end;
				total_avg_cycle := total_avg_cycle + data.total_sec;
				if data.percentage < percentage_min_cycle then
					percentage_min_cycle := data.percentage;
				end;
				if data.percentage > percentage_max_cycle then
					percentage_max_cycle := data.percentage;
				end;
				percentage_avg_cycle := percentage_avg_cycle + data.percentage;
			end;
		end;

feature {QUERY_EXECUTER} -- Column-Attributes

	-- column-attributes: min, max, avg per column means
	-- calls_min_eiffel, percentage_min_eiffel, etc.
	-- calls_max_eiffel, percentage_max_eiffel, etc.
	-- calls_avg_eiffel, percentage_avg_eiffel, etc.
	-- These attributes spawn also the languages.
	--
	-- Both the min and amx attributes are computed during
	-- the calls to the update features.
	--
	-- However, avg is first a summerization of all values,
	-- and when compute_avg is called, the avg-attributes are
	-- divided by the number of elements, which is the count
	-- of the list. This way of computing the average is
	-- mathematical and statistical correct for each sample-item
	-- has the same weight: 1.

	calls_min_eiffel,
	calls_max_eiffel,
	calls_avg_eiffel,
	calls_min_c,
	calls_max_c,
	calls_avg_c,
	calls_min_cycle,
	calls_max_cycle,
	calls_avg_cycle: INTEGER

	percentage_min_eiffel,
	percentage_max_eiffel,
	percentage_avg_eiffel,
	descendents_min_eiffel,
	descendents_max_eiffel,
	descendents_avg_eiffel,
	self_min_eiffel,
	self_max_eiffel,
	self_avg_eiffel,
	total_min_eiffel,
	total_max_eiffel,
	total_avg_eiffel,
	percentage_min_c,
	percentage_max_c,
	percentage_avg_c,
	descendents_min_c,
	descendents_max_c,
	descendents_avg_c,
	self_min_c,
	self_max_c,
	self_avg_c,
	total_min_c,
	total_max_c,
	total_avg_c,
	percentage_min_cycle,
	percentage_max_cycle,
	percentage_avg_cycle,
	descendents_min_cycle,
	descendents_max_cycle,
	descendents_avg_cycle,
	self_min_cycle,
	self_max_cycle,
	self_avg_cycle,
	total_min_cycle,
	total_max_cycle,
	total_avg_cycle: REAL

end -- class PROFILE_SET
