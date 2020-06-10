note
	description: "Object {ESA_USER_AGENT} responsible to detect the user agent, operating system, 32 or 64 bits."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Wikipedia", "src=http://en.wikipedia.org/wiki/User_agent", "protocol=url"
	EIS: "name=Browser detection using user agent","src=https://developer.mozilla.org/en-US/docs/Browser_detection_using_the_user_agent", "protocol=url"
	EIS: "name=Inspired by code at","src=https://github.com/JustinAzoff/splunk-scripts/blob/master/ua2os.py", "protocol=url"
	EIS: "name=Inspired by code at","src=https://github.com/barisaydinoglu/Detectizr/blob/master/src/detectizr.js", "protocol=url"


class
	ESA_USER_AGENT

create
	make_from_string

feature {NONE} -- Initialization

	make_from_string (a_user_agent_string: detachable READABLE_STRING_8)
		do
			if a_user_agent_string = Void then
				create user_agent.make_empty
			else
				create user_agent.make_from_string (a_user_agent_string)
			end
			analyze
		end

	analyze
			-- Analyze `user_agent'.
		local
			s: READABLE_STRING_8
		do
			s := user_agent.as_lower
			get_address_register_size (s)
			get_os_family (s)
		end

feature -- Access

	user_agent: IMMUTABLE_STRING_8
			-- USER AGENT text.
			-- ex: Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.104 Safari/537.36

	address_register_size: READABLE_STRING_32
			-- Current architecture 32 or 64 bits.

	os_family: READABLE_STRING_32
			-- Current OS platform.

feature -- Query

	is_64bits: BOOLEAN
			-- Is a 64bits address register?
		do
			Result := address_register_size ~ x64_address_register_size
		end

	is_32bits: BOOLEAN
			-- Is a 32bits address register?
		do
			Result := address_register_size ~ x32_address_register_size
		end

	is_windows_os: BOOLEAN
			-- Is detected OS a Windows ?
		do
			Result := os_family ~ windows_os_family_name
		end

	is_mac_os: BOOLEAN
			-- Is detected OS a MacOS ?
		do
			Result := os_family ~ mac_os_family_name
		end

	is_linux_os: BOOLEAN
			-- Is detected OS a Linux ?
		do
			Result := os_family ~ linux_os_family_name
		end

feature -- Change Element

	get_address_register_size (a_user_agent: READABLE_STRING_8)
			--arch_mapping = (
			--    ('Windows .. 5.2',                 'x64'),
			--    ('x64',                     		'x64'),
			--    ('Win64',                          'x64'),
			--    ('Windows .. 6.1.*WOW64',                   'x64'),
			--    ('Windows .. 6.([012])\; Trident/',         'i386'),
			--    ('i386',               	 		'i386'),
			--    ('i686',                                    'i686'),
			--    ('x86_64',              			'x64'),
			--    ('amd64',                                   'x64'),
			--    ('PPC',                 			'PowerPC'),
			--    ('Power.{1,3}Macint',   			'PowerPC'),
			--    ('droid',               			'android'),
			--    ('iPad',                			'ipad'),
			--    ('iPod',                			'ipod'),
			--    ('iPhone',              			'iphone'),
			--    ('Intel',               			'Intel'),
			--    ('BlackBerry (\d+)',          		'BlackBerry %s'),
			--    ('BlackBerry',				'BlackBerry'),
			--    ('BB10',                                    'BlackBerry 10'),
			--    ('Playbook',                                'BlackBerry Playbook'),
			--    ('hp-tablet',                               'HP Tablet'),
			--    ('armv(\d+)',                               'ARM v%s'),
			--)
		do
			if
				a_user_agent.has_substring ("windows .. 5.2")
				or a_user_agent.has_substring ("x64")
				or a_user_agent.has_substring ("win64")
				or a_user_agent.has_substring ("wow64")
				or a_user_agent.has_substring ("x86_64")
				or a_user_agent.has_substring ("amd64")
			then
				address_register_size := x64_address_register_size
			else
				address_register_size := x32_address_register_size
			end
		end

	get_os_family (a_user_agent: READABLE_STRING_8)
			--os_mapping = (
			--    ('Windows .. 5.1',      'Windows XP'),
			--    ('Windows .. 5.2',      'Windows XP'),
			--    ('Windows NT 6.0',      'Windows Vista'),
			--    ('Windows 6.0',         'Windows Server 2008'),
			--    ('Windows NT 6.1',      'Windows 7'),
			--    ('Windows NT 6.2',      'Windows 8'),
			--    ('OS X 10.(\d)',        'MAC OS X 10.%s.x'),
			--    ('SunOS',               'Solaris'),
			--    ('droid',               'Android'),
			--    ('Windows',             'Windows - Other'),
			--    ('iPad',                'ipad'),
			--    ('iPod',                'ipod'),
			--    ('iPhone',              'iphone'),
			--    ('OS X',                'MAC OS X other'),
			--    ('Darwin',              'MAC OS X other'),
			--    ('Linux ',              'Linux'),
			--    ('winhttp',             'Windows - Other'),
			--    ('MSIE 4.0;',           'Windows - Other'),
			--    ('Microsoft',           'Windows - Other'),
			--    ('Win32',               'Windows - Other'),
			--    ('BlackBerry',          'BlackBerry'),
			--    ('BB10',                'BlackBerry 10'),
			--    ('RIM (\S+ \S+ \S+)',   'BlackBerry %s'),
			--    ('OS/2',                'OS/2'),
			--    ('urlgrabber/.* yum',   'Linux - redhat/fedora'),
			--    ('Skype for Macintosh', 'MAC OS X other'),
			--    ('Xbox Live Client',    'Xbox'),
			--    ('hpwOS/(\S+)',         'HP webOS %s'),
			--    ('J2ME',                'JVM Micro Edition'),
			--    ('CrOS',                'Chromium OS'),
			--    ('FreeBSD',             'FreeBSD'),
			--)		
		do
			if
				a_user_agent.has_substring ("windows")
				or a_user_agent.has_substring ("winhttp")
				or a_user_agent.has_substring ("msie")
				or a_user_agent.has_substring ("microsoft")
				or a_user_agent.has_substring ("win32")
			then
				os_family := windows_os_family_name
			elseif a_user_agent.has_substring ("os x") or a_user_agent.has_substring ("darwin") then
				os_family := mac_os_family_name
			elseif a_user_agent.has_substring ("sunos") then
				os_family := solaris_os_family_name
			elseif a_user_agent.has_substring ("os/2") then
				os_family := os2_os_family_name
			elseif a_user_agent.has_substring ("linux") or a_user_agent.has_substring ("urlgrabber/.* yum") then
				os_family := linux_os_family_name
			elseif a_user_agent.has_substring ("freebsd") then
				os_family := freebsd_os_family_name
			else
				os_family := "unknown"
			end
		end

feature -- Constants

	x32_address_register_size: STRING = "32"
	x64_address_register_size: STRING = "64"

	windows_os_family_name: STRING = "win"
	mac_os_family_name: STRING = "mac"
	linux_os_family_name: STRING = "linux"
	freebsd_os_family_name: STRING = "freebsd"
	os2_os_family_name: STRING = "os/2"
	solaris_os_family_name: STRING = "solaris"

end

